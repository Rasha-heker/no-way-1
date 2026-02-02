extends CharacterBody2D

const SPEED = 30
var  current_state = IDLE

var dir = Vector2.RIGHT
var start_pos

var is_roaming = true
var is_chating = false

var player
var player_in_chat_zone = false

enum {
	IDLE,
	NEW_DIREC,
	MOVE,
}

func _physics_process(delta):
	#garpitasi
	if not is_on_floor():
		velocity += get_gravity() * delta

func _ready():
	randomize()
	start_pos = position
func _process(delta):
	if current_state == 0 or current_state == 1:
		$AnimatedSprite2D.play("diam")
		
	elif current_state == 2 and !is_chating:
		if dir.x == -1:
			$AnimatedSprite2D.play("jalan_kiri")
		elif dir.x == 1:
			$AnimatedSprite2D.play("jalan_kanan")
			
		if is_roaming:
			match current_state:
				IDLE:
					pass
				NEW_DIREC:
					dir = choose([Vector2.RIGHT, Vector2.LEFT])
				MOVE:
					move(delta)
					
func choose(array):
	array.shuffle()
	return array.front()
	
func move(delta):
	if !is_chating:
		position += dir * SPEED * delta

func _on_chat_area_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		player = body
		player_in_chat_zone = true


func _on_chat_area_body_exited(body: Node2D) -> void:
	if body.has_method("Player"):
		player_in_chat_zone = false


func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIREC, MOVE])
