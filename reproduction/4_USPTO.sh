#!/bin/bash
# ======================================
# Script description: Execute multiple distributed training tasks in sequence, each using specified GPU devices
# Prerequisites: Ensure at least 8 GPUs are available (adjust CUDA_VISIBLE_DEVICES based on actual resources)
# We modified `train.py` to include a `try_resume` function that enables training resumption from a saved checkpoint. This function restores the model, optimizer, and scheduler states, and recovers the training epoch and best validation score, allowing for flexible and robust experiment management.
# ======================================

# Change to root directory before execution
cd ..

# 1. Log root directory
SAVE_DIR="./reproduction/4_uspto"
mkdir -p "$SAVE_DIR"

# 2. Define command list to execute
COMMANDS=(
    ## Train
    # USPTO-50K
     'export CUDA_VISIBLE_DEVICES="0,1,2,3,4,5,6,7"; python -m torch.distributed.launch --nproc_per_node 8 train_model.py --config_json ./config/uspto/uspto_50k_parameters.json'

    # USPTO-480K task
     'export CUDA_VISIBLE_DEVICES="0,1,2,3,4,5,6,7"; python -m torch.distributed.launch --nproc_per_node 8 train_model.py --config_json ./config/uspto/uspto_480k_parameters.json'

    # USPTO_STEREO task
     'export CUDA_VISIBLE_DEVICES="0,1,2,3,4,5,6,7"; python -m torch.distributed.launch --nproc_per_node 8 train_model.py --config_json ./config/uspto/USPTO_STEREO_parameters.json'

    # USPTO-FULL task
     'export CUDA_VISIBLE_DEVICES="0,1,2,3,4,5,6,7"; python -m torch.distributed.launch --nproc_per_node 8 train_model.py --config_json ./config/uspto/uspto_full_parameters.json'

    # Evaluation tasks
    # USPTO-50k evaluation
     "python eval_model.py --config_json ./config/uspto/uspto_50k_eval.json"

    # USPTO-FULL evaluation
     "python eval_model.py --config_json ./config/uspto/uspto_full_eval.json"

    # USPTO-480K evaluation
    "python eval_model.py --config_json ./config/uspto/uspto_480k_eval.json"

    # USPTO-STEREO evaluation
    "python eval_model.py --config_json ./config/uspto/uspto_stereo_eval.json"
)

# 3. Execute each command in sequence
for cmd in "${COMMANDS[@]}"; do
    ts=$(date +%Y%m%d_%H%M%S)
    tag=$(basename "$cmd" | sed 's/--config_json //' | tr '/' '_')
    logfile="${SAVE_DIR}/${ts}_${tag}.log"

    echo "======================================================================"
    echo "Starting command: $cmd"
    echo "Log file: $logfile"
    echo "======================================================================"

    # 4. Real-time output + save to log
    eval "$cmd" 2>&1 | tee "$logfile"
    exit_code=$?

    if [ $exit_code -eq 0 ]; then
        echo "✅ Command executed successfully!"
    else
        echo "❌ Command failed! Exit code: $exit_code"
    fi
    echo
done

echo "======================================================================"
echo "All commands completed! Logs saved to: $SAVE_DIR"
echo "======================================================================"