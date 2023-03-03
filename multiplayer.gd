extends Control


const PORT = 4433


func _ready():
	get_tree().paused = true
	multiplayer.server_relay = false
	
	if DisplayServer.get_name() == "headless":
		print("Automatically starting dedicated server.")
		_on_host_pressed.call_deferred()


func _on_host_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer server.")
		return
	
	multiplayer.multiplayer_peer = peer
	start_game()


func _on_connect_pressed():
	var txt: String = $Net/Options/Remote.text
	
	if txt == "":
		OS.alert("Need a remote to connect to.")
		return
	
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(txt, PORT)
	
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer client.")
		return
	
	multiplayer.multiplayer_peer = peer
	start_game()


func start_game():
	hide()
	get_tree().paused = false
