extends Node2D

@onready var spawn_point = $SpawnPoint

func _ready():
	print("WORLD 2")

	if scene_manager.next_player_scene == null:
		print("TIDAK ADA PLAYER")
		return

	var player = scene_manager.next_player_scene.instantiate()
	player.global_position = spawn_point.global_position
	add_child(player)
	print("PLAYER SPAWNED")
