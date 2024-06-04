#!/bin/bash
#SBATCH --account=def-ibajic
#SBATCH --mail-user=compute@masoudka.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --gpus-per-node=a100:4
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=12    # 24 p100l, 32 v100l, 40 v100 beluga
#SBATCH --mem=0               # Request the full memory of the node
#SBATCH --time=00-11:55           # time (DD-HH:MM)
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
srun mkdir -p $SLURM_TMPDIR/data/coco2017
#export CUDA_VISIBLE_DEVICES=[0,1,2,3]

DATA_DIR="/scratch/mka267/data/coco2017"
LOCAL_DATA_DIR="$SLURM_TMPDIR/data/"

srun cp -r $DATA_DIR $LOCAL_DATA_DIR 

current_time=$(date +"%Y-%m-%d %H:%M:%S")
echo "Current time after cp: $current_time"

PROJECT_HOME="/home/$USER/project"
APPTAINER_DATA_DIR="$PROJECT_HOME/data/coco2017"

srun apptainer run \
--contain \
--nv \
--bind /project/def-ibajic/mka267/workspace/UnivCollabSFU24:$PROJECT_HOME/unisam \
--bind $LOCAL_DATA_DIR/coco2017:$APPTAINER_DATA_DIR \
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
--datamodule.data-dir $APPTAINER_DATA_DIR \
--datamodule.batch-size 7 \
--datamodule.num-workers 48 \
--litmodel.learning-rate 0.0004 \
--checkpoint-callback.dirpath "checkpoints_unisam_reconstruction/" \
--checkpoint-callback.monitor "val_loss" \
--logger.save-dir "logs/" \
--logger.name "unisam-reconstruction" \
