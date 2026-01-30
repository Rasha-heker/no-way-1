extends CharacterBody2D

const LAJU = 130.0
const JUMP_VELOCUTY = -300.0
const LIAT_ARAH = 60.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var cam: Camera2D = $Camera2D

func _physics_process(delta):
	#garpitasi
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_axis("ui_left", "ui_right")
	
	# Lompat
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCUTY
		sprite.play("lompat")

	#jalan
	if direction != 0:
		velocity.x = direction * LAJU
		sprite.flip_h = direction < 0
		cam.offset.x = lerp(cam.offset.x, LIAT_ARAH * direction, 0.1)
	else:
		velocity.x = 0
		cam.offset.x = lerp(cam.offset.x, 0.0, 0.1)
		
	#PERANIMASIAN AH
	if not is_on_floor():
		if velocity.y < 0:
			if sprite.animation != "lompat":
				sprite.play("lompat") # saat lompat
		else:
			if sprite.animation != "diudara":
				sprite.play("diudara") # saat jatuh
	else:
		if direction != 0:
			if sprite.animation != "jalan":
				sprite.play("jalan") #animasi jalan
		else:
			if sprite.animation != "idle":
				sprite.play("idle") #animasi diammmm

	move_and_slide()
