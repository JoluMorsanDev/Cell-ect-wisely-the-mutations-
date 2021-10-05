extends KinematicBody2D

onready var cellroute = load("res://Scenes/Virus.tscn")
export (PackedScene) var Cell
export (Array) var MutationColors
export var Gen = 0
onready var limitR = get_parent().get_parent().get_node("SecureGuard").get_node("Rd")
onready var limitL = get_parent().get_parent().get_node("SecureGuard").get_node("Lt")
 
# Called when the node enters the scene tree for the first time.
func _ready():
	redy()

func redy():
	$Sprite.modulate = MutationColors[Gen]
	randomize()
	Cell = cellroute
	GetGen()
	if Gen != 2:
		$ReproductionTimer.start()
		pass

# warning-ignore:unused_argument
func _process(delta):
	if global_position > limitR.global_position or global_position < limitL.global_position:
			get_parent().get_parent().game_over() 
	if global_position.y > limitR.global_position.y or global_position.y < limitL.global_position.y:
			get_parent().get_parent().game_over() 

#Get the gen to change things
func GetGen():
	if Gen == 1:
		$ReproductionTimer.wait_time = rand_range(1.75, 2.25)
	else:
		$ReproductionTimer.wait_time = rand_range(3.75,4.25)
	if Gen == 2:
		$SelfDestruction.start()
		$ReproductionTimer.stop()
	else:
		$SelfDestruction.stop()
	if Gen == 3:
		$CellDetectionArea.scale =  Vector2(1.5,1.5) 
	else:
		$CellDetectionArea.scale = Vector2(1,1)
	if Gen == 4:
		self.add_to_group("Allies")
		$ReproductionTimer.wait_time = rand_range(3.25,3.75)
	else:
		if self.is_in_group("Allies"):
			self.remove_from_group("Allies")

func _on_Timer_timeout():
	$Sprite.play("Divide")

func _on_Sprite_animation_finished():
	if $Sprite.animation == "Divide":
		divide()

#Divide into 2 cells
func divide():
		
	if Gen != 2:
		#spawn 1st cell
		var cell1 = Cell.instance()
		get_parent().add_child(cell1)
		cell1.global_position = $VirusNewSpawn.global_position
		cell1.Cell = cellroute
		cell1.global_rotation_degrees = rand_range(0,360)
		if !self.is_in_group("Allies"):
			if rand_range(0,1) < .95:
				cell1.Gen = Gen
			else:
				if rand_range(0,1) > 0.8:
					cell1.Gen = 4
				else:
					cell1.Gen = int(rand_range(0,3))
		else:
			cell1.Gen = Gen 
		cell1.get_node("Sprite").modulate = MutationColors[Gen]
		
		#spawn 2nd cell
		var cell2 = Cell.instance()
		get_parent().add_child(cell2)
		cell2.global_position = $VirusNewSpawn2.global_position
		cell2.Cell = cellroute
		cell2.global_rotation_degrees = rand_range(0,360)
		if !self.is_in_group("Allies"):
			if rand_range(0,1) < .95:
				cell2.Gen = Gen
			else:
				if rand_range(0,1) > 0.8:
					cell2.Gen = 4
				else:
					cell2.Gen = int(rand_range(0,3))
		else:
			cell2.Gen = Gen
		cell2.get_node("Sprite").modulate = MutationColors[Gen]
		
		
	_on_SelfDestruction_timeout()

func _on_SelfDestruction_timeout():
	queue_free()

func _on_CellDetectionArea_area_entered(area):
	if area.owner.has_method("hit") and area.owner.is_in_group("Allies") and !self.is_in_group("Allies"):
		area.owner.hit()
		$CellDetectionArea/CollisionShape2D.set_deferred("disabled", true)
		$AtkCooldown.start()

func _on_AtkCooldown_timeout():
	$CellDetectionArea/CollisionShape2D.set_deferred("disabled", false)

func hit():
	queue_free()
