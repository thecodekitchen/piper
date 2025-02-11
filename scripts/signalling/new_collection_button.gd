extends Button

var req:HTTPRequest
var api_key = "4>GAK~YV+m-eZ5YO,9,O"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	req = HTTPRequest.new()
	self.add_child(req)
	req.request_completed.connect(self.request_completed)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func request_completed(result, _response_code, _headers, _body) -> void:
	remove_spinner()
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("New collection request failed: "+ result)

func _pressed() -> void:
	self.add_sibling(Spinner.new())
	open_file_dialog()
	
func remove_spinner():
	for sibling in get_parent_control().get_children():
		if sibling is Spinner:
			sibling.queue_free()
			
func open_file_dialog():
	var dialog = FileDialog.new()
	add_child(dialog)
	dialog.access = FileDialog.ACCESS_FILESYSTEM
	dialog.file_mode = FileDialog.FILE_MODE_OPEN_DIR
	dialog.connect("dir_selected", self._on_dir_selected)
	dialog.popup_centered()

func _on_dir_selected(path: String):
	var paths = []
	scan_dir(path, paths)
	var doc_batch = {
		"paths": paths,
		"index": path.get_file()
	}# Gets directory name without full path
	var headers = PackedStringArray(["qdrant-key: " +api_key ])
	req.request("http://localhost:8000/upload", headers,HTTPClient.METHOD_POST,JSON.stringify(doc_batch))
	
func scan_dir(path: String, paths: Array):
	var dir_client = DirAccess.open(path)
	var files = dir_client.get_files()
	var dirs = dir_client.get_directories()
	for file in files:
		if file.ends_with(".rst"):
			var original = file
			file = file.trim_suffix("rst")+"txt"
			dir_client.rename(path+"/"+original, path+"/"+file)
		if file.ends_with(".txt") || file.ends_with(".xlsx") || file.ends_with(".html") || file.ends_with(".pdf") || file.ends_with(".docx") || file.ends_with(".md"):
			paths.append(path+"/"+file)
	for dir in dirs:
		scan_dir(path+"/"+dir, paths)
		
