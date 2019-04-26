# This is a quick and hacky implementation of Rekognition being used to scan for donuts.
# mkuenning@anki.com, version .01

from collections import Counter
import string
import boto3
import json
import os
import re

if os.path.exists("DonutCount.txt"):
    os.remove("DonutCount.txt")

if __name__ == "__main__":

    imageFile=r'/home/mkuenning/donutbot/node_modules/hubot-donut/src/snapshot.jpg'
    client=boto3.client('rekognition')

    reportFile = open("DonutCount.txt","w")

    with open(imageFile, 'rb') as image:
        response = client.detect_labels(Image={'Bytes': image.read()})

    for label in response['Labels']:
        #print (label['Name'] + ' : ' + str(label['Instances']))
        #print("Iterating...")
        dataWeWant = (label['Instances'])
        dataWeWantString = json.dumps(dataWeWant)
        #print(dataWeWantString)
        reportFile.write(dataWeWantString + '\n')

    reportFile.close()

    def tokenize():
        if finalCount is not None:
            splitData = finalCount.lower().split()
            return splitData
        else:
            return None

    def count_word(tokens, token):
        count = 0

        for element in tokens:
            # Remove Punctuation
            word = element.replace(",","")
            word = word.replace(".","")

        # Found Word?
            if word == token:
                count += 1
        return count

#    with open('DonutCount.txt') as inputfile:
#        f = inputfile.read().translate(remove)       

    with open('DonutCount.txt', 'r') as file:
        finalCount = file.read().replace('\n', '')
        #print(type(finalCount))

    finalDonutData = tokenize()
    #print(type(finalDonutData))
 
    quickSet = re.findall(r'"(.*?)"', finalCount)
    #print(quickSet)
    #print(type(quickSet))

    word = 'BoundingBox'
    frequency = count_word(quickSet, word)
    #print('Word: [' + word + '] Frequency: ' + str(frequency))

    finalNumber = str(frequency)
    print(finalNumber)
    reportFinal = open("DonutNumber.txt","w")
    reportFinal.write(finalNumber)
    reportFinal.close()
