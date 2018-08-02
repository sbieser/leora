extends KinematicBody2D

signal select
signal action
signal collected_item(item)

#TODO: We need to have states to show which direction the player is facing, left or right
enum STATE{
	IDLE, 
	WALK
}

#The direction in which the player/character is facing
#How many directions do we need?
enum DIRECTION{
	RIGHT, 
	LEFT,
	UP,
	DOWN
}

export (int) var walk_speed = 85	# Allow editor to change the walking speed
export (int) var facing = 0			# Allow editor to change the starting facing direction
var state
var velocity = Vector2()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	change_state(IDLE)

func change_state(new_state):
	if new_state != state:
		state = new_state
		match state:
			IDLE:
				#new_anim = "idle"
				pass
			WALK:
				#new_anim = "walk"
				pass
#	if state == WALK or state == CROUCH_WALK:
#		change_direction()
#
#	#change player size based on standing or crouching
#	if state == CROUCH_IDLE or state == CROUCH_WALK or state == CROUCH_ATTACK:
#		$CollisionShape2D.shape.set_extents(Vector2(16,16))
#		$CollisionShape2D.position = Vector2(0,16)
#		$AnimatedSprite.position = Vector2(0,16)
#	else:
#		$CollisionShape2D.shape.set_extents(Vector2(16,32))
#		$CollisionShape2D.position = Vector2(0,0)
#		$AnimatedSprite.position = Vector2(0,0)
#
#	if facing == LEFT_FACING:
#		$AnimatedSprite.flip_h = true
#		if state == CROUCH_WALK or state == CROUCH_IDLE or state == CROUCH_ATTACK:
#			get_node("AttackArea/CollisionShape2D").position = Vector2(-33,16)
#		else:
#			get_node("AttackArea/CollisionShape2D").position = Vector2(-33,-16)
#	else:
#		$AnimatedSprite.flip_h = false
#		if state == CROUCH_WALK or state == CROUCH_IDLE or state == CROUCH_ATTACK:
#			get_node("AttackArea/CollisionShape2D").position = Vector2(33,16)
#		else:
#			get_node("AttackArea/CollisionShape2D").position = Vector2(33,-16)
	
func print_state():
	#enum {IDLE, JUMP, ATTACK, WALK, CROUCH_IDLE, CROUCH_WALK, CROUCH_ATTACK}
	match state:
		IDLE:
			print("IDLE")
		WALK:
			print("WALK")
			
func handle_movement():
	velocity = Vector2()
	
	var right = Input.is_action_pressed("ui_right") 	# movement right
	var left = Input.is_action_pressed("ui_left") 		# movement left
	var down = Input.is_action_pressed("ui_down") 		# movement down
	var up = Input.is_action_pressed("ui_up")			# movement up
	
	if right:
		velocity.x += 1
	if left: 
		velocity.x -= 1
	if up:
		velocity.y -= 1
	if down:
		velocity.y += 1
		
	return velocity.normalized() * walk_speed
	
func handle_input():
	#print_state()
	
	var select = Input.is_action_pressed("ui_select")	# spacebar
	var action = Input.is_action_pressed("ui_accept")	# enter
	#set velocity to 0 initially
	velocity = handle_movement()#Vector2()
	
	match state:
		IDLE:
			if velocity.x != 0 || velocity.y != 0:
				change_state(WALK)
			elif select:
				emit_signal("select")	
			elif action:
				emit_signal("action")
			
		WALK:
			if velocity.x == 0 and velocity.y == 0:
				change_state(IDLE)
			elif action:
				emit_signal("action")

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	handle_input()
	
func _physics_process(delta):
	velocity = move_and_slide(velocity)
	
	var areas = $CollectingArea.get_overlapping_areas()
	for area in areas:
		if area.is_in_group("item"):
			emit_signal("collected_item", area)