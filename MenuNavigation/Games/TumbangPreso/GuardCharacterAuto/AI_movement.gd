extends CharacterBody3D
class_name Guard

@onready var head = $Head
@onready var NavAgent = $NavigationAgent3D
@onready var SM : GuardSM= $GuardStateMachine
@onready var stats = $PlayerStats

@onready var Player = get_tree().get_first_node_in_group("tapon")
@onready var Can = get_tree().get_first_node_in_group("can")
var idlePosition

var BASESPEED = 10
var SPEED = 5
var tStart = 0

func _ready():
	set_physics_process(false)
	await  get_tree().physics_frame
	await  get_tree().physics_frame
	await  get_tree().physics_frame
	set_physics_process(true)

func update_target_loc(loc):
	NavAgent.target_position = (loc)


func _physics_process(_delta: float) -> void:
	var look_pos
	var target_pos
	match SM.currentstate:
		SM.States.IDLE:
			SPEED = BASESPEED+ randf_range(-1.0, 1.0)
			idlePosition = (Player.global_position - Vector3.ZERO) * 2/5
			target_pos = idlePosition
			look_pos = Player.global_position
		SM.States.CHASE:
			SPEED = BASESPEED * 1.2 + randf_range(-1.0, 1.0)
			target_pos = Player.global_position
			look_pos = target_pos
		SM.States.RETURN:
			SPEED = BASESPEED * 1.2 + randf_range(-1.0, 1.0)
			target_pos = Vector3(0,0,0)
			look_pos = target_pos
		SM.States.RETREIVE:
			SPEED = BASESPEED * 1.2 + randf_range(-1.0, 1.0)
			target_pos = Can.global_position
			look_pos = target_pos
		SM.States.DONE:
			SPEED = BASESPEED + randf_range(-1.0, 1.0)
			idlePosition = (Player.global_position - Vector3.ZERO) * 2/5
			target_pos = idlePosition
			look_pos = Player.global_position
			GlobalSignals.emit_signal("guardCommand", GuardSM.States.IDLE)
		_:
			pass
	update_target_loc(target_pos)
	var current_location = global_transform.origin
	var next_location = NavAgent.get_next_path_position()
	
	head.look_at(look_pos)
	var new_velocity : Vector3 = (next_location - current_location).normalized() * SPEED/2
	velocity = new_velocity
	move_and_slide()
