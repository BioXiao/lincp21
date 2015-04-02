module load bio/picard-tools-1.98
mem=20000
threads=10
time=300
inputDir=/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/bam
#for dir in `ls -d $inputDir/*_*`;do 
#	echo $dir
#	sbatch -J "pSort" -t $time --mem=$mem -N 1 -n $threads -p general --mail-type=FAIL --wrap="java -Xmx40g -jar /n/sw/picard-tools-1.98/SortSam.jar INPUT=$dir/accepted_hits.bam OUTPUT=$dir/accepted_hits_sorted_picard.bam SORT_ORDER=coordinate";
#done

for dir in `ls -d $inputDir/JR*`;do
       echo $dir
    	sbatch -J "pSort" -t $time --mem=$mem -N 1 -n $threads -p general --mail-type=FAIL --wrap="java -Xmx40g -jar /n/sw/picard-tools-1.98/SortSam.jar INPUT=$dir/accepted_hits.bam OUTPUT=$dir/accepted_hits_sorted_picard.bam SORT_ORDER=coordinate";
	sbatch -J "pSort" -t $time --mem=$mem -N 1 -n $threads -p general --mail-type=FAIL --wrap="java -Xmx40g -jar /n/sw/picard-tools-1.98/SortSam.jar INPUT=$dir/rmdup_accepted_hits.bam OUTPUT=$dir/rmdup_accepted_hits_sorted_picard.bam SORT_ORDER=coordinate";
done

