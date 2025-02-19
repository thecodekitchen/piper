extends FileDialog

var req:HTTPRequest
var paths:Array[String]
var dir_name:String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dir_selected.connect(_dir_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _dir_selected(dir:String)->void:
	if OS.get_name() == "Windows":
		dir_name = dir.split("\\")[-1]
	else:
		dir_name = dir.split("/")[-1]
	if DirAccess.dir_exists_absolute(Globals.collection_folder) and not Globals.collection_folder in dir:
		var origin = dir
		if OS.get_name() == "Windows":
			dir = Globals.collection_folder + "\\" + dir_name
		else:
			dir = Globals.collection_folder + "/" + dir_name
		copy_directory(origin,dir)
		
	paths = []
	scan_dir(dir, paths)
	var container_paths:Array[String] = []
	for path in paths:
		container_paths.append(path.replace(Globals.collection_folder,"/collections"))
	print(container_paths)
	paths = container_paths
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

func copy_directory(source_path: String, destination_path: String) -> Error:
	# Ensure source directory exists
	var dir = DirAccess.open(source_path)
	if not dir:
		push_error("Failed to open source directory: " + source_path)
		return FAILED
	
	# Create the destination directory if it doesn't exist
	if not DirAccess.dir_exists_absolute(destination_path):
		var err = DirAccess.make_dir_recursive_absolute(destination_path)
		if err != OK:
			push_error("Failed to create destination directory: " + destination_path)
			return err
	
	# Open destination directory
	var dest_dir = DirAccess.open(destination_path)
	if not dest_dir:
		push_error("Failed to open destination directory: " + destination_path)
		return FAILED
	
	# Begin listing all files in source directory
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	while file_name != "":
		var source_item = source_path.path_join(file_name)
		var dest_item = destination_path.path_join(file_name)
		
		if dir.current_is_dir():
			# Recursively copy subdirectories
			var err = copy_directory(source_item, dest_item)
			if err != OK:
				return err
		else:
			# Copy individual files
			var err = DirAccess.copy_absolute(source_item, dest_item)
			if err != OK:
				push_error("Failed to copy file: " + source_item)
				return err
		
		file_name = dir.get_next()
	
	dir.list_dir_end()
	return OK
