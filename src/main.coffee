Request = require("sdk/request").Request
contextMenu = require "sdk/context-menu"
note = require "sdk/notifications"
clipboard = require "sdk/clipboard"
tabs = require "sdk/tabs"
URL = require "sdk/url"
data = require("sdk/self").data
exports.main = ->
	cLink = contextMenu.Item({
		context: contextMenu.SelectorContext("a[href]"),
		label: "Akarin~ Shorten This Link",
		contentScriptFile : data.url "link.js"
		onMessage: (link) ->
			if not URL.isValidURI(link)
				website = tabs.activeTab.url.split("/")
				link = "#{website[0]}#{website[1]}//#{website[2]}#{link}"
			Request({
				url: "http://api.waa.ai/shorten",
				content:{url:link},
				onComplete: (response) ->
					json = response.json
					sh = json.data.url
					sh = sh.replace /\\\//g , "/"
					note.notify({
						title: "Waa.ai",
						text: sh,
						iconURL: data.url "icon.png"
					})
					clipboard.set(sh)
			}).post()
	})
	pLink = contextMenu.Item({
		context: contextMenu.PageContext(),
		label: "Akarin~ Shorten This Page",
		contentScriptFile: data.url "current.js"
		onMessage: (page) ->
			Request({
				url: "http://api.waa.ai/shorten",
				content:{url:page},
				onComplete: (response) ->
					json = response.json
					sh = json.data.url
					sh = sh.replace /\\\//g , "/"
					note.notify({
						title: "Waa.ai",
						text: sh,
						iconURL: data.url "icon.png"
					})
					clipboard.set(sh)
			}).post()
	})
	iLink = contextMenu.Item({
		context: contextMenu.SelectorContext("img"),
		label: "Akarin~ Shorten This Image",
		contentScriptFile: data.url "image.js"
		onMessage: (image) ->
			Request({
				url: "http://api.waa.ai/shorten",
				content:{url:image},
				onComplete: (response) ->
					json = response.json
					sh = json.data.url
					sh = sh.replace /\\\//g , "/"
					note.notify({
						title: "Waa.ai",
						text: sh,
						iconURL: data.url "icon.png"
					})
					clipboard.set(sh)
			}).post()
	})
