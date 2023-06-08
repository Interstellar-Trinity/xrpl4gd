extends Reference

class_name WalletStats

static func addressLookup():
	print('Hello World')
	print("I'm asking the XRPL for wallet stats'")
	var message = {}
	message.method = "account_info"
	var paramObject = {}
	paramObject.account = "rJab1KS2TnBHHmRi2jdbaxc6geAgg3iCS3"
	paramObject.strict = true
	paramObject.ledger_index = "current"
	message.params = [paramObject]
	var headers = ["Content-Type: application/json"]
	var query = JSON.print(message)
	print(message)
	var http = HTTPRequest.new()
	print("I got here")
	http.request("https://s1.ripple.com:51234/", headers, true, HTTPClient.METHOD_GET, query)
