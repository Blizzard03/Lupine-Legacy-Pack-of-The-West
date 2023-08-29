extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSettings.connect("FPS_displayed",self, "_on_fps_displayed")

func _on_fps_displayed(value):
	visible = value

func _process(delta):
	text = "FPS : %s" % [Engine.get_frames_per_second()]
