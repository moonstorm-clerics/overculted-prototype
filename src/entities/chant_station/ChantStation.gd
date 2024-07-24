@tool
extends Node2D
class_name ChantStation

var visit_count = 0
var chanting = false

## config warnings ###########################################################

func _get_configuration_warnings():
	return U._config_warning(self, {expected_nodes=["ActionArea", "ActionHint"]})

## actions ###########################################################

var actions = [
	Action.mk({label="Chant", fn=start_chant, show_on_actor=false,
		source_can_execute=func(): return not chanting}),
	]

## start_chant ###########################################################

func start_chant(actor):
	visit_count += 1
	chanting = true

	actor.machine.transit("Chant", {exit_cb=func():
		chanting = false})
