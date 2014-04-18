# Trakt.tv API Wrapper
This is a LiveScript/JavaScript wrapper around the [Trakt.tv API](http://trakt.tv/api-docs), made mostly as a proof of concept and to familiarize myself with [LiveScript](http://livescript.net/), the Trakt.tv API and Promises.
It's also 100% functioning. It uses [Q Promises](https://github.com/kriskowal/q) and [request](https://github.com/mikeal/request).

To use in your projects: `$ npm install traktwrapper --save` and `var Trakt = require('traktwrapper');`

To compile yourself:

	$ git clone https://github.com/kalprestito/traktwrapper.git
	$ cd traktwrapper
	$ npm install
	$ node_modules/LiveScript/bin/lsc -c .

## Quickstart tutorial
This module exposes the `Trakt` class. In order to create an instance, you must provide your API key (you can get it going [here](http://trakt.tv/api-docs/authentication) while logged in Trakt). In your instance you can set a login username and password (optional, but methods that require authentication will fail if you don't set them) with `wrapper.username` and `wrapper.password`.

Now you're all set. You can call methods as they're listed in the [Trakt API Docs](http://trakt.tv/api-docs), e.g.: if you want to get the data for `activity/user/episodes`, call `wrapper.activity.user.episodes()`.

Indeed, some API methods require us to send some information as well, as we can see in [`activity/user/episodes` documentation](http://trakt.tv/api-docs/activity-user-episodes). This method needs an `username` to perform the lookup on, and the `title`, `season`, and `episode` arguments, as well as the optional parameters `actions`, `start_ts`, `end_ts`, `min` and `images` and optional authentication. However, each of these arguments must be sent in a different place: `min` and `images` are passed as a querystring, the authentication has to be sent as a JSON request body and the rest in the url, in a specific order. That's quite a mess.

However, `traktwrapper` handles all this for you, you only have to pass the parameters as a JSON object when calling the method ([something to know when using optional URL parameters](#optional-url-parameters)). Moreover, authentication and the `format` parameter get handled for you. Therefore, we can call `activity/user/episodes` like this: `episodes = wrapper.activity.user.episodes({"username": "archimedes", "title": "the-walking-dead", "season": 1, "episode": "1,2", "min": 1});`. If you use a compile-to-js language like CoffeeScript or LiveScript, their syntactic sugar makes this a breeze.

So, now we have called the method and are expecting the result. But, how are we going to get it? We didn't pass any callback! Don't worry, Promises to the rescue! Every API call returns a `Promise` for the value of the request, so you can use a `.then` method to attach a function which will modify the output and a `.done` method (that accepts a `success` function and a `error` one) to continue with your program. Promises let you manage callbacks more easily, see [PromiseJS.org](https://www.promisejs.org/) for more information on Promises and the [Q Promises docs](https://github.com/kriskowal/q) to learn what this specific implementation of Promises can do.

So, now we have finished our program. It's been quite some reading but the final code is very understandable and concise:

	var Trakt = require('traktwrapper');
	
	var wrapper = new Trakt('abcde1234andsoon'); // Your API key
	wrapper.username = 'archimedes'; // Login username
	wrapper.password = 'eureka'; // Login password
	
	wrapper.activity.user.episodes({
        "username": "archimedes",
        "title": "the-walking-dead",
        "season": 1,
        "episode": "1,2",
        "min": 1
    }).then(function(result) {
		// For example, convert all timestamps to human-readable time strings
	}).done(function (result) {
		// The data is here at last, use it
	}, function (error) {
		// There's been an error, act accordingly
	});

## Optional URL Parameters
The Trakt API does *not* accept unordered optional URL parameters. That is, you have to provide all the previous arguments to an optional one, even if some of them are also optional. For example, `Trakt#activity.user.episodes({"username": "archimedes", "title": "the-walking-dead", "season": 1, "episode": "1,2", "start_ts": whatever});` will get an empty response from Trakt.tv, as `actions` wasn't set and Trakt thinks we don't want any actions. This is a fault on Trakt's side. To work around this, visit the documentation page for each method you use and look what the default value is. Use that value.

Note that this does **NOT** apply to querystring or JSON parameters, you can pick which ones to use. Nonetheless, it is always a good idea to visit each method's documentation page and learn which parameters are required and which are not.

## API Reference

###  Trakt(apiKey)
Returns an instance of the Trakt object, ready to use.

- `apiKey` is your Trakt.tv API key (log in Trakt and go [here](http://trakt.tv/api-docs/authentication) to get yours).

### Trakt#username, Trakt#password and Trakt#passwordHash
These properties correspond to the username and password sent as authentication and the API key used for any request.

`username` and `password` are not compulsory, but if they're not **BOTH** set, the Trakt API will be called without authentication, failing in some methods or returning less information.

The value of `password` will only be returned as `true` (if it is set) or `false` (if it isn't).

Trakt requires passwords to be sent as SHA1 hashes. `traktwrapper` supposes `Trakt#password` is a plain text password and automatically hashes it. If you store passwords as hashes (you should), you might want to use the write-only `Trakt#passwordHash` property, that accepts already hashed passwords. For your convenience, a `Trakt.sha1(str)` function is provided.

### Trakt#apiCall(method, data)
Calls a specific Trakt.tv method. This method is not meant to be used directly, but every *'shorthand'* API call curries this function (i.e., returns this function with `method` already populated).

- `method` is an array in the form `[METHOD, ROUTE, URLPARAMS, QSPARAMS, JSONPARAMS]`, and is meant as a guideline to parse `data` and construct a `request` object. To learn more about it, view `methods.json` or `methods.json.ls`.

- `data` should be an object with the necessary named parameters to populate the request. Look up your method in `methods.json` or `methods.json.ls` to learn which parameters each function accepts, or look them up in the Trakt.tv API Docs.
  Alternatively, you can add the properties `urlparams`, `qsparams` and `jsonparams` to `data`, and these will be passed to `request` without further proccessing (or appended to the url in the case of `urlparams`).
  Also, see the note on [Optional URL Parameters](#optional-url-parameters).

This method returns a `Q` `Promise` that will be fulfilled with the body of the response or rejected with an error. If the error is because of an unexpected status code, it will include the `res` property, with a copy of the node.js `http.ServerResponse` object.

### Where are all the methods of the Trakt API?
They're all curried versions of `Trakt#apiCall`, i.e.: `apiCall` with the `method` argument already populated. All those methods only accept one argument, `data`. See above for more info on `Trakt#apiCall`.

**And in the code?** They're in `methods.json.ls`. This file is iterated over and applied to the `Trakt.prototype`.

## Contribution
I'm not a very experienced programmer, and I'm sure this project could be improved in quite a number of ways. If you spot either a bug or some code that can be improved, please send a pull request with your proposed changes, or file an issue if you're not feeling *code-y* today.
The program itself is very straight-forward, and should be easy to understsand, even though it isn't significantly commented.

Some things that need work are:

* Writing tests
* Debugging, which is non-existent now
* Handling unnecessary, optional or required authentication instead of sending it with every request
* Working around optional URL parameters
