#!/usr/bin/perl -w

###This script is used to calculate how many annotated maive v3 transcripts are covered by each pacbio gene, to further see are these annotated genes complete or not?
##usage: perl number_of_overlapv3_transcripts_covered_by_each_pacbiogene.pl annoatedv3_overlap_pacbio_exon_uniq >v3genes_harbored_by_per_pacbio_gene;

open A,"$ARGV[0]" || die $!;
open B,">temp" || die $!;

while(<A>){
   chomp;
   @sp=split(/\s+/,$_);
#   @sec=split(/\./,$sp[4]);
#   $pacgene=join'.',$sec[0],$sec[1];
 #  print B "$sp[0]\t$pacgene\n";}
   print B "$sp[0]\t$sp[4]\n";}

close A;
close B;

system "cat temp \| uniq \>temp_uniq"; 
system "awk \'\{print \$1\}\' temp_uniq \| sort \| uniq \>overlapped_v3_geneid";
system "awk \'\{print \$2\}\' temp_uniq \| sort \| uniq \>overlapped_pacbio_geneid";

open C,"temp_uniq" || die $!;
open D,"overlapped_pacbio_geneid" || die $!;
#open E,"overlapped_v3_geneid" || die $!;
open PAC,">v3genes_harbored_by_per_pacbio_gene" || die $!;

$all=join'',<C>;
@al=split(/\n/,$all);
close C;

while(<D>){
   chomp;
   print PAC "$_";
   $len1=length($_);
   foreach $ele(@al){
    chomp($ele);
    $v3id=get_v3gene($ele);
    $pacid=get_pacid($ele);
    $len2=length($pacid);
    if(($pacid=~/$_/) && ($len1==$len2)){
     print PAC "\t$v3id";}
}
print PAC "\n";}

close D;

sub get_v3gene {
   my $v3=shift;
   my @arr=split(/\t/,$v3);
   return $arr[0];
}

sub get_pacid{
   my $pac=shift;
   my @se=split(/\t/,$pac);
   return $se[1];
}
