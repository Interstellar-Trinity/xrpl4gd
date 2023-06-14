extends Node
	
func _on_Button_pressed():
	var address = "rpYdCHsTgvfcpSNkrhgKpUBJoGh8s8AJum"
	
	WalletStats.addressLookup(address)
	##$"Funds HBox/Funds LineEdit".text = WalletStats.addressLookup()
