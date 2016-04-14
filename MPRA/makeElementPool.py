#!/bin/py
from Bio import SeqIO
import collections
import re

def getLocus():
	faFile="whole_peril_locus_mm10.fa"
	handle = open(faFile, "rU")
	records=list(SeqIO.parse(handle, "fasta"))
	handle.close()
	return records

def getSeqObjs(file):
        handle = open(file, "rU")
        records=list(SeqIO.parse(handle, "fasta"))
        handle.close()
	return records

def infoFromDescription(seqObj):
#	seqObj=object[0]
	id=seqObj.id
	desc=seqObj.description
	items=desc.split()
	coords=items[1].split('=')[1]
	strand=items[4].split('=')[1]
	return coords,strand, id

#def tileElements(seqIOlocusList):
def tileElements(seqIOobject):
	potentialElements=collections.OrderedDict() # make a dict of lists... 
	dontUse=collections.OrderedDict()
#	seqIOobject=seqIOlocusList[0]
	locus=seqIOobject.seq
	seqLength=len(locus)	
	i=0; # start
	j=90; # elementSize/end ##check indexing 	
	tileWindow=49 #tile size-1 
#	print seqIOobject.description
	coord,strand,id=infoFromDescription(seqIOobject)
	chr,points=coord.split(":")
	start,end=points.split("-")
	localOrder=1
	if strand=="NA":
		start=1;end=seqLength;

	while j < seqLength+1: ##check indexing
		element=str(locus[i:j])
		if strand=="+":
			localStart=int(start)+i #CHECK INDEXING 
			localEnd=int(start)+(j-1)
			localCoords=chr+":"+str(localStart)+"-"+str(localEnd)
		if strand=="-":
			localStart=int(end)-i
			localEnd=int(end)-(j-1)
			localCoords=chr+":"+str(localEnd)+"-"+str(localStart)
		if strand=="NA":
                        localStart=int(start)+i #CHECK INDEXING
                        localEnd=int(start)+(j-1)
                        localCoords=chr+":"+str(localStart)+"-"+str(localEnd)

		if ('GGTACC' in element):
			dontUse[element]=str(i) #[",".join([str(i),tag])] #not even checking whether in rev 
			i=i+1;j=j+1
			continue;	
		if ('TCTAGA' in element):
			dontUse[element]=str(i) #[",".join([str(i),tag])] #not even checking rev
			i=i+1;j=j+1
			continue
#		if sum(1 for m in re.finditer('GGCC[AaTtCcGg]{5}GGCC', element))>0: 
		if re.search('GGCC[AaTtCcGg]{5}GGCC',element): #GGCCNNNNNGGCC = SfiI site
			dontUse[element]=str(i)
			i=i+1;j=j+1
			continue
		if element in potentialElements.keys():
			potentialElements[element].append(",".join([id,strand,localCoords,localOrder,"repetitive"]))
			# THIS MEANS ELEMENT OCCURS MULT TIMES/IS REPETITIVE (firre) but dont want to exclude this! just keep in mind during analysis! 
		else:
			potentialElements[element]=",".join([id,strand,localCoords,str(localOrder)])
		localOrder+=1
		i+=tileWindow
		j+=tileWindow

	return potentialElements


if __name__ == "__main__":
	locus=getLocus()
	potentialElements=tileElements(locus)
	print potentialElements
	print len(potentialElements)


#These are every single element, tiled at 1bp. NOW go through and take every 50 elementByPos
#	print len(dontUse)

# generate barcodes that do not contain RE1, RE2, REX and no microRNA sites
# b.c inefficiency, 10 barcodes per element. 1.2k elements
# bc enhancer, do both orientations - 600 elements, 90bp each. 

# create 90bp elements, tiling 1 bp resolution, keep track of start position in gene 
	# make dictionary. toss any dups? -- maybe keep one as element but flag in mapping file as occuring multiple times 
	# dict of lists -- list of start positions 
	# iterate through dict 
		# toss any elements with RE sites 1,2,X 
	# print length of dict 
		# how to decide tiling coverage?? 
		# take first. find next. if <10 next, if 10 take it, if >30 take last unless < 3 
		# visualize coverage 
		# print number of elements and approx coverage 
