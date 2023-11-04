extends RigidBody2D

const MOVE_SPEED = 1300.0
const JUMP_VELOCITY = -400.0
const ROTATION_SPEED = 1.0
const JUMP_COOLDOWN = 0.5

var jump_cooldown_remaining = 0;

func handle_direction(delta):
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		apply_force(Vector2(direction * MOVE_SPEED, 0))
		rotation += direction * ROTATION_SPEED * delta;

func handle_jump():
	var direction = Input.get_axis("move_up", "move_down")
	var collisions = get_colliding_bodies()
	if direction and len(collisions) > 0 and jump_cooldown_remaining <= 0:
		apply_impulse(Vector2(0, 1 * JUMP_VELOCITY))
		jump_cooldown_remaining = JUMP_COOLDOWN

func _physics_process(delta):
	handle_direction(delta)
	handle_jump()

func _process(delta):
	jump_cooldown_remaining -= delta
