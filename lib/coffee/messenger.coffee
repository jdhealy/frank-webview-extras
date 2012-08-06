do ->
	try 
		i = `insertable#{script}`
		do -> JSON.stringify 
			success: i?
			result: i
	catch e
		callstack = ->
			currentFunction = arguments.callee.caller

			while currentFunction
				fn = currentFunction.toString()
				currentFunction = currentFunction.caller
				fname = fn.substring(fn.indexOf("function") + 8, fn.indexOf("(")).trim() || "anonymous"
				# alert fname
				fname
		JSON.stringify { success: false, error: e, callstack: callstack() } #, lineNumber: e.lineNumber, keys: e.getOwnPropertyNames?() 