util = require 'util'
request = require 'request'
fs = require 'fs'
crypto = require 'crypto'

sstutil = require './util'

class sstapi
	constructor: (@devicename) ->
		@version_name='5.3.1'
		@platform='android'

		@getSignData=()->
			common_key='sstifengcom'
			signTemplate='devicename=%srtime=%splatform=%sv=%s%s'

			rtime=new Date().getTime()
			signText=util.format(signTemplate,@devicename,rtime,@platform,@version_name,common_key)
			sign=crypto.createHash('md5').update(signText).digest('hex')
			return{
				sign:  sign
				rtime: rtime
			}

		@postRequest=(url,form,callback)->
			headers={
				'Content-Type': 'application/x-www-form-urlencoded'
				'User-Agent': 'Apache-HttpClient/UNAVAILABLE (java 1.4)'
			}

			sd=@getSignData()
			form['devicename']=@devicename
			form['platform']=@platform
			form['v']=@version_name
			form['rtime']=sd.rtime
			form['sign']=sd.sign

			options=
				url:     url
				method:  'POST'
				headers: headers
				form:    form

			# decrypt filepath

			console.log "sesese"
			request options, @callbackWrap(callback)

		@defaultCallback=(err,body)->
			fs.writeFile './_lastcallback.json',body,(err)->
				if err
					console.log err
				else
					console.log "json saved"

		@callbackWrap=(callback)=>
			if !callback?
				callback=@defaultCallback

			(err,res,body)=>
				obj={}
				if !err and res.statusCode is 200
					console.log "dec"

					obj=JSON.parse(body)
					obj=@filepathDecrypt(obj)

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
		sd=@getSignData()

		form={}
		console.log callback

		@postRequest(url,form,callback)


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
	getNewProgramList:(channelid,categoryid,page,callback)->
		url='http://diantai.ifeng.com/api/sstApi.php?action=getNewProgramList5.3'
		sd=@getSignData()

		form=
			channelid:   channelid
			categoryid:  categoryid
			# page index start from 1
			page:        page
			percount:    20
			# const
			tags:        2

		@postRequest(url,form,callback)


	getProgramAudio:(programid,page,order,needinfo,callback)->
		url='http://diantai.ifeng.com/api/sstApi.php?action=getProgramAudio5.3'
		sd=@getSignData()

		form=
			programid:   programid
			# page index start from 1
			page:        page
			percount:    20
			sid:         ''
			# 0:asc 1:desc
			order:       order
			# 0:not-fetch-info 1:fetch-info
			needinfo:    needinfo

		@postRequest(url,form,callback)


module.exports=sstapi


