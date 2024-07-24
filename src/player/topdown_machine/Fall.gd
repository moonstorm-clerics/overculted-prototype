extends State


var fall_time = 0.6
var fall_ttl
var fall_scale_factor = 0.2

var tween

## enter ###########################################################

func enter(opts = {}):
	actor.anim.play("fall")
	Sounds.play(Sounds.S.willem_scream)
	fall_ttl = U.get_(opts, "fall_time", fall_time)
	actor.velocity = Vector2.ZERO

	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(actor, "scale", Vector2.ONE*fall_scale_factor, fall_ttl)
	tween.tween_property(actor, "modulate:a", 0.0, fall_ttl)

	actor.stamp()

	if actor.skull_particles != null:
		# force one-shot emission
		actor.skull_particles.set_emitting(true)
		actor.skull_particles.restart()



## exit ###########################################################

func exit():
	tween.kill()
	tween = create_tween()
	tween.tween_property(actor, "scale", Vector2.ONE, 0.3)
	tween.tween_property(actor, "modulate:a", 1.0, 0.3)


## input ###########################################################

func unhandled_input(_event):
	pass


## physics ###########################################################

func physics_process(delta):
	fall_ttl -= delta

	if fall_ttl <= 0:
		machine.transit("Dead")
		return

	actor.move_and_slide()
