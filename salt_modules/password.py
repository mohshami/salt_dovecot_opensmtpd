import crypt
import os

def hash(pw, salt=None):
	if not salt:
		salt = os.urandom(16).encode('base_64')

	salt = "$6${}$".format(salt)

	return crypt.crypt(str(pw), salt)
