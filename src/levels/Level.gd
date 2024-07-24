extends Node2D
class_name Level

## vars ###########################################################

@onready var order_list = $%OrderList

@onready var player = $TDHairo
var player_start

var npcs = []

signal action_taken(demand)

## ready ###########################################################

func _ready():
	action_taken.connect(on_action_taken)

	setup_player()
	setup_npcs()

	U.remove_children(order_list)
	add_order()

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

func add_order():
	var new_order = OrderDef.gen_order()
	var card = OrderCard.create(new_order)
	order_list.add_child(card)

## action ###########################################################

func on_action_taken(demand):
	match demand:
		OrderDef.Demand.SacPlayer, OrderDef.Demand.SacNPC, OrderDef.Demand.Chant, OrderDef.Demand.Pray:
			Log.info("Action taken", OrderDef.demand_label(demand))
		_: Log.warn("Unhandled action", demand)

	var to_remove
	for order_card in order_list.get_children():
		if order_card.has_demand(demand):
			order_card.complete_demand(demand)

			if order_card.is_complete():
				to_remove = order_card
			break

	if to_remove:
		await get_tree().create_timer(2.0).timeout
		to_remove.queue_free()

		if len(order_list.get_children()) < 2:
			add_order()
			add_order()
