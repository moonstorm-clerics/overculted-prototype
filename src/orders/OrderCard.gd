extends Control
class_name OrderCard

@export var order_def: OrderDef

func _ready():
	Log.pr("order card def", order_def)
