fs = require 'fs'

{ print } = require 'sys'
{ spawn } = require 'child_process'

fs = require 'fs'

{print} = require 'sys'
{spawn} = require 'child_process'

build =  ->
	coffee = spawn 'coffee' , ["-c","-o","lib","src"]
	cfx = spawn "cfx" , ["xpi"]
	coffee.stderr.on 'data', (data) ->
    		process.stderr.write data.toString()
    	coffee.stdout.on 'data', (data) ->
    		print data.toString()
watch = ->
	coffee = spawn 'coffee', ['-w', '-c', '-o', 'lib', 'src']
	coffee.stderr.on 'data', (data) ->
		process.stderr.write data.toString()
	coffee.stdout.on 'data', (data) ->
		cfx = spawn "cfx" , ["xpi"]
		print data.toString()
task 'build' , 'Build lib/ from /src', ->
	build()
task 'watch', 'Watch src/ for changes', ->
	watch()


