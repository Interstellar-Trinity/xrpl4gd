extends Node

# The URL we will connect to
export var websocket_url = "wss://s.devnet.rippletest.net:51233/"
var node2

# Our WebSocketClient instance
var _client = WebSocketClient.new()

func _ready():
	# Connect base signals to get notified of connection open, close, and errors.
	_client.connect("connection_closed", self, "_closed")
	_client.connect("connection_error", self, "_closed")
	_client.connect("connection_established", self, "_connected")
	# This signal is emitted when not using the Multiplayer API every time
	# a full packet is received.
	# Alternatively, you could check get_peer(1).get_available_packets() in a loop.
	_client.connect("data_received", self, "_on_data")

	# Initiate connection to the given URL.
	var err = _client.connect_to_url(websocket_url, [])
	if err != OK:
		print("Unable to connect")
		set_process(false)

func _closed(was_clean = false):
	# was_clean will tell you if the disconnection was correctly notified
	# by the remote peer before closing the socket.
	print("Closed, clean: ", was_clean)
	set_process(false)

func _connected(proto = ""):
	# This is called on connection, "proto" will be the selected WebSocket
	# sub-protocol (which is optional)
	print("Connected with protocol: ", proto)
	# You MUST always use get_peer(1).put_packet to send data to server,
	# and not put_packet directly when not using the MultiplayerAPI.
	var message = {}
	message.id = "example watch of Issuer wallet"
	message.command = "subscribe"
	message.accounts = ["rPRj85p1aakos2s8GgLEh4x74YPDcHte9C"]
	var connectIssuer = JSON.print(message)
	print(connectIssuer)
	_client.get_peer(1).put_packet(connectIssuer.to_utf8())



func _on_data():
	# Print the received packet, you MUST always use get_peer(1).get_packet
	# to receive data from server, and not get_packet directly when not
	# using the MultiplayerAPI.
	print("Got data from server")
	
	var message = _client.get_peer(1).get_packet().get_string_from_utf8()
	print(message)
	
	var parsedMessage = JSON.parse(message)
	if parsedMessage.result.type == "transaction":
		print(parsedMessage.result.transaction.TransactionType)
		if parsedMessage.result.transaction.TransactionType == "NFTokenAcceptOffer":
			print("Offer Accepted!")
			#add in the function to change the player's weapon here
		if parsedMessage.result.transaction.TransactionType == "NFTokenCreateOffer":
			var affectedNodes = parsedMessage.result.meta.AffectedNodes
			print("Offer Made!")
			for element in affectedNodes:
				print(element)
				print(element.keys()[0])
				if (element.keys()[0] == "CreatedNode"):
					if (element.CreatedNode.LedgerEntryType == "NFTokenOffer"):
						print("Found the NFTokenOfferId")
						#push to XUMM Wallet
						get_parent().onCall(element.CreatedNode.LedgerIndex)


func _process(delta):
	# Call this in _process or _physics_process. Data transfer, and signals
	# emission will only happen when calling this function.
	_client.poll()
