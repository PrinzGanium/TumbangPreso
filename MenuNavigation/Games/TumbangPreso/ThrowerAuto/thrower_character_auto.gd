extends CharacterBody3D
class_name Thrower

@onready var head = $Head
@onready var NavAgent = $NavigationAgent3D
@onready var SM : ThrowerSM = $ThrowerStateMachine
@onready var stats = $PlayerStats

@onready var Player = get_tree().get_first_node_in_group("guard")
@onready var Can = get_tree().get_first_node_in_group("can")
@onready var idlepath = $"../ThrowerPath/ThrowerLocation"

var idlePosition
var idleTravel = false

var findT = false

var SPEED = 5
var tStart = 0
	
func _ready() -> void:
	set_physics_process(false)
	await  get_tree().physics_frame
	await  get_tree().physics_frame
	await  get_tree().physics_frame
	set_physics_process(true)
	
	idlepath = $"../ThrowerPath/ThrowerLocation"
	
func update_target_loc(loc):
	NavAgent.target_position = (loc)

func _physics_process(_delta: float) -> void:
	var look_pos
	var target_pos
	
	match SM.currentstate:
		
		SM.States.IDLE:
			SPEED = 4
			
			if not idleTravel:
				idlepath.progress_ratio = randf()
				idleTravel = true
			if (global_position - idlepath.position).length() < 0.6:
				SPEED = 0
				idleTravel = false
			
			target_pos = idlepath.position
			look_pos = Can.global_position
		SM.States.RETRIEVE:
			SPEED = 8
			var pickup = get_tree().get_nodes_in_group("pickup")
			if not findT:
				var t = find_closest(pickup)
				target_pos = t
				look_pos = t
				findT = true
			if pickup.is_empty():
				SM.next_state()
		SM.States.FLEE:
			SPEED = 8
			target_pos = -abs(Player.global_position - global_position)
			look_pos = global_position - Player.global_position
		SM.States.LURE:
			target_pos = idlepath.position
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


func find_closest(choices:Array) -> Vector3:
	var closest = Vector3.INF
	for v in choices:
		if abs(global_position - v.global_position) < closest:
			closest = v.global_position
	return closest


func gain_ammo():
	$Actions.add_ammo()
	findT = false
	var p = stats.ammo/3
	if randf() <= p:
		SM.set_state(SM.States.IDLE)
	else:
		SM.set_state(SM.States.RETRIEVE)
