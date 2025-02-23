extends CharacterBody3D
class_name Thrower

@onready var head = $Head
@onready var NavAgent = $NavigationAgent3D
@onready var SM : ThrowerSM = $ThrowerStateMachine
@onready var stats = $PlayerStats

@onready var Player = get_tree().get_first_node_in_group("guard")
@onready var Can = get_tree().get_first_node_in_group("can")
@onready var idlepath = $"../ThrowerPath/ThrowerLocation"

var catchable = false
var catchBounds = false

#catch conditions.
# 1. Thrower in the area
# 2. Can is NOT knocked down

var canThrow = true

var idlePosition
var idleTravel = false

var findT = false

var BASESPEED = 10
var SPEED = 5
var tStart = 0
	
func _ready() -> void:
	GlobalSignals.ThrowerInArea.connect(inArea)
	GlobalSignals.ThrowerOutArea.connect(outArea)
	set_physics_process(false)
	await  get_tree().physics_frame
	await  get_tree().physics_frame
	await  get_tree().physics_frame
	set_physics_process(true)
	
	idlepath = $"../ThrowerPath/ThrowerLocation"
	
func update_target_loc(loc):
	NavAgent.target_position = (loc)

func _physics_process(_delta: float) -> void:
	var look_pos = Vector3.FORWARD
	var target_pos = Vector3.FORWARD
	
	if (Player.global_position - global_position).length() < 4.0:
		SM.set_state(SM.States.FLEE)
	
	match SM.currentstate:	
		SM.States.IDLE:
			SPEED = BASESPEED * 0.8 + randf_range(-1.0, 1.0)
			if not idleTravel:
				idlepath.progress_ratio = randf()
				idleTravel = true
			if (global_position - idlepath.position).length() < 0.6:
				SPEED = 0 + randf_range(-1.0, 1.0)
				idleTravel = false
			target_pos = idlepath.position
			look_pos = Can.global_position
		SM.States.RETRIEVE:
			SPEED = BASESPEED * 1.2 + randf_range(-1.0, 1.0)
			var pickup = get_tree().get_nodes_in_group("pickup")
			var p = find_closest(pickup)
			if p:
				target_pos = p.global_position
				look_pos = p.global_position
			#if pickup.is_empty():
				#SM.force_state(SM.States.IDLE)
		SM.States.FLEE:
			SPEED = BASESPEED * 1.4 + randf_range(-1.0, 1.0)
			look_pos = global_position + (global_position-Player.global_position).normalized() * 2
			target_pos = global_position + (global_position-Player.global_position).normalized() * 2
			
		SM.States.LURE:
			target_pos = idlepath.position
			look_pos = Player.global_position
		SM.States.WAIT:
			SPEED = BASESPEED * 0.8 + randf_range(-1.0, 1.0)
			if not idleTravel:
				idlepath.progress_ratio = randf()
				idleTravel = true
			if (global_position - idlepath.position).length() < 0.6:
				SPEED = 0 + randf_range(-1.0, 1.0)
				idleTravel = false
			target_pos = idlepath.position
			look_pos = Can.global_position
		_:
			pass
	update_target_loc(target_pos)
	var current_location = global_transform.origin
	var next_location = NavAgent.get_next_path_position()
	
	head.look_at(look_pos)
	var new_velocity : Vector3 = (next_location - current_location).normalized() * SPEED/2
	velocity = new_velocity
	move_and_slide()


func find_closest(choices:Array):
	var closest = Vector3.INF
	var pick
	for v in choices:
		var distance = abs(global_position - v.global_position)
		if distance < closest:
			closest = distance
			pick = v
	if pick: return pick
	else: return


func gain_ammo():
	print("GAIN AMMO")
	$Actions.add_ammo()

func inArea():
	canThrow = false
	catchable = true
	pass

func outArea():
	canThrow = true
	catchable = false
	pass

func interact(collider):
	return catchable
