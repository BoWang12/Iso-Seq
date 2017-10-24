#!/usr/bin/perl -w
##perl count_eachgene_iso.pl pac_gene_iso;
open A,"$ARGV[0]"||die $!;
while(<A>){
   chomp;
   @tm=split(/\s+/,$_);
   $num=scalar(@tm);
   $count=$num-1;
   print "$tm[0]\t$count\n";}
close A;
