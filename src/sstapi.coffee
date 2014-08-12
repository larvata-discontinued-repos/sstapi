util = require 'util'
request = require 'request'
fs = require 'fs'
crypto = require 'crypto'

sstutil = require './util'

class sstapi
	constructor: (@devicename) ->
		@version_name='5.3.1'
		@platform='android'

		@defaultCallback=(err,res,body)->
			if !err and res.statusCode is 200
				fs.writeFile './_lastcallback.json',body,(err)->
					if err
						console.log err

		@getSignData=()->
			common_key='sstifengcom'
			signTemplate='devicename=%srtime=%splatform=%sv=%s%s'

			rtime=new Date().getTime()
			signText=util.format(signTemplate,@devicename,rtime,@platform,@version_name,common_key)
			sign=crypto.createHash('md5').update(signText).digest('hex')
			return {
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

			options={
				url:     url
				method:  'POST'
				headers: headers
				form:    form
			}

			if callback?
				request options,@callbackWrap(callback)
			else
				# default callback for debug
				request options,(err,res,body)=>
					@defaultCallback(err,res,body)

		@callbackWrap=(callback)->
			(err,res,body)->
				obj={}
				if !err and res.statusCode is 200
					obj=JSON.parse(body)
				callback(err,obj)




	getIndex:(callback)->
		url='http://diantai.ifeng.com/api/sstApi.php?action=getIndex'
		sd=@getSignData()

		form={
		}

		@postRequest(url,form,callback)


	getNewProgramList:(channelid,page,callback)->
		url='http://diantai.ifeng.com/api/sstApi.php?action=getNewProgramList5.3'
		sd=@getSignData()

		form={
			channelid:   channelid
			# page index start from 1
			page:        page
			percount:    20
			# const
			tags:        2
		}

		@postRequest(url,form,callback)


	getProgramAudio:(programid,page,order,needinfo,callback)->
		url='http://diantai.ifeng.com/api/sstApi.php?action=getProgramAudio5.3'
		sd=@getSignData()

		form={
			programid:   programid
			# page index start from 1
			page:        page
			percount:    20
			sid:         ''
			# 0:asc 1:desc
			order:       order
			# 0:not-fetch-info 1:fetch-info
			needinfo:    needinfo
		}
		@postRequest(url,form,callback)


module.exports=sstapi