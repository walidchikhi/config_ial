#!/bin/bash
#SBATCH -J w-getarp1
#SBATCH -p transfert
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --time=01:00:00
#SBATCH -o get_arpege_hendrix.eo%j
#SBATCH -e get_arpege_hendrix.eo%j

set -evx
DATE=`cat $HOME/fog1km/date`

AA=`echo $DATE |cut -c1-4`
MM=`echo $DATE |cut -c5-6`
JJ=`echo $DATE |cut -c7-8`

echo $AA
echo $MM
echo $JJ
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
#                                                              Create working directory                                                                       
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
export INPARP=/scratch/work/chikhiw/INPUT/ARPEGE/$MM$JJ 
mkdir -p $INPARP
#rm -f $INPARP/*
export DATARP=/home/m/mxpt/mxpt001/vortex/arpege/4dvarfr/OPER

# Start by cd to the TMPDIR because Slurm won't do it for you !!
cd $TMPDIR
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
#                                                                  Change of date (manually in fileD) 
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------

############################################################################################
#                                      Clear Old Data                                      #
############################################################################################
#CLEAN
echo '1.' Download ICMSHARP data for ${JJ}/${MM}/${AA} > log1.out
############################################################################################
#                                    Write new get file                                    #
############################################################################################
car=T0000P
#for iech in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48
#do
#historic.arpege.tl1798-c22+0067:00.fa

#iech=$(echo $car | cut -c2-5)
echo 'user chikhiw Dilaw#31' > get_icmsharp1
chmod 700 get_icmsharp1
echo 'cd /home/m/mxpt/mxpt001/vortex/arpege/4dvarfr/OPER/'${AA}/${MM}/${JJ}'/'${car}'/forecast' >> get_icmsharp1
for iech in {11..24..01}  
do
echo get historic.arpege.tl1798-c22+00${iech}:00.fa >> get_icmsharp1
done
echo 'quit' >> get_icmsharp1
############################################################################################
#                              Get Arpege Files from HENDRIX                               #
############################################################################################
echo '2. Connecting to HENDRIX ....' >> log1.out
ftp -n hendrix < get_icmsharp1
sleep 5
for iech in  {11..20..01} 
do
historic.arpege.tl1798-c22+00${iech}:00.fa  $INPARP/ICMSHARPE_${AA}${MM}${DD}00${iech}
done
mv log1.out ${HOME}/FOG/getarpege/.
sleep 2
#rm -f get_icmsharp1
exit
