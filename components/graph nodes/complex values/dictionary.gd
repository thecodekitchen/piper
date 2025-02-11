extends PipelineGraphNode

var kwarg_map:Dictionary
var kwarg_slots:Dictionary
var reset_button:Button
#Input dict will contain keys with boolean values denoting whether or not they are required inputs
func _ready() -> void:
	super._ready()
	var reset_button = $SlotContainer0/ResetButton
	reset_button.pressed.connect(on_reset)
	inputs = [
		Pipeline.DataType.ArgDict
	]
	outputs = [
		Pipeline.DataType.ArgDict
	]
	if not data.has("kwargs"):
		data["kwargs"] = {}
		kwarg_map = {}
	else:
		kwarg_map = data["kwargs"]
		var kwargs = data["kwargs"].keys()
		for i in range(kwargs.size()):
			var kwarg = kwargs[i]
			var type = int(data["kwargs"][kwarg]["enum"])
			make_kwarg_slot(kwarg, i+1,type)
			inputs.append(type)
			
	
	slot(0,Pipeline.DataType.ArgDict,Pipeline.DataType.ArgDict)
		
func conn_request(from:StringName,from_port:int,to:StringName,to_port:int)->void:
	if to == name && to_port >0:
		var origin = graph_editor.get_node(NodePath(from)) as PipelineGraphNode
		var origin_type = origin.get_output_port_type(from_port)
		var origin_color = origin.get_output_port_color(from_port)
		var kwarg_idx = to_port-1
		var kwarg_key = kwarg_map.keys()[kwarg_idx]
		data["kwargs"][kwarg_key] = {
			"name": Pipeline.DataType.keys()[origin_type],
			"enum": origin_type
		}
		print("updated kwargs: ", data["kwargs"])
		set_slot_color_left(to_port,origin_color)
		set_slot_type_left(to_port,origin_type)
		if inputs.size()<=to_port:
			inputs.append(origin_type)
		else:
			inputs[to_port]=origin_type
	super.conn_request(from,from_port,to,to_port)
		
func handle_port_change(port:int,val)->void:
	if port == 0:
		print("type map changed")
		if kwarg_map == null || kwarg_map == {}:
			print("setting kwarg map")
			kwarg_map = val
			type_map_connected()
			update_kwarg_slots()
		else:
			kwarg_map = val
			update_kwarg_slots()
	
func type_map_connected()->void:
	var slot_number = 1
	for kwarg in kwarg_map.keys():
		print("appending Any input")
		inputs.append(Pipeline.DataType.Any)
		print(inputs)
		make_kwarg_slot(kwarg,slot_number)
		if kwarg_map[kwarg]:
			var kwarg_hbox = get_node("SlotContainer"+str(slot_number))
			var label = kwarg_hbox.get_child(0)
			label.text += " (required)"
		slot_number += 1
	
func make_kwarg_slot(kwarg:String, slot_number:int, type:Pipeline.DataType = Pipeline.DataType.Any)->void:
	slot(slot_number,type)
	var hbox = HBoxContainer.new()
	hbox.name = "SlotContainer"+str(slot_number)
	var label = Label.new()
	label.name = kwarg
	label.text = kwarg
	hbox.add_child(label)
	add_child(hbox)
	kwarg_slots[slot_number] = {
		"kwarg": kwarg,
		"slot": hbox
	}


func update_kwarg_slots()->void:
	print("updating kwarg slots")
	var kwargs = kwarg_map.keys()
	
	print("kwargs: ", kwargs)
	for i in range(kwargs.size()):
		var key = kwargs[i]
		var required = kwarg_map[key]
		if kwarg_slots.has(i+1):
			var slot = kwarg_slots[i+1]["slot"] as HBoxContainer
			var label = slot.get_child(0) as Label
			if required:
				label.text = key + " (required)"
			else:
				label.text = key
		else:
			if inputs.size()<i+2:
				inputs.resize(i+2)
			inputs[i+1]=Pipeline.DataType.Any
			make_kwarg_slot(key,i+1)
		
func on_reset()->void:
	break_connections()	
	for slot_number in kwarg_slots.keys():
		set_slot_type_left(int(slot_number),Pipeline.DataType.Any)
		set_slot_color_left(int(slot_number),Pipeline.new().TypeColors["Any"])
