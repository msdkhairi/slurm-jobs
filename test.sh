#!/bin/bash

apptainer run \
--contain \
--cleanenv \
--nv \
--bind /home/masoud/apptainer/workspace/unisam:/app/unisam \
--bind /home/masoud/apptainer/workspace/data:/app/data/coco2017 \
--workdir /home/masoud/apptainer/workspace/temp \
--pwd /app/unisam/ \
./py310_torch.sif \
python train.py