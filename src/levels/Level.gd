extends Node2D
class_name Level

@onready var player = $TDHairo
var player_start

var npcs = []

func _ready():
	setup_player()
	setup_npcs()

func setup_player():
	player_start = player.position

	player.machine.transitioned.connect(player_transit)

	player.died.connect(func():
		Log.pr("player sacrificed themselves")
		player.reset()
		player.position = player_start
		player.machine.transit("Idle"), CONNECT_DEFERRED)

func player_transit(new_state_name):
	match new_state_name:
		"Pray": Log.pr("player praying!")
		"Chant": Log.pr("player chanting!")
		_: Log.pr("player entered new state")

func setup_npcs():
	npcs = U.get_children_in_group(self, "npcs")
	for n in npcs:
		var n_start = n.position
		n.died.connect(func():
			Log.pr("npc sacrificed")
			n.reset()
			n.position = n_start
			n.machine.transit("Idle"),
			CONNECT_DEFERRED)
