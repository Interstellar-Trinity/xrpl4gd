extends Node
	
func _on_Button_pressed():
	var address = "rpYdCHsTgvfcpSNkrhgKpUBJoGh8s8AJum"
	
	WalletStats.addressLookup()
	##$"Funds HBox/Funds LineEdit".text = WalletStats.addressLookup()
	print(address)
