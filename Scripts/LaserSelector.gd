extends TextureButton

export (PackedScene) var Laser
export var laserselected = [true, true, true]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	match laserselected:
		[true, true, true]:
			$DedLaser.show()
			$DedLaser.disabled = false
			$MutateLaser.show()
			$MutateLaser.disabled = false
			$ResetLaser.show()
			$ResetLaser.disabled = false
		[false, true, true]:
			$DedLaser.hide()
			$DedLaser.disabled = true
			$MutateLaser.show()
			$MutateLaser.disabled = false
			$ResetLaser.show()
			$ResetLaser.disabled = false
		[true, false, true]:
			$DedLaser.show()
			$DedLaser.disabled = false
			$MutateLaser.hide()
			$MutateLaser.disabled = true
			$ResetLaser.show()
			$ResetLaser.disabled = false
		[true, true, false]:
			$DedLaser.show()
			$DedLaser.disabled = false
			$MutateLaser.show()
			$MutateLaser.disabled = false
			$ResetLaser.hide()
			$ResetLaser.disabled = true


func _on_LaserSelector_pressed():
	if get_node("Laser") != null:
		get_node("Laser").queue_free()
	laserselected = [true, true, true]

func _on_DedLaser_pressed():
	if get_node("Laser") != null:
		get_node("Laser").queue_free()
	if  get_node("Laser") == null:
		var laser = Laser.instance()
		add_child(laser)
		laser.type = 0
		laser.name = "Laser"
		laserselected = [false, true, true]

func _on_MutateLaser_pressed():
	if get_node("Laser") != null:
		get_node("Laser").queue_free()
	if  get_node("Laser") == null:
		var laser = Laser.instance()
		add_child(laser)
		laser.type = 1
		laser.name = "Laser"
		laserselected = [true, false, true]

func _on_ResetLaser_pressed():
	if get_node("Laser") != null:
		get_node("Laser").queue_free()
	if  get_node("Laser") == null:
		var laser = Laser.instance()
		add_child(laser)
		laser.type = 2
		laser.name = "Laser"
		laserselected = [true, true, false]
