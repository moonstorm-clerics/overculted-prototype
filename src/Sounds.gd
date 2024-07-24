extends DJSoundMap

enum S {
	chant,
	demand_complete,
	grab,
	new_order,
	order_complete,
	pray,
	respawn,
	throw,
	light_candle,
	willem_scream,
	}

###########################################################################
# sounds

@onready var sounds = {
	S.chant: [preload("res://assets/sounds/chant.sfxr")],
	S.demand_complete: [preload("res://assets/sounds/demand_complete.sfxr")],
	S.grab: [preload("res://assets/sounds/grab.sfxr")],
	S.new_order: [preload("res://assets/sounds/new_order.sfxr")],
	S.order_complete: [preload("res://assets/sounds/order_complete.sfxr")],
	S.pray: [preload("res://assets/sounds/pray.sfxr")],
	S.respawn: [preload("res://assets/sounds/respawn.sfxr")],
	S.throw: [preload("res://assets/sounds/throw.sfxr")],
	S.light_candle: [preload("res://assets/sounds/light_candle.sfxr")],
	S.willem_scream: [preload("res://assets/sounds/WillemScream.wav")],
}

## enter tree ##################################################################

func _enter_tree() -> void:
	if not Engine.is_editor_hint():
		get_tree().node_added.connect(on_node_added)

func on_node_added(node: Node):
	if node is Button:
		node.focus_entered.connect(on_button_focused.bind(node))
		node.pressed.connect(on_button_pressed.bind(node))

## ready ##################################################################

func _ready():
	if not Engine.is_editor_hint():
		SoundManager.set_default_sound_bus("Sound")
		SoundManager.set_default_ui_sound_bus("UI Sound")
		SoundManager.set_default_ambient_sound_bus("Ambient Sound")
		# deferring to give Music._ready a chance to set its buses
		# dodging a SoundManager warning about using the Master bus
		SoundManager.set_sound_volume.call_deferred(0.3)
		SoundManager.set_ui_sound_volume.call_deferred(0.3)
		SoundManager.set_ambient_sound_volume.call_deferred(0.3)

	super._ready()

## button sounds ##################################################################

func on_button_focused(_button: Button) -> void:
	pass
	# if button.is_visible_in_tree():
	# 	play(S.step)

func on_button_pressed(_button: Button) -> void:
	pass
	# play(S.speedup)
