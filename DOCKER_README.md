# FaceFusion Docker Setup

## Quick Start

### Build and Run with Docker Compose (Recommended)

```bash
# Build and start the container
docker-compose up --build

# Access the web UI at http://localhost:7860
```

### Build and Run with Docker

```bash
# Build the image
docker build -t facefusion .

# Run the container
docker run -p 7860:7860 -v $(pwd)/outputs:/app/outputs -v $(pwd)/temp:/app/temp facefusion
```

## Usage

Once the container is running, access the Gradio web interface at:
- **http://localhost:7860**

## GPU Support (NVIDIA)

If you have an NVIDIA GPU and want to use hardware acceleration:

1. Install NVIDIA Container Toolkit on your host system
2. Uncomment the GPU section in `docker-compose.yml`:

```yaml
deploy:
  resources:
    reservations:
      devices:
        - driver: nvidia
          count: all
          capabilities: [gpu]
runtime: nvidia
```

3. Rebuild and restart:

```bash
docker-compose up --build
```

## Directory Structure

- `./input` - Place your input images/videos here
- `./outputs` - Generated outputs will be saved here
- `./temp` - Temporary files used during processing

## Stopping the Container

```bash
# Stop with docker-compose
docker-compose down

# Stop with docker
docker stop facefusion
```

## Notes

- The container exposes port 7860 by default
- First run may take longer as models are downloaded
- Ensure you have sufficient disk space for model files
