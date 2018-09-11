##########################
#this program can build a map contained unigram and bigram information
#input:
#     a dir
#output:
#     word.dic
###############################################################
use strict;
my $inputdir=@ARGV[0];
my $outfile=@ARGV[1];

if($outfile eq undef){
  $outfile="word_ctb.dic";
}

open OUT,">$outfile"
or die "could not open the Output file!!!";

#######################################################open dictionary file
my %hdic;

if($inputdir eq undef){
  $inputdir = "input"
}
if(-d $inputdir){
  print "Read inputfile: $inputdir.....\n";   #### Read Inputdir
  opendir DIR,"$inputdir"
  or die"Could not open the input dir!!!";
  my @dir=readdir(DIR);
  chdir($inputdir);
  $/=undef;
  for(my $i=2;$i<scalar(@dir);$i++){
  my $infile=@dir[$i];
  $infile=~s/^ //gs;
  $infile=~s/ $//gs;
  open IN,"$infile"
  or die "Could not open the file: @dir[$i]";    ####open each file in the input dir
  my $str=<IN>;
  $str=~s/ +/ /gs;
  my @array=($str=~/\<S ID=\d+\>\s*(.*?)\s*\<\/S\>/gs);
  for(my $i=0;$i<scalar(@array);$i++){
    my @array1=split(/ /,@array[$i]);
    foreach (@array1){
      $hdic{$_}++
    }
  }
close IN;
  }
}
else{
  print "this is not a dir\n";
}
my @array2=sort({$hdic{$b}<=>$hdic{$a}}keys (%hdic));
for(my $i=0;$i<scalar(@array2);$i++){
  print OUT "@array2[$i]::$hdic{@array2[$i]}\n";
}
chdir("..");
print "Program finished\n";
close DIR;
close OUT;

##########################################


#############################################
