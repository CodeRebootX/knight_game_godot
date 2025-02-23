extends "res://knight_state.gd"

func enter_state():
	animation_player.play("death_animation")
	await animation_player.animation_finished

	knight.set_physics_process(false)
	knight.set_collision_layer_value(1, false)  
	knight.set_collision_mask_value(1, false)
	knight.queue_free()

func process_state():
	pass

func exit_state():
	pass
