extends Node

class_name ActionType

enum ActionTypeEnum {ROCK, PAPER, SCISSORS, HEAL, NONE}

# TODO: How can you make these static?
static var ROCK: ActionTypeEnum = ActionTypeEnum.ROCK
static var PAPER: ActionTypeEnum = ActionTypeEnum.PAPER
static var SCISSORS: ActionTypeEnum = ActionTypeEnum.SCISSORS
static var HEAL: ActionTypeEnum = ActionTypeEnum.HEAL
static var NONE: ActionTypeEnum = ActionTypeEnum.NONE

static func All():
	return [ROCK, PAPER, SCISSORS, HEAL]
