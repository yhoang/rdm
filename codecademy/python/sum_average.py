grades = [100, 100, 90, 40, 80, 100, 85, 70, 90, 65, 90, 85, 50.5]

def grades_sum(gradeslist):
    gradessum = 0
    for i in gradeslist:
        gradessum += i
    return gradessum

def grades_average(gradeslist):
    gradessum = grades_sum(gradeslist)
    gradesaverage = gradessum/float(len(gradeslist))
    print gradesaverage
    return gradesaverage
    
ave = grades_average(grades)
print ave

grades_average([9,2,2,7,6,9])
