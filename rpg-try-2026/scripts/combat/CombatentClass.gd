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
	name = nm + " " + NAMES.pick_random()

func initialize(resource : CombatentResource):
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
	return self

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
