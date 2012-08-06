do ->
	for el in document.getElementsByTagName('input') when el.type is 'submit'
		if el.click?
			el.click() 
			return true
	for el in document.getElementsByTagName('button') when el.type is 'submit'
		if el.click?
			el.click() 
			return true
	return throw "Submit button not found…"