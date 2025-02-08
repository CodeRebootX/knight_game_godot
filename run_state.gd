extends "res://knight_state.gd"


func enter_state():
	pass

func process_state():
	var direction=Input.get_axis("move_left","move_right")
	animation_player.play("run_animation")
	
	if Input.is_action_pressed("move_attack"):
		knight_machine_state.change_state($"../attack_state")
	
	if Input.is_action_just_pressed("move_crouch"):
		knight_machine_state.change_state($"../crouch_state")
	
	if Input.is_action_pressed("move_jump"):
		knight_machine_state.change_state($"../jump_state")
		
	if Input.is_action_pressed("move_roll"):
		knight_machine_state.change_state($"../roll_state");
		
	if Input.is_action_just_pressed("move_slide"):
		knight_machine_state.change_state($"../slide_animation");
	
	if not direction:
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
