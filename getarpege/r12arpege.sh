#!/bin/bash
#SBATCH -J w-r12getarp0
#SBATCH -p transfert
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --time=01:00:00
#SBATCH -o get_arpege_hendrix.eo%j
#SBATCH -e get_arpege_hendrix.eo%j
set -evx
DATE=`cat $HOME/fog1km/dater12`

AA=`echo $DATE |cut -c1-4`
MM=`echo $DATE |cut -c5-6`
JJ=`echo $DATE |cut -c7-8`
#AA=2018
#MM=05
#JJ=21
#AA=$(echo $jour | cut -c1-4)
#AA=
#MM=$(echo $jour | cut -c5-6)
#MM=
#JJ=$(echo $jour | cut -c7-8)
#JJ=
#HH=$(echo $jour | cut -c9-10)
#YYYY=$AA
#MMDD=$MM$JJ
echo $AA
echo $MM
echo $JJ
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
#                                                              Create working directory                                                                       
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
export INPARP=/scratch/work/chikhiw/INPUT/ARPEGE/r12/$MM$JJ
mkdir -p $INPARP
#rm -f $INPARP/*
export DATARP=/chaine/mxpt/mxpt001/arpege/oper/production

# Start by cd to the TMPDIR because Slurm won't do it for you !!
cd $TMPDIR
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
#                                                                  Change of date (manually in fileD) 
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------

############################################################################################
#                                      Clear Old Data                                      #
############################################################################################
#CLEAN
echo '1.' Download ICMSHARP data for ${JJ}/${MM}/${AA} > log0.out
############################################################################################
#                                    Write new get file                                    #
############################################################################################
car=r12
#for iech in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48
#do
#historic.arpege.tl1798-c22+0067:00.fa

#iech=$(echo $car | cut -c2-5)
echo 'user chikhiw Dilaw#31' > get_icmsharp0
chmod 700 get_icmsharp0
echo 'cd /chaine/mxpt/mxpt001/arpege/oper/production/'${AA}/${MM}/${JJ}'/'${car} >> get_icmsharp0
for iech in {00..24..01}
do
echo get  icmsharpe+00${iech} >> get_icmsharp0
done
echo 'quit' >> get_icmsharp0
############################################################################################
#                              Get Arpege Files from HENDRIX                               #
############################################################################################
echo '2. Connecting to HENDRIX ....' >> log0.out
ftp -n hendrix < get_icmsharp0
sleep 5
for iech in  {00..24..01}
do
mv  icmsharpe+00${iech} $INPARP/historic.arpege.tl1198-c22+00${iech}:00.fa
done
mv log0.out ${HOME}/fog1km/getarpege/.
sleep 2
#rm -f get_icmsharp0
cd ${HOME}/fog1km/e927
sbatch r12job_e927-13km90NI 

exit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
