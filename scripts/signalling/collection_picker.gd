extends OptionButton

var collections = []
var api_key = "4>GAK~YV+m-eZ5YO,9,O"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self.collections_request_completed)
	get_collections(http_request)

func collections_request_completed(result, _response_code, _headers, body) -> void:
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("Collections request failed: " + str(result))
		return
		
	var response = HTTP.parse_json(body)
	if response.get("error"):
		push_error(response.error)
		return
	var retrieved_collections = response.get("result").collections
	for collection in retrieved_collections:
		self.add_item(collection.name)# Update collections array

func get_collections(req: HTTPRequest) -> void:
	var headers = PackedStringArray(["Authorization: Bearer " + api_key])
	var err = req.request("http://localhost:6333/collections", headers)
	if err != OK:
		push_error("HTTP request failed: " + str(err))
