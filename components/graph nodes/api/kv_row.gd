class_name KeyValueRow
extends HBoxContainer

var model_node:DataModelNode
var pipeline_types:Array[String]
var custom_types:Array[String]
var is_custom:bool
var key_idx:int

var custom_type_button:CheckButton
var type_option_button:OptionButton
var key_edit:LineEdit
var add_button:Button


signal custom_changed(key:String,on:bool)
signal type_changed(key:String,type:String)
signal key_changed(idx:int, new:String)
signal add_pressed()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	key_idx = get_index()
	var parent = get_parent()
	if not parent is DataModelNode:
		push_error("KeyValueRow was used outside of DataModelNode. Use a different node for whatever you're doing.")
		return
	model_node = parent as DataModelNode
	model_node.refresh_editor()
	var data_models = model_node.graph_editor.data_models
	for model in data_models:
		custom_types.append(model._name)
	for key in Pipeline.DataType.keys():
		if key is String:
			pipeline_types.append(key)
	custom_type_button = $CustomCheck/CustomCheckButton
	type_option_button = $TypePicker/TypeOptionButton
	key_edit = $KeyEditor/KeyEdit
	add_button = $AddButton
	
	custom_type_button.toggled.connect(custom_toggled)
	type_option_button.item_selected.connect(type_selected)
	key_edit.text_submitted.connect(key_edited)
	add_button.pressed.connect(pressed)
	
func custom_toggled(on:bool)->void:
	is_custom = on
	type_option_button.clear()
	refresh_custom_types()
	if on:		
		print(custom_types)
		for type in custom_types:
			type_option_button.add_item(type)
	else:
		for type in pipeline_types:
			type_option_button.add_item(type)
	type_option_button.select(0)
	emit_signal("custom_changed",{"key": key_edit.text,"value":on})
	
func type_selected(idx:int)->void:
	var type = ""
	if is_custom:
		type = custom_types[idx]
	else:
		type = pipeline_types[idx]
	emit_signal("type_changed",{"key": key_edit.text, "value": type})

func key_edited(new:String)->void:
	emit_signal("key_changed",{"idx":key_idx,"new":new})
		
func pressed()->void:
	emit_signal("add_pressed")

func refresh_custom_types()->void:
	var new_types: Array[String] = []
	for model in model_node.graph_editor.data_models:
		new_types.append(model._name)
	custom_types = new_types
