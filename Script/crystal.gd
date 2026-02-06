extends Area2D

@onready var sfx_ambil: AudioStreamPlayer2D = $sfx_ambil
var taken := false

func _on_body_entered(body: Node2D) -> void:
	if taken:
		return

	if body.is_in_group("player"):
		taken = true
		sfx_ambil.play()
		hide()
		await sfx_ambil.finished
		queue_free()
