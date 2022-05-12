extends AnimatedSprite
onready var animated_sprite = $AnimatedSprite


var velocity = Vector2.ZERO   #See hoiab kiirus
var max_speed = 300
var run_accel = 800         #Kiirenemine
var gravity = 1000
var max_falling = 160  
var jump_tugevus = -170
var jump_inputlag = 0.2
var local_inputlag = 0




func _process(delta):
	
	#hüppamine
	var jumping = Input.is_action_just_pressed("Jumping")
	var on_ground = global_position.y >=160
	
	if jumping && on_ground:
		velocity.y = jump_tugevus
	
	
	#liikumine paremale ja vasakule
	var derection = sign(Input.get_action_strength("ui_right") - Input.get_action_raw_strength("ui_left"))
	
	#kui direction > 0 siis pööra paremale
	if derection > 0:
		animated_sprite.flip_h = false
	
	#kui direction > 0 siis pööra vasakule
	elif derection < 0:
		animated_sprite.flip_h = true
		
	
	if derection != 0:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
	
	
	#liikumine in space
	velocity.x = move_toward(velocity.x, max_speed * derection, run_accel * delta)
	velocity.y = move_toward(velocity.y, max_falling, gravity * delta)
	
	#gravitatsioon
	global_position.x += (velocity.x * delta)
	global_position.y += (velocity.y * delta)
	
	#collision to the ground
	if global_position.y >= 160:
		global_position.y = 160
		
