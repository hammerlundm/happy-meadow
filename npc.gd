extends Area

var player
var is_alive = true

func _ready():
	player = $"../player"

func _on_npc_body_entered(body):
	if player != null and body == player:
		player.touching.append(self)

func _on_npc_body_exited(body):
	if player != null and body == player:
		player.touching.remove(player.touching.find(self))
