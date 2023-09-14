import re
from collections import defaultdict

novel = open("the_days_play.txt","r",encoding = "utf8")
allwords = open("allwords.txt","w")
worddict = defaultdict(int)
freqdict = defaultdict(int)

# lowercase and separating words into allwords.txt while incrementing frequency in worddict for each word
for line in novel:
    if line.strip():
        for word in re.findall('[a-z]+',line.lower()):
            allwords.write(word + '\n')
            worddict[word] += 1
allwords.close()

uniquewords = open("uniquewords.txt","w")
# iterating over worddict to find unique words (only one occurence in txt) and writing to uniquewords.txt
for key in worddict:
    if worddict[key] == 1:
        uniquewords.write(key + "\n")

uniquewords.close()

wordfreq = open("wordfrequency.txt","w")
# using another dictionary to make a wordcount of specific frequencies, later writing to wordfreq.txt
for freq in worddict.values():
    freqdict[freq] += 1

for key in sorted(freqdict):
    wordfreq.write(f"{key}: {freqdict[key]}\n")

wordfreq.close()