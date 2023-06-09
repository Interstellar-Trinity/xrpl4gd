tool
extends Node

func _ready():
	print("testing")

func addressLookup():
	print('Hello World')
	print("I'm asking the XRPL for wallet stats'")
	var message = {}
	message.method = "account_info"
	var paramObject = {}
	paramObject.account = "rJab1KS2TnBHHmRi2jdbaxc6geAgg3iCS3"
	paramObject.strict = true
	paramObject.ledger_index = "current"
	message.params = [paramObject]
	##var headers = ["Content-Type: application/json"]
	##var query = JSON.print(message)
	print(message)
	var http = HTTPRequest.new()
	get_tree().root.add_child(http)
	
	print("I got here")
	##http.request("https://s1.ripple.com:51234/", headers, true, HTTPClient.METHOD_GET, query)
	
	var data_to_send = {"method": "account_nfts","params": [{"account": "rJab1KS2TnBHHmRi2jdbaxc6geAgg3iCS3","ledger_index": "validated"}]}
	var query = JSON.print(data_to_send)
	var headers = ["Content-Type: application/json"]

	http.request("http://localhost:8080/mintAndOffer", headers, true, HTTPClient.METHOD_POST, query)
