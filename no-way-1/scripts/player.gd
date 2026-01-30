extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var was_on_floor := false
var landing := false

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not Input.is_action_pressed("ui_down"):
		velocity.y = JUMP_VELOCITY
		sprite.play("jump")

	var direction := Input.get_axis("ui_left", "ui_right")
	var crouching := Input.is_action_pressed("ui_down")

	# =====================
	# 🛬 LANDING DETECTION
	# =====================
	if not was_on_floor and is_on_floor():
		landing = true
		sprite.play("land")

	# =====================
	# ✈️ DI UDARA
	# =====================
	if not is_on_floor():
		if velocity.y < 0:
			if sprite.animation != "jump":
				sprite.play("jump")
		else:
			if sprite.animation != "fall":
				sprite.play("fall")

	# =====================
	# 🔽 JONGKOK
	# =====================
	elif crouching:
		velocity.x = 0
		if sprite.animation != "jongkok":
			sprite.play("jongkok")

	# =====================
	# ▶️ JALAN
	# =====================
	elif direction != 0:
		velocity.x = direction * SPEED
		sprite.flip_h = direction < 0

		if sprite.animation != "walk" and not landing:
			sprite.play("walk")

	# =====================
	# 🧍 IDLE
	# =====================
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

		if sprite.animation != "idle" and not landing:
			sprite.play("idle")

	move_and_slide()

	# Reset landing setelah animasi selesai
	if landing and not sprite.is_playing():
		landing = false

	was_on_floor = is_on_floor()
