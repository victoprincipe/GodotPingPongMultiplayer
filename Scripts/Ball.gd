extends RigidBody2D

export var ready = false

var dir

slave var ball_position

var initial_position = Vector2.ZERO
var reset_position = false

func _ready():
	if is_network_master():
		initial_position = position
		dir = Vector2(randf(), randf()).normalized()
		linear_velocity = dir * 500
	pass

func _integrate_forces(state):
	var transform = state.get_transform()
	if reset_position == true:
		transform.origin.x = 390
		transform.origin.y = 400
		state.set_transform(transform)
		var angle = randi() % 360
		state.linear_velocity = Vector2(cos(deg2rad(angle)), sin(deg2rad(angle))).normalized() * 500
		reset_position = false
		return
	if is_network_master():
		rotation_degrees = 0
		linear_velocity = linear_velocity.normalized() * 500 
		rset("ball_position", transform.origin)
	elif ball_position != null:
		transform.origin = ball_position
	state.set_transform(transform)

func _process(delta):
	pass

func reset_ball():
	reset_position = true
	pass