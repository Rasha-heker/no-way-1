extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_area: Area2D = $AttackArea
@onready var attack_cooldown: Timer = $AttackCooldown

@export var SPEED = 130
@export var JUMP_VELOCITY = -350
@export var max_hp := 5
var hp := 0
var is_hurt := false

func _ready():
	hp = max_hp

var is_attacking := false

func _physics_process(delta):
	#grapitasi
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#jalan
	var dir = Input.get_axis("ui_left", "ui_right")
	velocity.x = dir * SPEED
	
	#lompat
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	#nyerang
	if Input.is_action_just_pressed("attack") and not is_attacking:
		attack()
		
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
	sprite.play("hurt")
		
	print("HP Player:", hp)
		
	await  sprite.animation_finished
	is_hurt = false
	sprite.play("idle")
	


func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		if body.has_method("take_damage"):
			body.take_damage(1)


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "attack":
		is_attacking = false
		attack_area.monitoring = false
		sprite.play("idle")
