sstapi
======

a 3rd party api for [ifeng fm](http://diantai.ifeng.com/)


### Install

	npm install sstapi

### Usage

	var sstapi = require('sstapi');

	// get it from your mobile or fake it
	var imei='353043056516027';
	var api = new sstapi(imei);

	api.getIndex(function(err, obj) {
		console.log(obj);
	});

### Test

	npm test