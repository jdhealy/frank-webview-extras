JSON.stringify do ->
	# try_stringify = ->
	# 	result = null
	# 	try
	# 		result = (JSON.stringify arg for arg in arguments)
	# 	catch e
	# 		alert "error: #{e.message}"
	# 		result = e
	# 	return result
	try 
		i = `insertable#{script}`
		success: i?
		result: i
	catch e
		{ error: e } #, lineNumber: e.lineNumber, keys: e.getOwnPropertyNames?() 