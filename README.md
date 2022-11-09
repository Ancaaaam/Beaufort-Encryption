# Beaufort-Encryption

The algorithm has as inputs a plain text and a key and it returns an encrypted text, with the same length as the plain text.
The Beaufort cipher's algorithm is based on the table called tabula recta:

![image](https://user-images.githubusercontent.com/94039813/200960342-80796c46-e691-49b4-8f66-7e5f83baecf4.png)

Encrypting each character is done by applying the following steps:
1. we associate each character from plain text a character from the key, repeating the key to cover the entire initial string
2. we go to the ``tabula recta'' on the column associated with the letter we want to encrypt
3. travel down this column until we find the current key letter
4. the leftmost letter in the current row is the new ciphertext letter.

Arguments are:
1.len_plain and plain: the size of plain text and address of the first element of the plain text
2. len_key and key: the size of the key and address of the first element of the key
3.tabula_recta: an 2Darray (statically allocated) of 26 X 26 characters of the English language, with the contents of the figure above
4.enc: the address to which the encrypted text is written
