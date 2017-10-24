#!/usr/bin/perl -w

##This script is used to select more than two genes(not transcripts) covered by per pacbio gene based on 'v3genes_harbored_by_per_pacbio_gene' result;
##usage: perl select_more_than_one_gene_covered_by_pacbio.pl v3genes_harbored_by_per_pacbio_gene;

open A,"$ARGV[0]" || die $!;
open T,">temp" || die $!;

while(<A>){
   $count=0;
   chomp;
   @sp=split(/\t/,$_);
   $pac=shift(@sp);
   $num=scalar(@sp);
   $qry=shift(@sp);
   @sec=split(/\_/,$qry);
   if($num>1){
    print T "$pac\t$sec[0]";
     foreach $left(@sp){
      $id=trim($left);
       if($id!~/$sec[0]/){
         print T "\t$id";}
    else{next;}
  }
      print T "\n";
}
   else{next;}
}
  

close A;

sub trim {
    my $new=shift;
    my @sp=split(/\_/,$new);
    return $sp[0];
 }

open B,"temp" || die $!;
open C,">temp2" || die $!;
while(<B>){
   chomp;
   @st=split(/\t/,$_);
   $count=scalar(@st);
   if($count>2){
    $pacid=shift(@st);
    foreach $le(@st){
      print C "$pacid\t$le\n";}
 }
}
close B;
close C;

system "cat temp2 \| sort \| uniq \> uniq_paccovered";
system "awk \'\{print \$1\}\' uniq_paccovered \| sort \| uniq \>uniq_paccovered_id";

open D,"uniq_paccovered_id" || die $!;
open E,"uniq_paccovered" || die $!;
open F,">v3Refgenes_harbored_by_per_pacbio_gene" || die $!;
$all=join'',<E>;
@arr=split(/\n/,$all);
close E;

while(<D>){
    chomp;
    $len1=length($_);
    print F "$_";
    foreach $name(@arr){
      @se=split(/\t/,$name);
      $len2=length($se[0]);
      if(($se[0]=~/$_/) && ($len1==$len2)){
         print F "\t$se[1]";}
    }
    print F "\n";
}

close D;
close E;
close F;

open G,"v3Refgenes_harbored_by_per_pacbio_gene" || die $!;
open R,">Result" || die $!;
while(<G>){
   chomp;
   @qq=split(/\t/,$_);
   $pac=shift(@qq);
   $new=join("\t",@qq);
   @re=split(/\./,$pac);
   $id=join('.',$re[0],$re[1]);
   print R "$id\t$new\n";}
close G;
close R;

system "cat Result \| sort \| uniq \>Result_v3Refgenes_harbored_by_per_pacbio_gene";




