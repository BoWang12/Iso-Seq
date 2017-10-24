#!/usr/bin/perl -w

## This script is used to see if an annotated transcript has any overlap with exon region of a long-read transcript;
#usage: perl annotated_overlap_with_pacbio_exon.pl pacbio_exon_chain_each_transcript /sonas-hs/ware/hpc/data/bwang/maize/FGS/fgs.transcripts;

open A,"$ARGV[0]" || die $!;
$annot=join'',<A>;
@pacbio=split(/\n/,$annot);
close A;

open B,"$ARGV[1]" || die $!;
open O, ">annotated_overlap_with_pacbio_exon"||die $!;
while(<B>){
    chomp;
    $transcript=trim($_);
        $chr=get_chr($_);
        $transcript_start=start($_);
        $transcript_stop=stop($_);
        $len1=length($chr);
    foreach $pac(@pacbio){
        @sp=split(/\s+/,$pac);
        $total=scalar(@sp);
        $len2=length($sp[0]);
      for($i=0;$i<$total-3;$i=$i+1){
        if(($chr=~/$sp[0]/) && ($len1==$len2)){
         if((($transcript_start<$sp[$i+2]) && ($transcript_stop>$sp[$i+2])) || (($transcript_start<$sp[$i+3]) && ($transcript_stop>$sp[$i+3])))
{
           print O "$transcript has overlap with $sp[1] exon\n";}
         }
 }
}
}
close B;
close O;

sub trim {
   my $transcript=shift;
   my @sec=split(/\t/,$transcript);
   my @thd=split(/\;/,$sec[8]);
   my @fou=split(/\:/,$thd[0]);
   return $fou[1];
 }

sub get_chr {
   my $chr=shift;
   my @ch=split(/\t/,$chr);
   return $ch[0];
}

sub start {
   my $trans=shift;
   my @new=split(/\t/,$trans);
   return $new[3];
}

sub stop {
   my $sto=shift;
   my @st=split(/\t/,$sto);
   return $st[4];
}
