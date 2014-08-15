util = require 'util'
request = require('superagent')
fs = require 'fs'
crypto = require 'crypto'

sstutil = require './util'

class sstapi
	constructor: (@devicename) ->
		@version_name='5.3.1'
		@platform='android'
		@apiUrl='http://diantai.ifeng.com/api/sstApi.php'

		@headers={
			'Content-Type': 'application/x-www-form-urlencoded'
			'User-Agent': 'Apache-HttpClient/UNAVAILABLE (java 1.4)'
		}

		@request=request

		@formSignture=(form,signlist)->
			common_key='sstifengcom'
			signTemplate='rtime=%splatform=%sv=%s%s'

			preText=''
			for i in signlist
				preText += "#{i}=#{form[i]}"

			rtime=new Date().getTime()
			signText=preText+util.format(signTemplate,rtime,@platform,@version_name,common_key)
			sign=crypto.createHash('md5').update(signText).digest('hex')

			form.platform=@platform
			form.v=@version_name
			form.rtime=rtime
			form.sign=sign

			return form

		@postRequest=(action,form,signlist,callback)->

			form=@formSignture(form,signlist)

			request
				.post(@apiUrl)
				.set(@headers)
				.query({"action",action})
				.send(form)
				.end @callbackWrap(callback)



		@defaultCallback=(bodyObj)->

			fs.writeFile './_lastcallback.json',JSON.stringify(bodyObj),(err)->
				if err
					console.log err
				else
					console.log "_lastcallback saved"

		@callbackWrap=(callback)=>

			if !callback?
				callback=@defaultCallback

			(res)=>

				obj={}
				if res.status is 200
					obj=JSON.parse(res.text)
					@filepathDecrypt(obj)

				callback(obj)

		@filepathDecrypt=(obj)->
			sstutil.objectLoop(obj)


	# 索引列表
	# channel
	# 	channelId
	# 	channelname
	# 	categoryId
	# 	fixed
	# 	show

	getIndex:(callback)->
		action='getIndex'

		form=
			devicename: @devicename

		signlist=["devicename"]

		@postRequest(action,form,signlist,callback)


	# 节目列表
	# totalCount
	# list
	# 	isfav
	# 	programId
	# 	programname
	# 	compere
	# 	info
	# 	channelname
	# 	isreplace
	# 	programlogo
	# 	title
	# 	create_at
	getNewProgramList:(channelId,categoryid,page,perCount,callback)->
		action='getNewProgramList5.3'

		form=
			devicename:  @devicename
			channelid:   channelId
			categoryid:  categoryid
			# page index start from 1
			page:        page
			percount:    perCount
			# const
			tags:        2

		signlist=["devicename"]

		@postRequest(action,form,signlist,callback)

	# 节目音频
	getProgramAudio:(programId,page,perCount,order,needinfo,callback)->
		action='getProgramAudio5.3'

		form=
			devicename:  @devicename
			programid:   programId
			# page index start from 1
			page:        page
			percount:    perCount
			sid:         ''
			# 0:asc 1:desc
			order:       order
			# 0:not-fetch-info 1:fetch-info
			needinfo:    needinfo

		signlist=["devicename"]

		@postRequest(action,form,signlist,callback)


	getCategoryList:(categoryId,page,perCount,callback)->
		action='getCategoryList'

		form =
			# from getIndex().categoryid
			categoryid:  categoryId
			page:        page
			percount:    perCount
			source:      'index'

		signlist=['categoryid','page']

		@postRequest(action,form,signlist,callback)

	getAudioBooks:(channelId,page,perCount,callback)->
		action='getAudioBooks'

		form =
			# form getCategoryList().categoryid
			channelid:  channelId
			page:       page
			percount:   perCount
			tags:       2

		signlist=['channelid','page','percount']
		@postRequest(action,form,signlist,callback)

	getOpenClassList:(channelId,page,perCount,callback)->
		action="getOpenClassList"

		form =
			channelid:  channelId
			page:       page
			percount:   perCount
			tags:       2

		signlist=['channelid','page','percount']
		@postRequest(action,form,signlist,callback)

	getMusicCategory:(categoryId,callback)->
		action="getMusicCategory"

		form =
			categoryid: categoryId

		signlist=['categoryid']
		@postRequest(action,form,signlist,callback)

	getSingerList:(categoryId,callback)->
		action="getSingerList"

		form =
			categoryid: categoryId

		signlist=['categoryid']

		@postRequest(action,form,signlist,callback)

	getSongList:(type,id,page,perCount,callback)->
		action="getSongList"

		form =
			type:       type
			id:         id
			page:       page
			percount:  perCount

		signlist=['type','id']

		@postRequest(action,form,signlist,callback)

	getSongByThemeId:(themeId,callback)->
		action="getSongBythemeid"

		form =
			themeid:  themeId

		signlist=['themeid']

		@postRequest(action,form,signlist,callback)

	getTvList:(type,page,perCount,callback)->
		action="getTvList"

		form =
			devicename: @devicename
			type:       type
			page:       page
			percount:  perCount

		signlist=['devicename']

		@postRequest(action,form,signlist,callback)

	getTvEpgList:(tvid,callback)->
		action="getTvEpgList"

		form =
			devicename: @devicename
			tvid:       tvid

		signlist=['devicename']

		@postRequest(action,form,signlist,callback)

	getTvNowEpg:(tvid,callback)->
		action="getTvNowEpg"

		form =
			devicename: @devicename
			tvid:       tvid

		signlist=['devicename']

		@postRequest(action,form,signlist,callback)

	getTvRelevantList:(type,tvId,showNum,callback)->
		action="getTvRelevantList"

		form =
			devicename:  @devicename
			type:        type
			tvid:        tvId
			shownum:     showNum

		signlist=['devicename']

		@postRequest(action,form,signlist,callback)

	getTvCatAndPos:(callback)->
		action="getTvCatAndPos"

		form =
			devicename:  @devicename

		signlist=['devicename']

		@postRequest(action,form,signlist,callback)

	getRankingByCategoryId:(categoryId,perCount,callback)->
		action="getRankingByCategoryid"

		form =
			devicename:  @devicename
			categoryid:  categoryId
			percount:    perCount

		signlist=['devicename']

		@postRequest(action,form,signlist,callback)

	getSpecialList:(page,perCount,callback)->
		action="getSpecialList"

		form =
			devicename:  @devicename
			page:        page
			percount:    perCount

		signlist=['devicename']

		@postRequest(action,form,signlist,callback)

	getSpecialAudioList:(themeId,page,perCount,callback)->
		action="getSpecialAudioList"

		form =
			devicename:  @devicename
			themeid:     themeId
			page:        page
			perCount:    perCount

		signlist=['devicename']

		@postRequest(action,form,signlist,callback)


module.exports=sstapi


