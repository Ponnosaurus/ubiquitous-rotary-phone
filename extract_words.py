import re
from collections import defaultdict

novel = open("pg71638.txt","r",encoding = "utf8")
allwords = open("allwords.txt","w")
worddict = defaultdict(int)
freqdict = defaultdict(int)

for line in novel:
    if line.strip():
        for word in re.findall('[a-z]+',line.lower()):
            allwords.write(word + '\n')
            worddict[word] += 1

allwords.close()

uniquewords = open("uniquewords.txt","w")

for key in worddict:
    if worddict[key] == 1:
        uniquewords.write(key + "\n")

uniquewords.close()

wordfreq = open("wordfrequency.txt","w")

for freq in worddict.values():
    freqdict[freq] += 1

for key in sorted(freqdict):
    wordfreq.write(f"{key}: {freqdict[key]}\n")

wordfreq.close()