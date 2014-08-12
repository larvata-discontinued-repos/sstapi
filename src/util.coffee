crypto = require 'crypto'

@changeChar=(charCode)->
	if 65 <= charCode <= 90
		return charCode - 65
	if 97 <= charCode <=122
		return 26 + charCode - 97
	if 48 <= charCode <=57
		return 52 + charCode - 48

	switch charCode
		when 43
			return 62
		when 47
			return 63
		when 64
			return 61
		else
			return -1

@segmentDecode=(array)->
	byte0 = 0x3F & array[0]
	byte1 = 0x30 & array[1]
	byte2 = 0x0F & array[1]
	byte3 = 0x3C & array[2]
	byte4 = 0x03 & array[2]
	byte5 = 0x3F & array[3]
	byte6 = byte0 << 2
	byte7 = @byteDecode(byte1, 4)
	byte8 = byte2 << 4
	byte9 = @byteDecode(byte3, 2)
	byte10 = byte4 << 6

	abyte1=[]
	abyte1[0] = byte6 | byte7 & 0xFF
	abyte1[1] = byte8 | byte9 & 0xFF
	abyte1[2] = byte10 | byte5 & 0xFF

	return abyte1

@byteDecode=(charCode,pos)->
	baseCode=[-128, 64, 32, 16, 8, 4, 2, 1]
	bitset='00000000'.split('')

	for i in [0...8]
		if i<pos
			bitset[i]='0'
		else
			if (charCode & baseCode[i-pos]) is baseCode[i-pos]
				bitset[i]='1'
			else
				bitset[i]='0'

	parseInt(bitset.join(''),2)


@convertUrl=(encryptedUrl)->
	convertedArray=[]

	changedArray=[]
	for i in [0...108]
		changedArray.push(@changeChar(encryptedUrl[i].charCodeAt(0)))

	for i in [0...27]
		peace = changedArray.splice(0,4)
		convertedArray=convertedArray.concat(@segmentDecode(peace))

	convertedArray.splice(-1)
	return convertedArray


@crateKeyString=(audioId)->
	keyTemplate="sst_android_#{audioId}_sstifengcom"
	fullkey=crypto.createHash('md5').update(keyTemplate).digest('hex')

	return fullkey.substring(0,24)


# decrypt filepath in api responsed json
module.exports.decryptAudioUrl=(encryptedUrl,audioId)->
	convertedUrl=@convertUrl(encryptedUrl)

	hexedUrl=''
	for i in convertedUrl
		if i<=16
			hexedUrl+="0"

		hexedUrl+= i.toString(16)

	key=@crateKeyString(audioId)

	decipher = crypto.createDecipheriv('des-ede3-cbc', key, '20110512');

	plainText = decipher.update(hexedUrl, 'hex', 'utf8')
	plainText += decipher.final('utf8')
	return plainText