extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -700.0
@onready var vida = $CanvasLayer/vida


func _physics_process(delta: float) -> void:
	position.x=clamp(position.x, 50,9000)
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	

func _on_knight_hurtbox_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group('enemys'):
		$CanvasLayer/vida.get_damage(10)
	pass # Replace with function body.
