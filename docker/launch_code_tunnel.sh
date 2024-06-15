docker run --cpus=60 \
           --memory=240g \
           --memory-swap=240g \
           --shm-size=120g \
           --gpus=8 \
           --volume /localhome/mka267/workspace:/home/workspace \
           --volume /data/datasets:/home/data \
           --workdir /home/workspace/ \
           --name code-torch \
           code-tunnel:v0.9
