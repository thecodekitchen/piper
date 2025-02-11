extends Control

var file_menu: PopupMenu
var edit_menu: PopupMenu
var save_dialog:FileDialog
var load_dialog:FileDialog
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file_menu_button = $ColorRect/VBoxContainer/MenuBar/HBoxContainer/FileMenuButton
	var edit_menu_button = $ColorRect/VBoxContainer/MenuBar/HBoxContainer/EditMenuButton
	file_menu = file_menu_button.get_popup()
	edit_menu = edit_menu_button.get_popup()
	file_menu.index_pressed.connect(file_menu_router)
	edit_menu.index_pressed.connect(edit_menu_router)
	save_dialog = $SaveDialog
	load_dialog = $LoadDialog
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func file_menu_router(index:int)->void:
	var handlers = [
		save_pipeline,
		load_pipeline
	]
	handlers[index].call()
	
func edit_menu_router(index:int)->void:
	var handlers = [
		chat
	]
	handlers[index].call()
		
func save_pipeline() -> void:
	save_dialog.popup_centered()
	
func load_pipeline() -> void:
	load_dialog.popup_centered()
	
func chat() -> void:
	get_tree().change_scene_to_file("res://main_scene.tscn")
