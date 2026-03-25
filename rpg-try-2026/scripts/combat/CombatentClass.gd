extends Node
class_name CombatentClass

var creaturename : String
var max_hp : int
var current_hp : int

var max_stamina : int
var stamina_regen : int
var current_stamina : int

var speed : int
var strength : int

var attacks : Array[OffensiveActionResource]
var defenses : Array[DefensiveActionResource]

func setName(nm):
	var NAMES = ["Albert", "Bernard", "Carlos", "Danny", "Eric", "Frederic", "Garry"]
	creaturename = nm + " " + NAMES.pick_random()

func _init(resource : CombatentResource)-> void:
	strength = resource.strength
	speed = resource.speed

	max_hp = resource.max_hp
	current_hp = resource.max_hp

	max_stamina = resource.max_stamina
	current_stamina = resource.max_stamina
	stamina_regen = resource.stamina_regen

	attacks = resource.attacks
	defenses = resource.defenses
	setName(resource.name)

func choseAction(manager : TurnManager):
	# Refatorar para ser um metodo "Take turn"
	# As ações escolhidas podem ser de buff/cura (não requerem defesa)
	# As ações podem não passar o turno (poderes)

	# o TurnManager requer uma logica de "Targeting" (uma func que retorna as possiveis alvos para uma acao????)
	# Na real isso deveria ser responsabilidade da action, filtrar os alvos
	# o choseDefese só deveria ser chamado quando o alvo fossse definido
	return attacks.pick_random()


func choseDefense(manager : TurnManager):
	return defenses.pick_random()

# MOCK
#TODO: Refatorar Actions para receber configurações do alvo
#TODO: Refatorar para ActionGroups ser um resource.
#TODO: Fazer com que actions possuam um conjunto de "Aplicabilidade". Se um grupo estiver vazio ele não vai ser aplicado
func getActionGroups():
	return [{"name":"Offensive" , "actions":attacks}, {"name":"Defensive" , "actions":defenses }]
