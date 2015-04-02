module load bio/picard-tools-1.98
dir="/n/rinn_data1/users/agroff/seq/broad/get.broadinstitute.org/pkgs/SN0054491"
out="/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/data/fastq"

for file in `ls $dir/linc-p21*`;do
        OIFS=$IFS
        IFS='/'
        fileArray=($file)
        bamName=${fileArray[10]}
        IFS=$OIFS
#	echo $bamName
        sbatch -J "tofastq" -t 600 --mem=42000 --wrap="java -Xmx40g -jar /n/sw/picard-tools-1.98/SamToFastq.jar I=$file F=$out/$bamName'_R1.fastq' F2=$out/$bamName'_R2.fastq'";
done
