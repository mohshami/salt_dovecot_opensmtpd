def generate(bits=1024):
	'''
	Generate an RSA keypair with an exponent of 65537 in PEM format
	param: bits The key length in bits
	Return private key and public key
	'''
	
	from Crypto.PublicKey import RSA
	new_key = RSA.generate(bits, e=65537)

	public_key = str(new_key.publickey().exportKey("PEM"))
	public_key = public_key.replace('-----BEGIN PUBLIC KEY-----', '')
	public_key = public_key.replace('-----END PUBLIC KEY-----', '')
	public_key = public_key.replace('\n', '')

	private_key = str(new_key.exportKey("PEM"))

	return [private_key, public_key]
