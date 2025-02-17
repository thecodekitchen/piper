extends FileDialog

var req:HTTPRequest
var paths:Array[String]
var dir_name:String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dir_selected.connect(_dir_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _dir_selected(dir:String)->void:
	paths = []
	scan_dir(dir, paths)
	if OS.get_name() == "Windows":
		dir_name = dir.split("\\")[-1]
	else:
		dir_name = dir.split("/")[-1]
	start_request()
	
func start_request()->void:
	req = HTTPRequest.new()
	add_child(req)
	req.request_completed.connect(request_completed)
	var body = JSON.stringify({
		"paths": paths,
		"recreate": true
	})
	req.request(Globals.pipeline_url+"/upload/"+dir_name,[],HTTPClient.METHOD_POST,body)

func request_completed(result,code,headers,body)->void:
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("failed to upload collection!")
		req.queue_free()
		return
	if not dir_name in Globals.qdrant_collections:
		Globals.qdrant_collections.append(dir_name)
		Globals.emit_signal("updated_collections")
		
func scan_dir(path: String, paths: Array):
	var dir_client = DirAccess.open(path)
	var files = dir_client.get_files()
	var dirs = dir_client.get_directories()
	var sep = "/"
	if OS.get_name() == "Windows":
		sep = "\\"
	for file in files:
		if file.ends_with(".rst"):
			var original = file
			file = file.trim_suffix("rst")+"txt"
			dir_client.rename(path+sep+original, path+sep+file)
		if file.ends_with(".txt") || file.ends_with(".xlsx") || file.ends_with(".html") || file.ends_with(".pdf") || file.ends_with(".docx") || file.ends_with(".md"):
			paths.append(path+sep+file)
	for dir in dirs:
		scan_dir(path+sep+dir, paths)
