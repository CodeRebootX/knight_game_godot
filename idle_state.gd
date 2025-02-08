extends "res://knight_state.gd"



func enter_state():
	pass


func process_state():
	var direction=Input.get_axis("move_left","move_right")
	$"../../AnimationPlayer".play("idle_animation")
	
	if Input.is_action_pressed("move_attack"):
		knight_machine_state.change_state($"../attack_state")
	
	elif Input.is_action_just_pressed("move_crouch"):
		knight_machine_state.change_state($"../crouch_state")
	
	elif Input.is_action_pressed("move_jump"):
		knight_machine_state.change_state($"../jump_state")
	
	
	elif direction:
		knight_machine_state.change_state($"../run_state")

func exit_state():
	pass
