class_name health_component extends Control

@export var max_health: float
@export var parent: Node2D
@export var health: float
@export var anim_player: AnimationPlayer

func update_bar():
	$halth_bar.value=health

func regen_health(healing : float): 
	health=min(health+healing, max_health)
	update_bar()
	
func get_damage (damage : float):
	health -= damage
	update_bar()
	if health<=0:
		die()
	
	
func die():
	if anim_player and anim_player.has_animation("death_animation"):
		anim_player.play("death_animation") 
		await anim_player.animation_finished  
	
	GameManager.restart_game()
	parent.queue_free()
	


func _ready() -> void:
	$halth_bar.max_value=max_health
	$halth_bar.value=health
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
