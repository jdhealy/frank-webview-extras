# Set Text

do ->
	query = `insertable#{query}` #document.getElementById('accountID')
	return throw "Query produced no results" if not query?
	return throw "Query did not produce an input" if query?.tagName.toLowerCase() isnt 'input'
	# return throw """
	# Query has no value to set
	# 	keys: #{Object.keys query}
	# 	outerHTML: #{query.outerHTML}
	# """ if not query?.value
	query.value = JSON.parse(`insertable#{text}`).text