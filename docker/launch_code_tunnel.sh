docker run --cpus=60 \
           --memory=240g \
           --memory-swap=240g \
           --shm-size=64g \
           --gpus=8 \
           --volume /localhome/mka267/workspace:/home/workspace \
           --volume /data/datasets:/home/data \
           --workdir /home/workspace/ \
           --name conda-code \
           conda-code:v1.0 \
           code tunnel
