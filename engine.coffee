# https://gist.github.com/faisalman/4213592s
# Buffer = require('buffer').Buffer not neccesary

fs = require 'fs'
path = require 'path'
hashmap =
	'.png' : '89504E470D0A1A0A'
	'.jpg' : 'FFD8FF'
	'.jpeg' : 'FFD8FF'
	'.gif' : '47494638'
	'.bmp' : '41564920'
	'.avi' : '52494646'
	'.mkv' : '1A45DFA3'
	'.mp4' : '0000001866747970'
	'.mp3' : 'FFFB'


toValidate  = (fd, buffer, callback) ->
	tempBuffer = new Buffer(buffer.length)
	isValid = false
	fs.read fd, tempBuffer, 0,buffer.length,0, (err, bytesRead, buffer2) ->
		count = 0
		if tempBuffer.length is buffer.length
			while tempBuffer[count] is buffer[count] and count < tempBuffer.length
				count++
		isValid = if count is tempBuffer.length then true else false
		callback isValid
		# console.log 'toValidate extensions : ', extensions


module.exports =
	checkImage : (filePath)  ->
		fs.exists filePath, (exists) ->
			if (exists)
				fs.open filePath, 'r', (err, fd) ->
					if err
						throw err

					fileExtension = path.extname filePath
					fileExtension = fileExtension.toLowerCase()

					if fileExtension of hashmap
						for extensions of hashmap
							# console.log 'extension : ', extensions
							if extensions is fileExtension
								tmpExtension = extensions;
								toValidate fd, new Buffer(hashmap[extensions],'hex'), (toTest) ->
									if toTest
										console.log tmpExtension, ' : todo bien !!'
									else
										console.log tmpExtension, ' : ca marche pas !!!!'
					else
						console.log fileExtension, ': ce format n\'est pas supporté'




					# switch extension.toLowerCase()
					# 	when '.png'
					# 		buff fd, [new Buffer('89504E470D0A1A0A','hex')], (toTest) ->
					# 			if toTest
					# 				console.log 'png : todo bien !!'
					# 			else
					# 				console.log 'png : ca marche pas !!!!'

					# 	when '.jpg', '.jpeg'
					# 		buff fd, new Buffer('FFD8FF','hex'),  (toTest) ->
					# 			if toTest
					# 				console.log 'jpg : todo bien !!'
					# 			else
					# 				console.log 'jpg : ca marche pas !!!!'

					# 	when '.gif'
					# 		buff fd, new Buffer('47494638','hex'), (toTest) ->
					# 			if toTest
					# 				console.log 'gif : todo bien !!'
					# 			else
					# 				console.log 'gif : ca marche pas !!!!'

					# 	when '.bmp'
					# 		buff fd, new Buffer('424D','hex'), (toTest) ->
					# 			if toTest
					# 				console.log 'bmp : todo bien !!'
					# 			else
					# 				console.log 'bmp : ca marche pas !!!!'

					# 	when '.avi'
					# 		buff fd, new Buffer('52494646','hex'), (toTest) ->
					# 			# if toTest is '41564920' or toTest is'52494646'
					# 			if toTest
					# 				console.log 'avi : todo bien !!'
					# 			else
					# 				console.log 'avi : ca marche pas !!!!'

					# 	when '.mkv'
					# 		buff fd, new Buffer('1A45DFA3','hex'), (toTest) ->
					# 			if toTest
					# 				console.log 'mkv : todo bien !!'
					# 			else
					# 				console.log 'mkv : ca marche pas !!!!'

					# 	when '.mp4'
					# 		buff fd, new Buffer('0000001866747970','hex'), (toTest) ->
					# 			if toTest
					# 				console.log 'mp4 : todo bien !!'
					# 			else
					# 				console.log 'mp4 : ca marche pas !!!!'

					# 	when '.mp3'
					# 		buff fd, new Buffer('4944','hex'), (toTest) ->
					# 			# if toTest is '4944' or  toTest is 'FFFB' or toTest is 'FFF3' or toTest is 'FFE3'
					# 			if toTest
					# 				console.log 'mp3 : todo bien !!'
					# 			else
					# 				console.log 'mp3 : ca marche pas !!!!'


