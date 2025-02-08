extends "res://knight_state.gd"

@export var animation_finished=false

func enter_state():
	animation_player.play("crouch_attack_animation")
	animation_finished=false

func process_state():
	if animation_finished:
		knight_machine_state.change_state($"../crouch_state")


func exit_state():
	pass
