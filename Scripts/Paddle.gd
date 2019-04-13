extends RigidBody2D

enum MOVE_TYPE { HORIZONTAL = 0, VERTICAL = 1 }

export(MOVE_TYPE) var move_type

var initial_rotation

slave var slave_velocity = Vector2()
slave var slave_rotation = 0

func _ready():
	if move_type == MOVE_TYPE.VERTICAL:
		rotation_degrees = 0
	if move_type == MOVE_TYPE.HORIZONTAL:
		rotation_degrees = 90
	pass

func _physics_process(delta):	
	if is_network_master():
		linear_velocity = Vector2.ZERO
		if move_type == MOVE_TYPE.VERTICAL:
			if Input.is_action_pressed("ui_up"):
				linear_velocity = Vector2(0, -1) * 500
			if Input.is_action_pressed("ui_down"):
				linear_velocity = Vector2(0, 1) * 500
		if move_type == MOVE_TYPE.HORIZONTAL:
			if Input.is_action_pressed("ui_left"):
				linear_velocity = Vector2(-1, 0) * 500
			if Input.is_action_pressed("ui_right"):
				linear_velocity = Vector2(1, 0) * 500
		rset_unreliable("slave_velocity", linear_velocity)
	else:
		linear_velocity = slave_velocity
	pass
