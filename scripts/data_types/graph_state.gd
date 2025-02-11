class_name GraphState
extends Object

var _connections:Array[Connection]
var _nodes:Array[NodeState]
var _frames:Array[FrameState]

func _init(connections:Array[Connection],nodes:Array[NodeState],frames:Array[FrameState]) -> void:
	_connections = connections
	_nodes = nodes
	_frames = frames
	
static func from_json_file(file_path: String) -> GraphState:
	var file_contents = FileAccess.open(file_path, FileAccess.READ).get_as_text()
	return GraphState.from_json(file_contents)

static func from_json(src:String) -> GraphState:
	var json = JSON.new()
	var error = json.parse(src)
	if error == OK:
		var data = json.get_data()
		if data.has("connections") && data.has("nodes") && data.has("frames"):
			var connections:Array[Connection] = []
			var nodes:Array[NodeState] = []
			var frames:Array[FrameState] = []
			for c in data["connections"]:
				var conn = Connection.from_dict(c)  # Changed from JSON.stringify
				if conn != null:
					connections.append(conn)  # Removed JSON.stringify
				else:
					print("connection failed to parse: ", c)
			for n in data["nodes"]:
				var node = NodeState.from_dict(n)  # Changed from JSON.stringify
				if node != null:
					nodes.append(node)
				else:
					print("node failed to parse: ", n)
			for f in data["frames"]:
				var frame = FrameState.from_dict(f)  # Changed from JSON.stringify
				if frame != null:
					if frame._title == "":
						frame._title = f["title"]
					frames.append(frame)
				else:
					print("frame failed to parse: ", f)
			return GraphState.new(connections,nodes,frames)
		push_error("data was missing fields: ", data)
		return null
	push_error("failed to parse json data: ", src)
	return null
