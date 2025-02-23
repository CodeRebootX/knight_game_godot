extends CharacterBody2D

const  speed: float = 100.0  
const attack_speed = 300
@export var move_range: float = 200.0
@export var animation_finished=false
var direction := 1  
var left_limit: float
var right_limit: float
var is_attacking = false
var is_returning = false
var is_death = false
var original_position
var caballero: CharacterBody2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	original_position = position

	left_limit = position.x - move_range
	right_limit = position.x + move_range
	$AnimationPlayer.play("idle_animation")

func _process(delta):
	position.x += direction * speed * delta
	if not is_attacking:
		$AnimationPlayer.play("idle_animation")
		if is_returning:
			
			await get_tree().create_timer(0.5).timeout
			$movible/hurt/hurt_box.disabled=false
			position.y = move_toward(position.y, original_position.y, attack_speed*delta)
			
			if abs(position.y - original_position.y) < 5:
				$movible/hurt/hurt_box.disabled=true
				is_returning= false
		else:
			if position.x >= right_limit:
				$movible.scale.x=-abs($movible.scale.x)
				direction = -1
			elif position.x <= left_limit:
				$movible.scale.x=abs($movible.scale.x)
				direction = 1
	elif is_attacking:
		$movible/hurt/hurt_box.disabled=true
		$AnimationPlayer.play("attack_animation")
		var position_y = caballero.position.y
		position.y = move_toward(position.y, position_y, attack_speed*delta)
		
		if abs(position.y - position_y) < 70:
			$movible/hit/hit_box.disabled=true
			is_attacking = false;
			is_returning = true;
	
func _physics_process(delta):
	pass
		

func _on_detection_area_body_entered(body: CharacterBody2D) -> void:
	
	if body.is_in_group('knight'):
		caballero=body
		is_attacking = true;
		
	
	pass # Replace with function body.


func _on_detection_area_body_exited(body: Node2D) -> void:

	pass # Replace with function body.


func _on_hurt_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("knight"):
		print("muerto")
		set_process(false)
		$AnimationPlayer.play("death_animation")
		var gravity=500
		var ground_y =420
		var velocity = 0
		while position.y<ground_y:
			await  get_tree().process_frame
			velocity += gravity*get_process_delta_time()
			position.y = move_toward(position.y, ground_y, velocity*get_process_delta_time())
		position.y=ground_y
		await $AnimationPlayer.animation_finished
		queue_free()
		get_tree().call_group("level","check_enemys")
	
