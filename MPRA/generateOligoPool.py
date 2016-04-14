import makeBarcodes
import makeElementPool
import sys
import pickle
import re

TAGS=5
barcodes=pickle.load(open("goodBarcodes.p","rb"))
#open file from cmd line
file=sys.argv[1]
records=makeElementPool.getSeqObjs(file)

#generate elements
pool={}
for rec in records:
	potentialElements=makeElementPool.tileElements(rec)
	pool.update(potentialElements)

#create array of universal-element-RE1-RE2-barcode-universal with 10 barcodes per element

UP1="ACTGGCCGCTTCACTG"
RE1="GGTACC" #Kpn1 (is this supposed to be #1?)
RE2="TCTAGA" #Xba1
UP2="AGATCGGAAGAGCGTCG" #rev comp of primer from tarjei's paper http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3297981/pdf/nihms-351608.pdf AGATCGGAAGAGCGTCG
targets=makeBarcodes.load_TargetScan_and_mirbase();

#def reverse_complement(dna):
#	dna_rev=dna[::-1]
#	dna_revA=dna_rev.replace("A","X") #will be T
#	dna_revAT=dna_revA.replace("T","A")
#	dna_revATC=dna_revAT.replace("C","Z") #will be G
#	dna_revATCG=dna_revATC.replace("G","C")
#	dnarevcomp=dna_revATCG.replace("X","T")
#	reverse_complement=dnarevcomp.replace("Z","G")
#	return str(reverse_complement)

finalOligoPool={}
filename=file.split(".")[0]
filename=filename+"Pool.txt"
finalOligoPoolFile=open(filename,'w')
#Oligo number/OligoID/finaloligo/name/barcode/#hits genome/element/strand/localcoords/RE1/RE2/Sfi/localOrder
print>>finalOligoPoolFile,"OligoNumber\tOligoID\tfinaloligo\tname\tbarcode\tgenome_hits\tElement\tstrand\tlocalCoordinates\tRE1\tRE2\tSfi\tLocalOrder"

barcodesUsed=0;
barcodeList=barcodes.keys()
elementNumber=1
for oligo in pool:
	print pool[oligo]
	numb=0
	for i in range(0,TAGS):
		if barcodesUsed>=12035:
			print "TOO MANY OLIGOS. EXCEEDING LIBRARY COUNT."
			sys.exit
		ithBarcode=str(barcodeList[barcodesUsed])
		finalOligo="".join([UP1,oligo,RE1,RE2,ithBarcode,UP2])

#check everything again at this final stage! (removed check from barcode generation)
#only one RE1 site
#only one RE2 site 
#no REX sites 
#no miR in RE2+UP2 

		RE1sites=sum(1 for m in re.finditer('GGTACC',finalOligo)) #want 1 
		RE2sites=sum(1 for m in re.finditer('TCTAGA',finalOligo)) #want 1
                Sfisites=sum(1 for m in re.finditer('GGCC[AaTtCcGg]{5}GGCC', finalOligo)) #want 0 or just 1 
		if RE1sites>1: 
			print "Too many RE1 sites in ",pool[oligo]," element"
		if RE2sites>1:
			print "Too many RE2 sites in ",pool[oligo]," element"
		if Sfisites>0:
			print "Too many SfiI sites in",pool[oligo]," element" 

		LocusOfOrigin,strand,localCoords,localOrder=pool[oligo].split(",")

		#Oligo number/OligoID/finaloligo/name/barcode/#hits genome/element/strand/localcoords/RE1/RE2/Sfi/localOrder
		print>>finalOligoPoolFile, "\t".join([str(barcodesUsed+1),".".join([str(elementNumber),str(i+1)]),finalOligo,LocusOfOrigin,ithBarcode,str(numb),oligo,strand,localCoords,str(RE1sites),str(RE2sites),str(Sfisites),localOrder])
		barcodesUsed+=1
	elementNumber+=1
print "Number of tags per element:" + str(TAGS)
