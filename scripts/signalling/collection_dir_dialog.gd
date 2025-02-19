extends FileDialog

func _ready() -> void:
	dir_selected.connect(selected)

func selected(dir:String)->void:
	Globals.collection_folder = dir
