extends Node

var skill_data
##TODO move these stats into a JSON
var test_data = {
		"Stats": {
			"Strength": 10,
			"Intelligence": 15,
			"Dexterity": 10,
			"Vitality": 5,
		}
}
	


func _ready():
	var skill_data_file = File.new()
	skill_data_file.open("res://Data/SkillData.json", File.READ)
	var skill_data_json = JSON.parse(skill_data_file.get_as_text())
	skill_data_file.close()
	skill_data = skill_data_json.result
