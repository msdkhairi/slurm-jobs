Apptainer images .def files.

Scripts to Submit jobs on compute canada.

Apptainer Build:

```apptainer build image_filename definition_filename.def```

Apptainer run:

```apptainer run -B ./workspace:/app/workspace ./image_filename python /app/workspace/unisam/train.py```

substitue run with shell to run the container in interactive mode.

```apptainer shell -B ./workspace:/app/workspace ./image_filename```