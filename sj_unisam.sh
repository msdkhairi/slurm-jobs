#!/bin/bash
#SBATCH --account=def-ibajic
#SBATCH --mail-user=compute@masoudka.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --gpus-per-node=p100l:4
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=6    # There are 24 CPU cores on P100 Cedar GPU nodes
#SBATCH --mem=0               # Request the full memory of the node
#SBATCH --time=03-12:00           # time (DD-HH:MM)
# --------------------------
srun apptainer run -C --nv \
-B /project/def-ibajic/mka267/workspace/unisam:/app/unisam \
-B /scratch/mka267/workspace-scratch/coco2017:/app/data/coco2017 \
-W $SLURM_TMPDIR \
--pwd /app/unisam/ \
./py311_torch.sif \
python train.py \
--seed 123 \
--data-dir "../data/coco2017" \
--num-workers 6 \
--num-nodes 2 \
--batch-size 1 \
--accumulate-grad-batches 2 \
--lr 0.0004
