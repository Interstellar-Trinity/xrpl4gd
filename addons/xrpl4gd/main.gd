tool
extends VBoxContainer

func _ready():
	$"Get Stats Button".connect("pressed", self, "_on_button_pressed")
	
func _on_button_pressed():
	var address = "rpYdCHsTgvfcpSNkrhgKpUBJoGh8s8AJum"
	WalletStats.addressLookup()
	##$"Funds HBox/Funds LineEdit".text = WalletStats.addressLookup()
	print(address)
