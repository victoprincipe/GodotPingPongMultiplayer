extends RigidBody2D

export var ready = false

var dir

func _ready():
	dir = Vector2(randf(), randf()).normalized()
	linear_velocity = dir * 500
	pass

func _physics_process(delta):
	if ready:
		rotation_degrees = 0
		linear_velocity = linear_velocity.normalized() * 500 
	pass
