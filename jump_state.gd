extends "res://knight_state.gd"

func enter_state():
	knight.velocity.y = JUMP_VELOCITY
	knight.move_and_slide()

func process_state():
	var direction=Input.get_axis("move_left","move_right")
	animation_player.play("jump_animation")
	if knight.is_on_floor():
		if direction:
			knight_machine_state.change_state($"../run_state")
		else:
			knight_machine_state.change_state($"../idle_state")
	else:
		knight.velocity.x=direction*SPEED
		if knight.velocity.x<0:
			$"../../movible".scale.x=-abs($"../../movible".scale.x)
		if knight.velocity.x>0:
			$"../../movible".scale.x=abs($"../../movible".scale.x)
		knight.move_and_slide()

func exit_state():
	pass
