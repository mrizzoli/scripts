#!/bin/bash
set -e  # Fail on errors
set -x  # Verbosity all the way

## Setta variabili e percorsi
src=$PWD/"markdown"
origine=$PWD
temporanea=$PWD/"tmp"
dest=$PWD/"Chapters"

##prepara ambiente
mkdir -p ${src}
mkdir -p ${temporanea}
mkdir -p ${dest}

##scarica file sorgente
cd ${src}

wget -O benenati.bib ${benenati}
wget -O Chapter1.md ${cap1}
wget -O Chapter2.md ${cap2}
wget -O Chapter3.md ${cap3}
wget -O Chapter4.md ${cap4}
wget -O Chapter5.md ${cap5}
wget -O Chapter6.md ${cap6}
wget -O note.md ${note}

##concatena md

for file in Chapter*
do
    echo "copio "$file" in "$temporanea""
    cat "$file" note.md >> ${temporanea}/$file
done

##esporta in latex

cd ${temporanea}

for file in *
do
    echo "esporto in latex "$file""
    pandoc --biblatex --chapters -o ${dest}/$file.tex $file
done

##cambia dir in /tesi/latex

cd ${dest}

for file in *
do
    mv $file ${file%%.*}.tex
done

##xelatex

cd ${origine}

xelatex template_tesi.tex
biber template_tesi
xelatex template_tesi.tex

git clone https://mrizzoli:${GH_TOKEN}@github.com/mrizzoli/tesi.git output/

cd output

git config --global user.email "marco@rizzoli.me.uk"
git config --global user.name "Marco Rizzoli"

git checkout -b tmp
cp ${origine}/*.pdf ${origine}/output/ 
git add *.pdf
git commit -m "update pdf"
git push -f origin tmp
