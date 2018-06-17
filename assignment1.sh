#!/bin/sh

loop1(){
  if [ `cat $tmpfile1|wc -l` -gt 0 ]; then
    c1=0
    cat $tmpfile1|while read line1
    do
      echo $line1
      c1=`expr $c1 + 1`
      if [ $c1 -eq 2 ]; then
        loop2
        c1=0
      fi
    cat $tmpfile1|grep -v "$line1" > /tmp/file1.tmp
    mv /tmp/file1.tmp $tmpfile1
    done
  fi
}

loop2(){
  c2=0
  line2=`head -1 $tmpfile2`
  echo $line2
  cat $tmpfile2|grep -v "$line2" > /tmp/file2.tmp
  mv /tmp/file2.tmp $tmpfile2
}

clean(){
  [ -f $tmpfile1 ] && rm -rf $tmpfile1
  [ -f $tmpfile2 ] && rm -rf $tmpfile2
}

# ----------------------------------------------
# main
[ $# -ne 2 ] && echo "[ERROR]: Not enough parameter, exiting..." && exit 1

file1=$1
file2=$2

tmpfile1="/tmp/file1"
tmpfile2="/tmp/file2"

cp $file1 $tmpfile1
cp $file2 $tmpfile2

while [ `cat $tmpfile1|wc -l` -gt 0 ];
do
  loop1
done

while [ `cat $tmpfile2|wc -l` -gt 0 ];
do
  loop2
done
# ----------------------------------------------
exit $?
