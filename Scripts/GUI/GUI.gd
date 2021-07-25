extends Control


func _physics_process(delta):
	var Player = get_parent().get_parent().get_parent().get_node("Player")
	var textCoin = get_node("InGame/COIN/CoinNum")
	
	if Player.playerParameters.Coins < 10: 
		textCoin.text = "0" + str(Player.playerParameters.Coins)
	else:
		textCoin.text = str(Player.playerParameters.Coins)
	pass
