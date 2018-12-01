extends RigidBody2D

func _ready():
	self.friction = 0
	add_to_group("enemies")

func _physics_process(delta):
	self.add_force(Vector2(0, 0), Vector2(30, 30))
	
	


func _on_Visibility_screen_exited():
	queue_free()


	
	




func _on_Ychromosome_body_entered(body):
	hide()
	queue_free()
	$Player.x_chromo -= 1
