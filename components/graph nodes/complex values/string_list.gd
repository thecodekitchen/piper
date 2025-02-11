class_name ListNode
extends PipelineGraphNode
# Called when the node enters the scene tree for the first time.
var item_row:PackedScene
var rows:Array[ItemRow]
func _ready() -> void:
	super._ready()
	item_row = preload("res://components/graph nodes/complex values/new_item_row.tscn")
#	Load in any existing array elements first
	if data.has("value") && data["value"] is Array:
		for i in range(data["value"].size()):
			var val = data["value"][i]
			var row = item_row.instantiate() as ItemRow
			row.idx = i
			add_child(row)
			row.label.text = str(i)+":"
			row.edit.text = str(val)
			row.button.text = "-"
			connect_row_signals(row)
			rows.append(row)
#	Always provide one row at the bottom of the list for providing a new value
	var row = item_row.instantiate() as ItemRow
	row.is_new = true
	var final_idx = rows.size() 
	row.idx = final_idx
	add_child(row)
	row.label.text = str(final_idx)+":"
	connect_row_signals(row)
	rows.append(row)
	
	inputs = []
	outputs = [
		Pipeline.DataType.PlainStringList
	]
	slot(0,Pipeline.DataType.None,Pipeline.DataType.PlainStringList)

func add_row(val)->void:
	if data.has("value"):
		data["value"].append(val)
	else:
		data["value"] = [val]
	set_value(data["value"])
	var edited_row = rows[-1]
	edited_row.button.text = "x"
	edited_row.is_new = false
	var row = item_row.instantiate() as ItemRow
	row.is_new = true
	row.idx = rows.size()
	add_child(row)
	row.label.text = str(row.idx)+":"
	connect_row_signals(row)
	rows.append(row)
	row.edit.grab_focus()

	
func update_row(val,idx:int)->void:
	data["value"][idx] = val
	set_value(data["value"])
	
func delete_row(idx:int)->void:
	data["value"].remove_at(idx)
	set_value(data["value"])
	var row_node = rows[idx]
	rows.remove_at(idx)
	size.y -= row_node.size.y
	remove_child(row_node)
	custom_minimum_size = Vector2.ZERO
	reset_size()
	for i in range(rows.size()):
		var row = rows[i]
		row.idx = i
		row.label.text = str(i)+":"
	
func connect_row_signals(row:ItemRow):
	row.add.connect(add_row)
	row.updated.connect(update_row)
	row.delete.connect(delete_row)
