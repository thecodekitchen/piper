extends Button

@onready var dialog:FileDialog = $"../../../../../../../../CollectionDirDialog"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(open_dialog)

func open_dialog()->void:
	dialog.popup_centered()
