should = require('chai').should()
fs = require 'fs'
sstapi = require '../lib/sstapi'
sstutil = require '../lib/util'

# testdeviceid
api=new sstapi('363033156546107')

tryTime=4000

# describe 'util', ()->
	# describe '.decryptAudioUrl()', ()->
	# 	it 'should return an valid uri', ()->

	# 		encryptedUrl='yvxqCpB1YpWQUgcccjWMgc+WCc1Uxf+ACMN+XgWgyvNxSZuAkvOrzaDy47r2Zgm1VC1LIQP7r5bqk9eg7A1DqZqjr26OOwKVgc/6Qx3LoNw=';
	# 		audioId='192975'
	# 		plainUrl='http://fm.ifengcdn.com/userfiles/audio01/2014/04/12/1829887-535-066-0251.mp3'
	# 		plainUrlDecrypted=sstutil.decryptAudioUrl(encryptedUrl,audioId)

	# 		plainUrlDecrypted.should.equal(plainUrl)



describe 'sstapi', ()->
	# describe '.getIndex()', ()->
	# 	it 'should fetch a catalogy', (done)->
	# 		@timeout(tryTime)
	# 		# api.getIndex()
	# 		api.getIndex (err,obj)->
	# 			should.not.exist err
	# 			should.exist obj

	# 			data=obj.data
	# 			should.exist(data)
	# 			should.exist(data.channel)
	# 			should.exist(data.focus)
	# 			should.exist(data.tv)
	# 			should.exist(data.slabs)

	# 			done()

	# describe '.getNewProgramList()', ()->
	# 	it 'should fetch a programlist', (done)->
	# 		@timeout(tryTime)

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
	# 		@timeout(tryTime)

	# 		# 总编辑时间
	# 		programId=16
	# 		page= 1
	# 		order=1
	# 		needInfo= 1

	# 		api.getProgramAudio programId,page,20,order,needInfo,(err,obj)->
	# 			should.not.exist err
	# 			should.exist obj
	# 			data=obj.data
	# 			should.exist data
	# 			should.exist data.totalCount
	# 			should.exist data.programinfo
	# 			should.exist data.audiolist

	# 			# fs.writeFileSync './_lastcallback.json',JSON.stringify(obj)

	# 			done()

	# describe 'getCategoryList()', ()->
	# 	it 'should fetch a category',(done)->
	# 		@timeout(tryTime)

	# 		categoryId=3
	# 		page=1
	# 		perCount=20

	# 		api.getCategoryList categoryId,page,perCount,(err,obj)->
	# 			should.not.exist err
	# 			should.exist obj

	# 			data=obj.data

	# 			should.exist data
	# 			should.exist data.totalCount
	# 			should.exist data.list
	# 			done()

	# describe 'getAudioBooks()',()->
	# 	it 'should fetch audio book list',(done)->
	# 		@timeout(tryTime)

	# 		channelId=52
	# 		page=1
	# 		perCount=20

	# 		api.getAudioBooks channelId,page,perCount,(err,obj)->
	# 			should.not.exist err
	# 			should.exist obj

	# 			data=obj.data

	# 			should.exist data
	# 			should.exist data.totalCount
	# 			should.exist data.list
	# 			done()

	# describe 'getOpenClassList()',()->
	# 	it 'should fetch open class list',(done)->
	# 		@timeout(tryTime)

	# 		channelId=37
	# 		page=1
	# 		perCount=20

	# 		api.getOpenClassList channelId,page,perCount,(err,obj)->
	# 			should.not.exist err
	# 			should.exist obj

	# 			data=obj.data

	# 			should.exist data
	# 			should.exist data.totalCount
	# 			should.exist data.list
	# 			done()

	# describe 'getMusicCategory()',()->
	# 	it 'should fetch music category',(done)->
	# 		@timeout(tryTime)

	# 		categoryId=1

	# 		api.getMusicCategory categoryId ,(err,obj)->

	# 			should.not.exist err
	# 			should.exist obj

	# 			data=obj.data

	# 			should.exist data
	# 			done()

	# describe 'getSinglerList()',()->
	# 	it 'should fetch singer list',(done)->
	# 		@timeout(tryTime)

	# 		categoryId=1

	# 		api.getSinglerList categoryId ,(err,obj)->

	# 			should.not.exist err
	# 			should.exist obj

	# 			data=obj.data

	# 			should.exist data
	# 			done()

	# describe 'getSongList()',()->
	# 	it 'should fetch song list',(done)->
	# 		@timeout(tryTime)

	# 		type="singer"
	# 		id=116
	# 		page=1
	# 		pageCount=20

	# 		api.getSongList type,id,page,pageCount,(err,obj)->
	# 			should.not.exist err
	# 			should.exist obj

	# 			data=obj.data

	# 			should.exist data
	# 			should.exist data.totalCount
	# 			should.exist data.list
	# 			done()

	# describe 'getSongByThemeId()',()->
	# 	it 'should fetch song list by theme id',(done)->
	# 		@timeout(tryTime)

	# 		themeId=62

	# 		api.getSongByThemeId themeId,(err,obj)->
	# 			should.not.exist err
	# 			should.exist obj

	# 			data=obj.data

	# 			should.exist data
	# 			should.exist data.totalCount
	# 			should.exist data.list
	# 			done()


	# describe 'getTvList()',()->
	# 	it 'should fetch tv list',(done)->
	# 		@timeout(tryTime)

	# 		type=1
	# 		page=1
	# 		pageCount=20

	# 		api.getTvList type,page,pageCount,(err,obj)->
	# 			should.not.exist err
	# 			should.exist obj

	# 			data=obj.data

	# 			should.exist data
	# 			should.exist data.totalCount
	# 			should.exist data.tvList
	# 			done()


	