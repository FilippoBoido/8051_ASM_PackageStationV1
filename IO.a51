;inputs
PUBLIC safetyOK				
PUBLIC palletizerElevMoving	
PUBLIC pallElevBackLimit		
PUBLIC pallElevFrontLimit		
PUBLIC elevatorRightLimit		
PUBLIC elevatorLeftLimit		
PUBLIC startButton				
;Retroreflective Sensor
PUBLIC packageDetected			
;outputs
PUBLIC startConveyors 			
PUBLIC palletizerChainBack		
PUBLIC palletizerChainForw		
PUBLIC palletizerConvBack		
PUBLIC palletizerConvForw		
PUBLIC palletizerOpen			
PUBLIC palletizerClamp			
PUBLIC palletizerElevatorDown	
PUBLIC palletizerElevatorUp	
PUBLIC palletizerPush			
PUBLIC palletizerElevMoveLimit	
PUBLIC startRollerConveyors	
PUBLIC emitter1				
PUBLIC emitter2				
PUBLIC greenLight				
PUBLIC redLight				
PUBLIC yellowLight				
PUBLIC warning					
PUBLIC siren					
PUBLIC elevatorUp				
PUBLIC elevatorDown			
PUBLIC elevatorBack			
PUBLIC elevatorForw			
PUBLIC startButtonLight		
;inputs
safetyOK				equ		p0.0
palletizerElevMoving	equ		p0.1
pallElevBackLimit		equ		p0.2
pallElevFrontLimit		equ		p0.3
elevatorRightLimit		equ		p0.4
elevatorLeftLimit		equ		p0.5
startButton				equ		p0.6
;Retroreflective Sensor
packageDetected			equ		p0.7
;outputs
startConveyors 			equ 	p1.0
palletizerChainBack		equ		p1.1
palletizerChainForw		equ		p1.2
palletizerConvBack		equ		p1.3
palletizerConvForw		equ		p1.4
palletizerOpen			equ		p1.5
palletizerClamp			equ		p1.6
palletizerElevatorDown	equ		p1.7
palletizerElevatorUp	equ		p2.0
palletizerPush			equ		p2.1
palletizerElevMoveLimit	equ		p2.2
startRollerConveyors	equ		p2.3
emitter1				equ		p2.4
emitter2				equ		p2.5
greenLight				equ		p2.6
redLight				equ		p2.7
yellowLight				equ		p3.0
warning					equ		p3.1
siren					equ		p3.2
elevatorUp				equ		p3.3
elevatorDown			equ		p3.4
elevatorBack			equ		p3.5
elevatorForw			equ		p3.6
startButtonLight		equ		p3.7

END
