extends Control

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("quit"):
		get_tree().quit()

func _on_Button_button_up():
	get_tree().quit()
