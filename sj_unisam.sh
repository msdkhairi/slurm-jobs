#!/bin/bash
#SBATCH --account=def-ibajic
#SBATCH --mail-user=compute@masoudka.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --gpus-per-node=p100l:4 
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24    # There are 24 CPU cores on P100 Cedar GPU nodes
#SBATCH --mem=0               # Request the full memory of the node
#SBATCH --time=03-12:00           # time (DD-HH:MM)
# --------------------------
apptainer run -C --nv -B /project/def-ibajic/mka267/workspace/unisam:/app/unisam -B /scratch/mka267/workspace-scratch/coco2017:/app/data/coco2017 -W $SLURM_TMPDIR ./py311_torch.sif python /app/unisam/train.py
