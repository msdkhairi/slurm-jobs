# FROM ubuntu:22.04
FROM python:3.11

# Install necessary packages
RUN apt-get update && \
    apt-get install -y git curl tmux htop && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install VSCode CLI
RUN curl -sL "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64" \
        --output /tmp/vscode-cli.tar.gz && \
    tar -xf /tmp/vscode-cli.tar.gz -C /usr/bin && \
    rm /tmp/vscode-cli.tar.gz

# Create a virtual environment and install PyTorch
RUN python -m venv /home/venv && \
    . /home/venv/bin/activate && \
    pip install --upgrade pip && \
    pip install --no-cache-dir torch==2.2.2 torchvision==0.17.2 torchaudio==2.2.2 --index-url https://download.pytorch.org/whl/cu121 && \
    pip install --no-cache-dir lightning tensorboard pycocotools matplotlib mlflow cuda-python torchmetrics ipykernel

RUN git config --global user.email "msdkhairi@gmail.com" && \
    git config --global user.name "Masoud KA"

# Ensure the virtual environment is activated when the container starts
#ENV VIRTUAL_ENV=/opt/venv
#ENV PATH="$VIRTUAL_ENV/bin:$PATH"

CMD ["code", "tunnel"]