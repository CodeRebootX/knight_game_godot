extends CharacterBody2D
@export var animation_finished=false
var activated = false
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

const projectile_scene= preload("res://golem/arm_projectile.tscn")


func _ready() -> void:
	$AnimationPlayer.play("idle_animation")
	animation_finished=false

func _process(delta: float) -> void:	
	
	pass

func _physics_process(delta: float) -> void:
	pass

func shoot_projectile():
	$movible/golem_sprite.play("throw_animation")
	var projectile = projectile_scene.instantiate()
	projectile.position.x=$movible/projectile_position.position.x
	projectile.position.y=$movible/projectile_position.position.y
	add_child(projectile)

func shoot_laser() -> void:
	pass
	
func _on_timer_timeout() -> void:
	$AnimationPlayer.play("idle_animation")
	
	if activated:
		
		var rng = RandomNumberGenerator.new()
		var n = rng.randi_range(1,3)
		
		match n:
			1:
				$AnimationPlayer.play("laser_animation")
			2: 
				$AnimationPlayer.play("melet_animation")
			3:
				$AnimationPlayer.play("projectile_animation")
		
		await $AnimationPlayer.animation_finished
		
		$AnimationPlayer.play("idle_animation")
		
		n = rng.randi_range(2,3)
		$Timer.wait_time = n
		$Timer.start()
		
func _on_hurtbox_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group('knight'):
		$vida_golem.get_damage(1)





func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('knight'):
		activated=true
	


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group('knight'):
		activated=false
		$AnimationPlayer.play("idle_animation")
