#!/bin/zsh

# Resolve the project root from this file so it works from any directory.
project_root="${${(%):-%N}:A:h}"
project_scripts="$project_root/scripts"

case ":$PATH:" in
    *":$project_scripts:"*) ;;
    *) export PATH="$project_scripts:$PATH" ;;
esac

export VERILOG_PRACTICE_ROOT="$project_root"

# Export flags as strings so child scripts such as eda can receive them.
unset VERI_FLAGS COMPILE_FLAGS SIM_FALGS
export VERI_FLAGS='--lint-only -Wall -y common -Idesigns -Wno-DECLFILENAME'
export COMPILE_FLAGS='-g2012 -ycommon -Y.sv -Idesigns'
export SIM_FALGS=''

printf 'Project Root: %s\n\n' "$project_root"
printf 'VERILATOR flags: %s\n' "$VERI_FLAGS"
printf 'COMPILE flags: %s\n' "$COMPILE_FLAGS"
# printf 'SIMULATION flags: %s\n' "${SIM_FALGS[*]}"
