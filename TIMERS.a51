
PUBLIC homeDelayCounter 		
PUBLIC homeDesiredDelay		
PUBLIC homeLoopCounter			
PUBLIC homeDesiredLoop			

PUBLIC errCycleDelayCounter 	
PUBLIC errCycleDesiredDelay	

PUBLIC elevatorDelayCounter	
PUBLIC elevatorDesiredDelay	
PUBLIC elevatorLoopCounter		
PUBLIC elevatorDesiredLoop		

PUBLIC elevatorDelayCounter2	
PUBLIC elevatorDesiredDelay2	
PUBLIC elevatorLoopCounter2	
PUBLIC elevatorDesiredLoop2	
 
PUBLIC palletizerDelayCounter	
PUBLIC palletizerDesiredDelay	
PUBLIC palletizerLoopCounter	
PUBLIC palletizerDesiredLoop	
 
PUBLIC palletizerDelayCounter2 
PUBLIC palletizerDesiredDelay2	
PUBLIC palletizerLoopCounter2	
PUBLIC palletizerDesiredLoop2	

PUBLIC palletizerDelayCounter3 
PUBLIC palletizerDesiredDelay3	
PUBLIC palletizerLoopCounter3	
PUBLIC palletizerDesiredLoop3	

PUBLIC palletizerDelayCounter4 
PUBLIC palletizerDesiredDelay4	
PUBLIC palletizerLoopCounter4	
PUBLIC palletizerDesiredLoop4	

PUBLIC palletizerDelayCounter5 
PUBLIC palletizerDesiredDelay5	
PUBLIC palletizerLoopCounter5	
PUBLIC palletizerDesiredLoop5	

PUBLIC palletizerDelayCounter6 
PUBLIC palletizerDesiredDelay6	
PUBLIC palletizerLoopCounter6	
PUBLIC palletizerDesiredLoop6	

PUBLIC palletizerDelayCounter7 
PUBLIC palletizerDesiredDelay7	
PUBLIC palletizerLoopCounter7	
PUBLIC palletizerDesiredLoop7	

PUBLIC rollerConvDelayCounter  
PUBLIC rollerConvDesiredDelay	
PUBLIC rollerConvLoopCounter	
PUBLIC rollerConvDesiredLoop	

;----------------------------------------------------------------------------------------
;2/4 bytes timers	- Starting from adress 50h
;----------------------------------------------------------------------------------------

homeDelayCounter 		equ 	50h
homeDesiredDelay		equ		51h	
homeLoopCounter			equ		52h
homeDesiredLoop			equ		53h

errCycleDelayCounter 	equ 	54h
errCycleDesiredDelay	equ		55h

elevatorDelayCounter	equ		56h
elevatorDesiredDelay	equ		57h
elevatorLoopCounter		equ		58h
elevatorDesiredLoop		equ		59h

elevatorDelayCounter2	equ		5Ah
elevatorDesiredDelay2	equ		5Bh
elevatorLoopCounter2	equ		5Ch
elevatorDesiredLoop2	equ		5Dh

palletizerDelayCounter	equ		5Eh
palletizerDesiredDelay	equ		5Fh
palletizerLoopCounter	equ		60h
palletizerDesiredLoop	equ		61h

palletizerDelayCounter2 equ		62h
palletizerDesiredDelay2	equ		63h
palletizerLoopCounter2	equ		64h
palletizerDesiredLoop2	equ		65h

palletizerDelayCounter3 equ		66h
palletizerDesiredDelay3	equ		67h
palletizerLoopCounter3	equ		68h
palletizerDesiredLoop3	equ		69h

palletizerDelayCounter4 equ		6Ah
palletizerDesiredDelay4	equ		6Bh
palletizerLoopCounter4	equ		6Ch
palletizerDesiredLoop4	equ		6Dh

palletizerDelayCounter5 equ		6Eh
palletizerDesiredDelay5	equ		6Fh
palletizerLoopCounter5	equ		70h
palletizerDesiredLoop5	equ		71h

palletizerDelayCounter6 equ		72h
palletizerDesiredDelay6	equ		73h
palletizerLoopCounter6	equ		74h
palletizerDesiredLoop6	equ		75h

palletizerDelayCounter7 equ		76h
palletizerDesiredDelay7	equ		77h
palletizerLoopCounter7	equ		78h
palletizerDesiredLoop7	equ		79h

rollerConvDelayCounter  equ		7Ah
rollerConvDesiredDelay	equ		7Bh
rollerConvLoopCounter	equ		7Ch
rollerConvDesiredLoop	equ		7Dh
	
end