(define (domain trnkato2-assign1)
	(:requirements :strips :equality :typing :action-costs);
	(:types tool location color shape wood robot-state table-state)
	(:predicates	(robot-s ?s - robot-state)
					(robot-hand ?s - tool)
					(wood-state ?w - wood ?l - location ?c - color ?s - shape)
					(can-upgrade ?rsO ?rsN - robot-state)
					(table-s ?ts - table-state)
					(table-count-incr ?ts ?tsN - table-state)
					(table-count-decr ?ts ?tsN - table-state)
		)
	(:functions	
		(total-cost)
		(cut-cost ?rs - robot-state)
		(paint-cost ?rs - robot-state)
		(lay-cost ?rs - robot-state)
		(upgrade-cost ?rs - robot-state)
		)
	(:action move-wood-at-table
		:parameters (?w - wood ?from - location ?s - shape ?c - color ?rs - robot-state ?ts ?tsN - table-state)
		:precondition (and (robot-s ?rs)
						   (robot-hand nothing)
						   (wood-state ?w ?from ?c ?s)
						   (table-s ?ts)
						   (table-count-incr ?ts ?tsN))
		:effect (and (wood-state ?w table ?c ?s)
					 (not (wood-state ?w ?from ?c ?s))
					 (increase (total-cost) (lay-cost ?rs))
					 (table-s ?tsN)
					 (not (table-s ?ts))
					 )
		)
	(:action move-wood-from-table
		:parameters (?w - wood ?to - location ?s - shape ?c - color ?rs - robot-state ?ts ?tsN - table-state)
		:precondition (and (robot-s ?rs)
						   (robot-hand nothing)
						   (wood-state ?w table ?c ?s)
						   (table-s ?ts)
						   (table-count-decr ?ts ?tsN))
		:effect (and (wood-state ?w ?to ?c ?s)
					 (not (wood-state ?w table ?c ?s))
					 (increase (total-cost) (lay-cost ?rs))
					 (table-s ?tsN)
					 (not (table-s ?ts))
					 )
		)
	(:action grabTool
		:parameters (?tN - tool)
		:precondition (robot-hand nothing)
		:effect (and (robot-hand ?tN)
					 (not (robot-hand nothing))
					 (increase (total-cost) 2))
		)
	(:action layTool
		:parameters (?tN - tool)
		:precondition (robot-hand ?tN)
		:effect (and (robot-hand nothing)
					 (not (robot-hand ?tN))
					 (increase (total-cost) 2))
		)
	(:action cut-wood
		:parameters (?w - wood ?s - shape ?c - color ?rs - robot-state)
		:precondition (and (robot-s ?rs)
						   (wood-state ?w table ?c raw)
						   (robot-hand saw))	
		:effect (and (wood-state ?w table ?c ?s)
					 (not (wood-state ?w table ?c raw))
					 (increase (total-cost) (cut-cost ?rs)))
		)
	(:action paint-wood
		:parameters (?w - wood ?s - shape ?c - color ?rs - robot-state)
		:precondition (and (robot-s ?rs)
		                   (wood-state ?w table natural ?s)
		                   (robot-hand brush))	
		:effect (and (wood-state ?w table ?c ?s)
					 (not (wood-state ?w table natural ?s))
					 (increase (total-cost) (paint-cost ?rs)))
		)
	 (:action upgrade-robot
	  	:parameters (?rsO ?rsN - robot-state)
	   	:precondition (and (robot-s ?rsO)
	   				       (can-upgrade ?rsO ?rsN))
	   	:effect (and (robot-s ?rsN)
	   				 (not (robot-s ?rsN))
	   				 (increase (total-cost) (upgrade-cost ?rsO))
	   				 )
	   )

)
