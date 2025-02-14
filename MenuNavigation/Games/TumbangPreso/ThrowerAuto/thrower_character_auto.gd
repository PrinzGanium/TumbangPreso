extends CharacterBody3D
class_name Thrower

@onready var head = $Head
@onready var NavAgent = $NavigationAgent3D
@onready var SM : ThrowerSM = $ThrowerStateMachine
@onready var stats = $PlayerStats

@onready var Player = get_tree().get_first_node_in_group("tapon")
@onready var Can = get_tree().get_first_node_in_group("can")
var idlePosition

var SPEED = 5
var tStart = 0
	
func update_target_loc(loc):
	NavAgent.target_position = (loc)


func _physics_process(_delta: float) -> void:
	var look_pos
	var target_pos
	match SM.currentstate:
		SM.States.IDLE:
			SPEED = 4
			idlePosition = (Player.global_position - Vector3.ZERO) * 2/5
			target_pos = idlePosition
			look_pos = Player.global_position
		_:
			pass
	update_target_loc(target_pos)
	var current_location = global_transform.origin
	var next_location = NavAgent.get_next_path_position()
	
	head.look_at(look_pos)
	var new_velocity : Vector3 = (next_location - current_location).normalized() * SPEED/2
	velocity = new_velocity
	move_and_slide()
