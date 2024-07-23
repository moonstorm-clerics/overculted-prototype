extends Node2D
class_name Level

@onready var player = $TDHairo
var player_start

func _ready():
	player_start = player.position

	player.died.connect(func():
		Log.pr("player died")
		player.reset()
		player.position = player_start
		player.machine.transit("Idle"), CONNECT_DEFERRED)
