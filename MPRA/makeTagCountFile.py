###########################################################
### counts tags from GFP lib and prints bed of coverage ###
###########################################################

#!/bin/py
import copy
import re
import itertools
from Bio import SeqIO
from Bio.Seq import Seq
import collections
import pickle
import sys

#read in all replicates 
files=sys.argv[1:] 
dSearch=pickle.load(open("BarcodeDictionarySearch.p",'rb'))
outFile="tag_rep_counts.tab"
out=open(outFile,'w')
elementDict=pickle.load(open("elementDict.p",'rb'))
allElements=pickle.load(open("allElements.p",'rb'))
barcodesUsed=open("barcodesUsed.txt",'rb')
finalCountTable=dict();#initialize as tag-indexed dictonary of arrays
initCounts=dict(); #initialize as dictionary set to zeros of all barcodes 
for tag in barcodesUsed:
	tag=tag.strip()
	finalCountTable[tag]=[tag]
	initCounts[tag]=0
barcodesUsed.close()

header=["tags"];

for f in files:
	tagCounts=copy.deepcopy(initCounts)
	handle=open(f,"rU")
	OligosFromSeq=SeqIO.parse(handle, "fastq-sanger") #not illumina?!!? get invalid character warning.. 
	for oligo in OligosFromSeq:
        	if 'TTATTCTT' in oligo.seq: #and min(oligo.letter_annotations["phred_quality"])>=20:# if has GFP and passses quality filter: #TTATTCTTCAC
               		b=str(oligo.reverse_complement().seq[-10:]) # need to look for the reverse complement of the barcode!			
			# if barcode exists, increase count occurance of that barcode
			if "N" in b:
				continue; #may want break
			if b in dSearch[b[0]][b[1]][b[2]].keys():
				tagCounts[b]+=1
	handle.close()
	header.append(f)
	for tag in finalCountTable: #transfer final counts to correct place in finalcount table #this is probably not efficient way to do this
		finalCountTable[tag].append(tagCounts[tag])
		
	
print>>out,"\t".join(header)	
for tag in finalCountTable:
#	print finalCountTable[tag]
	vec=list(finalCountTable[tag][1:])
	vec2="\t".join(map(str,vec))
	print>>out, "\t".join([finalCountTable[tag][0],vec2])
#	print vec
