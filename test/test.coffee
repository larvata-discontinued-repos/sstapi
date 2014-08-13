should = require('chai').should()

sstapi = require '../lib/sstapi'
sstutil = require '../lib/util'

# testdeviceid
api=new sstapi('363033156546107')

describe 'util', ()->
	describe '.decryptAudioUrl()', ()->
		it 'should return an valid uri', ()->


			# 长度非108
			# s2="7SvNBlIq7u6kf00JcbYydvFetjYFi9EQhewJj9W00Momp41TeT/IuS92Dg2kpejGICz+qMYB50gBDdYl/Oj0tDmZGKRVor2VaJR2Tt3+1i8yIs3G0Api4w=="
			# k="49485"
			# console.log "length: #{s2.length}"
			# p=sstutil.decryptAudioUrl(s2,k)
			# console.log p


			# 长度非108
			# s2="s9diScdIS3TqbVlCvINZf6FW+FfQOvyCL3nVws6KPyI1mrwYT7V7D6WKOJSoeP5dirjFAJ257UYQ0LsJkAXF93hca2IWo1H2yGnQULa8vgY="
			# k="522398"
			# console.log "length: #{s2.length}"
			# p=sstutil.decryptAudioUrl(s2,k)
			# console.log p

			# encryptedUrl='yvxqCpB1YpWQUgcccjWMgc+WCc1Uxf+ACMN+XgWgyvNxSZuAkvOrzaDy47r2Zgm1VC1LIQP7r5bqk9eg7A1DqZqjr26OOwKVgc/6Qx3LoNw=';
			# audioId='192975'
			# plainUrl='http://fm.ifengcdn.com/userfiles/audio01/2014/04/12/1829887-535-066-0251.mp3'
			# plainUrlDecrypted=sstutil.decryptAudioUrl(encryptedUrl,audioId)

			# plainUrlDecrypted.should.equal(plainUrl)



describe 'sstapi', ()->
	describe '.getIndex()', ()->
		it 'should fetch a catalogy', (done)->
			@timeout(4000)
			api.getIndex()
			api.getIndex (err,obj)->
				should.not.exist err
				should.exist obj

				data=obj.data

				should.exist(data)
				should.exist(data.channel)
				should.exist(data.focus)
				should.exist(data.tv)
				should.exist(data.slabs)

				done()

	# describe '.getNewProgramList()', ()->
	# 	it 'should fetch a programlist', (done)->
	# 		@timeout(6000)

	# 		# channel: 新闻
	# 		channelId = 1
	# 		# const
	# 		categoryId = 1
	# 		pageIndex = 1

	# 		api.getNewProgramList channelId,categoryId,pageIndex,(err,obj)->
	# 			console.log "get callback"
	# 			should.not.exist err
	# 			should.exist obj

	# 			data=obj.data

	# 			should.exist data
	# 			should.exist data.totalCount
	# 			should.exist data.list

	# 			done()

	# describe '.getProgramAudio()', ()->
	# 	it	'should fetch a audio list',(done)->
	# 		@timeout(4000)

	# 		# 总编辑时间
	# 		programId=16
	# 		page= 1
	# 		order=1
	# 		needInfo= 1

	# 		api.getProgramAudio programId,page,order,needInfo

			# api.getProgramAudio programId,page,order,needInfo,(err,obj)->
			# 	should.not.exist err
			# 	should.exist obj

			# 	data=obj.data

			# 	should.exist data
			# 	should.exist data.totalCount
			# 	should.exist data.programinfo
			# 	should.exist data.audiolist

			# 	done()

