#!/usr/bin/python3.5

### printing methods
# two ways to print in Python
name = 'Florence'
age = 73
print('%s is %d years old' % (name, age)) # common amongst many programming languages
print('{} is {} years old'.format(name, age)) # perhaps more consistent with stardard Python syntax

### dictionary
shopping_dict = {'item-0': 'bread', 'item-1': 'potatoes', 
                 'item-2': 'eggs', 'item-3': 'flour', 
                 'item-4': 'rubber duck', 'item-5': 'pizza', 
                 'item-6': 'milk'}
# different ways to iterate through each key/value and print it
for key in shopping_dict:
    print(key)
    print(shopping_dict[key])
for key, value in shopping_dict.items():
    print(key,value)
for i in shopping_dict.keys():
	print(i)
for i in shopping_dict.values():
	print(i)

### input method
temperature = int(input())

### Check if a variable or data type for example, a list (my_list) exists (not empty)
my_list=()

if 'my_list' in globals():
    print("my_list exists in globals")
    
if 'my_list' in locals():
    print("my_list exists in locals")

### lists/array handling
shopping = ['bread', 'potatoes', 'ggs', 'flour', 'rubber duck', 'pizza', 'milk']
extrashopping = ['cheese', 'flour', 'eggs', 'spaghetti', 'sausages', 'bread']

# Combining lists
all_items = shopping + extrashopping
# and then remove redundancy using set()
unique_items = set(all_items)

# or combining it right away without adding doubles
# slower though! (3times slower?)
for i in extrashopping:
	if i not in shopping:
		shopping.append(i)

### performance measurement
import timeit
start = timeit.timeit()
end = timeit.timeit()
print (end - start)

### read/write example with python3+
def read_each_line_of_each_file(pathname): # name of path with multiple files
    with open(pathname+"/receptor_proteins.csv",'w') as csv_out:
        for files in os.listdir(pathname):
            if files.endswith(".csv"):
                csv_out.write("%s: \n" % files)
                with open(pathname+"/"+files,'r') as csv_files:
                    for entry in csv_files:
                        if ('receptor') in entry.lower():
                            csv_out.write("%s\t%s\n" % (entry.split("\t")[0],entry.split("\t")[3]))

pathname = 'demo_folder' # name of path with multiple files
read_each_line_of_each_file(pathname)

with open(pathname+"/receptor_proteins.csv",'r') as new_csv:
    for entry in new_csv:
        print(entry)

### module sys allows you to pipe elements to code
# call in bash
python script.py element1 element2 element3

# in script:
import sys

var = []
for i in sys.argv:
    var.append(i)



