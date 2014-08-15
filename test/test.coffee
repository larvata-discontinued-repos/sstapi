should = require('chai').should()
fs = require 'fs'
sstapi = require '../lib/sstapi'
sstutil = require '../lib/util'

# testdeviceid
api=new sstapi('363033156546107')

tryTime=6000


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
			@timeout(tryTime)
			# api.getIndex()
			api.getIndex (obj)->
				should.exist(obj)
				data=obj.data
				should.exist(data)
				should.exist(data.channel)
				should.exist(data.focus)
				should.exist(data.tv)
				should.exist(data.slabs)

				done()

	describe '.getNewProgramList()', ()->
		it 'should fetch a programlist', (done)->
			@timeout(tryTime)

			# channel: 新闻
			channelId = 1
			# const
			categoryId = 1
			page = 1
			perCount=20

			api.getNewProgramList channelId,categoryId,page,perCount,(obj)->
				should.exist obj

				data=obj.data

				should.exist data
				should.exist data.totalCount
				should.exist data.list

				done()

	describe '.getProgramAudio()', ()->
		it	'should fetch a audio list',(done)->
			@timeout(tryTime)

			# 总编辑时间
			programId=16
			page= 1
			order=1
			needInfo= 1

			api.getProgramAudio programId,page,20,order,needInfo,(obj)->
				should.exist obj
				data=obj.data
				should.exist data
				should.exist data.totalCount
				should.exist data.programinfo
				should.exist data.audiolist

				# fs.writeFileSync './_lastcallback.json',JSON.stringify(obj)

				done()

	describe 'getCategoryList()', ()->
		it 'should fetch a category',(done)->
			@timeout(tryTime)

			categoryId=3
			page=1
			perCount=20

			api.getCategoryList categoryId,page,perCount,(obj)->
				should.exist obj

				data=obj.data

				should.exist data
				should.exist data.totalCount
				should.exist data.list
				done()

	describe 'getAudioBooks()',()->
		it 'should fetch audio book list',(done)->
			@timeout(tryTime)

			channelId=52
			page=1
			perCount=20

			api.getAudioBooks channelId,page,perCount,(obj)->
				should.exist obj

				data=obj.data

				should.exist data
				should.exist data.totalCount
				should.exist data.list
				done()

	describe 'getOpenClassList()',()->
		it 'should fetch open class list',(done)->
			@timeout(tryTime)

			channelId=37
			page=1
			perCount=20

			api.getOpenClassList channelId,page,perCount,(obj)->
				should.exist obj

				data=obj.data

				should.exist data
				should.exist data.totalCount
				should.exist data.list
				done()

	describe 'getMusicCategory()',()->
		it 'should fetch music category',(done)->
			@timeout(tryTime)

			categoryId=1

			api.getMusicCategory categoryId ,(obj)->

				should.exist obj

				data=obj.data

				should.exist data
				done()

	describe 'getSingerList()',()->
		it 'should fetch singer list',(done)->
			@timeout(tryTime)

			categoryId=1


			api.getSingerList categoryId ,(obj)->
				should.exist obj

				data=obj.data

				should.exist data
				done()

	describe 'getSongList()',()->
		it 'should fetch song list',(done)->
			@timeout(tryTime)

			type="singer"
			id=116
			page=1
			perCount=20

			api.getSongList type,id,page,perCount,(obj)->
				should.exist obj

				data=obj.data

				should.exist data
				should.exist data.totalCount
				should.exist data.list
				done()

	describe 'getSongByThemeId()',()->
		it 'should fetch song list by theme id',(done)->
			@timeout(tryTime)

			themeId=62

			api.getSongByThemeId themeId,(obj)->
				should.exist obj

				data=obj.data

				should.exist data
				should.exist data.totalCount
				should.exist data.list
				done()


	describe 'getTvList()',()->
		it 'should fetch tv list',(done)->
			@timeout(tryTime)

			type=1
			page=1
			perCount=20

			api.getTvList type,page,perCount,(obj)->
				should.exist obj

				data=obj.data

				should.exist data
				should.exist data.totalCount
				should.exist data.tvList
				done()


	describe 'getTvEpgList()',()->
		it 'should fetch tv epg list',(done)->
			@timeout(tryTime)

			tvid=2

			api.getTvEpgList tvid,(obj)->
				should.exist obj

				data=obj.data

				should.exist data
				should.exist data.epgList
				done()


	describe 'getTvNowEpg()',()->
		it 'should fetch tv now epg list',(done)->
			@timeout(tryTime)

			tvid=2

			api.getTvNowEpg tvid,(obj)->
				should.exist obj

				data=obj.data

				should.exist data
				should.exist data.id
				should.exist data.nowepg
				should.exist data.nexttime
				should.exist data.nextepg
				should.exist data.listennum
				should.exist data.collectnum
				done()


	describe 'getTvRelevantList()',()->
		it 'should fetch tv relevant list',(done)->
			@timeout(tryTime)

			type=1
			tvid=2
			shownum=20

			api.getTvRelevantList type,tvid,shownum,(obj)->
				should.exist obj

				data=obj.data

				should.exist data
				done()


	describe 'getTvCatAndPos()',()->
		it 'should fetch tv cat pos',(done)->
			@timeout(tryTime)

			api.getTvCatAndPos (obj)->
				should.exist obj

				data=obj.data

				should.exist data
				should.exist data.provinceList
				should.exist data.categoryList
				done()

	describe 'getRankingByCategoryId()',()->
		it 'should fetch ranking by provided category id',(done)->
			@timeout(tryTime)

			categoryId=1
			perCount=20

			api.getRankingByCategoryId categoryId,perCount,(obj)->
				should.exist obj

				data=obj.data

				should.exist data
				should.exist data.list
				done()

	describe 'getSpecialList()',()->
		it 'should fetch sepcial list',(done)->
			@timeout(tryTime)

			page=1
			perCount=20

			api.getSpecialList page,perCount,(obj)->
				should.exist obj

				data=obj.data

				should.exist data
				should.exist data.list
				done()

	describe 'getSpecialAudioList()',()->
		it 'should fetch SpecialAudioList',(done)->
			@timeout(tryTime)

			themeId=58
			page=1
			perCount=20

			api.getSpecialAudioList themeId,page,perCount,(obj)->
				should.exist obj

				data=obj.data

				should.exist data
				should.exist data.totalCount
				should.exist data.list
				done()


