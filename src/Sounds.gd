extends DJSoundMap

enum S {
	}

###########################################################################
# sounds

@onready var sounds = {
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
