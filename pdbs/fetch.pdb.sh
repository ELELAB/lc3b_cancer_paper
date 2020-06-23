#!/bin/bash
wget -O "$1".pdb 'http://www.pdb.org/pdb/download/downloadFile.do?fileFormat=pdb&compression=NO&structureId='$1;
