tool
extends Node

onready var address_input = get_node("Wallet Address LineEdit")

func _ready():
	$"Get Stats Button".connect("pressed", self, "_on_button_pressed")
	
func _on_button_pressed():
	
	var wallet_info = yield(WalletStats.addressLookup(address_input.get_text()), "completed")
	var parsedMessage = JSON.parse(wallet_info)
	print(parsedMessage)
	$"Funds HBox"/"Funds LineEdit".text = String(int(parsedMessage.result.result.account_data.Balance) / 1000000) + " XRP"
	
	var account_nfts = yield(WalletStats.accountNFTs(address_input.get_text()), "completed")
	parsedMessage = JSON.parse(account_nfts)
	print(account_nfts)
	
	var account_trustlines = yield(WalletStats.accountTrustlines(address_input.get_text()), "completed")
	parsedMessage = JSON.parse(account_trustlines)
	print(account_trustlines)
	
	var account_xumm_status = yield(WalletStats.accountXUMMStatus(address_input.get_text()), "completed")
	parsedMessage = JSON.parse(account_xumm_status)
	print(account_xumm_status)
