#!/bin/bash
#SBATCH --account=def-ibajic
#SBATCH --mail-user=compute@masoudka.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=4
#SBATCH --gpus-per-node=v100l:4
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=8    # 24 P100, 32 V100
#SBATCH --mem=0               # Request the full memory of the node
#SBATCH --time=06-11:55           # time (DD-HH:MM)
# --------------------------

# Print the current date and time
current_time=$(date +"%Y-%m-%d %H:%M:%S")
echo "Current time: $current_time"

echo "nccl --version"
nccl --version

module load apptainer
echo "apptainer version"
apptainer version

cat "$0"

nvidia-smi

srun mkdir -p $SLURM_TMPDIR/apptainer/workdir

#export CUDA_VISIBLE_DEVICES=[0,1,2,3]

PROJECT_HOME="/home/$USER/project"
DATA_DIR="$PROJECT_HOME/data/coco2017"

srun apptainer run \
--contain \
--nv \
--bind /project/def-ibajic/mka267/workspace/UnivCollabSFU24:$PROJECT_HOME/unisam \
--bind /scratch/mka267/workspace-scratch/coco2017:$DATA_DIR \
--workdir $SLURM_TMPDIR/apptainer/workdir \
--pwd $PROJECT_HOME/unisam \
./py311_torch.sif \
python train.py \
--seed 123 \
--trainer.accelerator "gpu" \
--trainer.devices "auto" \
--trainer.strategy "ddp" \
--trainer.num-nodes $SLURM_JOB_NUM_NODES \
--trainer.max-epochs 100 \
--trainer.accumulate-grad-batches 1 \
--datamodule.data-dir $DATA_DIR \
--datamodule.batch-size 6 \
--datamodule.num-workers $SLURM_CPUS_PER_TASK \
--litmodel.learning-rate 0.0004 \
--checkpoint-callback.dirpath "checkpoints_unisam_reconstruction/" \
--checkpoint-callback.monitor "val_loss" \
--logger.save-dir "logs/" \
--logger.name "unisam_reconstruction" \