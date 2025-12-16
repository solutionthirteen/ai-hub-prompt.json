# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.0-base

# install custom nodes into comfyui
# QwenVL Custom Node installieren
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/1038lab/ComfyUI-QwenVL
# TinyTerra Nodes (ttN text)
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/TinyTerra/ComfyUI_tinyterraNodes
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/yolain/ComfyUI-Easy-Use.git
RUN pip install --no-cache-dir -r /comfyui/custom_nodes/ComfyUI-Easy-Use/requirements.txt


RUN pip install --no-cache-dir huggingface_hub && \
    python - <<'EOF'
from huggingface_hub import snapshot_download

snapshot_download(
    repo_id="Qwen/Qwen3-VL-4B-Instruct",
    local_dir="/comfyui/models/LLM/Qwen-VL/Qwen3-VL-4B-Instruct",
    local_dir_use_symlinks=False
)
EOF