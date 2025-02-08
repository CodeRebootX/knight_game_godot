class_name health_component extends Control

@export var max_health: float
@export var parent: Node2D
@export var health: float

func update_bar():
	$barra_vida.value=health

func regen_health(healing : float): 
	health=min(health+healing, max_health)
	update_bar()
	
func get_damage (damage : float):
	health -= damage
	update_bar()
	if health<=0:
		parent.queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$barra_vida.max_value=max_health
	$barra_vida.value=health
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
