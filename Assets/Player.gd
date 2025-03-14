extends CharacterBody3D

enum State {IDLE, RUN, JUMP, FALL, DASH}
enum Attacks {NONE, ATTACK, DEFEND, DASH}
enum Curves {LINEAR, EXPONENTIAL, INV_S}

var CURVES_RES = [
	load("res://Curves/Linear.tres"),
	load("res://Curves/Exponential.tres"),
	load("res://Curves/Inverse_S.tres")
]

@export var mouse_sens = Vector2(.1,.1) # sensitivities for each
@export var gamepad_sens = Vector2(2,2) # axis + input
@export var gamepad_curve = Curves.INV_S # curve analog inputs map to
@export var move_speed = 7 # max move speed
@export var acceleration = 1 # ground acceleration
@export var air_speed = 7 # max move speed in air
@export var air_acceleration = .5 # air acceleration
@export var jump_speed = 5 # length in frames to reach apex
@export var jump_height = 1 # apex in meters of jump
@export var coyote_factor = 3 # jump forgiveness after leaving platform in frames
@export var gravity_accel = -12 # how fast fall speed increases
@export var gravity_max = -24 # max falling speed
@export var friction = 1.15 # how fast player stops when idle
@export var max_climb_angle = 0.6 # 0.0-1.0 based on normal of collision .5 for 45 degree slope
@export var angle_of_freedom = 80 # amount player may look up/down

# Multiplayer variables

@export var id = 0
@export var mouse_control = true # only works for lowest viewport (first child)

func _physics_process(delta):
	_process_input(delta)
	_process_movement(delta)

func _ready():
	if mouse_control: Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # might need to disable for multiplayer

# Handles mouse movement
func _input(event):
	if event is InputEventMouseMotion && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if mouse_control: # only do mouse control if enabled for this instance
			cam_rotate(Vector2(event.relative.x, event.relative.y), mouse_sens)


var state = State.FALL
var on_floor = false
var frames = 0 # frames jumping
var input_dir = Vector3(0, 0, 0)
func _process_input(delta):
	# Toggle mouse capture
	if Input.is_action_just_pressed("mouse_escape") && mouse_control:
			if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# Jump
	if Input.is_action_pressed("jump_%s" % id) && can_jump():
		frames = 0
		state = State.JUMP
	
	# WASD
	input_dir = Vector3(Input.get_action_strength("right_%s" % id) - Input.get_action_strength("left_%s" % id), 0,
			Input.get_action_strength("back_%s" % id) - Input.get_action_strength("forward_%s" % id)).normalized()
	
	# Look
	var look_vec = Vector2(
		Input.get_action_strength("look_right_%s" % id) - Input.get_action_strength("look_left_%s" % id),
		Input.get_action_strength("look_down_%s" % id) - Input.get_action_strength("look_up_%s" % id)
	)
	
	# Map gamepad look to curves
	var signs = Vector2(sign(look_vec.x),sign(look_vec.y))
	var sens_curv = CURVES_RES[gamepad_curve]
	look_vec = look_vec.abs() # Interpolate input on the curve as positives
	look_vec.x = sens_curv.interpolate_baked(look_vec.x)
	look_vec.y = sens_curv.interpolate_baked(look_vec.y)
	look_vec *= signs # Return inputs to original signs
	
	cam_rotate(look_vec, gamepad_sens)


var collision : KinematicCollision3D  # Stores the collision from move_and_collide
var velocity := Vector3(0, 0, 0)
var coyote_frames = 0
func _process_movement(delta):
	# state management
	if !collision:
		on_floor = false
		coyote_frames += 1 * delta * 60
		if state != State.JUMP:
			state = State.FALL
	else:
		if state == State.JUMP:
			on_floor = false # fixes wall climbing due to walls having y1 normal sometimes
			coyote_frames = coyote_factor + 1
		elif collision.normal.y < max_climb_angle:
			state = State.FALL
		else:
			on_floor = true
			coyote_frames = 0
			if input_dir.length() > .1 && (frames > jump_speed || frames == 0):
				state = State.RUN
			else:
				state = State.IDLE
	
	# jump state
	if state == State.JUMP && frames < jump_speed:
		velocity.y = jump_height/(jump_speed * delta)
		frames += 1 * delta * 60
	elif state == State.JUMP:
		state = State.FALL

	# fall state
	if state == State.FALL:
		velocity.y += gravity_accel * delta * 4
		velocity.y = clamp(velocity.y, gravity_max, 9999)
	
	# run state
	if state == State.RUN:
		velocity += input_dir.rotated(Vector3(0, 1, 0), rotation.y) * acceleration
		if Vector2(velocity.x, velocity.z).length() > move_speed:
			velocity = velocity.normalized() * move_speed # clamp move speed
		velocity.y = ((Vector3(velocity.x, 0, velocity.z).dot(collision.normal)) * -1)
		
		# fake gravity to keep character on the ground
		# increase if player is falling down slopes instead of running
		velocity.y -= .0001 + (int(velocity.y < 0) * 1.1) 

	# idle state
	if state == State.IDLE && frames < jump_speed:
		frames += 1 * delta * 60
	elif state == State.IDLE:
		if velocity.length() > .5:
			velocity /= friction
			velocity.y = ((Vector3(velocity.x, 0, velocity.z).dot(collision.normal)) * -1) - .0001
	
	# air movement
	if state == 2 or state == 3:
		velocity += input_dir.rotated(Vector3(0, 1, 0), rotation.y) * air_acceleration # add acceleration
		if Vector2(velocity.x, velocity.z).length() > air_speed: # clamp speed to max airspeed
			var velocity2d = Vector2(velocity.x, velocity.z).normalized() * air_speed
			velocity.x = velocity2d.x
			velocity.z = velocity2d.y
	
	#apply
	if velocity.length() >= .5:
		collision = move_and_collide(velocity * delta)
	else:
		velocity = Vector3(0, velocity.y, 0)
	if collision:
		if collision.normal.y < .5: # if collision is 50% not from below aka if on slope
			velocity.y += delta * gravity_accel
			clamp(velocity.y, gravity_max, 9999)
			velocity = velocity.slide(collision.normal).normalized() * velocity.length()
		else:
			velocity = velocity

func enable_mouse():
	mouse_control = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func cam_rotate(vect, sens):
	rotate_y(deg_to_rad(vect.x * sens.y * -1))
	$Collider/Camera3D.rotate_x(deg_to_rad(vect.y * sens.x * -1))
	
	var camera_rot = $Collider/Camera3D.rotation_degrees
	camera_rot.x = clamp(camera_rot.x, 90 + angle_of_freedom * -1, 90 + angle_of_freedom)
	$Collider/Camera3D.rotation_degrees = camera_rot # I don't understand this function

func can_jump():
	if on_floor && state != State.FALL && (frames == 0 || frames > jump_speed):
		return true
	elif state != State.JUMP && coyote_frames < coyote_factor:
		return true # allows the player to jump after leaving platforms
	else:
		return false
