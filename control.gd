extends Control
@export var nivel: Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not nivel:
		var main_node = get_parent()
		if main_node and main_node.has_node("Node"):
			nivel = main_node.get_node("Node")
		
	if nivel:
		nivel.process_mode=Node.PROCESS_MODE_DISABLED
		nivel.hide()
	else: 
		print("Error  el nivel es null")
	

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

	
