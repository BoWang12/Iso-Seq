#!/usr/bin/perl -w
##usage: perl seleect1721fromgff.pl 1721isoforms_notinto_compare all.collapsed.gff;

open A,"$ARGV[0]"||die $!;
$all=join'',<A>;
@id=split(/\n/,$all);
close A;

open B,"$ARGV[1]"||die $!;
open O,">1721missed.collapsed.gff"||die $!;
while(<B>){
  chomp;
  @tm=split(/\"/,$_);
  $in_len=length($tm[3]);
  foreach $line(@id){
    $qry_len=length($line);
    if(($line=~/$tm[3]/)&&($in_len==$qry_len)){
       print O "$_\n";}
   }
}

close B;
close O;

