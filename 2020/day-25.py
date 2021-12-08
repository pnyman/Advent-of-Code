# To transform a subject number, start with the value 1.
# Then, a number of times called the loop size, perform the following steps:

# Set the value to itself multiplied by the subject number.
# Set the value to the remainder after dividing the value by 20201227.

# The card always uses a specific, secret loop size when it transforms a subject number.
# The door always uses a different, secret loop size.

# The card transforms the subject number of the door's public key
# according to the card's loop size. The result is the encryption key.
# The door transforms the subject number of the card's public key
# according to the door's loop size. The result is the same encryption
# key as the card calculated.

# Input:
# 19241437
# 17346587

s = 7
val = 1
loop = 0
while val != 19241437:
    loop += 1
    val *= s
    val %= 20201227
print(loop) # 8808305

s = 7
val = 1
loop = 0
while val != 17346587:
    loop += 1
    val *= s
    val %= 20201227
print(loop) # 11570336


s = 17346587
val = 1
loop = 0
for _ in range(8808305):
    val *= s
    val %= 20201227
print(val) # 12181021
