extends "res://knight_state.gd"


func enter_state():
	animation_player.play("crouch_walk_animation")

func process_state():
	var direction=Input.get_axis("move_left","move_right")
	
	if Input.is_action_pressed("move_attack"):
		knight_machine_state.change_state($"../crouch_attack_state")
	
	if not direction:
		knight_machine_state.change_state($"../crouch_state")
	else: 
		knight.velocity.x=direction*SPEED
		if knight.velocity.x<0:
			$"../../movible".scale.x=-abs($"../../movible".scale.x)
		if knight.velocity.x>0:
			$"../../movible".scale.x=abs($"../../movible".scale.x)
		knight.move_and_slide()
			
func exit_state():
	pass
