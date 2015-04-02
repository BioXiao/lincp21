module load bio/picard-tools-1.98

mem=40000
threads=20
time=400
inputDir=/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/bam
#for dir in `ls -d $inputDir/*_*`;do 
#	echo $dir
#	rm $dir/accepted_hits.bam
#	sbatch -J "markdup" -t $time --mem=$mem -N 1 -n $threads -p general --mail-type=FAIL --wrap="java -Xmx40g -jar /n/sw/picard-tools-1.98/MarkDuplicates.jar INPUT=$dir/accepted_hits_sorted_picard.bam OUTPUT=$dir/accepted_hits_sorted_duplicates_marked.bam METRICS_FILE=dup_metrics.txt"
#done

for dir in `ls -d $inputDir/JR*`;do 
	echo $dir
	sbatch -J "markdup" -t $time --mem=$mem -N 1 -n $threads -p general --mail-type=FAIL --wrap="java -Xmx40g -jar /n/sw/picard-tools-1.98/MarkDuplicates.jar INPUT=$dir/accepted_hits_sorted_picard.bam OUTPUT=$dir/accepted_hits_sorted_duplicates_marked.bam METRICS_FILE=dup_metrics.txt"
	sbatch -J "markdup" -t $time --mem=$mem -N 1 -n $threads -p general --mail-type=FAIL --wrap="java -Xmx40g -jar /n/sw/picard-tools-1.98/MarkDuplicates.jar INPUT=$dir/rmdup_accepted_hits_sorted_picard.bam OUTPUT=$dir/rmdup_accepted_hits_sorted_duplicates_marked.bam METRICS_FILE=dup_metrics.txt"
done
