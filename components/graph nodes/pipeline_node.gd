class_name PipelineGraphNode
extends GraphNode

var graph_editor:PipelineGraphEdit
var copy:PackedScene
var copy_offset:Vector2

var component_type:Pipeline.ComponentType
var inputs:Array[Pipeline.DataType]
var outputs:Array[Pipeline.DataType]

var connections:Array[Dictionary]
var pipeline = Pipeline.new()

signal data_changed(data:Dictionary,src:StringName)

var data: Dictionary

var data_sources:Dictionary
var inputs_allow_multi:Array[bool]

signal input_connected(port:int,from:StringName,from_port:int)
signal value_updated(value,src:StringName)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#super._ready()
	var parent = get_parent()
	if parent is PipelineGraphEdit:
		graph_editor = parent
		connect_signals()
	else:
		graph_editor = parent.get_parent().get_parent() as PipelineGraphEdit
		connect_signals()
	data["connections"] = {}
	
func slot(
	idx:int,
	input:Pipeline.DataType=Pipeline.DataType.None,
	output:Pipeline.DataType=Pipeline.DataType.None)->void:
		var enable_left = false
		var enable_right = false
		var left_color = Color.WHITE
		var right_color = Color.WHITE
		var in_type_name = Pipeline.DataType.keys()[input]
		var out_type_name = Pipeline.DataType.keys()[output]
		if input != Pipeline.DataType.None:
			enable_left = true
			if input == Pipeline.DataType.Bool:
				left_color = pipeline.TypeColors["BoolFalse"]
			else:
				left_color = pipeline.TypeColors[in_type_name]
		if output != Pipeline.DataType.None:
			enable_right = true
			if output == Pipeline.DataType.Bool:
				right_color = pipeline.TypeColors["BoolFalse"]
			else:
				right_color = pipeline.TypeColors[out_type_name]
		set_slot(idx,enable_left,input,left_color,enable_right,output,right_color)
		
func connect_signals()->void:
	graph_editor.connection_request.connect(conn_request)
	graph_editor.delete_nodes_request.connect(handle_delete_request)
	graph_editor.copy_nodes_request.connect(handle_copy)
	graph_editor.paste_nodes_request.connect(handle_paste)

func handle_delete_request(nodes:Array[StringName]) -> void:
	if nodes.has(StringName(self.name)):
		self.queue_free()

func handle_copy() -> void:
	if self.selected:
		var packed = PackedScene.new()
		var result = packed.pack(self)
		if result == OK:
			copy_offset.x = offset_left + 250
			copy_offset.y = offset_top
			copy = packed
			print("Node packed successfully")
		else:
			print("Failed to pack node")
	else:
		copy = null
		copy_offset.x = offset_left
		copy_offset.y = offset_top
		
func handle_paste() -> void:
	if copy:
		var clone = copy.instantiate()
		name_copy(clone)
		graph_editor.add_child(clone)
		clone.position_offset = copy_offset
		copy_offset.x += 250
		
func conn_request(from:StringName,from_port:int,to:StringName,to_port:int)->void:
	#print("processing connection request from ",from,":",from_port," to ",to,":",to_port)
	if to == name:
		var origin_node = graph_editor.get_node(NodePath(from)) as PipelineGraphNode
		var origin_type = origin_node.outputs[from_port]
		if  origin_type == inputs[to_port] || inputs[to_port]==Pipeline.DataType.Any:
			if origin_node.data.has("senders") && data.has("receivers"):
				var sender = origin_node.data["senders"][from_port]
				var receiver = data["receivers"][to_port]
				if data["connections"].has(receiver):
					data["connections"][receiver].append(sender)
				else:
					data["connections"][receiver] = [sender]
				print("new connection: ", data["connections"])
			if origin_node.data.has("value") && origin_node.data["value"] is bool:
				if origin_node.data["value"] == true:
					set_slot_color_left(to_port, pipeline.TypeColors["BoolTrue"])
				if origin_node.data["value"] == false:
					set_slot_color_left(to_port, pipeline.TypeColors["BoolFalse"])
			if inputs_allow_multi && inputs_allow_multi[to_port]==false:
#				Multiple connections not allowed on input
#				Disconnect any existing connections and replace them with the new one
				for conn in connections:
					if conn["to_port"] == to_port:
						graph_editor.disconnect_node(conn["from"],conn["from_port"],conn["to"],conn["to_port"])
				data_sources[to_port] = [origin_node.name]
			elif data_sources.has(to_port):
				data_sources[to_port].append(origin_node.name)
			else:
				data_sources[to_port] = [origin_node.name]
				
			connect_nodes(from,from_port,to,to_port)
			origin_node.value_updated.connect(input_updated)
			if origin_node.data.has("value"):
				handle_port_change(to_port,origin_node.data["value"])
			if from.contains("APIParam"):
				if origin_node.data.has("api_param"):
					var param_data = origin_node.data["api_param"]
					handle_param_assignment(to_port,param_data)
					

	
func connect_nodes(from:StringName,from_port:int,to:StringName,to_port:int)->void:
	print("connecting ",from," to ", to)
	graph_editor.connect_node(from,from_port,to,to_port)
	emit_signal("input_connected",{"port":to_port,"from":from,"from_port":from_port})
	print("connect signal emitted")
	connections.append({"from":from, "from_port":from_port, "to":to, "to_port":to_port})

func set_value(val)->void:
	data["value"] = val
	print(name," emitted value update: ", val)
	emit_signal("value_updated",val,name)
	
func input_updated(data,src:StringName)->void:
	for port in data_sources:
		if (data_sources[port] as Array[StringName]).find(src) != -1:
			handle_port_change(port,data)
			
func store_source_value(src:StringName, name:String)->void:
	var src_node = graph_editor.get_node(NodePath(src))
	if src_node.data.has("value"):
		data[name] = src_node.data["value"]

func name_copy(copy:Node)->void:
	var graph_nodes = graph_editor.get_children()
	var base_name = name.rstrip("0123456789")
	var num_matches = 0
	for node in graph_nodes:
		if node.name.contains(base_name):
			num_matches+=1
	copy.name = base_name+str(num_matches)

func break_connections()->void:
	if graph_editor:
		var connections = graph_editor.get_connection_list()
		for connection in connections:
			if connection.from_node == name || connection.to_node == name:
				graph_editor.disconnect_node(connection.from_node,connection.from_port,connection.to_node,connection.to_port)

@warning_ignore("unused_parameter")
func handle_port_change(port:int,data)->void:
	pass
@warning_ignore("unused_parameter")	
func handle_param_assignment(port:int,param_data)->void:
	pass
