extends Node3D

@onready var box = $Box

var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	tween = get_tree().create_tween()
	tween.set_loops(false)
	tween.set_trans(Tween.TRANS_SINE)
	animate_tween()
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	box.rotate_y(0.5 * delta)

func animate_tween():
	tween.tween_property(box, "position", Vector3(0, 0.3, 0), 1)
	tween.tween_property(box, "position", Vector3(0, -0.2, 0), 1)
	tween.finished.connect(animate_tween)
