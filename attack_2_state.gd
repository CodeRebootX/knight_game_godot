extends "res://knight_state.gd"


@export var animation_finished=false


func enter_state():
	animation_player.play("attack2_animation")
	animation_finished=false
	
	
func process_state():
	if animation_finished:
		if Input.is_action_pressed("move_attack"):
			knight_machine_state.change_state($"../attack_state")
		else:
			knight_machine_state.change_state($"../idle_state")
	
func exit_state():
	pass
