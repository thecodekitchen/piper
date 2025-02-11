class_name NodeState
extends Object

var _name:StringName
var _data:Dictionary
var _input_types:Array[String]
var _output_types:Array[String]
var _position_offset:Vector2

func _init(name:StringName, data:Dictionary, input_types:Array[String], output_types:Array[String], position_offset:Vector2):
	_name = name
	_data = data
	_input_types = input_types
	_output_types = output_types
	_position_offset = position_offset

static func from_dict(data:Dictionary)->NodeState:  # New method
	if data.has("name") && data.has("data") && data.has("input_types") && data.has("output_types") && data.has("position_offset"):
		# Create properly typed arrays
		var typed_input_types:Array[String] = []
		var typed_output_types:Array[String] = []
		
		# Convert input types
		for type in data["input_types"]:
			typed_input_types.append(type as String)
			
		# Convert output types
		for type in data["output_types"]:
			typed_output_types.append(type as String)
			
		return NodeState.new(
			StringName(data["name"]),
			data["data"],
			typed_input_types,
			typed_output_types,
			Parser.parse_vector2(data["position_offset"] as String)
		)
	push_error("data failed to parse into node: ", data)
	return null
	
static func from_json(src:String)->NodeState:
	var json = JSON.new()
	var err = json.parse(src)
	if err == OK:
		var data = json.get_data()
		return from_dict(data)
	push_error("invalid node json: ", src)
	return null
