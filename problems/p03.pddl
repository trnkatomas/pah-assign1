(define (problem p)
	(:domain trnkato2-assign1)
	(:objects
		w1 w2 w3 w4 - wood
		pile finished-pile table - location
		basic advanced expert - robot-state
		triangle square circle hexagon raw - shape
		red blue yellow natural - color
		saw brush nothing - tool
		empty half-full full - table-state
	)
	(:init
		(= (total-cost) 0)
		(= (cut-cost basic) 24)
		(= (paint-cost basic) 36)
		(= (lay-cost basic) 12)
		(= (cut-cost advanced) 18)
		(= (paint-cost advanced) 27)
		(= (lay-cost advanced) 9)
		(= (cut-cost expert) 12)
		(= (paint-cost expert) 18)
		(= (lay-cost expert) 6)
		(= (lay-cost expert) 6)
		(= (upgrade-cost basic) 40)
		(= (upgrade-cost advanced) 70)
		(table-count-incr empty half-full)
		(table-count-incr half-full full)
		(table-count-decr full half-full)
		(table-count-decr half-full empty)
		(can-upgrade basic advanced)
		(can-upgrade advanced expert)
		(robot-hand nothing)
		(robot-s basic)	
		(table-s empty)	

		(wood-state w1 pile natural raw)
		(wood-state w2 pile natural raw)
		(wood-state w3 pile natural raw)
		(wood-state w4 pile natural raw)
		)		
	(:goal
		(and 
			(wood-state w1 finished-pile red hexagon)
			(wood-state w2 finished-pile blue triangle)
			(wood-state w3 finished-pile yellow circle)
			(wood-state w4 finished-pile blue circle)
			)
	)
	(:metric minimize (total-cost))
)