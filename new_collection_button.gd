extends Button

@onready var dialog:FileDialog = $"../../../../../../../CollectionFolderDialog"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(open_collection_dialog)

func open_collection_dialog()->void:
	dialog.popup_centered()
	
