extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCUTY = -300.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	#grapitasi
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var direction := Input.get_axis("ui_left", "ui_right")

	#ompat
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCUTY
	# biar bisa jalan
	if direction != 0:
		velocity.x = direction * SPEED
		
	# biar bisa hadap kanan kiri
		if direction > 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		
	# animasi buat jalan
		if sprite.animation != "jalan":
			sprite.play("jalan")
	else:
		velocity.x = 0
		
	# Animasi idel
		if sprite.animation != "idle":
			sprite.play("idle")

	move_and_slide()
