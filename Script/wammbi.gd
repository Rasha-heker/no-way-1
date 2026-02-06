class_name wammbi extends CharacterBody2D

const LAJU = 130.0
const JUMP_VELOCUTY = -300.0
const LIAT_ARAH = 60.0

@export var max_hp := 5
var hp := 0
var is_hurt := false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var cam: Camera2D = $Camera2D
@onready var sfx_lompat: AudioStreamPlayer2D = $sfx_lompat

func _ready():
	hp = max_hp

var is_attacking := false

func _physics_process(delta):
	#garpitasi
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_just_pressed("attack") and not is_attacking:
		attack()
	
	# Lompat
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCUTY
		sprite.play("jump")
		sfx_lompat.play()

	#jalan
	if direction != 0:
		velocity.x = direction * LAJU
		sprite.flip_h = direction < 0
		cam.offset.x = lerp(cam.offset.x, LIAT_ARAH * direction, 0.1)
	else:
		velocity.x = 0
		
		
	#PERANIMASIAN AH
	if not is_on_floor():
		if velocity.y < 0:
			if sprite.animation != "jump":
				sprite.play("jump") # saat lompat
	else:
		if direction != 0:
			if sprite.animation != "walk":
				sprite.play("walk") #animasi jalan
		else:
			if sprite.animation != "idle":
				sprite.play("idle") #animasi diammmm

	move_and_slide()
	
	
