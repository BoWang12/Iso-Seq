#!/uar/bin/perl -w
#usage: perl get_pacidv3geens_genomic_length.pl all_collapsed_transcript_genomic_region_size pacid_withv3_covered_genenumbers;
open A,"$ARGV[0]"||die $!;
$all=join'',<A>;
@tm=split(/\n/,$all);
close A;

open B,"$ARGV[1]"||die $!;
while(<B>){
    chomp;
    @sp=split(/\s+/,$_);
    $len1=length($sp[0]);
    foreach $line(@tm){
     @sec=split(/\s+/,$line);
     $len2=length($sec[0]);
     if(($len1==$len2)&&($sec[0]=~/$sp[0]/)){
        print "$sp[0]\t$sp[1]\t$sec[1]\n";}
     }
}
close B;

