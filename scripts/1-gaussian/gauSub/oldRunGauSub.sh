function submit() {
    model=$1
    method=$2

    initial_path=${full_path}/${model}/${method}/${initial_basis}
    cd ${initial_path}
    # Loop over all molecules
    for input in ./*.com
    do
        # Launch job for inital basis
        cd ${initial_path}
        job=$(basename $input)
        chk_name=${job:9:-4}.chk
        # Get job id - need to check what string is returned by launch script
        job_id=$(${full_path}/gau-sub.sh ${job})
        job_id=$(echo $job_id | awk '{print $4}')

        # Launch jobs for all other basis sets
        # Submitted job now must
        # i) know its dependency
        # ii) be able to copy the required data from dependent job (i.e. checkpoint file)
        for basis in ${basis_sets}
        do
            cd ${full_path}/${model}/${method}/${basis}
            ${full_path}/gauSub.sh -c ${initial_path}/${chk_name} -d ${job_id} ${job}
        done
    done
}

submit /aerosol/users/nicole/CCS/gaussian_in/molecule1