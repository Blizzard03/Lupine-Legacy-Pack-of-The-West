extends Node

const Player_Data_File = "user://Player_Save.save"

var Player_Data = {}

func _ready():
	pass # Replace with function body.

func Data_Load():
	pass
	
	#var File_Load = File.new()
	#if not File_Load.file_exists(Player_Data_File):
	#	Player_Data = {
			#"Name": String,
			#"Gender" : String ,
			#"Level":  ,
			#"EXP" : 0,
			#"Defense": 1,
			#"Attack" : 1,
			#"Master_Volume" : -2,
			#"Music_Volume": -2,
			#"SFX_Volume": -2,	
	#	}
	#	Data_Save()
	#Data_File_Load.open(Settings_Data,File.READ)
	#Data_Settings = Data_File_Load.get_var()
	#Data_File_Load.close()

func Data_Save():
	var File_Save = File.new()
	File_Save.open(Player_Data_File,File.WRITE)
	File_Save.store_var(Player_Data)
	File_Save.close()

