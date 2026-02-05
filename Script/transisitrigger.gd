class_name TransisiTrigger extends Area2D
@export var connected_scene: String
@export var scene_folder : = "res://Sceen/"

func _on_body_entered(body: Node2D) -> void:
    if body is Player:
     scene_manager.change_scene(get_owner(), connected_scene)
