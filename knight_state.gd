class_name knight_state extends Node

@onready var knight: CharacterBody2D = $"../.."
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var knight_machine_state: Node = $".."

const SPEED = 300.0
const JUMP_VELOCITY = -600.0


func enter_state():
	pass


func process_state():
	pass


func exit_state():
	pass
