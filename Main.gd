extends Node

export (PackedScene) var Mob
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("Mobs", "queue_free")
	
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	$HUD.update_score(score)
	$HUD.show_message("Use WASD to dodge enemies.\nHit space to shoot a fireball.\nSurvive as long as you can.", 5)
	
	if get_node("HUD/Options/EasyCheckBox").is_pressed():
		$MobTimer.wait_time = .5
	else:
		$MobTimer.wait_time = .4
		
	$AudioStreamPlayer.play()


func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.offset = randi()
	
	var mob = Mob.instance()
	add_child(mob)
	
	mob.position = $MobPath/MobSpawnLocation.position
	
	#mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
	
	if score % 10 == 0 and $MobTimer.wait_time > .05:
		$MobTimer.wait_time -= .05


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
