extends CharacterBody2D

@export var animation_finished=false
@export var move_range: float
const SPEED = 0100.0
const JUMP_VELOCITY = -400.0
var direction = 1
var activated = false
var is_attacking = false
var original_position
var left_limit: float
var right_limit: float
var caballero: CharacterBody2D

const ball_scene= preload("res://worm/fire_ball.tscn")

func _ready() -> void:
	original_position = position

	left_limit = position.x - move_range
	right_limit = position.x + move_range
	$AnimationPlayer.play("walk_animation")

func _process(delta: float) -> void:
	position.x += direction * SPEED * delta
	if is_attacking and caballero != null and is_instance_valid(caballero):
		
		if caballero.position.x < position.x: 
			$movible.scale.x = -abs($movible.scale.x)
		else:
			$movible.scale.x = abs($movible.scale.x)
		$AnimationPlayer.play("attack_animation")
	else: 
		$AnimationPlayer.play("walk_animation")
		if position.x >= right_limit:
			$movible.scale.x=-abs($movible.scale.x)
			direction = -1
		elif position.x <= left_limit:
			$movible.scale.x=abs($movible.scale.x)
			direction = 1
		
		move_and_slide()
	
	
func shoot_fire_ball():
	animation_finished=false
	var fire_ball = ball_scene.instantiate()
	var worm_direction=1
	if $movible.scale.x < 0:
		worm_direction = -1
		
	fire_ball.position.x=$movible/ball_position.position.x * worm_direction
	fire_ball.position.y=$movible/ball_position.position.y
	
	fire_ball.set_direction(worm_direction)
	add_child(fire_ball)


func _physics_process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if activated:
		$AnimationPlayer.play("attack_animation")# Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('knight'):
		var knight_machine_state = body.get_node_or_null("knight_machine_state")
		if knight_machine_state and knight_machine_state.current_state.name == "death_state":
			return
		caballero = body
		is_attacking = true
		direction = 0
		
		if caballero.has_signal("died"):
			caballero.disconnect("died", Callable(self, "_on_knight_died"))
			caballero.connect("died", Callable(self, "_on_knight_died"))
func _on_knight_died():
	is_attacking = false
	caballero=null
	direction = 1 if position.x < original_position.x else -1
	$movible.scale.x = direction * abs($movible.scale.x)
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group('knight'):
		is_attacking = false
		direction = 1 if position.x < original_position.x else -1
		$movible.scale.x = direction * abs($movible.scale.x)


func _on_hurt_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("knight"):
		print("muerto")
		set_process(false)
		$AnimationPlayer.play("death_animation")
		await $AnimationPlayer.animation_finished
		queue_free()
		get_tree().call_group("level","check_enemys")
