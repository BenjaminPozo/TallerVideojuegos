extends CharacterBody2D

const SPEED = 70.0
const JUMP_VELOCITY = -300.0
const GRAVITY = 500
const ACCELERATION = 500

@onready var pivot = $Pivot

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if Input.is_action_pressed("ability_up"):
			var dif = velocity.y -90
			if velocity.y > 0:
				if dif > 0:
					velocity.y -= 200*delta
				if dif < 0:
					velocity.y += 200*delta
			else:
				velocity.y += GRAVITY * delta
		else:
			velocity.y += GRAVITY * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY 

	var move_input = Input.get_axis("move_left", "move_right")
	
	velocity.x = move_toward(velocity.x, move_input * SPEED, ACCELERATION * delta)
		
	move_and_slide()
	
	if move_input:
		pivot.scale.x = sign(move_input)
