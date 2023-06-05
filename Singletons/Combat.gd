extends Node

func FetchSkillDamage (skill_name):
	var damage = ServerData.skill_data[skill_name].damage
	return damage
