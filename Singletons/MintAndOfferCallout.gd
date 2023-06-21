extends Node

var data_to_send = {"method": "account_nfts","params": [{"account": "rJab1KS2TnBHHmRi2jdbaxc6geAgg3iCS3","ledger_index": "validated"}]}


func _ready():
	print("mint executing")
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	_on_Button_pressed()
	
	
func onCall(NFTokenOfferId):
	print("mint executing")
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	Server.PlayerOfferNotification()
	#add in a popup letting the player know that the NFT is being minted

func _on_request_completed(result, response_code, headers, body):
	print("it worked again")

func _on_Button_pressed():
	print ("it worked")
	var query = JSON.print(data_to_send)
	print (query)
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.request("http://localhost:8080/mintAndOffer", headers, true, HTTPClient.METHOD_POST, query)
	Server.PlayerOfferNotification()

func playerOfferAccept(NFTokenOfferId):
	print("Im asking the player to accept the offer")
	print(NFTokenOfferId)
	var message = {}
	message.txjson = {}
	message.user_token = "a4f8349f-27f5-475d-aff0-83260138b374"
	message.txjson.TransactionType = "NFTokenAcceptOffer"
	message.txjson.NFTokenSellOffer = NFTokenOfferId
	message.txjson.Account = "rBzenNKj1R8kDmi7cRydSmgkD4st6uAu78"
	var headers = ["Content-Type: application/json","X-API-Key: 406082c3-bc32-4d3b-80c9-e1b508a9194b","X-API-Secret: 6b8222e1-44cf-4385-af26-9e6895778ddb"]
	var query = JSON.print(message)
	$HTTPRequest.request("https://xumm.app/api/v1/platform/payload", headers, true, HTTPClient.METHOD_POST, query)
	#TODO add in the logic to request that they check their wallet.


#Need to pull th mint and offer callout out of the scene tree and put it into a
#function that will be called when the server recieves the button pressed event
