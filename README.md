sstapi
======

[![NPM IMAGE]][NPM]
[![TRAVIS IMAGE]][TRAVIS]


a 3rd party api for [ifeng fm](http://diantai.ifeng.com/)


### Install

	npm install sstapi

### Usage

	var sstapi = require('sstapi');

	// get IMEI from your mobile or just fake it
	var imei='353043056516027';
	var api = new sstapi(imei);

	api.getIndex(function(err, obj) {
		// ...
	});

### Develop & Unit Test

	git clone https://github.com/larvata/sstapi.git
	cd sstapi
	grunt
	npm test


[NPM]:          https://www.npmjs.org/package/sstapi
[NPM IMAGE]:    https://badge.fury.io/js/sstapi.svg

[TRAVIS]:       https://travis-ci.org/larvata/sstapi
[TRAVIS IMAGE]: https://travis-ci.org/larvata/sstapi.svg