class_name CustomGlobal

# COOKING
static var isCooking = false

# INGREDIENTS
static var ingredients_limit = 3
static var ingredients_count = 0
static var ingredients_last_used: Array[String] = []
static var ingredients_value = 0

# STATS
static var has_won = false

static func add_ingredient(ingredient_name: String, value: float, modifier: float):
	if ingredients_count >= ingredients_limit:
		return
	
	ingredients_count += 1
	
	if ingredients_last_used.size() >= 12:
		ingredients_last_used.remove_at(0)
	
	ingredients_last_used.push_front(ingredient_name)
	
	var occurences = get_number_of_duplicates(ingredients_last_used, ingredient_name) - 1
	value = (value - ((value*occurences)/3)) * modifier
	ingredients_value += value


static func cook():
	isCooking = true


static func resetPot():
	ingredients_count = 0
	ingredients_value = 0


static func resetEverything():
	isCooking = false
	ingredients_limit = 3
	ingredients_count = 0
	ingredients_last_used = []
	ingredients_value = 0
	has_won = false


static func get_number_of_duplicates(array: Array[String], item: String) -> int:
	var occurences = 0
	for i in range(array.size()):
		if array[i] == item:
			occurences += 1
	return occurences
