extends Node

const PORT = 3333
const SERVER_MAX_PLAYERS = 4
var SERVER_IP = "127.0.0.1"

func host_server():
	var host = NetworkedMultiplayerENet.new()
	host.create_server(PORT, SERVER_MAX_PLAYERS)
	get_tree().set_network_peer(host)
	pass

func connect_server():
	var client = NetworkedMultiplayerENet.new()
	client.create_client(SERVER_IP, PORT)
	get_tree().set_network_peer(client)
	pass