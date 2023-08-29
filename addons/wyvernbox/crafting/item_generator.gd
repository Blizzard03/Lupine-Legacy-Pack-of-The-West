tool
class_name ItemGenerator, "res://addons/wyvernbox/icons/item_generator.png"
extends Resource

# Name of the generator displayed in tooltips. Can be a locale string.
export var name := ""
# The generator's icon displayed in tooltips.
export var texture : Texture
# The [ItemType]s or [ItemGenerator]s that can be generated.
export(Array, Resource) var results setget _set_results
# The non-normalized chances for each [ItemType] or [ItemGenerator] to appear.
# (If equals [3, 1, 1], the item at index 0 will appear three times as often as each of the others)
export(Array, float) var weights setget _set_weights
# The counts of result [ItemType]s or repeats of result [ItemGenerator]s.
export(Array, Vector2) var count_ranges setget _set_count_ranges


func _set_results(v):
	results = v
	_resize_arrays(v.size())


func _set_weights(v):
	weights = v
	_resize_arrays(v.size())


func _set_count_ranges(v):
	count_ranges = v
	_resize_arrays(v.size())


func _resize_arrays(size):
	size = max(size, 1)
	results.resize(size)
	weights.resize(size)
	count_ranges.resize(size)
	for i in size:
		if weights[i] == null || weights[i] == 0.0:
			weights[i] = 1.0

		if count_ranges[i] == null || count_ranges[i] == Vector2.ZERO:
			count_ranges[i] = Vector2.ONE

# Get a random item from [member results] with random [member count_ranges], considering their random [member weights].
# Override to define special item generators that modify results or [code]input_stacks[/code].
func get_items(rng : RandomNumberGenerator = null, input_stacks : Array = [], input_types : Array = []) -> Array:
	if rng == null:
		rng = RandomNumberGenerator.new()
		rng.randomize()

	if results[0] == null:
		assert(input_stacks.size() > 0, "Generator with blank Result received no Inputs!\n\nPerhaps you called consume_inputs() without passing its return value to get_items()?")

	var item_index = weighted_random(weights, rng) if results.size() > 0 else 0
	var item = results[item_index]
	if item == null:
		return []

	if item is ItemType:
		return [ItemStack.new(
			item,
			rng.randi_range(count_ranges[item_index].x, count_ranges[item_index].y),
			item.default_properties.duplicate(true)
		)]

	else:  # If nested ItemGenerator
		var repeats = rng.randi_range(count_ranges[item_index].x, count_ranges[item_index].y)
		var arr = []
		for i in repeats:
			arr.append_array(item.get_items(rng, input_stacks, input_types))

		return arr

	return []

# Must return settings for displays of item lists. Override to change behaviour, or add to your own class.
# The returned arrays must contain:
# - Property editor label : String
# - Array properties edited : Array[String] (the resource array must be first; the folowing props skip the resource array)
# - Column labels : Array[String] (each vector array must have two/three)
# - Columns are integer? : bool (each vector array maps to one)
# - Column default values : Variant
# - Allowed resource types : Array[Script or Classname]
func _get_wyvernbox_item_lists() -> Array:
	return [[
		"Outcomes", ["results", "weights", "count_ranges"],
		["Weight", "Min", "Max"], [false, true], [1, Vector2(1, 1)],
		[ItemType, load("res://addons/wyvernbox/crafting/item_generator.gd")]
	]]

# Returns a random number. Non-normalized chances are defined inside [member weights].
# If [code]rng[/code] not set, uses global RNG.
static func weighted_random(weights : Array, rng : RandomNumberGenerator = null) -> int:
	var sum = 0.0
	for i in weights.size():
		sum += weights[i]

	var val = 0.0
	if rng == null:
		val = randf() * sum
	
	else:
		val = rng.randf() * sum

	for i in weights.size():
		if val < weights[i]:
			return i

		val -= weights[i]

	return -1
