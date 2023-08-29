tool
extends MenuButton

enum {
	OPTION_COPY = 101,
	OPTION_PASTE,
	OPTION_NEW_PATTERN = 201,
	OPTION_NEW_GENERATOR,
}

var list_node


func _init(list_node):
	self.list_node = list_node

	yield(self, "ready")

	var popup := get_popup()
	popup.add_icon_item(get_icon("ActionCopy", "EditorIcons"), "Copy Data", OPTION_COPY)
	popup.add_icon_item(get_icon("ActionPaste", "EditorIcons"), "Paste Data", OPTION_PASTE)
	popup.add_separator()

	if list_node.allowed_types.has(ItemPattern):
		popup.add_icon_item(get_icon("Add", "EditorIcons"), "New ItemPattern", OPTION_NEW_PATTERN)

	if list_node.allowed_types.has(ItemGenerator):
		popup.add_icon_item(get_icon("Add", "EditorIcons"), "New ItemGenerator", OPTION_NEW_GENERATOR)

	popup.connect("id_pressed", self, "_on_id_selected")
	_on_id_selected(-99999)


func _on_id_selected(id : int):
	match(id):
		OPTION_COPY:
			OS.clipboard = var2str_without_sorted_keys(list_node.columns)

		OPTION_PASTE:
			var columns = str2var(OS.clipboard)
			if columns.size() != list_node.columns.size(): return

			list_node.columns = columns
			list_node._clear_items()
			list_node._init_items(list_node.columns_are_int)
			for k in list_node.columns:
				list_node.emit_changed(k, list_node.columns[k], "", true)

		OPTION_NEW_PATTERN:
			var new_res = ItemPattern.new()
			list_node.drop_data(Vector2.ONE, {"resources" : [new_res]})

		OPTION_NEW_GENERATOR:
			var new_res = ItemGenerator.new()
			list_node.drop_data(Vector2.ONE, {"resources" : [new_res]})

	icon = get_icon("GuiTabMenuHl", "EditorIcons")


static func var2str_without_sorted_keys(dict):
	var strings = []
	for k in dict:
		strings.append("\"%s\":%s" % [k, var2str(dict[k])])

	return "{\n%s\n}" % ",\n".join(strings)
