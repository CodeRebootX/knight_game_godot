extends "res://knight_state.gd"

@export var animation_finished=false

func enter_state():
	animation_player.play("roll_animation")
	animation_finished=false

func process_state():
	var direction=Input.get_axis("move_left","move_right")
	
	if !animation_finished:
	
		knight.velocity.x=direction*SPEED
		if knight.velocity.x<0:
			$"../../movible".scale.x=-abs($"../../movible".scale.x)
		if knight.velocity.x>0:
			$"../../movible".scale.x=abs($"../../movible".scale.x)
		knight.move_and_slide()
	
	else:
		if Input.is_action_pressed("move_roll") && direction:
			knight_machine_state.change_state($".")
			
		elif direction: 
			knight_machine_state.change_state($"../run_state");
		else:
			knight_machine_state.change_state($"../idle_state")

func exit_state():
	pass
