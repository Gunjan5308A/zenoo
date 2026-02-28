extends CharacterBody3D


var speed = 5.0
const JUMP_VELOCITY = 5

var sensitivity = 0.1
var rotation_x = 0.0
var rotation_y = 0.0
var jump_count = 1
var accelaration: Vector3 = Vector3(0, 0.7, 0)

var x_value: float = 0
var y_value: float = 0
var z_value: float = 0
var y: Vector3 = Vector3(x_value, y_value, z_value)



func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		y -= accelaration
		velocity += (y + get_gravity()) * delta
	else:
		y = Vector3(0, 0, 0)
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump_count < 1 :
		velocity.y = JUMP_VELOCITY
		jump_count += 1

	if is_on_floor():
		jump_count = 0
	
	if Input.is_action_pressed("ui_sprint"):
		speed = 10	
	
	elif Input.is_action_pressed("ui_crouch"):
		speed = 2
	
	else:
		speed = 5
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func super_power():
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_x -= event.relative.y * sensitivity
		rotation_y -= event.relative.x * sensitivity
		rotation_x = clamp(rotation_x, -90, 90)
		rotation_degrees.y = rotation_y
		rotation_degrees.x = rotation_x 	
