extends KinematicBody

var gameover = preload("res://gameover.tscn")

export(float) var SPEED
export(float) var FRICTION
export(float) var GRAVITY
export(float) var JUMP

var a = Vector3(0, 0, 0)
var v = Vector3(0, 0, 0)
var touching = []
var kill_count = 0

func _ready():
	$animation.play("walk")
	$timer.start()

func _physics_process(delta):
	v += a * delta
	a *= pow(2, -FRICTION*delta)
	v *= pow(2, -FRICTION*delta)
	move_and_slide(v)

func _process(delta):
	a.y = -GRAVITY
	if Input.is_action_pressed("player_left"):
		a.x -= SPEED
	if Input.is_action_pressed("player_right"):
		a.x += SPEED
	if Input.is_action_pressed("player_in"):
		a.z -= SPEED
	if Input.is_action_pressed("player_out"):
		a.z += SPEED
	if Input.is_action_just_pressed("player_attack"):
		$animation.play("attack")
		$animation.queue("walk")
		$sound.play()
		for npc in touching:
			if npc.is_alive:
				npc.is_alive = false
				npc.get_node("sprite").modulate = Color(1, 0, 0)
				npc.get_node("sound").play()
				npc.get_node("blood").emitting = true
				npc.get_node("animation").play("dead")
				kill_count += 1
				if kill_count >= 4:
					var asdf = gameover.instance()
					asdf.get_node("text").text = "Congratulations! You're a psychopath."
					asdf.get_node("text").modulate = Color(.85, 0, 0)
					$"../..".add_child(asdf)
	if v.x > 0:
		$sprite.flip_h = true
	else:
		$sprite.flip_h = false


func _on_Timer_timeout():
	var asdf = gameover.instance()
	if kill_count > 0 and kill_count < 4:
		asdf.get_node("text").text = "Well, at least you didn't kill everybody."
		asdf.get_node("text").modulate = Color(.75, 0, .5)
	else:
		asdf.get_node("text").text = "Wow, you're actually a decent human being!"
		asdf.get_node("text").modulate = Color(0, 0, 0.85)
	$"../..".add_child(asdf)
