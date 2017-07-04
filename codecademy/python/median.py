def median(numlist):
    print "input:",numlist
    numlist.sort()
    print "sorted:",numlist
    print "len numlist:",len(numlist)
    if len(numlist)%2 == 0:
        mid = (len(numlist)-1)/2
        median = (numlist[mid] + numlist[mid+1])/2.0
        print "even, median:",median
        
    else:
        mid = (len(numlist)-1)/2
        median = numlist[mid]
        print "uneven, median:",median
    return median


median([1, 34, 1, 6, 8, 0])
