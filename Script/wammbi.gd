class_name character_body_2d extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_area: Area2D = $AttackArea
@onready var attack_cooldown: Timer = $AttackCooldown
@onready var cam: Camera2D = $Camera2D
@onready var sfx_lompat: AudioStreamPlayer2D = $sfx_lompat
@onready var sfx_jalan: AudioStreamPlayer2D = $sfx_jalan

const LIAT_ARAH = 60
@export var LAJU = 130
@export var JUMP_VELOCUTY = -370
@export var max_hp := 5
var hp := 0
var is_hurt := false

func _ready():
	hp = max_hp

var is_attacking := false

func _physics_process(delta):
	# GRAVITASI
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_axis("ui_left", "ui_right")

	# GERAK (SELALU BOLEH)
	velocity.x = direction * LAJU

	if direction != 0:
		sprite.flip_h = direction < 0
		cam.offset.x = lerp(cam.offset.x, LIAT_ARAH * direction, 0.1)

	# LOMPAT
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not is_attacking and not is_hurt:
		velocity.y = JUMP_VELOCUTY
		sprite.play("jump")
		sfx_lompat.play()

	# ATTACK
	if Input.is_action_just_pressed("attack") and not is_attacking and not is_hurt:
		attack()

	# === ANIMASI (SATU PINTU) ===
	if is_hurt:
		pass
	elif is_attacking:
		pass
	elif not is_on_floor():
		if velocity.y < 0:
			sprite.play("jump")
		else:
			sprite.play("fall")
	elif direction != 0:
		sprite.play("walk")
		if not sfx_jalan.playing:
			sfx_jalan.play()
	else:
		sprite.play("idle")
		sfx_jalan.stop()

	move_and_slide()



func attack():
	is_attacking = true
	sprite.play("attack")
	attack_area.monitoring = true
	
func take_damage(amount):
	if is_hurt:
		return

	hp -= amount
	is_hurt = true
	is_attacking = false

	sprite.play("hurt")
	print("HP Player:", hp)

	await sprite.animation_finished

	is_hurt = false


func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		if body.has_method("take_damage"):
			body.take_damage(1)


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "attack":
		is_attacking = false
		attack_area.monitoring = false
