extends PopupMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_submenu_item("API", "APIMenu")
	add_submenu_item("Doc Stores", "DocStoreMenu")
	add_submenu_item("Audio", "AudioMenu")
	add_submenu_item("Builders", "BuilderMenu")
	add_submenu_item("Caching", "CachingMenu")
	add_submenu_item("Classifiers", "ClassifierMenu")
	add_submenu_item("Connectors", "ConnectorMenu")
	add_submenu_item("Converters", "ConverterMenu")
	add_submenu_item("Embedders", "EmbedderMenu")
	add_submenu_item("Evaluators", "EvaluatorMenu")
	add_submenu_item("Extractors", "ExtractorMenu")
	add_submenu_item("Fetchers", "FetcherMenu")
	add_submenu_item("Generators", "GeneratorMenu")
	add_submenu_item("Joiners", "JoinerMenu")
	add_submenu_item("Preprocessors", "PreprocessorMenu")
	add_submenu_item("Rankers", "RankerMenu")
	add_submenu_item("Readers", "ReaderMenu")
	add_submenu_item("Retrievers", "RetrieverMenu")
	add_submenu_item("Routers", "RouterMenu")
	add_submenu_item("Samplers", "SamplerMenu")
	add_submenu_item("ToolComponents", "ToolComponentMenu")
	add_submenu_item("Validators", "ValidatorMenu")
	add_submenu_item("WebSearch", "WebSearchMenu")
	add_submenu_item("Writers", "WriterMenu")
	add_submenu_item("Scalar Values", "ScalarValuesMenu")
	add_submenu_item("Complex Values", "ComplexValuesMenu")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
