#!/bin/bash

SAVE_DIR="../save"
mkdir -p "$SAVE_DIR"

# Benchmark tasks with seeds
BENCHMARK_TASKS=(
    "buchwald_hartwig: ./config/bechmark/buchwald_hartwig_seed"
    "C_H_func:./config/bechmark/C_H_func_seed"
    "suzuki_miyaura:./config/bechmark/suzuki_miyaura_seed"
    "thiol_addition:./config/bechmark/thiol_addition_seed"
)

# OOS tasks (no seeds)
OOS_TASKS=(
    # BH OOS
    "BH_AddTest1:./config/OOS/BH_AddTest1_OOS_parameters.json"
    "BH_AddTest2:./config/OOS/BH_AddTest2_OOS_parameters.json"
    "BH_AddTest3:./config/OOS/BH_AddTest3_OOS_parameters.json"
    "BH_AddTest4:./config/OOS/BH_AddTest4_OOS_parameters.json"
    "BH_Br:./config/OOS/BH_Br_OOS_parameters.json"
    "BH_Cl:./config/OOS/BH_Cl_OOS_parameters.json"
    "BH_I:./config/OOS/BH_I_OOS_parameters.json"
    "BH_component_combination:./config/OOS/BH_component_combination_OOS_parameters.json"

    # thiol OOS
    "thiol_addition_cat:./config/OOS/thiol_addition_cat_parameters.json"
    "thiol_addition_sub:./config/OOS/thiol_addition_sub_parameters.json"
    "thiol_addition_sub_cat:./config/OOS/thiol_addition_sub_cat_parameters.json"
)

# External tasks (DOI loop ,AHO,NAT)
EXTERNAL_TASKS=()
for i in {0..25}; do
    EXTERNAL_TASKS+=("DOI_${i}:./config/external/DOI_${i}_parameters.json")
done
EXTERNAL_TASKS+=("aho:./config/external/aho_parameters.json")
EXTERNAL_TASKS+=("nat:./config/external/nat_synth_parameters.json")

# Generate all commands
COMMANDS=()

# Add benchmark tasks (with seeds)
for task in "${BENCHMARK_TASKS[@]}"; do
    IFS=':' read -r task_name path_prefix <<< "$task"
    for seed in {0..9}; do
        COMMANDS+=("cd .. && python train_model.py --config_json ${path_prefix}${seed}_parameters.json:$task_name:$seed")
    done
done

# Add OOS and external tasks (no seeds)
for task in "${OOS_TASKS[@]}" "${EXTERNAL_TASKS[@]}"; do
    IFS=':' read -r task_name config_path <<< "$task"
    COMMANDS+=("cd .. && python train_model.py --config_json $config_path:$task_name:")
done

# Execute all commands
for entry in "${COMMANDS[@]}"; do
    IFS=':' read -r cmd task_name seed <<< "$entry"

    log_file="${SAVE_DIR}/$(date +%Y%m%d_%H%M%S)_${task_name}_seed${seed}.log"
    [ "$seed" = ":" ] && log_file="${SAVE_DIR}/$(date +%Y%m%d_%H%M%S)_${task_name}.log"

    echo "======================================================================"
    echo "Starting: $task_name (seed: $seed)"
    echo "Command: $cmd"
    echo "Log: $log_file"
    echo "======================================================================"

    eval "$cmd" 2>&1 | tee "$log_file"
    exit_code=$?

    if [ $exit_code -eq 0 ]; then
        echo "✅ Success"
    else
        echo "❌ Failed (exit code: $exit_code)"
    fi
    echo
done

echo "======================================================================"
echo "All tasks completed! Total: ${#COMMANDS[@]}"
echo "Logs saved to: $SAVE_DIR"
echo "======================================================================"