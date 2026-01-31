extends CharacterBody2D


const SPEED = 80.0
const JUMP_VELOCITY = -250.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $ActionTimer

var direction := 0

func _ready() -> void:
	randomize()
	timer.wait_time = randf_range(1.5, 3.0)
	timer.start()
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	velocity.x = direction * SPEED
	
	move_and_slide()
	
	update_animation()
	
func update_animation():
	if not is_on_floor():
		sprite.play()
	elif direction != 0:
		sprite.play("jalan")
	else:
		sprite.play("diam")
		
	if direction != 0:
		sprite.flip_h = direction < 0
		
func _on_ActionTimer_timeout():
	var action = randi_range(0, 2)
	
	match  action:
		0:
			direction = 0
		1:
			direction = [-1, 1].pick_random()
		2:
			if is_on_floor():
				velocity.y = JUMP_VELOCITY
				
	timer.wait_time = randf_range(1.5, 3.0)
	timer.start()
