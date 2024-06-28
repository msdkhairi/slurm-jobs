docker run --cpus=60 \
           --memory=240g \
           --memory-swap=240g \
           --shm-size=64g \
           --gpus=8 \
           --volume /localhome/mka267/workspace:/home/workspace \
           --volume /localhome/mka267/mlruns:/home/mlruns \
           --volume /data/datasets:/home/data \
           --workdir /home/workspace/ \
           --name conda-code \
           msdkhairi/conda-code:v1.0 \
           code tunnel
