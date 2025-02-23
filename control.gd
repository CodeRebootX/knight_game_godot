extends Control
@export var nivel: Node2D
@onready var golem=null
@onready var knight=null



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("level")
	$CanvasLayer.visible=true
	if not nivel:
		var main_node = get_parent()
		if main_node and main_node.has_node("Node"):
			nivel = main_node.get_node("Node")
		
	if nivel:
		if nivel.has_node("golem"):
			golem=nivel.get_node("golem")
			golem.process_mode = Node.PROCESS_MODE_DISABLED
			golem.visible = false
		if nivel.has_node("knight"):
			knight=nivel.get_node("knight")
		nivel.process_mode=Node.PROCESS_MODE_DISABLED
		nivel.hide()
	else: 
		print("Error  el nivel es null")
	

func check_enemys():
	var numero = get_tree().get_nodes_in_group("enemys_sec").size()
	print (numero)
	if get_tree().get_nodes_in_group("enemys_sec").size() == 1:
		print("todos muertos")
		golem.visible = true
		golem.process_mode = Node.PROCESS_MODE_INHERIT
		
		if knight.has_node("CanvasLayer/vida"):
			var vida = knight.get_node("CanvasLayer/vida")
			if vida.health < vida.max_health/2:
				vida.regen_health(vida.max_health/2-vida.health)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_button_pressed() -> void:
	if not nivel:
		var main_node = get_parent()
		if main_node and main_node.has_node("Node"):
			nivel = main_node.get_node("Node")
	if nivel:
		nivel.process_mode=Node.PROCESS_MODE_INHERIT
		
		$CanvasLayer.hide()
		nivel.show()
	else: 
		print("Error  el nivel al pulsar el botón es null")

	
