extends Node2D
class_name Level

## vars ###########################################################

@onready var player = $TDHairo
var player_start

var npcs = []
var orders = []

signal action_taken(demand)

## ready ###########################################################

func _ready():
	action_taken.connect(on_action_taken)

	setup_player()
	setup_npcs()
	start_orders()

## setup player/npcs ###########################################################

func setup_player():
	player_start = player.position

	player.machine.transitioned.connect(player_transit)

	player.died.connect(func():
		action_taken.emit(OrderDef.Demand.SacPlayer)
		player.reset()
		player.position = player_start
		player.machine.transit("Idle"), CONNECT_DEFERRED)

func player_transit(new_state_name):
	match new_state_name:
		"Pray": action_taken.emit(OrderDef.Demand.Pray)
		"Chant": action_taken.emit(OrderDef.Demand.Chant)
		_: pass

func setup_npcs():
	npcs = U.get_children_in_group(self, "npcs")
	for n in npcs:
		var n_start = n.position
		n.died.connect(func():
			action_taken.emit(OrderDef.Demand.SacNPC)
			n.reset()
			n.position = n_start
			n.machine.transit("Idle"),
			CONNECT_DEFERRED)

## orders ###########################################################

func start_orders():
	var new_order = OrderDef.gen_order()
	orders.append(new_order)
	Log.pr("order up!", orders)
	# TODO create and add order card

## action ###########################################################

func on_action_taken(demand):
	Log.info("Action taken", OrderDef.demand_label(demand))

	# TODO check off/complete existing orders

	match demand:
		OrderDef.Demand.SacPlayer:
			pass
		OrderDef.Demand.SacNPC:
			pass
		OrderDef.Demand.Chant:
			pass
		OrderDef.Demand.Pray:
			pass
		_: Log.warn("Unhandled action taken", demand)
