extends Area2D

@onready var sfx_tersentuh: AudioStreamPlayer2D = $sfx_tersentuh

func _on_body_entered(body):
	print("") 
	sfx_tersentuh.play()
	hide()
	$CollisionShape2D.disabled = true
	await sfx_tersentuh.finished
	queue_free()
