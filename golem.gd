extends CharacterBody2D
@export var animation_finished=false

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

const projectile_scene= preload("res://golem/arm_projectile.tscn")


func _ready() -> void:
	$AnimationPlayer.play("idle_animation")
	animation_finished=false

func _process(delta: float) -> void:
	
	#$AnimationPlayer.play("idle_animation")
	pass

func _physics_process(delta: float) -> void:
	pass

func shoot_projectile():
	$movible/golem_sprite.play("throw_animation")
	var projectile = projectile_scene.instantiate()
	projectile.position.x=$movible/projectile_position.position.x
	projectile.position.x=$movible/projectile_position.position.y
	add_child(projectile)

func shoot_laser() -> void:
	pass
	
func _on_timer_timeout() -> void:
	$AnimationPlayer.play("idle_animation")
	animation_finished=false
	var rng = RandomNumberGenerator.new()
	var n = rng.randi_range(1,3)
	
	if (n == 1):
		$AnimationPlayer.play("laser_animation")
		if animation_finished:
			$AnimationPlayer.play("idle_animation")
		print(n)
					
	if (n == 2):
		$AnimationPlayer.play("projectile_animation")
		if animation_finished:
			$AnimationPlayer.play("idle_animation")
		
		print(n)
	if (n == 3):
		$AnimationPlayer.play("melet_animation")
		if animation_finished:
			$AnimationPlayer.play("idle_animation")
		print(n)
		
	n=rng.randi_range(2,5)
	print( "wait time: "+ str(n))
	
	$Timer.wait_time = n
		
	$Timer.start()
		

func _on_timer_timeoutd() -> void:
	var is_playing=$AnimationPlayer.is_playing()
	if not is_playing:
		var rng = RandomNumberGenerator.new()
		var n = rng.randi_range(1,3)
		if (n == 1):
			$AnimationPlayer.play("laser_animation")
			print(n)
			
		if (n == 2):
			$AnimationPlayer.play("projectile_animation")
			print(n)
		if (n == 3):
			$AnimationPlayer.play("melet_animation")
			print(n)
		n=rng.randi_range(2,5)
		$Timer.wait_time = n
		$Timer.start()
	


func _on_hurtbox_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group('knight'):
		print("daño")
		$vida_golem.get_damage(1)
	pass # Replace with function body.
