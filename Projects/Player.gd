extends KinematicBody2D

export (int) var gravity = 300.0
export (int) var jump = 200
export (int) var speed = 600
var screensize
var x_chromo = 30 
var new_x 
var velocity = Vector2()

func _ready():
	 screensize = get_viewport_rect().size
	 add_to_group("player")
	
	

	
		
func get_input():
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
		
		
	elif Input.is_action_pressed("ui_right"):
		velocity.x = speed
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true 
		
	elif Input.is_action_pressed("ui_up") :
		velocity.y = -jump
		$AnimatedSprite.play("jump")
		self.x_chromo -= 0.1
		
	
	elif Input.is_action_pressed("ui_down"):
		velocity.y += gravity
		$AnimatedSprite.animation = "stand"
		$AnimatedSprite.stop()

		
	if  Input.is_action_just_pressed("ui_up") and  Input.is_action_just_pressed("ui_right"):
		velocity.x = speed
		velocity.y = -jump
		$AnimatedSprite.play("jump")
		self.x_chromo -= 1
			
	elif Input.is_action_just_pressed("ui_up") and  Input.is_action_just_pressed("ui_left"):
		velocity.x = -speed
		velocity.y = -jump
		$AnimatedSprite.play("jump")
		self.x_chromo -= 1
		
	if velocity.x == 0 and velocity.y == 0:
		$AnimatedSprite.play("stand")
	
		
	#TODO make flying animation constant in air 
		
	velocity = velocity.normalized() * speed



func _physics_process(delta):
	velocity.y += delta * gravity
	velocity.x += 0
	position.x = clamp(position.x, 0, screensize.x )
	position.y = clamp(position.y, 0, screensize.y )	
	
	
	get_input()
	move_and_slide(velocity, Vector2(0, -1))
	
func set_x(new_x):
	x_chromo = new_x
	pass
	

	


#func _on_Area2D_area_entered(area):
	#self.x_chromo -= 1


func _on_Area_body_entered(body):	
	body.hide()
	self.x_chromo -= 1
	
	
	
