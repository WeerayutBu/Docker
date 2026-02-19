# Building a Docker Image

This project uses Docker to build and run the application (FastAPI) in a container.


| File                 | Purpose                                                          |
| -------------------- | -----------------------------------------------------------------|
| `Dockerfile`         | Defines how Docker builds and runs the application.|
| `requirements.txt`   | Lists Python dependencies to be installed                        |
| `.dockerignore`      | Excludes unnecessary files from the Docker build context         |

## Checklist
[x] `Dockerfile`: verify `FROM` and `WORKDIR` are set correctly  
[x] `Dockerfile`: confirm `COPY . .` copies project files into the container  
[x] `Dockerfile`: ensure `CMD` starts the application  
[x] `requirements.txt`: update Python dependencies

[x] `docker run`: verify `--gpus 4` (use 4 GPUs) or `--gpus all` setting  
[x] `docker run`: verify `-p` (ports) and `-v` (volumes) settings   


## Build image
```bash
# Build the image
docker build -t username/fastapi:latest .
# Verify the image
docker images
```

## Using the image as the environment
```
docker run -p 8800:8080 \
  --gpus all \
  username/fastapi:latest \
  uvicorn app.main:app --host 0.0.0.0 --port 8080
```


## Run the container
```bash
docker run -d \
    --name demo-fastapi \
    -p 8800:8080 \
    -e HF_HOME=/cache \
    -v ${HOME}/.cache/huggingface:/cache/huggingface \
    --gpus all \
  username/fastapi:latest

# Execute a shell inside the running container
docker exec -it demo-fastapi bash

# Test inference
curl http://localhost:8080  # inside container
curl http://localhost:8800  # outside container
```

## Push → Pull
```python
# Server 1: Push to Registry
docker push username/fastapi:latest

# Server 2: Pull
docker pull username/fastapi:latest
```

### Common command
- Stop container: `docker stop <CONTAINER_ID>`
- Remove image: `docker images` then `docker rmi 53c25b2d0faa`.
- Cleanup `docker container prune -f`, `docker image prune -af`, `docker system prune -af --volumes`, and `docker builder prune -af`
- Save and copy an image `docker save image:latest | gzip > image.tar.gz`.