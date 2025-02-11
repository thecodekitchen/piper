extends Control

var file_menu: PopupMenu
var edit_menu: PopupMenu
var pipeline_editor_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pipeline_editor_scene = preload("res://pipeline_editor.tscn")
	var file_menu_button = $Background/VBoxContainer/MenuBar/HBoxContainer/FileMenuButton
	var edit_menu_button = $Background/VBoxContainer/MenuBar/HBoxContainer/EditMenuButton
	file_menu = file_menu_button.get_popup()
	edit_menu = edit_menu_button.get_popup()
	file_menu.index_pressed.connect(file_menu_router)
	edit_menu.index_pressed.connect(edit_menu_router)
	
func file_menu_router(index:int)->void:
	var handlers = [
		self.save_conversation,
		self.load_conversation
	]
	handlers[index].call()
	
func edit_menu_router(index:int)->void:
	var handlers = [
		self.pipeline_editor
	]
	handlers[index].call()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func save_conversation():
	pass
	
func load_conversation():
	pass
	
func pipeline_editor():
	get_tree().change_scene_to_packed(pipeline_editor_scene)
