extends Control

func _on_HostButton_pressed():
	get_tree().change_scene("res://Level/Lobby.tscn")
	NetworkManager.host_server()
	pass

func _on_JoinButton_pressed():
	get_tree().change_scene("res://Level/Lobby.tscn")
	NetworkManager.connect_server()
	pass
