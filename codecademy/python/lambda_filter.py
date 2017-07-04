##
my_list = range(16)
filter(lambda x: x % 3 == 0, my_list)

##
languages = ["HTML", "JavaScript", "Python", "Ruby"]
print filter(lambda x: x == "Python", languages)

##
squares = [x**2 for x in range(1,11)]
print filter(lambda x: 30 <= x <= 70, squares)

##
garbled = "IXXX aXXmX aXXXnXoXXXXXtXhXeXXXXrX sXXXXeXcXXXrXeXt mXXeXsXXXsXaXXXXXXgXeX!XX"
message = filter ( lambda x: x!="X",garbled)
print message
