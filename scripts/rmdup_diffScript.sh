####### AFTER broad seq, rerun all final samples with rmdup versions and follow through to reports #####
###### then process all either with or without rmdup and delete other set ####### 

####HEART####
#WT: 919,927,935
#KO: 920,928,936
wt_heart=/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_JR919/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_JR927/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_JR935/abundances.cxb
ko_heart=/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_JR920/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_JR928/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_JR936/abundances.cxb
./cuffdiff_strain.sh Trp53cor1 rmdup_E14.5_HEART $wt_heart $ko_heart

##### E14.5 Kidney 
ko_kidney=/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_kidney_ko1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_kidney_ko2/abundances.cxb
wt_kidney=/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_kidney_wt1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_kidney_wt2/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_kidney_wt3/abundances.cxb
./cuffdiff_strain.sh Trp53cor1 rmdup_E14.5_Kidney $wt_kidney $ko_kidney 

####  E14.5 Leg 
#take out WT4 and KO5 (both from the broad round of sequencing) b/c noise and JR879 in order to sex balance 
wt_leg=/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_JR878/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_JR880/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_JR881/abundances.cxb
ko_leg=/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_JR882/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_JR883/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_leg_ko4/abundances.cxb
./cuffdiff_strain.sh Trp53cor1 rmdup_E14.5_Leg $wt_leg $ko_leg

#### E14.5 Liver 
wt_liver=/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_JR917/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_JR925/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_JR933/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_liver_wt1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_liver_wt2/abundances.cxb
ko_liver=/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_JR926/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_JR934/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_liver_ko1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_liver_ko2/abundances.cxb
./cuffdiff_strain.sh Trp53cor1 rmdup_E14.5_Liver $wt_liver $ko_liver 

#### E14.5 Lung 
ko_lung=/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_lung_ko1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_lung_ko2/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_lung_ko3/abundances.cxb
wt_lung=/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_lung_wt1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_lung_wt2/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_lung_wt3/abundances.cxb
./cuffdiff_strain.sh Trp53cor1 rmdup_E14.5_Lung $wt_lung $ko_lung

#### mike MEFs
ko_mikeMEFs=/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_mikeMEFs_ko1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_mikeMEFs_ko2/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_mikeMEFs_ko3/abundances.cxb
wt_mikeMEFs=/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_mikeMEFs_wt1/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_mikeMEFs_wt2/abundances.cxb,/n/rinn_data1/users/agroff/seq/OtherMice/Diana/lincP21/quants/rmdup_mikeMEFs_wt3/abundances.cxb
./cuffdiff_strain.sh Trp53cor1 rmdup_mike_MEFs $wt_mikeMEFs $ko_mikeMEFs 
