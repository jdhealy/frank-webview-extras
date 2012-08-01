do ->
	elements = document.getElementsByTagName("button")
	elements = 
		el for el in elements when \
			el.type is 'submit' and 
			el.value is "Log In"
	console.log elements
	elements.map (el) ->
		el.click?()
	return elements

do ->
	elements = 
		el for el in document.getElementsByTagName("button") when el.type is 'submit' and el.value is "Log In"
	console.log elements
	elements.map (el) ->
		el.click?()
	return elements