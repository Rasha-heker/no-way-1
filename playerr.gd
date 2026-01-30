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

	#ompat
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCUTY

	#jalan
	if direction != 0:
		velocity.x = direction * LAJU

		#karakter arah kanan kiri
		sprite.flip_h = direction < 0

		#kamerak ngikut karakter
		cam.offset.x = lerp(cam.offset.x, LIAT_ARAH * direction, 0.1)

		# Animasi jalan
		if sprite.animation != "jalan":
			sprite.play("jalan")
	else:
		velocity.x = 0

		# Kamera balik ke tengah
		cam.offset.x = lerp(cam.offset.x, 0.0, 0.1)

		# Animasi diam
		if sprite.animation != "idle":
			sprite.play("idle")

	move_and_slide()
