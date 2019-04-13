extends Node2D

var index = 0

onready var p1 = get_node("Paddle")
onready var p2 = get_node("Paddle2")
onready var p3 = get_node("Paddle3")
onready var p4 = get_node("Paddle4")
onready var ball = get_node("Ball")


func _ready():
	rpc("set_players_paddle")
	pass

sync func set_players_paddle():
	if get_tree().is_network_server():
		ball.set_network_master(get_tree().get_network_unique_id())
	p1.set_network_master(NetworkManager.players[0])
	p2.set_network_master(NetworkManager.players[1])
	p3.set_network_master(NetworkManager.players[2])
	p4.set_network_master(NetworkManager.players[3])
	pass

remote func register_player(id):
	rpc("set_player_paddle", id)
	pass

func on_connect():
	rpc_id(0, "register_player", get_tree().get_network_unique_id())
	pass