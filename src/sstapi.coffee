util = require 'util'
request = require 'request'
fs = require 'fs'
crypto = require 'crypto'

sstutil = require './util'

class sstapi
	constructor: (@devicename) ->
		@version_name='5.3.1'
		@platform='android'

		headers={
			'Content-Type': 'application/x-www-form-urlencoded'
			'User-Agent': 'Apache-HttpClient/UNAVAILABLE (java 1.4)'
		}

		@apiRequest=request.defaults(
				'proxy':'http://127.0.0.1:8888'
				method:  'POST'
				headers: headers
			)

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

		@postRequest=(url,form,signlist,callback)->

			form=@formSignture(form,signlist)

			options=
				url:     url
				form:    form

			@apiRequest options, @callbackWrap(callback)

		@defaultCallback=(err,obj)->

			fs.writeFile './_lastcallback.json',JSON.stringify(obj),(err)->
				if err
					console.log err
				else
					console.log "_lastcallback saved"

		@callbackWrap=(callback)=>

			if !callback?
				callback=@defaultCallback

			(err,res,body)=>

				obj={}
				if !err and res.statusCode is 200
					obj=JSON.parse(body)
					@filepathDecrypt(obj)

				callback(err,obj)

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
		url='http://diantai.ifeng.com/api/sstApi.php?action=getIndex'

		form=
			devicename: @devicename

		signlist=["devicename"]

		@postRequest(url,form,signlist,callback)


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
		url='http://diantai.ifeng.com/api/sstApi.php?action=getNewProgramList5.3'

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

		@postRequest(url,form,signlist,callback)

	# 节目音频
	getProgramAudio:(programId,page,perCount,order,needinfo,callback)->
		url='http://diantai.ifeng.com/api/sstApi.php?action=getProgramAudio5.3'

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

		@postRequest(url,form,signlist,callback)


	getCategoryList:(categoryId,page,perCount,callback)->
		url='http://diantai.ifeng.com/api/sstApi.php?action=getCategoryList'

		form =
			# from getIndex().categoryid
			categoryid:  categoryId
			page:        page
			percount:    perCount
			source:      'index'

		signlist=['categoryid','page']

		@postRequest(url,form,signlist,callback)

	getAudioBooks:(channelId,page,perCount,callback)->
		url='http://diantai.ifeng.com/api/sstApi.php?action=getAudioBooks'

		form =
			# form getCategoryList().categoryid
			channelid:  channelId
			page:       page
			percount:   perCount
			tags:       2

		signlist=['channelid','page','percount']
		@postRequest(url,form,signlist,callback)


	getOpenClassList:(channelId,page,perCount,callback)->
		url="http://diantai.ifeng.com/api/sstApi.php?action=getOpenClassList"

		form =
			channelid:  channelId
			page:       page
			percount:   perCount
			tags:       2

		signlist=['channelid','page','percount']
		@postRequest(url,form,signlist,callback)

	getMusicCategory:(categoryId,callback)->
		url="http://diantai.ifeng.com/api/sstApi.php?action=getMusicCategory"

		form =
			categoryid: categoryId

		signlist=['categoryid']
		@postRequest(url,form,signlist,callback)


	getSinglerList:(categoryId,callback)->
		url="http://diantai.ifeng.com/api/sstApi.php?action=getSingerList"

		form =
			categoryid: categoryId

		signlist=['categoryid']

		@postRequest(url,form,signlist,callback)

	getSongList:(type,id,page,pageCount,callback)->
		url="http://diantai.ifeng.com/api/sstApi.php?action=getSongList"

		form =
			type:       type
			id:         id
			page:       page
			pagecount:  pageCount

		signlist=['type','id']

		@postRequest(url,form,signlist,callback)

	getSongByThemeId:(themeId,callback)->
		url="http://diantai.ifeng.com/api/sstApi.php?action=getSongBythemeid"

		form =
			themeid:  themeId

		signlist=['themeid']

		@postRequest(url,form,signlist,callback)

	getTvList:(type,page,pageCount,callback)->
		url="http://diantai.ifeng.com/api/sstApi.php?action=getTvList"

		form =
			devicename: @devicename
			type:       type
			page:       page
			pagecount:  pageCount

		signlist=['devicename']

		@postRequest(url,form,signlist,callback)

	getTvEpgList:(tvid,callback)->
		url="http://diantai.ifeng.com/api/sstApi.php?action=getTvEpgList"

		form =
			tvid:  2

		@postRequest(url,form,callback)

	getTvNowEpg:(callback)->
		url="http://diantai.ifeng.com/api/sstApi.php?action=getTvNowEpg"
		@postRequest(url,form,callback)

	getTvReventList:(type,tvid,shownum,callback)->
		url="http://diantai.ifeng.com/api/sstApi.php?action=getTvRelevantList"

		form =
			type:     type
			tvid:     tvid
			shownum:  shownum

		@postRequest(url,form,callback)

	getTvCatAndPos:(callback)->
		url="http://diantai.ifeng.com/api/sstApi.php?action=getTvCatAndPos"
		@postRequest(url,form,callback)

	getRankingByCategoryId:(categoryId,perCount,callback)->
		url="http://diantai.ifeng.com/api/sstApi.php?action=getRankingByCategoryid"

		form =
			categoryid:  categoryId
			percount:    perCount

		@postRequest(url,form,callback)

	getSpecialList:(page,perCount,callback)->
		url="http://diantai.ifeng.com/api/sstApi.php?action=getSpecialList"

		form =
			page:     page
			percount: perCount

		@postRequest(url,form,callback)

	getSepcialAudioList:(themeId,page,pageCount)->
		url="http://diantai.ifeng.com/api/sstApi.php?action=getSpecialAudioList"

		form =
			themeid:    themeId
			page:       page
			pagecount:  pageCount

		@postRequest(url,form,callback)


module.exports=sstapi


