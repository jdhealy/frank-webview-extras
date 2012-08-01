#iterate

do ->
	query = `insertable#{query}`
	options = JSON.parse `insertable#{json_options.inspect}`

	query = [ query ] unless (query instanceof Array)
	if query?.length > 0
		results = []
		for el in query 
			result = {}
			for func in options?.functions when (typeof func).toLowerCase() is 'string'
				if el[func]?
					result[func] = el[func].call()
				else
					evaluation = eval "el.#{func}"
					result[func] = if evaluation isnt undefined then evaluation else "undefined"
			for property in options?.properties when (typeof property).toLowerCase() is 'string'
				if el[property]?
					result[property] = el[property]
				else
					evaluation = el[property]
					result[property] = if evaluation isnt undefined then evaluation else "undefined"
			results.push result
			#alert JSON.stringify result #DEBUG
		#alert "results\n———\n" + JSON.stringify results #DEBUG
		return results
	else
		return nil