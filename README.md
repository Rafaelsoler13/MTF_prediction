# MTF_prediction

Here is the code used to perform the analysis of the paper. Inside the folders you can find the _awk_ files to obtain the proper transmembrane domain. Also, _tf_running_captum.py_ is the python modify version to obtain Captum interpretation.

<img src="https://github.com/Rafaelsoler13/MTF_prediction/blob/main/Figure_1.png" width="500">

### UniProtKB 2022_05 Version Used

#MEMBRANE PROTEINS

`
(organism_id:9606) AND (reviewed:true) AND (keyword:KW-0472) #human -> 7663
`

`
(organism_id:10090) AND (reviewed:true) AND (keyword:KW-0472) #mouse -> 6527
`

## FOR CYTOPLASMIC

#### Filter search from UniProt
`
(organism_id:9606) AND (reviewed:true) AND (ft_topo_dom:cytoplasmic) #human
`

`
(organism_id:10090) AND (reviewed:true) AND (ft_topo_dom:cytoplasmic) #mouse
`

#Download data GFF from UniProt

#### Filter to obtain only Cytoplasmic domains

`
grep "Cytoplasmic" cytoplasmic.gff > cytoplasmic_filtered.gff
`

#### AWK to adapt to UniProt format

`
awk -F "\t" '{print $1"["$4"-"$5"]"}' cytoplasmic_filtered.gff > cytoplasmic_filtered_IDs.csv
`

#Download fasta with these coords with "Retrieve/ID mapping", from "UniProtKB AC/ID" to "UniProtKB", format: FASTA (saurce list)

#### Run DeepTFactor

`
conda activate deeptfactor
`
`
python tf_running.py -i ~/cytoplasmic.fasta -g cuda -o ~/result
`

#### Filter the positive results

`
grep "True" prediction_result.txt | sort -rn -k3 > cytoplasmic_true.csv 
`

#### Extract UniProtKB AC/IDs to download GeneNames with "Retrieve/ID mapping"

`
awk '{print $1}' cytoplasmic_true.csv | cut -c 4- | cut -f1 -d"|" > uniprot_names.csv
`

----------------


### Same but substract half of the TMD

`
awk -f half_cytoplasmic.awk cytoplasmic.gff > cytoplasmic_filtered.gff
`

`
awk -F "\t" '{print $1"["$4"-"$5"]"}' cytoplasmic_filtered.gff > cytoplasmic_filtered_IDs.csv
`

`
python tf_running.py -i ~/cytoplasmic.fasta -g cuda -o ~/result
`

`
grep "True" prediction_result.txt | sort -rn -k3 > all_cytoplasmic_true.csv 
`

`
awk '{print $1}' all_cytoplasmic_true.csv | cut -c 4- | cut -f1 -d"|" > uniprot_names.csv
`

#Manually eliminate the duplicates keeping the highest score

----------------


### Same but substract full TMD

`
awk -f full_cytoplasmic.awk cytoplasmic.gff > cytoplasmic_filtered.gff
`

`
awk -F "\t" '{print $1"["$4"-"$5"]"}' cytoplasmic_filtered.gff > cytoplasmic_filtered_IDs.csv
`

`
python tf_running.py -i ~cytoplasmic.fasta -g cuda -o ~/result
`

`
grep "True" prediction_result.txt | sort -rn -k3 > all_cytoplasmic_true.csv 
`

`
awk '{print $1}' all_cytoplasmic_true.csv | cut -c 4- | cut -f1 -d"|" > uniprot_names.csv
`

#Manually eliminate the duplicates keeping the highest score

----------------
----------------

## FOR EXTRACELLULAR

#### Filter search from UniProt

`
(organism_id:9606) AND (reviewed:true) AND (ft_topo_dom:extracellular) #human
`

`
(organism_id:10090) AND (reviewed:true) AND (ft_topo_dom:extracellular) #mouse
`

#### Filter to obtain only Extracellular domains

`
grep "Extracellular" extracellular.gff > extracellular_filtered.gff
`

#### AWK to adapt to UniProt format

`
awk -F "\t" '{print $1"["$4"-"$5"]"}' extracellular_filtered.gff > extracellular_filtered_IDs.csv
`

#Download fasta with these coords with "Retrieve/ID mapping", from "UniProtKB AC/ID" to "UniProtKB", format: FASTA (saurce list)

#### Run DeepTFactor

`
conda activate deeptfactor
`

`
python tf_running.py -i ~/extracellular.fasta -g cuda -o ~/result
`

#### Filter the positive results

`
grep "True" prediction_result.txt | sort -rn -k3 > extracellular_true.csv 
`

#### Extract UniProtKB AC/IDs to download GeneNames with "Retrieve/ID mapping"

`
awk '{print $1}' extracellular_true.csv | cut -c 4- | cut -f1 -d"|" > uniprot_names.csv
`

----------------


### Same but substract half of the TMD

`
awk -f half_extracellular.awk extracellular.gff > extracellular_filtered.gff
`

`
awk -F "\t" '{print $1"["$4"-"$5"]"}' extracellular_filtered.gff > extracellular_filtered_IDs.csv
`

`
python tf_running.py -i ~/extracellular.fasta -g cuda -o ~/result
`

`
grep "True" prediction_result.txt | sort -rn -k3 > extracellular_true.csv 
`

`
awk '{print $1}' extracellular_true.csv | cut -c 4- | cut -f1 -d"|" > uniprot_names.csv
`

#Manually eliminate the duplicates keeping the highest score


----------------


### Same but substract full TMD

`
awk -f full_extracellular.awk extracellular.gff > extracellular_filtered.gff
`

`
awk -F "\t" '{print $1"["$4"-"$5"]"}' extracellular_filtered.gff > extracellular_filtered_IDs.csv
`

`
python tf_running.py -i ~/extracellular.fasta -g cuda -o ~/result
`

`
cd /home/victor/deeptfactor/2022_analysis_final/extracellular/human_extracellular_full/result
`

`
grep "True" prediction_result.txt | sort -rn -k3 > extracellular_true.csv 
`

`
awk '{print $1}' extracellular_true.csv | cut -c 4- | cut -f1 -d"|" > uniprot_names.csv
`

#Manually eliminate the duplicates keeping the highest score

-------------
-------------

# FOR LUMENAL

#### Filter search from UniProt

`
(organism_id:9606) AND (reviewed:true) AND (ft_topo_dom:lumenal) #human
`

`
(organism_id:10090) AND (reviewed:true) AND (ft_topo_dom:lumenal) #mouse
`

#### Filter to obtain only Lumenal domains

`
grep "Lumenal" lumenal.gff > lumenal_filtered.gff
`

#### AWK to adapt to UniProt format

`
awk -F "\t" '{print $1"["$4"-"$5"]"}' lumenal_filtered.gff > lumenal_filtered_IDs.csv
`

#Download fasta with these coords with "Retrieve/ID mapping", from "UniProtKB AC/ID" to "UniProtKB", format: FASTA (saurce list)
#### Run DeepTFactor

`
conda activate deeptfactor
`

`
python tf_running.py -i ~/lumenal.fasta -g cuda -o ~/result
`


#### Filter the positive results

`
grep "True" prediction_result.txt | sort -rn -k3 > lumenal_true.csv 
`

#### Extract UniProtKB AC/IDs to download GeneNames with "Retrieve/ID mapping"

`
awk '{print $1}' lumenal_true.csv | cut -c 4- | cut -f1 -d"|" > uniprot_names.csv
`

-------------


### Same but substract half of the TMD

`
awk -f half_lumenal.awk lumenal.gff > lumenal_filtered.gff
`

`
awk -F "\t" '{print $1"["$4"-"$5"]"}' lumenal_filtered.gff > lumenal_filtered_IDs.csv
`

`
python tf_running.py -i ~/lumenal.fasta -g cuda -o ~/result
`

`
grep "True" prediction_result.txt | sort -rn -k3 > lumenal_true.csv 
`


`
awk '{print $1}' lumenal_true.csv | cut -c 4- | cut -f1 -d"|" > uniprot_names.csv
`

-------------

### Same but substract full TMD

`
awk -f full_lumenal.awk lumenal.gff > lumenal_filtered.gff
`

`
awk -F "\t" '{print $1"["$4"-"$5"]"}' lumenal_filtered.gff > lumenal_filtered_IDs.csv
`

`
python tf_running.py -i ~/lumenal.fasta -g cuda -o ~/result
`

`
grep "True" prediction_result.txt | sort -rn -k3 > lumenal_true.csv 
`

`
awk '{print $1}' lumenal_true.csv | cut -c 4- | cut -f1 -d"|" > uniprot_names.csv
`

#Manually eliminate the duplicates keeping the highest score

**#Domains greater than 1000 amino acids were not analyzed due to the limitation of the tool.**

-------------
-------------

#### Check errors (Proteins with "U" aas)

`
grep -hv "^>" extracellular.fasta > error.fasta
`

`
grep "U" error.fasta
`

#### Use of Integrated Gradients

`
python tf_running_captum.py -i ATF6A.fasta -g cuda -o ./results_captum
`
