extends Node2D

var index = 0

onready var p1 = get_node("Paddle")
onready var p2 = get_node("Paddle2")
onready var p3 = get_node("Paddle3")
onready var p4 = get_node("Paddle4")
onready var ball = get_node("Ball")

var ids = []

func _ready():
	get_tree().connect("connected_to_server", self, "on_connect")
	if get_tree().is_network_server():
		p1.set_network_master(get_tree().get_network_unique_id())
		ball.set_network_master(get_tree().get_network_unique_id())
		pass
	pass

sync func set_player_paddle(id):
	if get_tree().is_network_server():
		p1.set_network_master(get_tree().get_network_unique_id())
		ball.set_network_master(get_tree().get_network_unique_id())
	p2.set_network_master(id)
	pass

remote func register_player(id):
	rpc("set_player_paddle", id)
	pass

func on_connect():
	rpc_id(0, "register_player", get_tree().get_network_unique_id())
	pass