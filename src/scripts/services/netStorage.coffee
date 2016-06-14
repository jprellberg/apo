class NetStorage extends Factory
	constructor: ($localStorage, TransitionSystemFactory, PetriNetFactory) ->

		storage = $localStorage.$default
			nets: [ new TransitionSystemFactory
				name: "Sample Net"
				nodes: []
				edges: []
			]

		getNetFromStorageObject = (storageObject) ->
			switch storageObject.type
				when "lts" then return new TransitionSystemFactory(storageObject)
				when "pn" then return new PetriNetFactory(storageObject)

		return {
			getNets: ->
				allNets = []
				for net in storage.nets
					allNets.push(getNetFromStorageObject(net))
				allNets

			addTransitionSystem: (name) ->
				if (@getNetByName(name))
					return false
				storage.nets.push(
					new TransitionSystemFactory(
						name: name
						nodes: []
						edges: []
					)
				)

			addPetriNet: (name) ->
				if (@getNetByName(name))
					return false
				storage.nets.push(
					new PetriNetFactory(
						name: name
						nodes: []
						edges: []
					)
				)

			deleteNet: (id) -> storage.nets.splice(id, 1)

			getNetByName: (name) ->
				return getNetFromStorageObject(net) for net in storage.nets when net.name is name
				return false
		}
