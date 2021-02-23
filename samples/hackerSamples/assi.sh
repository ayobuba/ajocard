#!/bin/bash

read line
# shellcheck disable=SC2046
printf "%.3f" $(echo "scale = 4; $line" | bc);
#read X
#read Y
#read Z
#
#if [ "$X" = "$Y" ] && [ "$Y" = "$Z" ]; then
#  echo "EQUILATERAL"
#elif [ "$X" != "$Y" ] && [ "$Y" != "$Z" ] && [ "$X" != "$Z" ] ; then
#      echo "SCALENE"
#else
#  echo "ISOSCELES"
#fi


#read Char
#SYES="y"
#BYES="Y"
#BNO="N"
#SNO="n"
#
#
#if  [ "$Char" = "$SYES" ] or  ; then
#    echo "YES"
#elif  [ "$Char" = "$BYES" ]  ; then
#    echo "YES"
#elif  [ "$Char" = "$SNO" ]  ; then
#    echo "NO"
#elif  [ "$Char" = "$BNO" ]  ; then
#    echo "NO"
#
#fi

#read int1
#int1=5
#int2=2
#echo $((int1 + int2))
#echo $((int1 - int2))
#echo $((int1 * int2))
#echo $((int1 / int2))

#Given two integers, X and Y, identify X<Y whether X > Y or  or .
#read X
#read Y
#
#if [ $X -gt $Y  ]; then
#    echo "X is greater than Y"
#elif [ $X -eq $Y  ]; then
#    echo "X is equal to Y"
#elif [ $X -lt $Y ]; then
#    echo "X is less to Y"
#fi

