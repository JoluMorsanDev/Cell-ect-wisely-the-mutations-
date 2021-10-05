extends Sprite

var machinepics = [load("res://Assets/Sprites/MutationLaserDedM.png"),
 load("res://Assets/Sprites/MutationLaserDefM.png"), load("res://Assets/Sprites/MutationLaserResetM.png")]
var linespics = [load("res://Assets/Sprites/MutationLaserDed.png"),
 load("res://Assets/Sprites/MutationLaserDef.png"), load("res://Assets/Sprites/MutationLaserReset.png")]
var radiationpics =   [load("res://Assets/Sprites/MutationLaserDedL.png"),
 load("res://Assets/Sprites/MutationLaserDefL.png"), load("res://Assets/Sprites/MutationLaserResetL.png")]

export var type = int(1)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Radiation/CollisionShape2D.set_deferred("disabled", true)

func _input(event):
	if event is InputEventScreenTouch:
		$Radiation/CollisionShape2D.set_deferred("disabled", false)
		$Radiation.modulate.a = 1
		$OffTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	global_position = get_global_mouse_position()
	texture = machinepics[type]
	$Lines.texture = linespics[type]
	$Radiation/Sprite.texture = radiationpics[type]

func _on_OffTimer_timeout():
	$Radiation/CollisionShape2D.set_deferred("disabled", true)
	$Radiation.modulate.a = .39
