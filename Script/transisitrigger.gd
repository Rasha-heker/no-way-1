extends Area2D

var player_di_dalam = false

func _on_body_entered(body):
    if body.is_in_group("Player"):
        player_di_dalam = true
        print("Player masuk portal")

func _on_body_exited(body):
    if body.is_in_group("Player"):
        player_di_dalam = false
        print("Player keluar portal")

func _process(_delta):
    if player_di_dalam and Input.is_action_just_pressed("ui_accept"):
        print("PINDAH WORLD")
        get_tree().change_scene_to_file("res://Sceen/dunia_dua.tscn")
