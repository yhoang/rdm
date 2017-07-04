### open file and write
my_list = [i**2 for i in range(1,11)]
my_file = open("output.txt", "r+")

for item in my_list:
    my_file.write(str(item))
    my_file.write("\n")
    
my_file.close()

### open file and read only
my_file = open("output.txt","r")
print my_file.read()
my_file.close()

### open file and read only line by line
my_file = open("text.txt", "r")
print my_file.readline()
my_file.close()

### automatically close after written
with open("text.txt", "w") as textfile:
	textfile.write("Success!")

### if Abfrage ob File zu is
if my_file.closed == False:

