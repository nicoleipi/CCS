#!/bin/bash

usage(){
    echo
    echo "usage:"
    echo "$(basename $0) [-h|--help] [-w|--walltime WT] gaujob.com"
    echo
    echo "  submits a Gaussian job on 1 node (4 CPU cores)"
    echo "  make sure your input file requests 4 CPU cores"
    echo "  WT = wall time (default 24:00:00)"
    echo
}

# ----------------
# default settings
# ----------------
WALLTIME=24:00:00

# --------------------------
# get command line arguments
# --------------------------
while [[ $# > 0 ]] 
do
    key=$1
    case $key in
        -w|--walltime)
            WALLTIME=$2
            shift
            ;;
	-h|--help)
	    usage
	    exit 0
	    ;;
        *)
            JOBNAME=$(basename $1 .com)
            ;;
    esac
    shift
done

INPUT=${JOBNAME}.com
if [ ! -f ${INPUT} ]
then
    echo "ERROR: need input file (with extension .com)"
    usage
    exit 1
fi

# ----------------
# submit job
# ----------------
sbatch <<EOF
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --tasks-per-node=4
#SBATCH --time=$WALLTIME
#SBATCH --job-name=$JOBNAME
#SBATCH --output=$JOBNAME.%j.out
#SBATCH --error=$JOBNAME.%j.err
#SBATCH --export=ALL

# load gaussian module and assign scratch directory
module purge
module load gaussian/09.D.01
export GAUSS_SCR_DIR=\$SLURM_SCRATCH_DIR

DATE=\$(date "+%Y-%m-%d-%H%M%S")
echo ">>> Starting job $JOBNAME on \$(hostname) at \$DATE"

# run Gaussian
TIC=\$(date +%s)
g09 $INPUT
TOC=\$(date +%s)

let ELAPSED="\$TOC - \$TIC"
echo "elapsed time = \$ELAPSED seconds"
DATE=\$(date "+%Y-%m-%d-%H%M%S")
echo ">>> Job finished at \$DATE"

EOF
