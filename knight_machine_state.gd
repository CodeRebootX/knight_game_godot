extends Node

var current_state: knight_state

func _ready() -> void:
	current_state= $idle_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_state.process_state()

func change_state(next_state: knight_state):
	print("exit: "+ current_state.name)
	current_state.exit_state()
	current_state=next_state
	current_state.enter_state()
	print("enter: "+ current_state.name)
