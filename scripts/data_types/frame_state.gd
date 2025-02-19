class_name FrameState
extends Object

var _name:StringName
var _title:String
var _attached: Array[StringName]
var _position_offset: Vector2
var _size:Vector2

func _init(name:StringName,title:String,attached: Array[StringName],position_offset: Vector2,size:Vector2)->void:
	_name = name
	_title = title
	_attached = attached
	_position_offset = position_offset
	_size=size

static func from_dict(data:Dictionary)->FrameState:
	var name = StringName("")
	if data.has("name"):
		name = StringName(data["name"])
	else:
		print("no name on frame: ", data)
	var title = ""
	if data.has("title"):
		title = data["title"]
	else:
		print("no title on frame ", name)  # New method
	var attached:Array[StringName] = []
	if data.has("attached"):
		for node in data["attached"]:
			attached.append(StringName(node))
	var position_offset = Vector2.ZERO
	if data.has("position_offset"):
		position_offset = Parser.parse_vector2(data["position_offset"] as String)
	var size = Vector2.ZERO
	if data.has("size"):
		size = Parser.parse_vector2(data["size"] as String)  # Added type cast
	return FrameState.new(name, title, attached,position_offset,size)
	
static func from_json(src:String)->FrameState:
	var json = JSON.new()
	var err = json.parse(src)
	if err == OK:
		var data = json.get_data()
		var state = from_dict(data)
		if state.title == "":
			push_error("Title not parsed on frame: ", src)
		return state
	return null
