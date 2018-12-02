extends Node
export (PackedScene) var Y
var  score  = 0
export (int) var min_speed # Minimum speed range.
export (int) var max_speed # Maximum speed range.

# class member variables go here, for example:
# var a = 2
# var b = "textvar"



func _ready():
	$Player.hide()
	#randomize()
	
	

func _process(delta):
	if $Player.x_chromo < 1:
		game_over()
	$Label.text = "X-Chromosomes: " + str(int($Player.x_chromo))
	
		


func _on_StartTimer_timeout():
	$SpawnTimer.start()
	$ScoreTimer.start()


func _on_ScoreTimer_timeout():
	score += 10
	$HUD.update_score(score)
	if score == 100:
		min_speed += 100
		max_speed += 100
	if score == 500:
		$SpawnTimer.wait_time = 0.09
		min_speed += 100
		max_speed += 100
	if score == 750:
		$SpawnTimer.wait_time = 0.08
		min_speed += 100
		max_speed += 100
	if score == 1000:
		$SpawnTimer.wait_time = 0.07
		min_speed += 100
		max_speed += 100
	if score == 1250:
		$SpawnTimer.wait_time = 0.06
		min_speed += 100
		max_speed += 100
	if score == 1500:
		min_speed += 100
		max_speed += 100
	if score == 2000:
		$SpawnTimer.wait_time = 0.05
		min_speed += 100
		max_speed += 100

func game_over():
    $Music.stop()
    $Player.hide()
    $ScoreTimer.stop()
    $SpawnTimer.stop()
    $HUD.show_game_over()
    


func new_game():
    $SpawnTimer.wait_time = 0.1
    min_speed = 300
    max_speed = 400
    $Music.play()
    $Player.position = $StartPosition.position 
    $Player.x_chromo = 30
    score = 0
    $Player.show()
    $StartTimer.start()
    $HUD.update_score(score)
    $HUD.show_message("Get Ready")



func _on_SpawnTimer_timeout():
    # Choose a random location on Path2D.
    $MobPath/SpawnLocation.set_offset(randi())
    # Create a Mob instance and add it to the scene.
    var y = Y.instance()
    add_child(y)
    # Set the y's direction perpendicular to the path direction.
    var direction =  $MobPath/SpawnLocation.rotation + PI / 2 + PI / 2 
    # Set the y's position to a random location.
    y.position = $MobPath/SpawnLocation.position
    # Add some randomness to the direction.
    direction += rand_range(-PI / 4, PI / 4)
    y.rotation = direction
    # Choose the velocity.
    y.set_linear_velocity(Vector2(rand_range(self.min_speed, self.max_speed), 0).rotated(direction))

	
	

	
func _on_HUD_start_game():
	new_game()
