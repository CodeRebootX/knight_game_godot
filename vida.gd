class_name health_component extends Control

@export var max_health: float
@export var parent: Node2D
@export var health: float
@export var anim_player: AnimationPlayer
var is_death=false

func update_bar():
	$halth_bar.value=health

func regen_health(healing : float): 
	health=min(health+healing, max_health)
	update_bar()
	
func get_damage (damage : float):
	health -= damage
	update_bar()
	if health<=0:
		is_death = true
		die()

signal died
	
func die():
	if anim_player and anim_player.has_animation("death_animation"):
		anim_player.play("death_animation") 
		await anim_player.animation_finished
		
	emit_signal("died") 
	
	if parent.has_method("change_state"):
		var death_state = parent.knight_machine_state.get_node_or_null("death_state")
		if death_state:
			parent.knight_machine_state.change_state(death_state)
	
	parent.process_mode=Node.PROCESS_MODE_DISABLED
	parent.queue_free()
	queue_free()
	GameManager.restart_game()

func _ready() -> void:
	$halth_bar.max_value=max_health
	$halth_bar.value=health
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
