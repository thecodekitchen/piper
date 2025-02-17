extends OptionButton

var req:HTTPRequest

func _ready() -> void:
	Globals.updated_collections.connect(update_options)
	item_selected.connect(_item_selected)
	start_request()
	

func start_request()->void:
	req = HTTPRequest.new()
	add_child(req)
	var api_key = Globals.qdrant_api_key
	var headers = PackedStringArray(["Authorization: Bearer " + api_key])
	req.request_completed.connect(request_completed)
	req.request(Globals.qdrant_url+"/collections",headers)
	
func request_completed(result,_code,_headers,body)->void:
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("failed to get collections!")
		req.queue_free()
		return
	print(body.get_string_from_utf8())
	var data = HTTP.parse_json(body)
	if data.has("result") and data["result"].has("collections"):
		var collections:Array[String] = []
		for obj in data["result"]["collections"]:
			collections.append(obj["name"])
		Globals.qdrant_collections = collections
		update_options()
	req.queue_free()
	Globals.selected_collection = get_item_text(0)
	
func update_options()->void:
	clear()
	if Globals.qdrant_collections:
		for collection in Globals.qdrant_collections:
			add_item(collection)

func _item_selected(idx:int)->void:
	Globals.selected_collection = get_item_text(idx)
	
