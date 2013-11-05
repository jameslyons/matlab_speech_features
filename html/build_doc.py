# this script uses the comments in each matlab function along with matlabs 'publish' function
# to generate documentation for this library.
# - matlab puts output in different html files for every function, this script combines them into one big one.
# - this script assumes it lives one directory down from all the '.m' files

import os
from bs4 import BeautifulSoup

# first run matlab 'publish' to get pretty docs for our functions
publishcode = "opts.codeToEvaluate = 'fs=16000;speech=randn(1,100);';\nopts.showCode = false;\naddpath ..\n"
dirList=os.listdir('..')
for fname in dirList:
    temp,ext = os.path.splitext(fname.strip())
    if ext != '.m': continue
    publishcode += "publish('" + fname + "',opts);\n";

f = open('publishcode.m','w')
f.write(publishcode)
f.close()

os.system("matlab -nodesktop -nosplash < publishcode.m")

# now take all the matlab output and put it in one file
# - note that currently we are outputting a html fragment, copy and paste it into an actual document
dirList=os.listdir('.')

for fname in dirList:
    temp,ext = os.path.splitext(fname.strip())
    if ext != '.html': continue
    with open(fname, 'r') as f: html_doc = f.read()
    soup = BeautifulSoup(html_doc)
    
    for tag in soup.find_all('h1'):
        tag.name = 'h2'
    for tag in soup.find_all('p'):
        try:
            if tag['class'] == ['footer']: tag.replace_with('')
        except: continue
    print soup.div
    
    
