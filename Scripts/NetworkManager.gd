extends Node

const PORT = 3030
const SERVER_MAX_PLAYERS = 4
var SERVER_IP = "127.0.0.1"

var players = [-1, -1, -1, -1,]

signal players_updated

remote func add_player(id):
	if get_tree().is_network_server():
		for i in range(0, players.size()):
			if players[i] == -1:
				players[i] = id
				rpc("update_players_connected", players)
				return
	else:
		rpc_id(1, "add_player", id)
	pass

sync func update_players_connected(updated_players):
	players = updated_players
	emit_signal("players_updated")
	pass

func host_server():
	var host = NetworkedMultiplayerENet.new()
	host.create_server(PORT, SERVER_MAX_PLAYERS)
	get_tree().set_network_peer(host)
	add_player(get_tree().get_network_unique_id())
	pass

func connect_server():
	var client = NetworkedMultiplayerENet.new()
	client.create_client(SERVER_IP, PORT)
	get_tree().set_network_peer(client)
	pass