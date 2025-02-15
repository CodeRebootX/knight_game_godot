extends CharacterBody2D

@export var animation_finished=false
const SPEED = 0100.0
const JUMP_VELOCITY = -400.0

const ball_scene= preload("res://worm/fire_ball.tscn")

func _ready() -> void:
	$AnimationPlayer.play("idle_animation")
	#animation_finished=false

func _process(delta: float) -> void:
	#if animation_finished:	
		#$AnimationPlayer.play("idle_animation")
	$AnimationPlayer.play("walk_animation")
	$".".position.x+=SPEED*delta
	#Timer.wait_time=3
	$".".position.x-=SPEED*delta
	
	
func shoot_fire_ball():
	animation_finished=false
	$movible/worm_sprite.play("attack_animation")
	var fire_ball = ball_scene.instantiate()
	fire_ball.position.x=$movible/ball_position.position.x
	fire_ball.position.y=$movible/ball_position.position.y
	add_child(fire_ball)


func _physics_process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("attack_animation")# Replace with function body.
