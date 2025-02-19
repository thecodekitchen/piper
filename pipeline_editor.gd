extends Control

var file_menu: PopupMenu
var save_dialog:SaveDialog
var load_dialog:FileDialog
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file_menu_button = $ColorRect/VBoxContainer/MenuBar/HBoxContainer/FileMenuButton
	file_menu = file_menu_button.get_popup()
	file_menu.index_pressed.connect(file_menu_router)
	save_dialog = $SaveDialog
	load_dialog = $LoadDialog
	Globals.initialize_pipeline_graph()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func file_menu_router(index:int)->void:
	var handlers = [
		save_pipeline,
		load_pipeline
	]
	handlers[index].call()
	
		
func save_pipeline() -> void:
	save_dialog.popup_centered()
	
func load_pipeline() -> void:
	load_dialog.popup_centered()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("save"):
		if Globals.selected_pipeline_path:
			save_dialog.save_graph_to_file(Globals.selected_pipeline_path)
		else:
			save_dialog.popup_centered()
