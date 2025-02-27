extends Button

@onready var dialog:FileDialog = $"../../../../../../../CollectionFolderDialog"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(open_collection_dialog)
	Globals.uploading_collection.connect(uploading)
	Globals.updated_collections.connect(complete)
	
func open_collection_dialog()->void:
	dialog.popup_centered()
	
func uploading():
	text = "Uploading docs..."

func complete():
	text = "New Collection"
