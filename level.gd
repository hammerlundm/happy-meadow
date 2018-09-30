extends Node

var animated = []
export(float) var TIME = 1.0
var t = 0

func _ready():
	$npc5/blood.process_material.color.a = 0.0
	$npc5/blood.emitting = true
	$npc5/sprite.opacity = 0.0
	for child in get_children():
		if child.name.find("grass") != -1 or child.name.find("flower") != -1:
			animated.append(child)
		elif child.name.find("npc") != -1:
			child.get_node("animation").play("alive")

func _process(delta):
	t -= delta
	if t <= 0:
		t = TIME
		for thing in animated:
			thing.frame = (thing.frame + 1) % thing.hframes