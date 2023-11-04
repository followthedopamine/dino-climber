extends CharacterBody2D


const MOVE_SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ROTATION_SPEED = 1.0;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func handle_jump():
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
func apply_gravity(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
func handle_direction(delta):
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * MOVE_SPEED
		rotation += direction * ROTATION_SPEED * delta;
	else:
		velocity.x = move_toward(velocity.x, 0, MOVE_SPEED)
		rotation = move_toward(rotation, 0, delta)
		

func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	handle_direction(delta)
	move_and_slide()
