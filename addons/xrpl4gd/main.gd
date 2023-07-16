tool
extends Node

onready var address_input = get_node("Wallet Address LineEdit")

func _ready():
	$"Get Stats Button".connect("pressed", self, "_on_button_pressed")
	$"XUMM Sign In".connect("pressed", self, "_xumm_sign_in")
	
func _on_button_pressed():
	
	var wallet_info = yield(WalletStats.addressLookup(address_input.get_text()), "completed")
	var parsedMessage = JSON.parse(wallet_info)
	print(parsedMessage)
	$"Funds HBox"/"Funds LineEdit".text = String(int(parsedMessage.result.result.account_data.Balance) / 1000000) + " XRP"
	
	var account_nfts = yield(WalletStats.accountNFTs(address_input.get_text()), "completed")
	parsedMessage = JSON.parse(account_nfts)
	print(account_nfts)
	
	var nft_count = 0
	for element in parsedMessage.result.result.account_nfts:
		print(element)
		nft_count = nft_count + 1
	$"NFT Count HBox/NFT Count LineEdit".text = String(nft_count)
	
	var account_trustlines = yield(WalletStats.accountTrustlines(address_input.get_text()), "completed")
	parsedMessage = JSON.parse(account_trustlines)
	print(account_trustlines)
	
	var trustline_count = 0
	for element in parsedMessage.result.result.lines:
		print (element)
		trustline_count = trustline_count + 1
	$"Trustline Count HBox/Trustline Count LineEdit".text = String(trustline_count)
	
	var account_xumm_status = yield(WalletStats.accountXUMMStatus(address_input.get_text()), "completed")
	parsedMessage = JSON.parse(account_xumm_status)
	print(account_xumm_status)
	
	$"isXUMMPro/XUMM Pro LineEdit".text = String(parsedMessage.result.xummPro)

func _xumm_sign_in():
	print("Im asking XUMM for a sign in payload")
	var http = HTTPRequest.new()
	get_tree().root.add_child(http)
	
	var message = {}
	message.txjson = {}
	message.txjson.TransactionType = "SignIn"
	var headers = ["Content-Type: application/json","X-API-Key: 406082c3-bc32-4d3b-80c9-e1b508a9194b","X-API-Secret: 6b8222e1-44cf-4385-af26-9e6895778ddb"]
	var query = JSON.print(message)
	http.request("https://xumm.app/api/v1/platform/payload", headers, true, HTTPClient.METHOD_POST, query)
	var response = yield(http, "request_completed")
	response = response[3].get_string_from_utf8()
	print(response)
