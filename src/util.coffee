crypto = require 'crypto'
util = require 'util'
fs = require 'fs'

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
	len=array.length
	if 2>len>4
		null

	abyte1=[]
	if len>1
		byte0 = 0x3F & array[0]
		byte6 = byte0 << 2

		byte1 = 0x30 & array[1]
		byte7 = @byteDecode(byte1, 4)

		byte2 = 0x0F & array[1]
		byte8 = byte2 << 4

		abyte1[0] = byte6 | byte7 & 0xFF

	if len>2
		byte3 = 0x3C & array[2]
		byte9 = @byteDecode(byte3, 2)
		abyte1[1] = byte8 | byte9 & 0xFF

	if len>3
		byte4 = 0x03 & array[2]
		byte10 = byte4 << 6
		byte5 = 0x3F & array[3]

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
	len= encryptedUrl.length
	seg= encryptedUrl.length / 4

	convertedArray=[]

	changedArray=[]
	for i in [0...len]
		changedArray.push(@changeChar(encryptedUrl[i].charCodeAt(0)))

	piece=[]
	for i in [0...len]
		if changedArray[i] is -1

		else
			piece.push changedArray[i]

		if piece.length >= 4
			convertedArray=convertedArray.concat(@segmentDecode(piece))
			piece=[]

	if piece.length>0
		convertedArray=convertedArray.concat(@segmentDecode(piece))

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

	plainText=''

	try
		plainText = decipher.update(hexedUrl, 'hex', 'utf8')
		plainText += decipher.final('utf8')
	catch e
		# decrypt failed


	return plainText

module.exports.objectLoop=(v, k) ->
	if typeof v is "object"
		for kp of v
			if Object.hasOwnProperty.call(v, kp)
				q= kp
				q= "#{k}.#{kp}" if k?
				@objectLoop v[kp], q
			else
		if v? and v.filepath?
			plainText=@decryptAudioUrl(v.filepath,v.audio[0].audioid)
			if plainText is ''
				# decrypt failed log to file
				logTemplate='encryptedUrl: %s\nkey: %s\nlength: %s\n\n'
				logText=util.format(logTemplate,v.filepath,v.audio[0].audioid,v.filepath.length)

				@writeLog('./_decryptfailed',logText)
			else
				# decrypt success

			v.filepath=plainText
	return

@writeLog=(filePath,text)->
	fs.appendFileSync filePath,text
