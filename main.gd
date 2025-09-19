extends Node2D

@onready var players := {
	"1": {
		viewport = $HBoxContainer/SubViewportContainer/SubViewport,
		camera = $HBoxContainer/SubViewportContainer/SubViewport/Camera2D,
		player = %Map/Player1
	},
	"2": {
		viewport = $HBoxContainer/SubViewportContainer2/SubViewport,
		camera = $HBoxContainer/SubViewportContainer2/SubViewport/Camera2D,
		player = %Map/Player2
	}
}

@onready var spawnpoints := %Map/Spawnpoints
var all_spawnpoints := []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	players["2"].viewport.world_2d = players["1"].viewport.world_2d
	for node in players.values():
		var remote_transform := RemoteTransform2D.new()
		remote_transform.remote_path = node.camera.get_path()
		node.player.add_child(remote_transform)
	
	all_spawnpoints = spawnpoints.get_children()
	var chosen_spawn = move_to_random_spawn("1", null)
	move_to_random_spawn("2", chosen_spawn)
	
func move_to_random_spawn(player_id: String, excluded_spawn) -> int:
	var random_spawn: int
	while true:
		random_spawn = randi_range(0, all_spawnpoints.size()-1)
		if random_spawn != excluded_spawn:
			break
	players[player_id].player.global_position = all_spawnpoints[random_spawn].global_position
	return random_spawn
