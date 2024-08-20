# twixcrypt
A cryptography utility written in Luau and Python. This tool will be very useful for you to quickly and efficiently encrypt and decrypt data.

## Usage
```py
# Importing the main class from the module
from twixcrypt import Cryptography

# Creating an instance of the main class
instance = Cryptography("db3351a718784727904f180029b9aaf2") # Encryption & decryption key

print(instance.encrypt("Hello, World!")) # !94!144!249!171!15!91!58!170!54!169!58!34!212!83!72!26
print(instance.decrypt("!94!144!249!171!15!91!58!170!54!169!58!34!212!83!72!26")) # Hello, World!
print(instance.decrypt("!94!144!249!171!15!91!58!170!54!169!58!34!212!83!72!26") == "Hello, World!") # True
```