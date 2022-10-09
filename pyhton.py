string = "123+4"
i=0
n=0
fin=0
while string[i] != '+':
    n = int(string[i])
    if(i>1):
        n=n*10
    fin=fin+n

    i=i+1
    print(fin)
