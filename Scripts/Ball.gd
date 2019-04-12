extends RigidBody2D

export var ready = false

var dir

slave var ball_velocity

func _ready():
	if is_network_master():
		dir = Vector2(randf(), randf()).normalized()
		linear_velocity = dir * 500
	pass

func _physics_process(delta):
	if is_network_master():
		rotation_degrees = 0
		linear_velocity = linear_velocity.normalized() * 500 
		rset("ball_velocity", linear_velocity)
	if ball_velocity != null:
		linear_velocity = ball_velocity
	pass
