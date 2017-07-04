### bitwise shifting
shift_right = 0b1100
shift_left = 0b1

shift_right = shift_right >> 2
shift_left = shift_left << 2

print bin(shift_right)
print bin(shift_left)


### AND operator &
## Note that using the &operator can only result in a number that is less than or equal to the smaller of the two values.
## 1110
## 0101
## =
## 0100

print bin(0b1110 & 0b101)

### OR operator |
## Note that the bitwise | operator can only create results that are greater than or equal to the larger of the two integer inputs.
## 1110
## 0101
## =
## 1111

print bin(0b1110 | 0b101)

### XOR operator ^
## Keep in mind that if a bit is off in both numbers, it stays off in the result. Note that XOR-ing a number with itself will always result in 0.
## 1110
## 0101
## =
## 1011
print bin(0b1110 ^ 0b101)

### NOT operator ~
## Equivalent to adding one to the number and then making it negative.

### check if bit4 is on
def check_bit4(integer):
    mask = 0b1000
    if integer & mask > 0:
        return "on"
    else:
        return "off"

### turn bit 3 on
a = 0b11101110
mask = 0b100
print bin( a | mask)

### flipping all bits with XOR
a = 0b11101110
mask = 0b11111111
print bin(a ^ mask)

### flip only one bit by shifting mask
def flip_bit(num,n):
    mask = 0b1 << (n-1)
    result = num ^ mask
    return bin(result)

print flip_bit(0b111,2)






