extends Control

onready var player1status = get_node("Panel/Player1Status")
onready var player2status = get_node("Panel/Player2Status")
onready var player3status = get_node("Panel/Player3Status")
onready var player4status = get_node("Panel/Player4Status") 
onready var start_button = get_node("Panel/Button")


func _ready():
	get_tree().connect("connected_to_server", self, "_connected_ok")
	NetworkManager.connect("players_updated", self, "update_player_status")
	update_player_status()
	pass

func _connected_ok():
	NetworkManager.add_player(get_tree().get_network_unique_id())
	pass

func update_player_status():
	if(NetworkManager.players[0] != -1):
		player1status.text = "Ready"
	if(NetworkManager.players[1] != -1):
		player2status.text = "Ready"
	if(NetworkManager.players[2] != -1):
		player3status.text = "Ready"
	if(NetworkManager.players[3] != -1):
		player4status.text = "Ready"
		if get_tree().is_network_server():
			start_button.show()
	pass