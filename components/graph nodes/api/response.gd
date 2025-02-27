extends PipelineGraphNode

var reset_button:Button
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	inputs = [
		Pipeline.DataType.Any
	]
	outputs = [
		Pipeline.DataType.APIResponse
	]
	if data.has("source_type") && data["source_type"].has("enum"):
		slot(0,data["source_type"]["enum"], Pipeline.DataType.APIResponse)
	else:	
		slot(0,Pipeline.DataType.Any, Pipeline.DataType.APIResponse)
	reset_button = $ResetTypeButton
	reset_button.pressed.connect(on_reset)
	
func conn_request(from:StringName,from_port:int,to:StringName,to_port:int)->void:
	#if from == name:
		#super.conn_request(from,from_port,to,to_port)
		#return
	if to == name:
		var origin = graph_editor.get_node(NodePath(from)) as PipelineGraphNode
		var origin_type = origin.get_output_port_type(from_port)
		slot(0,origin_type,Pipeline.DataType.APIResponse)
		data["source_type"] = {
			"name": Pipeline.DataType.keys()[origin_type],
			"enum": origin_type
		}
	super.conn_request(from,from_port,to,to_port)

func on_reset()->void:
	break_connections()
	slot(0,Pipeline.DataType.Any, Pipeline.DataType.APIResponse)
	
