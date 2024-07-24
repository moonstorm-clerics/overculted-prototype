extends Resource
class_name OrderDef


## static ###################################################

enum Demand {
	SacPlayer,
	SacNPC,
	Chant,
	Pray,
	}

static var all_demands = [
	Demand.SacPlayer,
	Demand.SacNPC,
	Demand.Chant,
	Demand.Pray,
	]

static var demand_labels = {
	Demand.SacPlayer: "Sacrifice Yourself",
	Demand.SacNPC: "Sacrifice A Villager",
	Demand.Chant: "CHANT!",
	Demand.Pray: "PRAY TO ME!",
	}

static var demon_names = [
	"Cthulhu",
	"Devil",
	"Demon",
	]


static func random_demands(demand_count=1):
	return U.rand_of(OrderDef.all_demands, demand_count, true)

static func demand_label(demand: Demand):
	return demand_labels.get(demand)

static func random_demon_name() -> String:
	return U.rand_of(demon_names)

# pass in a list of `demands`, a `demand_count`, or just let it be random
static func gen_order(opts={}):
	if opts == {}:
		opts.demand_count = U.rand_of([1, 2])
	return OrderDef.new(opts)

## vars #####################################################

@export var demands: Array[Demand] = []
@export var demon_name: String = "Cthulhu"

## init #####################################################

func _init(opts={}):
	demands.assign(opts.get("demands",
		OrderDef.random_demands(opts.get("demand_count", 1))))

	demon_name = opts.get("demon_name", OrderDef.random_demon_name())

func to_pretty():
	return [demon_name, demands]
