extends Node

var network = NetworkedMultiplayerENet.new()
var port = 1909
var max_players = 100


onready var player_verification_process = get_node("PlayerVerification")
onready var combat_functions = get_node("Combat")


var data_to_send = {"method": "account_nfts","params": [{"account": "rJab1KS2TnBHHmRi2jdbaxc6geAgg3iCS3","ledger_index": "validated"}]}


func _ready():
	StartServer()


func StartServer():
	network.create_server(port, max_players)
	get_tree().set_network_peer(network)
	print("Server started")
	
	network.connect("peer_connected", self, "_Peer_Connected")
	network.connect("peer_disconnected", self, "_Peer_Disconnected")
	

func _Peer_Connected(player_id):
	print ("User " + str(player_id) + " has connected")
#	player_verification_process.start(player_id)
	

func _Peer_Disconnected(player_id):
	print ("User " + str(player_id) + " has disconnected") 
	
	
#remote func FetchSkillDamage(skill_name, requestor):
#	var player_id = get_tree().get_rpc_sender_id()
#	var damage = get_node("Combat").FetchSkillDamage[skill_name]
#	rpc_id(player_id, "ReturnSkillData", damage, requestor)
#	print("Sending " + str(damage) + " to player")


remote func FetchPlayerStats():
	var player_id = get_tree().get_rpc_sender_id()
	var player_stats = get_node(str(player_id)).player_stats
	rpc_id (player_id, "ReturnPlayerStats", player_stats)
	print ("Stats fetched and sent to " + str(player_id))


"""
MintAndOfferCallout Code 
"""

#func onCall(NFTokenOfferId):
#	print("mint executing")
#	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
#	PlayerOfferNotification()
#	#add in a popup letting the plaayer know that the NFT is being minted
#
#func _on_request_completed(result, response_code, headers, body):
#	print("it worked again")
#
#remote func MintNft(NFTokenOfferId):
#	print ("NFT minting")
#	var mint_query = JSON.print(data_to_send)
#	print (data_to_send)
#	# Add 'Content-Type' header:
#	var mint_headers = ["Content-Type: application/json"]
#	$HTTPRequest.request("http://localhost:8080/mintAndOffer", mint_headers, true, HTTPClient.METHOD_POST, mint_query)
#	PlayerOfferNotification()
#	print("Im asking the player to accept the offer")
#	print(NFTokenOfferId)
#	var message = {}
#	message.txjson = {}
#	message.user_token = "a4f8349f-27f5-475d-aff0-83260138b374"
#	message.txjson.TransactionType = "NFTokenAcceptOffer"
#	message.txjson.NFTokenSellOffer = NFTokenOfferId
#	message.txjson.Account = "rBzenNKj1R8kDmi7cRydSmgkD4st6uAu78"
#	var offer_headers = ["Content-Type: application/json","X-API-Key: 406082c3-bc32-4d3b-80c9-e1b508a9194b","X-API-Secret: 6b8222e1-44cf-4385-af26-9e6895778ddb"]
#	var offer_query = JSON.print(message)
#	$HTTPRequest.request("https://xumm.app/api/v1/platform/payload", offer_headers, true, HTTPClient.METHOD_POST, offer_query)
##	playerOfferAccept(NFTokenOfferId)
#
#
#
#
#func playerOfferAccept(NFTokenOfferId):
#	print("Im asking the player to accept the offer")
#	print(NFTokenOfferId)
#	var message = {}
#	message.txjson = {}
#	message.user_token = "a4f8349f-27f5-475d-aff0-83260138b374"
#	message.txjson.TransactionType = "NFTokenAcceptOffer"
#	message.txjson.NFTokenSellOffer = NFTokenOfferId
#	message.txjson.Account = "rBzenNKj1R8kDmi7cRydSmgkD4st6uAu78"
#	var offer_headers = ["Content-Type: application/json","X-API-Key: 406082c3-bc32-4d3b-80c9-e1b508a9194b","X-API-Secret: 6b8222e1-44cf-4385-af26-9e6895778ddb"]
#	var offer_query = JSON.print(message)
#	$HTTPRequest.request("https://xumm.app/api/v1/platform/payload", offer_headers, true, HTTPClient.METHOD_POST, offer_query)
#	# Need to call this function so that the Player gets a push request to XUMM


"""
MintAndOfferCallout Code ^^^
"""

#remote func FetchPlayerNft():
#	var player_id = get_tree().get_rpc_sender_id()
#	var player_nft = get_node("MintAndOfferCallout").NFTokenOfferID
#	rpc_id (player_id, "ReturnPlayerNft", player_nft)
#	print ("NFT fetched and sent to " + str(player_id))


remote func MintNft():
	$MintAndOfferCallout.onCall()
#	$MintAndOfferCallout.playerOfferAccept(NFTokenOfferId)

func PlayerOfferNotification():
	var player_id = get_tree().get_rpc_sender_id()
	rpc_id (player_id, "ReturnPlayerOffer")
	print ("Notification sent to " + str(player_id))
# Going to call the mint and offer callout


remote func FetchPlayerNft():
	var player_id = get_tree().get_rpc_sender_id()
	rpc_id (player_id, "ReturnPlayerNft")
	print ("Notification sent to " + str(player_id))
# This will fire when the player accepts the offer
# Needs to fire at the end of the Websocket 
