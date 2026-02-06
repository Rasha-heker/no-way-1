extends Area2D

@onready var label: Label = $Label

func _ready():
	label.visible = false



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		label.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		label.visible = false
		queue_free()
