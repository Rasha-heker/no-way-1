extends CharacterBody2D

@export var speed := 20
@export var max_hp := 3
@export var attack_damage := 1
@export var attack_range := 30

var hit_count := 0
var hit_used := false
var is_dead := false
var hp := 0
var player: Node2D = null
var can_attack := true
var is_hurt := false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_timer: Timer = $AttackCooldown

func _ready():
	hp = max_hp
	


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body


func _physics_process(delta):
	if is_dead:
		return
		
	if player and not is_hurt:
		var distance = global_position.distance_to(player.global_position)

		if distance > attack_range:
			var dir = sign(player.global_position.x - global_position.x)
			velocity.x = dir * speed
			sprite.flip_h = dir < 0
			sprite.play("walk")
		else:
			velocity.x = 0
			if can_attack:
				attack(player)
	else:
		velocity.x = 0
		if not is_hurt:
			sprite.play("idle")

	move_and_slide()





func _on_attack_area_body_entered(body: Node2D) -> void:
	if is_dead:
		return
		
	if body.is_in_group("player"):
		hit_used = true
		body.take_damage(attack_damage)
		
	if body.is_in_group("player"):
		if body.has_method("take_damage"):
			body.take_damage(attack_damage)
		
func attack(target):
	if is_dead:
		return
		
	hit_used = false
	can_attack = false
	sprite.play("attack")
	attack_timer.start()
	
func take_damage(amount):
	if is_hurt:
		return
	
	hp -= amount
	is_hurt = true
	sprite.play("hit")

	$HurtTimer.stop()
	$HurtTimer.start()

	if hp <= 0:
		die()

func die():
	if is_dead:
		return

	is_dead = true
	can_attack = false
	player = null
	velocity = Vector2.ZERO

	$AttackArea.monitoring = false
	$CollisionShape2D.disabled = true

	sprite.play("dead")
	await sprite.animation_finished
	queue_free()



func _on_attack_cooldown_timeout() -> void:
	can_attack = true


func _on_hurt_timer_timeout() -> void:
	is_hurt = false


func _on_animated_sprite_2d_frame_changed() -> void:
	if sprite == null:
		return
		
	if sprite.animation != "attack":
		return
		
	match sprite.frame:
		4:
			$AttackArea.monitoring = true
		5:
			$AttackArea.monitoring = false
		6:
			$AttackArea.monitoring = false
		7:
			$AttackArea.monitoring = false
		8:
			$AttackArea.monitoring = true
		9:
			$AttackArea.monitoring = false
