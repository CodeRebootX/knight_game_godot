extends Area2D

const ball_speed=200
var worm_direction = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$".".position.x+=ball_speed*delta*worm_direction
	
func set_direction(direction: int) -> void:
	worm_direction = direction
	
	


func _on_timer_timeout() -> void:
	$".".queue_free()
