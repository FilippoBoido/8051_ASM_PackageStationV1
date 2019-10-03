
PUBLIC capacityReached		
PUBLIC fallingFlank			
PUBLIC packagesInPos		
PUBLIC homed				
PUBLIC cycleTimeError		
PUBLIC errCycleTimerStarted	
PUBLIC palletSent			
PUBLIC palletExited			
PUBLIC palletPickedUp		
PUBLIC palletProcessStart	
PUBLIC palletProcessEnd		
PUBLIC palletInElevator		
PUBLIC palletInPalletizer	
PUBLIC palletOnRoute		
PUBLIC palletExiting		
PUBLIC palletInUpperPos		
PUBLIC openPalletizerPort	
PUBLIC pushPackages			
PUBLIC handshakeAllowOpen	
PUBLIC handshakeAllowClose	
PUBLIC packageOnPallet		
PUBLIC closePalletizerPort	
PUBLIC palletInLowerPos		
PUBLIC clampPackages		
PUBLIC unclampPackages		
PUBLIC conveyorsStarted		
PUBLIC secondWave			
PUBLIC serialBusy			
PUBLIC serialSend			

PUBLIC packagesDetected	
PUBLIC buffer			
PUBLIC debugBuffer		
PUBLIC timerBuffer		
PUBLIC serialCounter

PUBLIC mesSegment1				
PUBLIC mesSegment2				
PUBLIC mesSegment3				
PUBLIC mesSegment4				
PUBLIC mesSegment5				
PUBLIC mesSegment6				
PUBLIC mesSegment7				
PUBLIC mesSegment8				
PUBLIC mesSegment9				
PUBLIC mesSegment10		

	


;----------------------------------------------------------------------------------------
;bit-memory			- Starting from address 20h	to 29h.7
;----------------------------------------------------------------------------------------

capacityReached			equ		20h.1
fallingFlank			equ		20h.2
packagesInPos			equ		20h.3
homed					equ		20h.4
cycleTimeError			equ		20h.5
errCycleTimerStarted	equ		20h.6
palletSent				equ		20h.7
palletExited			equ		21h.0
palletPickedUp			equ		21h.1
palletProcessStart		equ		21h.2
palletProcessEnd		equ		21h.3
palletInElevator		equ		21h.4
palletInPalletizer		equ		21h.5
palletOnRoute			equ		21h.6
palletExiting			equ		21h.7
palletInUpperPos		equ		22h.0
openPalletizerPort		equ		22h.1
pushPackages			equ		22h.2
handshakeAllowOpen		equ		22h.3
handshakeAllowClose		equ		22h.4
packageOnPallet			equ		22h.5
closePalletizerPort		equ		22h.6
palletInLowerPos		equ		22h.7
clampPackages			equ		23h.0
unclampPackages			equ		23h.1
conveyorsStarted		equ		23h.2
secondWave				equ		23h.3
serialBusy				equ		23h.4
serialSend				equ		23h.5
;----------------------------------------------------------------------------------------
;byte-memory		- Starting from adress 30h to 3Fh
;----------------------------------------------------------------------------------------

packagesDetected		equ		30h
buffer					equ		31h
debugBuffer				equ		32h
timerBuffer				equ		33h
serialCounter			equ		34h

;----------------------------------------------------------------------------------------
;Interpretation of the messege segment:
;
;	Message 1 has been sent -> h01
;	Message 2 has been sent -> h02
;	Message 3 has been sent -> h04
;	Message 4 has been sent -> h08
;	Message 5 has been sent -> h10
;	Message 6 has been sent -> h20
;	Message 7 has been sent -> h40
;	Message 8 has been sent -> h80
;
;----------------------------------------------------------------------------------------

mesSegment1				equ		40h
mesSegment2				equ		41h
mesSegment3				equ		42h
mesSegment4				equ		43h
mesSegment5				equ		44h
mesSegment6				equ		45h
mesSegment7				equ		46h
mesSegment8				equ		47h
mesSegment9				equ		48h
mesSegment10			equ		49h

	
END