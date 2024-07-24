extends Control
class_name OrderCard

## static ###################################################

static func create(def: OrderDef):
	var scene = load("res://src/orders/OrderCard.tscn")
	var card = scene.instantiate()
	card.order_def = def
	return card

## vars ###################################################

@onready var name_label = $%DemonName
@onready var demand_checkboxes = $%Demands

@export var order_def: OrderDef :
	set(def):
		order_def = def
		if is_node_ready():
			set_demon_name(def)
			set_demands(def)

## ready ###################################################

func _ready():
	Log.pr("order card def", order_def)

	set_demon_name(order_def)
	set_demands(order_def)

## setters ###################################################

func set_demon_name(def):
	name_label.text = "[center]%s[/center]" % def.demon_name

func set_demands(def):
	U.remove_children(demand_checkboxes)
	for demand in def.demands:
		var checkbox = CheckBox.new()
		checkbox.text = OrderDef.demand_label(demand)
		demand_checkboxes.add_child(checkbox)

## has_demand ###################################################

func has_demand(demand):
	var lbl = OrderDef.demand_label(demand)
	for ch in demand_checkboxes.get_children():
		if ch.button_pressed:
			continue
		if ch.text == lbl:
			return true
	return false

## complete_demand ###################################################

func complete_demand(demand):
	var lbl = OrderDef.demand_label(demand)
	for ch in demand_checkboxes.get_children():
		if ch.button_pressed:
			continue
		if ch.text == lbl:
			ch.set_pressed(true)
			return
	Log.warn("Attempted to complete unknown demand on card!")

## is_complete ###################################################

func is_complete():
	for ch in demand_checkboxes.get_children():
		if not ch.button_pressed:
			return false
	return true
