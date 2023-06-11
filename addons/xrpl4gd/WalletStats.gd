tool
extends Node

func _ready():
	print("testing")

func addressLookup(address):
	
	print("I'm asking the XRPL for wallet stats'")
	var message = {}
	message.method = "account_info"
	var paramObject = {}
	paramObject.account = address
	paramObject.strict = true
	paramObject.ledger_index = "current"
	message.params = [paramObject]
	print(message)
	
	var http = HTTPRequest.new()
	get_tree().root.add_child(http)
	var body = JSON.print(message)
	var headers = ["Content-Type: application/json"]

	http.request("https://xrplcluster.com/", headers, true, HTTPClient.METHOD_POST, body)
	var response = yield(http, "request_completed")
	response = response[3].get_string_from_utf8()
	return response
	
func accountNFTs(address):
	print("I'm asking the XRPL for NFTs'")
	var message = {}
	message.method = "account_nfts"
	var paramObject = {}
	paramObject.account = address
	paramObject.strict = true
	paramObject.ledger_index = "current"
	message.params = [paramObject]
	print(message)
	
	var http = HTTPRequest.new()
	get_tree().root.add_child(http)
	var body = JSON.print(message)
	var headers = ["Content-Type: application/json"]

	http.request("https://xrplcluster.com/", headers, true, HTTPClient.METHOD_POST, body)
	var response = yield(http, "request_completed")
	response = response[3].get_string_from_utf8()
	return response
	
func accountTrustlines(address):
	print("I'm asking the XRPL for Trustlines'")
	var message = {}
	message.method = "account_lines"
	var paramObject = {}
	paramObject.account = address
	paramObject.strict = true
	paramObject.ledger_index = "current"
	message.params = [paramObject]
	print(message)
	
	var http = HTTPRequest.new()
	get_tree().root.add_child(http)
	var body = JSON.print(message)
	var headers = ["Content-Type: application/json"]

	http.request("https://xrplcluster.com/", headers, true, HTTPClient.METHOD_POST, body)
	var response = yield(http, "request_completed")
	response = response[3].get_string_from_utf8()
	return response
	
func accountXUMMStatus(address):
	print("I'm asking the XRPL for XUMM status'")
	
	var http = HTTPRequest.new()
	get_tree().root.add_child(http)
	var headers = ["Content-Type: application/json"]

	http.request("https://xumm.app/api/v1/platform/account-meta/" + address, headers, true, HTTPClient.METHOD_GET)
	var response = yield(http, "request_completed")
	response = response[3].get_string_from_utf8()
	return response

