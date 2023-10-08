extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_health(current_health):
	$HealthProgress.value = current_health
	$HealthProgress/Label.text = "%d/%d" % [int(current_health),int($HealthProgress.max_value)]

func update_max_health(max_health):
	$HealthProgress.max_value = max_health
