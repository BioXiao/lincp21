#!/bin/py
import re
import itertools
from Bio import SeqIO
from Bio.Seq import Seq
import collections
import pickle

def load_TargetScan_and_mirbase():
	targets={};
	faFile="mirbase_mature.fa"
	handle = open(faFile, "rU")
	for mir in SeqIO.parse(handle,"fasta"):
        	if "mmu" in str(mir.id):
                	seed=mir.seq[2:9]
                	target_seed=seed.reverse_complement()
                	target_seed=target_seed.back_transcribe()
			target_seed=str(target_seed)
                	targets[target_seed]=target_seed
	handle.close()
	miRseedsFile="/n/rinn_data2/users/agroff/oligogames/DesignScripts/targetscan/murineMIRs.txt"
	with open (miRseedsFile,'r') as f:
		for line in f:
			line=Seq(line.rstrip())
			line=line.reverse_complement()
			line=str(line.back_transcribe())
			targets[line]="mir"	
	f.close()
	print "targets loaded"
	return targets


def contains_miRseed(targets,seq):
	for key in targets.keys():
		if key in seq:
			return True
	return False;

def find_runons(barcode):
	#4+ nt stretches
	if re.match(r'A{5,10}',barcode):
		return True;
       	if re.match(r'T{5,10}',barcode):
		return True;
       	if re.match(r'C{5,10}',barcode):
		return True;
       	if re.match(r'G{5,10}',barcode):
		return True;
	return False;

def contains_REsite(barcode):
	if re.search('^TC',barcode): #bc Xba1 is RE2, barcode cannot start w TC or Xba1 will not cut. 
		return True;
	if 'GGTACC' in barcode:
		return True;
	if 'TCTAGA' in barcode:
		return True;
	return False;

def runMakeBarcodes(good_barcodes,bad_barcodes,containMir):
	#generate 10^4 unique sequences
	barcodes=map(''.join,itertools.product('ATCG',repeat=10))
	targets=load_TargetScan_and_mirbase();
	#universal primer site 2
	UP2="AGATCGGAAGAGCGTCG" #http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3297981/pdf/nihms-351608.pdf
	ALLNTs=set('ATCG')
	for barcode in barcodes:
		if find_runons(barcode):
			bad_barcodes[barcode]=barcode;
			continue;
		if contains_REsite(barcode):
			bad_barcodes[barcode]=barcode;
			continue;
		if not(ALLNTs.issubset(barcode)): #tests whether every element in s is in t
			bad_barcodes[barcode]=barcode
			continue;
		if contains_miRseed(targets,barcode+UP2): #get rid of any with microRNA seeds, in barcode and barcode+UP2
			containMir[barcode]=barcode
			continue;
		good_barcodes[barcode]=barcode #CAT UP2
	return good_barcodes,bad_barcodes,containMir

if __name__ == "__main__":
	good_barcodes={}
	bad_barcodes={}
	containMir={}
	
	good_barcodes,bad_barcodes,containMir=runMakeBarcodes(good_barcodes,bad_barcodes,containMir)

	print len(good_barcodes)
	print len(containMir)
	print len(bad_barcodes)
	pickle.dump(good_barcodes,open("goodBarcodes.p","wb"))
