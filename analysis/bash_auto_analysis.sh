

for i in {7..11};do
	sbatch -J R_auto -t 600 --mem-per-cpu=8000 -n 4 -p general --wrap="Rscript runScript.R $i"
#	sbatch -J R_auto -t 45 --mem-per-cpu=4000 -n 3 -p general --wrap="Rscript runScript.R $i"

done


#sbatch -J R_auto -t 600 --mem-per-cpu=8000 -n 4 -p general --wrap="Rscript runScript.R 2"
