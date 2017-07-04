def remove_duplicates(numlist):
    print numlist
    unique = []
    for i in range(0,len(numlist)):
        if numlist[i] not in unique:
            unique.append(numlist[i])
    print unique
    return unique
    
remove_duplicates([2,2,4,5,4,3,34])

