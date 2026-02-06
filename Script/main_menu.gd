extends Control

@onready var main_buttons: VBoxContainer = $"main buttons"
@onready var credit: Panel = $Credit



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _ready():
	main_buttons.visible = true
	credit.visible = false

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Sceen/Mainn.tscn")


func _on_credit_pressed() -> void:
	print("YEY")
	main_buttons.visible = false
	credit.visible = true


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_back_credit_pressed() -> void:
	_ready()
