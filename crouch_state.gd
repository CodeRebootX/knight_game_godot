extends "res://knight_state.gd"

@export var animation_finished=false
# Called when the node enters the scene tree for the first time.
func enter_state():
	animation_player.play("crouch_animation")
	animation_finished=false
	
func process_state():
	var direction=Input.get_axis("move_left","move_right")
	
	if animation_finished:
		if Input.is_action_pressed("move_crouch"):
			animation_player.play("crouch_idle_animation")
			if direction:
				knight_machine_state.change_state($"../crouch_walk_state")
		else:
			knight_machine_state.change_state($"../idle_state")
	
	if Input.is_action_pressed("move_attack"):
		knight_machine_state.change_state($"../crouch_attack_state")
	

func exit_state():
	pass
