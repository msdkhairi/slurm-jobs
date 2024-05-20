Apptainer images .def files.

Scripts to Submit jobs on compute canada.

Apptainer Build:

```apptainer build image_filename definition_filename.def```

Apptainer run:

```apptainer run -B ./workspace:/app/workspace ./image_filename python /app/workspace/unisam/train.py```

substitue run with shell to run the container in interactive mode.

```apptainer shell -B ./workspace:/app/workspace ./image_filename```

apptainer run -C --nv -B /project/def-ibajic/mka267/workspace/unisam:/app/unisam -B /scratch/mka267/workspace-scratch/coco2017:/app/data/coco2017 -W $SLURM_TMPDIR ./py311_torch.sif python /app/unisam/train.py
