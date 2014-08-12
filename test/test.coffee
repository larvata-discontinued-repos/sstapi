should = require('chai').should()

sstapi = require '../lib/sstapi'
sstutil = require '../lib/util'

# testdeviceid
api=new sstapi('363033156546107')

describe 'util', ()->
	describe '.decryptAudioUrl()', ()->
		it 'should return an valid uri', ()->
			encryptedUrl='yvxqCpB1YpWQUgcccjWMgc+WCc1Uxf+ACMN+XgWgyvNxSZuAkvOrzaDy47r2Zgm1VC1LIQP7r5bqk9eg7A1DqZqjr26OOwKVgc/6Qx3LoNw=';
			audioId='192975'
			plainUrl='http://fm.ifengcdn.com/userfiles/audio01/2014/04/12/1829887-535-066-0251.mp3'
			plainUrlDecrypted=sstutil.decryptAudioUrl(encryptedUrl,audioId)

			plainUrlDecrypted.should.equal(plainUrl)

describe 'sstapi', ()->
	describe '.getIndex()', ()->
		it 'should fetch a catalogy', (done)->
			@timeout(4000)

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

	describe '.getNewProgramList()', ()->
		it 'should fetch a programlist', (done)->
			@timeout(4000)

			# channle: 谈话
			channelId = "44"
			pageIndex = 1

			api.getNewProgramList channelId,pageIndex,(err,obj)->
				should.not.exist err
				should.exist obj

				data=obj.data

				should.exist data
				should.exist data.totalCount
				should.exist data.list

				done()

	describe '.getProgramAudio()', ()->
		it	'should fetch a audio list',(done)->
			@timeout(4000)

			programId=77
			page= 1
			order=1
			needInfo= 1

			api.getProgramAudio programId,page,order,needInfo,(err,obj)->
				should.not.exist err
				should.exist obj

				data=obj.data

				should.exist data
				should.exist data.totalCount
				should.exist data.programinfo
				should.exist data.audiolist

				done()

