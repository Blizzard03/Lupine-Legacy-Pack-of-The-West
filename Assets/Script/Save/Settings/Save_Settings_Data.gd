extends Node

const Settings_Data = "user://Settings_Data.save"

var Data_Settings = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	Data_Load()

func Data_Load():
	var Data_File_Load = File.new()
	if not Data_File_Load.file_exists(Settings_Data):
		Data_Settings = {
			"FullScreen_on": false,
			"V_Sync" : false,
			"Display_FPS": false,
			"Max_FPS" : 0,
			"Contrast": 1,
			"Brightness" : 1,
			"Master_Volume" : -2,
			"Music_Volume": -2,
			"SFX_Volume": -2,	
		}
		Data_Save()
	Data_File_Load.open(Settings_Data,File.READ)
	Data_Settings = Data_File_Load.get_var()
	Data_File_Load.close()

func Data_Save():
	var Data_File_Save = File.new()
	Data_File_Save.open(Settings_Data,File.WRITE)
	Data_File_Save.store_var(Data_Settings)
	Data_File_Save.close()
