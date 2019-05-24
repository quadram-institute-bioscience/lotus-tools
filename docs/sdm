# sdm - Simple DeMultiplexer

## Commands

Usage:

./sdm
  -i_path <path to several fastq / fasta files>
------OR------
 -i <input sequence file, will autodetect fna/fastq>
------OR------
 -i_fastq <fastQ file>
------OR------
 -i_fna <your fasta input file> (required)
 -i_qual <corresponding quality file> (required, unless quality file is "xx1.qual" and fasta is "xx1.yy")

 -map <mapping file in Qiime format> (optional)
 -o_fna <file to write output fasta> (optional)
 -o_qual <file to write corresponding quality values> (optional)
 -o_fastq <fastQ output file (overrides -o_qual & -o_fna)
 -options <sdm option file>(optional)
 -log <file to save demultiplex log in>(optional). Set to "nolog" to deactivate alltogether.
 
-sample_sep "X" string X is used to delimit samples and ID (optional, default:"__")
 -paired 1/2/3 (input is paired end sequenced(2), assumes two input files delimited by ','. 1=singleton (default); 3=paired end (R1,R3) + one file with MID (R2))
 -o_demultiplex [path] write input into single, demultiplexed files
 -onlyPair [1/2] consider only read pair 1 or 2. Useful when streamlining inputs (LotuS) or considering double barcoding.
 -i_MID_fastq fastq file with only MID sequences; if paired reads are supplied with -i_fna/-i_fastq and the MID identifier via -i_MID_fastq, paired has to be set to 2. If e.g. merged reads are supplied + mids, paired has to be set to 1.
 -oneLineFastaFormat [0/1] write Fasta and Quality file sequence string in one line, opposed to default 80 characters per line.
 -o_dereplicate <output fasta file> of dereplicated DNA reads (with size in header)
 -dere_size_fmt [0/1] either (0) usearch format "size=X;" or (1) "_X"
 -min_derep_copies only print seq if at least X copies present. Can be complex terms like "10:1,3:3" -> meaning at least 10x in 1 sample or 3x in 3 different samples.
 -SyncReadPairs [T/F] sdm can check, if read pairs occur in the same (correct) order in the input files, and correct this in case not (T).
 -maxReadsPerOutput number of filtered reads in output files. If more reads, a new file is created. Only works with -o_fna
 -mergedPairs <1/0> 1: paired sequences were merged externally, important for assumption that read quality is detoriating.
 -OTU_fallback <file>: Fallback fasta sequences for OTU's, only used in SEED extension mode
 -i_qual_offset [0-64] fastq offset for quality values. Set this to '0' or 'auto' if you are unsure which fastq version is being used (default: read from sdm option file)
 -o_qual_offset [0-64] set quality offset for fastq outfile. Default: 33
 -ignore_IO_errors [0/1]: 1=Errors in fastq reads are ignored, with sdm trying to sync reads pairs after corrupted single reads (default: 0)

Minimal Example:

```
./sdm -i test.fna -map mapping.txt (assuming quality file is "test.qual")
```

## Option File

The option file, specified via the "-options" argument, provides more specific control over filtering, 
barcode handling, and sequencing technologies, among others. 
A reference option file is printed below.


```
#--- Example ---
#copy into new file
#sequence length refers to sequence length AFTER removal of Primers, Barcodes and trimming. this ensures that downstream analyis tools will have appropiate sequence information
minSeqLength	250
maxSeqLength	1000
minAvgQuality	25

#Ambiguous bases in Sequence - uclust only supports 0 ambiguous nucleotides
maxAmbiguousNT	0

#Homonucleotide Runs.. this should normally be filtered by sequencer software
maxHomonucleotide	8

#Filter whole sequence if one window of quality scores is below average
QualWindowWidth	50
QualWindowThreshhold	25

#Trim the end of a sequence if a window falls below quality threshhold. Useful for removing low qulaity trailing ends of sequence

TrimWindowWidth	20
TrimWindowThreshhold	25

#Max number of accumulated P for a mismatch. After this length, the rest of the sequence will be deleted. Complimentary to TrimWindowThreshhold. (-1) deactivates this option.
maxAccumulatedError	1

#Barcode Errors - currently this can only be 0; 
maxBarcodeErrs	0
maxPrimerErrs	0

#keep Barcode / Primer Sequence in the output fasta file - in a normal 16S analysis this should be deactivated (0) for Barcode and de-activated (0) for primer
keepBarcodeSeq	0
keepPrimerSeq	0

#set fastqVersion to 1 if you use Sanger, Illumina 1.8+ or NCBI SRA files. Set fastqVersion to 2, if you use Illumina 1.3+ - 1.7+ or Solexa fastq files.

fastqVersion	1

#if one or more files have a technical adapter still included (e.g. TCAG 454) this can be removed by setting this option

TechnicalAdapter	TCAG

#delete X NTs (e.g. if the first 5 bases are known to have strange biases)

TrimStartNTs	0
#truncate total Sequence length to X (length after Barcode, Adapter and Primer removals)
TruncateSequenceLength	200
#correct PE header format (1/2) this is to accomodate the illumina miSeq paired end annotations 2="@XXX 1:0:4" instead of 1="@XXX/1". Note that the format will be automatically detected
PEheaderPairFmt	1

#sets if sequences without match to reverse primer will be accepted (T=reject ; F=accept all); default=F
RejectSeqWithoutRevPrim	F
#sets if sequences without a forward (LinkerPrimerSequence) primer will be accepted (T=reject ; F=accept all); default=T
RejectSeqWithoutFwdPrim	T

#checks if the whole amplicon was reverse-transcribed sequenced (Default = F)
CheckForReversedSeqs	F

#this option should be "T" if your amplicons are possibly shorter than a read in a paired end sequencing run (e.g. amplicon of 300 in 250x2 miSeq is "T")
AmpliconShortPE	T
```

