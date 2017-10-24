#!/usr/bin/perl -w
#usage: perl calculate_noofv3genes_ineachpacgene_more_than_two_fgsgenes_covered_by_pacbio_gene_final_out.pl 2755pacgene_more_than_two_fgsgenes_covered_by_pacbio_gene_final_out >pacid_withv3_covered_genenumbers;
#
open A,"$ARGV[0]"||die $!;
while(<A>){
   chomp;
   @tm=split(/\s+/,$_);
   $pac=$tm[0];
   shift(@tm);
   $number=scalar(@tm);
   print "$pac\t$number\n";}
close A;

