extends Node

var network = NetworkedMultiplayerENet.new()
var port = 1909
var max_players = 100


onready var player_verification_process = get_node("PlayerVerification")
onready var combat_functions = get_node("Combat")


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
	player_verification_process.start(player_id)
	

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


# This function is triggered by the player clicking the "Test Mint" button
remote func MintNft():
	var player_id = get_tree().get_rpc_sender_id()
	print("Player " + str(player_id) + " requested NFT mint")
	get_node("MintAndOfferCallout")._on_Button_pressed()
	


# This function should fire when the XUMM push request is generated
func OfferNft():
	
	var player_id = get_tree().get_rpc_sender_id()
	print ("Offer extended to " + str(player_id))
	rpc_id (player_id, "OfferNft")


# This will trigger the weapon change in the client
func NftAccepted():
	var player_id = get_tree().get_rpc_sender_id()
	rpc_id (player_id, "NftAccepted")
	print ("Player " + str(player_id) + (" accepted the NFT."))
