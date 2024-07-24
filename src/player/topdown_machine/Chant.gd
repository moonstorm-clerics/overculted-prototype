extends State

var exit_cb

## properties ###########################################################

func can_bump():
	return false

func can_act():
	return false

## enter ###########################################################

func enter(opts = {}):
	exit_cb = opts.get("exit_cb")

	actor.anim.play("chant")

	var chant_t = create_tween()
	chant_t.set_loops(3)
	chant_t.tween_callback(func():
		actor.do_chant()
		).set_delay(1)
	chant_t.finished.connect(transit.bind("Idle"))

## exit ###########################################################

func exit():
	# supports candle.put_out, room cam point reactivation
	if exit_cb != null:
		exit_cb.call()


## physics ###########################################################

func physics_process(_delta):
	actor.move_and_slide()
