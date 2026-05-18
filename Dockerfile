# Use NVIDIA CUDA base image with cuDNN runtime for GPU support
FROM nvidia/cuda:12.1.0-cudnn8-runtime-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV OMP_NUM_THREADS=1

# Install Python and system dependencies
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3.10-dev \
    python3-pip \
    ffmpeg \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/python3.10 /usr/bin/python \
    && ln -s /usr/bin/pip3 /usr/bin/pip

# Set working directory
WORKDIR /app

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python dependencies (onnxruntime-gpu will use system CUDA libs)
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir onnxruntime-gpu

# Copy the rest of the application
COPY . .

# Create necessary directories
RUN mkdir -p /app/outputs /app/temp /root/.facefusion

# Expose Gradio default port
EXPOSE 7860

# Set entrypoint
ENTRYPOINT ["python", "facefusion.py"]

# Default command to run the UI
CMD ["run"]
