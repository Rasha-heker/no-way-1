extends CanvasLayer

func show_text(text):
	visible = true
	$Panel/Label.text = text

func hide_box():
	visible = false
