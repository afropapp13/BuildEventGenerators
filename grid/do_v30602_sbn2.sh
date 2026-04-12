#! /usr/bin/env bash
# Modified to setup genie from my persistent area.

if [ -z "$PS1" ]; then
  # if $- contains "i" then interactive session
  export ESCCHAR="\x1B" # or \033 # Mac OS X bash doesn't support \e as esc?
  export OUTBLACK="${ESCCHAR}[0;30m"
  export OUTBLUE="${ESCCHAR}[0;34m"
  export OUTGREEN="${ESCCHAR}[0;32m"
  export OUTCYAN="${ESCCHAR}[0;36m"
  export OUTRED="${ESCCHAR}[0;31m"
  export OUTPURPLE="${ESCCHAR}[0;35m"
  export OUTORANGE="${ESCCHAR}[0;33m" # orange, more brownish?
  export OUTLTGRAY="${ESCCHAR}[0;37m"
  export OUTDKGRAY="${ESCCHAR}[1;30m"
  # labelled "light but appear in some cases to show as "bold"
  export OUTLTBLUE="${ESCCHAR}[1;34m"
  export OUTLTGREEN="${ESCCHAR}[1;32m"
  export OUTLTCYAN="${ESCCHAR}[1;36m"
  export OUTLTRED="${ESCCHAR}[1;31m"
  export OUTLTPURPLE="${ESCCHAR}[1;35m"
  export OUTYELLOW="${ESCCHAR}[1;33m"
  export OUTWHITE="${ESCCHAR}[1;37m"
  export OUTNOCOL="${ESCCHAR}[0m" # No Color
fi

# ./do_v30602_sbn2.sh <action> [ <tunelist> ]
#     action:  init launch stage2 stage4 stage5 status

#export EXTRAFLG="--skip-stage3-check"
#export EXTRAQUAL=":partial"
EXTRAFLG=""
EXTRAQUAL=""

# GENIE_PERSISTENT is the location on persistent where genie lives
export GENIE_PERSISTENT="/pnfs/$(id -ng)/persistent/users/$(id -nu)/genie_ups"

# ACTION is one of:  init launch-dag status

#set -ux

JSGROUP=$(id -gn)
export JOBSUB_GROUP=${JSGROUP}
export KNOTS=250
export EMAX="1000.0"   # was 400.0
GENLIST="CC" #"CCQE+CCMEC"
# You can set this to e.g. "CCQE", and it will make a qualifier of the type AR2520i00000:k150:e10:CCQE

READY=1 # set to 1 if good to go. 0 makes this be a dry run

export ACTION="status"
if [ -n "$1" ]; then ACTION="$1" ; fi

export TUNELIST=" \
              XXXXXXXXXXG18_10a_02_11b \
              XXXXXXXXXXAR23_20i_00_000 \
              XXXXXXXXXXAR23_20i_01_000 \
              XXXXXXXXXXAR23_20i_01_001 \
              XXXXXXXXXXAR23_20i_02_000 \
              XXXXXXXXXXAR23_22i_00_000 \
              AR25_20i_00_000 \
              XAR25_20i_01_000 \
              XAR25_20i_01_001 \
              XAR25_20i_02_000 \
              XAR25_22i_00_000 \
	            XG18_10b_00_000
"

echo TUNELIST=$TUNELIST

export JOBSUB_GROUP=sbnd # nova dune  # need to try "genie" role=production
export SEP="============================================================="

TAG=sbn2
export GVERS=v3_06_02_${TAG}
export GXVER=v3_06_02_${TAG}
export GQUAL="e26:prof"

export LOGBASE=v30602_${TAG}

echo "version:  $GXVER $GVERS $GQUAL"

TOPGEN=/pnfs/${JSGROUP}/scratch/users/$(id -un)/gen_genie_splines_v3

function now ()
{
    date "+%Y-%m-%d %H:%M:%S"
}
function bootstrap_genie ()
{
    export GPRD=/grid/fermiapp/products/genie;
    export ALTUPS="";
    case "$1" in
        cv*)
            export GPRD=/cvmfs/fermilab.opensciencegrid.org/products/genie
        ;;
        alt*)
            export ALTUPS=/genie/app/$(id -un)/altups
        ;;
    esac;
    #set +ux
    source ${GPRD}/bootstrap_genie_ups.sh;
    #set -ux
    if [ -n "$ALTUPS" ]; then
        echo -e "${OUTGREEN}adding ${ALTUPS} to \${PRODUCTS}${OUTNOCOL}";
        export PRODUCTS=${PRODUCTS}:${ALTUPS};
    fi
}

#al9# bootstrap_genie cvmfs
#al9# setup jobsub_client
alias myjobs="jobsub_q --user $USER"

export UPSV="ups:sbn+trycvmfs%${GVERS}%${GQUAL}"

cp $(pwd)/gen_genie_splines_v3.sh /exp/${JSGROUP}/app/users/$(id -un)/GXSPLINE
cd /exp/${JSGROUP}/app/users/$(id -un)/GXSPLINE

export TUNE
EMAXX=`echo ${EMAX} | tr '.' 'p' | sed -e 's/p0*$//g'`

for TUNE in ${TUNELIST} ; do
  C1=`echo $TUNE | cut -c1`
  if [ "$C1" == "X" -o "$C1" == "x" ]; then
    echo " "
    echo -e "${OUTORANGE}skip ${TUNE}${OUTNOCOL}"
    continue
  fi
  echo " "
  echo -e "${OUTGREEN}start ${ACTION} on ${TUNE}${OUTNOCOL}"

  export LOGFILE=do_${LOGBASE}_${TUNE}.log
  TUNEX=`echo ${TUNE} | tr -d "_" `
  GENQUAL=${TUNEX}:k${KNOTS}:e${EMAXX}
  if [ "${GENLIST}" != "Default" ]; then
    GENQUAL="${GENQUAL}:${GENLIST}"
  fi

  # switch off sleeping 
  # export NOSLEEP=1
  GENCMD="./gen_genie_splines_v3.sh ${EXTRAFLG} \
     --top ${TOPGEN} --version ${GXVER} \
     --qualifier "${GENQUAL}${EXTRAQUAL}" \
     --tune "${TUNE}" --genlist "${GENLIST}"  \
     --setup "$UPSV" --knots $KNOTS --emax $EMAX "
  export INITFIN="--split-nu-isotopes --init --finalize"

  case "$ACTION" in
    *init* )
      echo ${TUNE} ${SEP} `now`
      echo ${TUNE} ${SEP} `now` >> ${LOGFILE}
      echo $GENCMD  $INITFIN -v
      echo $GENCMD  $INITFIN -v >> ${LOGFILE}
      if [[ $READY == 1 ]] ; then
          $GENCMD  $INITFIN -v >> ${LOGFILE} 2>&1
	  init_stat=$?
	  echo -e "${OUTGREEN}init_stat=${init_stat}${OUTNOCOL}"
      else
	  echo -e "${OUTYELLOW}Not launching: this is a dry run${OUTNOCOL}"
      fi
      ;;
    *launch* | *dag* )
      echo ${TUNE} ${SEP} `now`
      echo ${TUNE} ${SEP} `now` >> ${LOGFILE}
      echo $GENCMD  --launch-dag
      echo $GENCMD  --launch-dag >> ${LOGFILE}
      if [[ $READY == 1 ]] ; then
          $GENCMD  --launch-dag >> ${LOGFILE} 2>&1
	  launch_stat=$?
	  echo -e "${OUTGREEN}launch_stat=${launch_stat}${OUTNOCOL}"
      else
	  echo -e "${OUTYELLOW}Not launching: this is a dry run${OUTNOCOL}"
      fi
      ;;
    *stage2* )
      echo ${TUNE} ${SEP} `now`
      echo ${TUNE} ${SEP} `now` >> ${LOGFILE}
      echo $GENCMD  --run-stage 2
      echo $GENCMD  --run-stage 2 >> ${LOGFILE}
      if [[ $READY == 1 ]] ; then
          $GENCMD  --run-stage 2 >> ${LOGFILE} 2>&1
	  stage2_stat=$?
	  echo -e "${OUTGREEN}stage4_stat=${stage2_stat}${OUTNOCOL}"
      else
	  echo -e "${OUTYELLOW}Not launching: this is a dry run${OUTNOCOL}"
      fi
      ;;
    *stage4* )
      echo ${TUNE} ${SEP} `now`
      echo ${TUNE} ${SEP} `now` >> ${LOGFILE}
      echo $GENCMD  --run-stage 4
      echo $GENCMD  --run-stage 4 >> ${LOGFILE}
      if [[ $READY == 1 ]] ; then
          $GENCMD  --run-stage 4 >> ${LOGFILE} 2>&1
	  stage4_stat=$?
	  echo -e "${OUTGREEN}stage4_stat=${stage4_stat}${OUTNOCOL}"
      else
	  echo -e "${OUTYELLOW}Not launching: this is a dry run${OUTNOCOL}"
      fi
      ;;
    *stage5* )
      echo ${TUNE} ${SEP} `now`
      echo ${TUNE} ${SEP} `now` >> ${LOGFILE}
      echo $GENCMD  --run-stage 5
      echo $GENCMD  --run-stage 5 >> ${LOGFILE}
      if [[ $READY == 1 ]] ; then
           $GENCMD  --run-stage 5 >> ${LOGFILE} 2>&1
	   stage5_stat=$?
	   echo -e "${OUTGREEN}stage5_stat=${stage5_stat}${OUTNOCOL}"
      else
	  echo -e "${OUTYELLOW}Not launching: this is a dry run${OUTNOCOL}"
      fi
      ;;
    *status* )
	echo ${TUNE} ${SEP} `now`
	if [[ $READY == 1 ]] ; then
            $GENCMD --status
	else
	    echo -e "${OUTYELLOW}Not launching: this is a dry run${OUTNOCOL}"
	fi
      ;;
    * )
      echo -e "${OUTORANGE}unknown ACTION=${ACTION}${OUTNOCOL}"
      ;;
   esac
done
### $GENCMD --launch-dag

# end-of-script
