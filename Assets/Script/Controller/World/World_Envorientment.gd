extends WorldEnvironment

func _ready():
	
	GlobalSettings.connect("Brightness_updated",self , "_on_brightness_update")
	GlobalSettings.connect("Contrast_updated",self,"_on_Contrast_updated" )
	
func _on_brightness_update(value):
	environment.adjustment_brightness = value
	
func _on_contrast_update(value):
	environment.adjustment_contrast = value
	


