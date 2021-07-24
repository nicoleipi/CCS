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

input_file=$JOBNAME.log
output_file=/aerosol/users/nicole/CCS/output_r1.csv

basis_sets=("6-31G(d)" "6-31G(d,p)" "6-31+G(d,p)" "6-311G(d,p)" "6-311++G(d,p)" "6-311G(2df,2pd)" "6-311++G(2df,2pd)")

for i in ${!basis_sets[@]};
do 
    num=0
    basis=${basis_sets[$i]}
    num=`grep ${basis} ${input_file} | wc -l`
    if [ ${num} -gt 0 ]; then
        basis_set=${basis}
    fi
done
#echo ${basis_set}

aline=`cat ${input_file} | grep "Sum of electronic and zero-point Energies"`
var_ezpe=`echo ${aline} | cut -d " " -f 7`
#echo ${var_ezpe}

aline=`cat ${input_file} | grep "Sum of electronic and thermal Energies"`
var_u=`echo ${aline} | cut -d " " -f 7`
#echo ${var_u}

aline=`cat ${input_file} | grep "Sum of electronic and thermal Enthalpies"`
var_h=`echo ${aline} | cut -d " " -f 7`
#echo ${var_h}

aline=`cat ${input_file} | grep "Sum of electronic and thermal Free Energies"`
var_g=`echo ${aline} | cut -d " " -f 8`
#echo ${var_g}

aline=`cat ${input_file} | grep 'HF='`
search="HF="
prefix=${aline%%${search}*}
num=${#prefix}
let "num=num+3"
rest_of_line=${aline:${num}}
search='\\'
var_e=${rest_of_line%%${search}*}
#echo ${var_e}

echo "${basis_set}, ${var_ezpe}, ${var_u}, ${var_h}, ${var_g}, ${var_e}" >> ${output_file}
EOF
