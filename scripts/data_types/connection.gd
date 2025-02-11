class_name Connection
extends Object

var _from:StringName
var _from_port:int
var _to:StringName
var _to_port:int

func _init(from:StringName,from_port:int,to:StringName,to_port:int) -> void:
	_from=from
	_from_port=from_port
	_to=to
	_to_port=to_port

static func from_dict(data:Dictionary)->Connection:  # New method
	if data.has("from_node") && data.has("from_port") && data.has("to_node") && data.has("to_port"):
		return Connection.new(
			StringName(data["from_node"]),
			data["from_port"],
			StringName(data["to_node"]),
			data["to_port"]
		)
	return null

static func from_json(src:String)->Connection:
	var json = JSON.new()
	var err = json.parse(src)
	if err == OK:
		var data = json.get_data()
		return from_dict(data)
	return null
