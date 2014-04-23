require! Q: q
require! crypto.createHash
require! url.resolve
require! \./methods.json

request = Q.denodeify require 'request'

sha1 = let {createHash} = require 'crypto'
	-> createHash \sha1
		..update it
		return ..digest \hex

strCast = (+ '')

module.exports = class Trakt
	
	@@sha1 = ^^sha1

	var _username
	var _password
	var _api-key

	const BASE_URL = \http://api.trakt.tv

	(_api-key ? throw new Error('No apikey')) ->

	username:~
		-> _username
		(str) -> _username := strCast str

	password:~
		-> !!_password
		(str) -> _password := @@sha1 strCast str
	
	password-hash:~
		(str) -> _password := strCast str

	api-call: _api-call = ([type, route, urlparams, qsparams, jsonparams] ? throw new Error('No method'), ^^data) -->
		# Type check
		data = switch typeof! data
		| \Array	=> { urlparams: data.0, qsparams: data.1, jsonparams: data.2 }
		| \Object	=> data
		| otherwise	=> {}
		
		# Set URL and METHOD
		opt =
			method: type
			url: BASE_URL + \/ + route + \/ + _api-key
		
		# Parse parameters
		## URL parameters
		if \urlparams of data
			opt.url = resolve opt.url + \/, delete data.urlparams
		else if urlparams?.split \/ then for let that
			opt.url += \/
			opt.url += that if delete data[..]
		
		## Querystring parameters
		if \qsparams of data
			opt.qs = delete data.qsparams
		else if qsparams?.split \/ then for let that
			opt.{}qs[..] = that if delete data[..]
		
		## JSON parameters
		if \jsonparams of data
			opt.json = delete data.jsonparams
		else if jsonparams?.split \/ then for let that
			opt.{}json[..] = that if delete data[..]
		
		## Send authentication if username and password are set
		opt.{}json[\username, \password] = [_username, _password] if _username? and _password?
		
		## Send request and return promise
		request opt .then ->
			it = it.0 if typeof! it is \Array
			if it.statusCode is 200 then it.body else throw do
				new Error 'Unexpected status code: ' + it.statusCode
					..res = it

	# METHOD FACTORY
	for let method in methods
		key-path = method.1 / \/
			name = (..pop! / \.).0
		
		accessed = ::
		for key-path
			accessed = accessed.{}[..]
		accessed[name] = _api-call method
