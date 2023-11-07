#!/bin/bash

# export NUM_CONTAINERS="${NUM_CONTAINERS:-4}"
# export TIMEOUT="${TIMEOUT:-3600}"
# export SKIPCOUNT="${SKIPCOUNT:-5}"
# export TEST_TIMEOUT="${TEST_TIMEOUT:-5000}"

export TARGET_LIST=$1
# export FUZZER_LIST=$2

if [[ "x$TARGET_LIST" == "x" ]]
then
    echo "Usage: $0 TARGET"
    exit 1
fi

echo
# echo "# NUM_CONTAINERS: ${NUM_CONTAINERS}"
# echo "# TIMEOUT: ${TIMEOUT} s"
# echo "# SKIPCOUNT: ${SKIPCOUNT}"
# echo "# TEST TIMEOUT: ${TEST_TIMEOUT} ms"
echo "# TARGET LIST: ${TARGET_LIST}"
# echo "# FUZZER LIST: ${FUZZER_LIST}"
echo

# for FUZZER in $(echo $FUZZER_LIST | sed "s/,/ /g")
# do

    for TARGET in $(echo $TARGET_LIST | sed "s/,/ /g")
    do

        echo
        echo "***** RUNNING AFLNET ON $TARGET *****"
        echo

##### FTP #####

        if [[ $TARGET == "lightftp" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH || exit
            mkdir results-lightftp
            profuzz_exec_common.sh lightftp aflnet out-lightftp-aflnet "-P FTP -D 10000 -q 3 -s 3 -E -K -m none "

        fi


        if [[ $TARGET == "bftpd" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH || exit
            mkdir results-bftpd
            profuzzbench_exec_common.sh bftpd aflnet out-bftpd-aflnet "-m none -P FTP -D 10000 -q 3 -s 3 -E -K "

        fi


        if [[ $TARGET == "proftpd" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH || exit
            mkdir results-proftpd
            profuzzbench_exec_common.sh proftpd aflnet out-proftpd-aflnet "-m none -P FTP -D 10000 -q 3 -s 3 -E -K "

        fi

        if [[ $TARGET == "pure-ftpd" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH || exit
            mkdir results-pure-ftpd
            profuzzbench_exec_common.sh pure-ftpd aflnet out-pure-ftpd-aflnet "-m none -P FTP -D 10000 -q 3 -s 3 -E -K "

        fi


##### SMTP #####

        if [[ $TARGET == "exim" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH || exit
            mkdir results-exim
            profuzzbench_exec_common.sh exim  aflnet out-exim-aflnet "-P SMTP -D 10000 -q 3 -s 3 -E -K -W 100 -m none "

        fi



##### DNS #####

        if [[ $TARGET == "dnsmasq" ]] || [[ $TARGET == "all" ]]
        then

            cd "$PFBENCH" || exit
            mkdir results-dnsmasq
            profuzzbench_exec_common.sh dnsmasq aflnet out-dnsmasq-aflnet "-P DNS -D 10000 -K -R -q 3 -s 3 -E -m none "

        fi


##### RTSP #####

        if [[ $TARGET == "live555" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH || exit
            mkdir results-live555
            profuzzbench_exec_common.sh live555 aflnet out-live555-aflnet "-P RTSP -D 10000 -q 3 -s 3 -E -K -R -m none "

        fi


##### SIP #####

        if [[ $TARGET == "kamailio" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH || exit
            mkdir results-kamailio
            profuzzbench_exec_common.sh kamailio aflnet out-kamailio-aflnet "-m none -P SIP -l 5061 -D 50000 -q 3 -s 3 -E -K "

        fi


##### SSH #####

        if [[ $TARGET == "openssh" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH || exit
            mkdir results-openssh
            profuzzbench_exec_common.sh openssh aflnet out-openssh-aflnet "-P SSH -D 10000 -q 3 -s 3 -E -K -W 10 -m none "

        fi


##### TLS #####

        if [[ $TARGET == "openssl" ]] || [[ $TARGET == "all" ]]
        then
    
            cd $PFBENCH || exit
            mkdir results-openssl
            profuzzbench_exec_common.sh openssl aflnet out-openssl-aflnet "-P TLS -D 10000 -q 3 -s 3 -E -K -R -W 100 -m none " 

        fi


##### DTLS #####

        if [[ $TARGET == "tinydtls" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH || exit
            mkdir results-tinydtls
            profuzzbench_exec_common.sh tinydtls aflnet out-tinydtls-aflnet "-P DTLS12 -D 10000 -q 3 -s 3 -E -K -W 30 -m none "

        fi

##### DICOM #####

        if [[ $TARGET == "dcmtk" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH || exit
            mkdir results-dcmtk
            profuzzbench_exec_common.sh dcmtk aflnet out-dcmtk-aflnet "-P DICOM -D 10000 -E -K -m none "

        fi


##### DAAPD #####

        if [[ $TARGET == "forked-daapd" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH || exit
            mkdir results-forked-daapd
            profuzzbench_exec_common.sh forked-daapd aflnet out-forked-daapd-aflnet "-P HTTP -D 200000 -m none -q 3 -s 3 -E -K "

        fi

        if [[ $TARGET == "all" ]]
        then
            # Quit loop -- all fuzzers and targets have already been executed
            exit
        fi

done

