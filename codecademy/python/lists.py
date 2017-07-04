doube_div_3 = [x**2 for x in range(1,11) if x%3 == 0]
cubes_by_four = [x**3 for x in range(1,11) if (x**3)%4 == 0]

to_one_hundred = range(101)
# Add your code below!

backwards_by_tens = to_one_hundred[::-10]

print backwards_by_tens

to_21 = range(1,22)
print to_21

odds = to_21[::2]
middle_third = to_21[7:14]
