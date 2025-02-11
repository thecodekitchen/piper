class_name Parser
extends Object

static func parse_vector2(vector_str: String) -> Vector2:
	# Remove any whitespace and parentheses
	vector_str = vector_str.strip_edges().trim_prefix("(").trim_suffix(")")
	var components = vector_str.split(",")
	if components.size() != 2:
		push_error("Invalid Vector2 string format: ", vector_str)
		return Vector2.ZERO
	# Remove any remaining whitespace from components
	components[0] = components[0].strip_edges()
	components[1] = components[1].strip_edges()
	return Vector2(float(components[0]), float(components[1]))
