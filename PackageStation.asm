;----------------------------------------------------------------------------------------
;DB

;----------------------------------------------------------------------------------------

ORG 1000h
mes_seg1_1:	DB "Conveyors started\r\n",0
mes_seg1_2:	DB "Capacity reached\r\n",0
mes_seg1_3:	DB "Packages in position\r\n",0
mes_seg1_4:	DB "Pushing packages\r\n",0
mes_seg1_5:	DB "Clamping packages\r\n",0
mes_seg1_6:	DB "Unclamping packages\r\n",0
;mes_seg1_7:	DB "Hello World message 7",0
;mes_seg1_8:	DB "Hello World message 8",0	

ORG 0h
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
;Messaging memory 	- Starting form address 40h to 4Fh 
;----------------------------------------------------------------------------------------

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

;----------------------------------------------------------------------------------------
;constants
;----------------------------------------------------------------------------------------

cMaxCapacity			equ		3d

	

;----------------------------------------------------------------------------------------
;Init stage
;----------------------------------------------------------------------------------------

init:

	;set port A as input
	mov 	p0, #0FFh
	mov		p1, #00h
	mov		p2, #00h
	mov		p3, #00h
	
	;for serial communication
	setb 	p3.1
	setb	p3.0
	
	acall	_new_cycle
	acall	_init_message_segment
	;setup timers
	
	;8s
	mov		homeDelayCounter, #0d	
	mov		homeDesiredDelay, #250d
	mov		homeLoopCounter, #0d
	mov		homeDesiredLoop, #32d
	
	;100ms
	mov		errCycleDelayCounter, #00h
	mov		errCycleDesiredDelay, #100d
	
	;1s
	mov		elevatorDelayCounter, #0d
	mov		elevatorDesiredDelay, #250d
	mov		elevatorLoopCounter, #0d
	mov		elevatorDesiredLoop, #40d
	
	;2s
	mov		elevatorDelayCounter2, #0d
	mov		elevatorDesiredDelay2, #250d
	mov		elevatorLoopCounter2, #0d
	mov		elevatorDesiredLoop2, #8d
	
	;250ms
	mov		palletizerDelayCounter, #0d
    mov     palletizerDesiredDelay, #250d
    mov     palletizerLoopCounter, #0d
    mov     palletizerDesiredLoop,	#1d

	;5s
	mov		palletizerDelayCounter2, #0d
    mov		palletizerDesiredDelay2, #250d
    mov		palletizerLoopCounter2, #0d	
    mov		palletizerDesiredLoop2, #20d	
	
	;5,5s
	mov		palletizerDelayCounter3, #0d
	mov		palletizerDesiredDelay3, #250d	
	mov		palletizerLoopCounter3,	#0d
	mov		palletizerDesiredLoop3,	#22d
	
	;2s
	mov		palletizerDelayCounter4, #0d
    mov		palletizerDesiredDelay4, #250d
    mov		palletizerLoopCounter4, #0d	
    mov		palletizerDesiredLoop4, #8d	
	
	;1s
	mov		palletizerDelayCounter5, #0d
	mov		palletizerDesiredDelay5, #250d	
	mov		palletizerLoopCounter5,	#0d
	mov		palletizerDesiredLoop5,	#12d
	
	;5s
	mov		palletizerDelayCounter6, #0d
    mov		palletizerDesiredDelay6, #250d
    mov		palletizerLoopCounter6, #0d	
    mov		palletizerDesiredLoop6, #20d
	
	;2s
	mov		palletizerDelayCounter7, #0d
	mov		palletizerDesiredDelay7, #250d
	mov		palletizerLoopCounter7,	#0d
	mov		palletizerDesiredLoop7,	#4d
	
	;6s
	mov		rollerConvDelayCounter, #0d  
	mov		rollerConvDesiredDelay, #250d	
	mov		rollerConvLoopCounter, #0d	
	mov		rollerConvDesiredLoop, #12d	
	
	
	;8-bit 1Stop REN-enabled
	mov		scon, #52h
	orl		pcon, #80h
	anl		tmod, #0
	orl		tmod, #1
	;set mode 2 and auto reload function 
	orl		tmod, #20h
	;value for baud rate
	mov		th1, #245
	;start timer 1 for serial com
	setb	tr1
	;----------------------------------------------------------------------------------------
	;debug
	;----------------------------------------------------------------------------------------
	;setb	palletSent
	;setb	cycleTimeError
	
;----------------------------------------------------------------------------------------
;Application is run cyclically every 1ms
;----------------------------------------------------------------------------------------

cycle_start:


	;Zeit zurücksetzen					
	clr 	tr0					
	;1ms cycle					
	mov 	tl0, #0BFh
	mov 	th0, #0FCh
	clr 	tf0
	;starte den Timer
	setb	tr0

;----------------------------------------------------------------------------------------
;Main					   	
;----------------------------------------------------------------------------------------

checks:
	
	
	;check if cycle time has been exceeded
	jb		cycleTimeError, check_cycle	
	;start machine operation if startButton is set
	jb		startButton, check_start
	;else stop machine operation
		
	acall	_stop_conveyors
	acall	_stop_light
	acall	_stop_elevator
	
	clr		homed
	
	jmp		serial_com 

check_cycle:
	
	acall	_stop_conveyors
	mov		r0, #errCycleDelayCounter
	acall	_timer_operation
	cjne	r2, #0d, end_check_cycle
	cpl		redLight
	
	end_check_cycle:
	
		jmp		serial_com
	
check_start:
	;send serial message:
	
	;01h stands for the first string in the segment memory
	;02h stands for the second string 04h for the third...
	;mov 	r3, #01h
	;mov the address of desired segment memory into r0
	;mov		r0, #mesSegment1
	;mov the address of desired message into dptr

	;acall	_send_message
	;home if not homed
	jnb		homed, check_homing
	;else start machine operation
	jmp		op_thread_1

check_homing:	

	acall	_home
	jmp		serial_com
	
	
;Execution chain for machine part 1
;->BeltConveyors and Palletizer
op_thread_1:
	
	;switch-case

	;if the conveyors are not already started goto OperationThread1 Stage1
	jnb		conveyorsStarted, start_conveyors 		
	;else if the detected packages < cMaxCapacity goto OperationThread1 Stage2
	jnb		capacityReached, capacity_reached 
	;else wait for the packages to be in the right position
	jnb		packagesInPos, packages_in_pos
	jnb		pushPackages, push_packages
	jnb		clampPackages, clamp_packages
	
	;Execution chain for machine part 2	
	jmp		op_thread_1_part_2
	
start_conveyors:
	
	;setb	conveyorsStarted
	acall	_start_light
	setb	startConveyors
	setb	conveyorsStarted
	setb	palletizerConvForw
	
	mov		dptr, #mes_seg1_1
	setb	serialSend
	acall	_serial_send_string
	
	;goto next execution chain	
	jmp		op_thread_2 
	
capacity_reached:
	
	jnb		fallingFlank, capacity_reached_sub_1
	;else falling edge was detected cycle before, now wait for rising edge
	jnb		packageDetected, end_capacity_reached 
	clr		fallingFlank
	jmp		end_capacity_reached
	
	capacity_reached_sub_1:
		;wait for a falling flank (retroreflective sensor)	
		jb		packageDetected, end_capacity_reached
		;falling flank detected
		setb	fallingFlank
		inc		packagesDetected
	
		mov		A, packagesDetected
		cjne	A, #cMaxCapacity, end_capacity_reached
		
		setb	capacityReached
		
		mov		dptr, #mes_seg1_2
		setb	serialSend
		acall	_serial_send_string
		
		jmp 	end_capacity_reached
	
	end_capacity_reached:
		;goto next execution chain
		jmp		op_thread_2
		

packages_in_pos:
	
	mov		r0, #palletizerDelayCounter3
	call	_timer_long_delay
	cjne	r2, #0d, end_packages_in_pos
	
	setb	packagesInPos
	
	mov		dptr, #mes_seg1_3
	setb	serialSend
	acall	_serial_send_string
	
	clr		startConveyors
	clr		palletizerConvForw
	
	end_packages_in_pos:
		jmp		op_thread_2

push_packages:

	setb	palletizerPush
	mov		r0, #palletizerDelayCounter4
	call	_timer_long_delay
	cjne	r2, #0d, op_thread_2
	clr		palletizerPush
	setb	pushPackages
	
	mov		dptr, #mes_seg1_4
	setb	serialSend
	acall	_serial_send_string
	
	jmp		op_thread_2

clamp_packages:

	setb	palletizerClamp
	mov		r0, #palletizerDelayCounter7
	call	_timer_long_delay
	cjne	r2, #0d, op_thread_2
	setb	clampPackages
	
	mov		dptr, #mes_seg1_5
	setb	serialSend
	acall	_serial_send_string
	
	jmp		op_thread_2
	
		
op_thread_1_part_2:

	jnb		unclampPackages, unclamp_packages
	clr		secondWave
	jnb		openPalletizerPort, open_palletizer_port
	jnb		closePalletizerPort, close_palletizer_port
	jmp 	op_thread_2
	
unclamp_packages:

	mov		r0, #palletizerDelayCounter7
	call	_timer_long_delay
	cjne	r2, #0d, op_thread_2
	jb		secondWave, end_unclamp_packages
	
	clr		palletizerClamp
	clr 	capacityReached
	clr		packagesInPos
	clr		pushPackages
	clr		clampPackages
	clr		conveyorsStarted
	;reset package count
	mov		packagesDetected, #00h
	setb	secondWave
	jmp		op_thread_2
	
	end_unclamp_packages:
		setb	unclampPackages
		
		mov		dptr, #mes_seg1_6
		setb	serialSend
		acall	_serial_send_string
		
		;setb	yellowLight
		jmp		op_thread_2		
		
open_palletizer_port:

	jnb		handshakeAllowOpen, op_thread_2
	setb	palletizerOpen
	clr		handshakeAllowOpen
	setb	openPalletizerPort
	jmp		op_thread_2
	
close_palletizer_port:
	
	jnb		handshakeAllowClose, op_thread_2
	clr		palletizerOpen
	;clr		yellowLight
	clr		palletizerClamp
	setb	closePalletizerPort
	jmp		op_thread_2
;Execution chain for machine part 2	
;->RollerConveyors and Elevator
op_thread_2:

	;switch-case
	jnb		palletProcessStart,	pallet_process_start
	jnb		palletPickedUp,	pallet_picked_up
	jnb		palletInElevator, pallet_in_elevator
	jnb		palletSent, pallet_sent
	jnb		palletOnRoute, pallet_on_route
	jnb		palletInPalletizer, pallet_in_palletizer
	jnb		palletInUpperPos, pallet_in_upper_pos
	
	;Start all over again
	jmp		op_thread_2_part_2	
	
	
pallet_process_start:

	setb	palletProcessStart	
	jmp		serial_com
	
pallet_picked_up:

	setb 	elevatorUp	
	;wait x time for the elevator to come in upper position
	mov		r0, #elevatorDelayCounter
	call	_timer_long_delay
	cjne	r2, #0d, end_pallet_picked_up
	;if time is up set/reset bits 
	setb	palletPickedUp
	setb	emitter2
	clr		elevatorUp
	
	end_pallet_picked_up:
	
		jmp		serial_com
	
pallet_in_elevator:

	;wait x time for the pallet to position itself on the elevator
	mov		r0, #elevatorDelayCounter2
	call	_timer_long_delay
	cjne	r2, #0d, end_pallet_in_elevator
	;if time is up set/reset bits 
	setb	palletInElevator
	setb	palletPickedUp
	clr		emitter2
	
	end_pallet_in_elevator:
	
		jmp		serial_com
	
pallet_sent:

	;wait for the elevator to move down
	setb	elevatorDown
	
	mov		r0, #elevatorDelayCounter
	call	_timer_long_delay
	cjne	r2, #0d, end_pallet_sent
	
	setb	palletSent
	setb	elevatorForw
	setb	startRollerConveyors
	setb	palletizerChainForw
	clr		elevatorDown
	
	end_pallet_sent:
	
		jmp		serial_com
	
pallet_on_route:

	jnb		pallElevFrontLimit,	end_pallet_on_route
	;palletizer front limit reached
	
	clr		elevatorForw
	mov		r0, #palletizerDelayCounter
	call	_timer_long_delay
	cjne	r2, #0d, serial_com
	clr 	palletizerChainForw
	setb	palletOnRoute
	
		end_pallet_on_route:
		jmp		serial_com
	
pallet_in_palletizer:

	;setb	palletizerChainBack
	;clr	palletizerChainBack
	setb	palletInPalletizer
	jmp		serial_com
	
pallet_in_upper_pos:

	setb	palletizerElevatorUp
	setb	palletizerElevMoveLimit
	mov		r0, #palletizerDelayCounter2
	call	_timer_long_delay
	cjne	r2, #0d, serial_com
	
	clr		palletizerElevatorUp
	clr		palletizerElevMoveLimit
	setb	palletInUpperPos
	setb	handshakeAllowOpen
	
	jmp		serial_com

op_thread_2_part_2:

	jnb		packageOnPallet, package_on_pallet
	jnb		palletInLowerPos, pallet_in_lower_pos
	jnb		palletExiting, pallet_exiting
	jnb		palletExited, pallet_exited
	jnb		palletProcessEnd, pallet_process_end
	
	jmp		serial_com
	
	
package_on_pallet:

	jb		handshakeAllowOpen, serial_com
	mov		r0, #palletizerDelayCounter5
	call	_timer_long_delay
	cjne	r2, #0d, serial_com
	setb	packageOnPallet
	
	jmp		serial_com
	
pallet_in_lower_pos:

	setb	palletizerElevatorDown
	setb	palletizerElevMoveLimit
	
	mov		r0, #palletizerDelayCounter6
	call	_timer_long_delay
	cjne	r2, #0d, serial_com
	
	clr		palletizerElevatorDown
	clr		palletizerElevMoveLimit
	setb	handshakeAllowClose
	setb	palletInLowerPos
	
	jmp		serial_com
	
pallet_exiting:

	setb	startRollerConveyors
	setb	palletizerChainForw
	jb		pallElevFrontLimit, serial_com
	setb	palletExiting
	jmp		serial_com
	
pallet_exited:
	
	mov		r0, #rollerConvDelayCounter
	call	_timer_long_delay
	cjne	r2, #0d, serial_com
	setb	palletExited
	jmp		serial_com
	
pallet_process_end:

	acall	_new_cycle
	jmp		serial_com
	
;----------------------------------------------------------------------------------------
;Main application ends here				   	
;----------------------------------------------------------------------------------------

;----------------------------------------------------------------------------------------
;Serial communication
;----------------------------------------------------------------------------------------
serial_com:

	jnb		serialBusy, wait_end_cycle
	acall 	_serial_send_string
	jmp		wait_end_cycle


;----------------------------------------------------------------------------------------
;Wait here for the end of the cycle	
;----------------------------------------------------------------------------------------

wait_end_cycle:

	;check if tf0 is already set before starting the wait_end_cycle loop
	;if tf0 is alread set it means that we have exceeded the cyle limit
	;this will set the cycleTimeError and stop the machine
	jnb		tf0, end_cycle_loop
	;else 
	setb	cycleTimeError
	
	end_cycle_loop:
	;wait until the overflow bit is not set. 
	jnb		tf0, end_cycle_loop
	
	jmp 	cycle_start

;----------------------------------------------------------------------------------------
;Main Sub-Routines						   	
;----------------------------------------------------------------------------------------

;----------------------------------------------------------------------------------------

_stop_elevator:

	clr		elevatorUp
	clr		elevatorDown
	clr		elevatorForw
	
ret

;----------------------------------------------------------------------------------------

_stop_conveyors:
	
	clr		startConveyors
	clr		startRollerConveyors
	clr		palletizerConvForw
		
ret

;----------------------------------------------------------------------------------------

_start_light:

	setb	greenLight
	clr		redLight
	
ret

;----------------------------------------------------------------------------------------

_stop_light:

	clr		greenLight
	setb	redLight
	
ret

;----------------------------------------------------------------------------------------

_init_message_segment:

	mov		mesSegment1, #0d		
	mov		mesSegment2, #0d		
	mov		mesSegment3, #0d		
	mov		mesSegment4, #0d		
	mov		mesSegment5, #0d		
	mov		mesSegment6, #0d		
	mov		mesSegment7, #0d		
	mov		mesSegment8, #0d		
	mov		mesSegment9, #0d		
	mov		mesSegment10, #0d	
	
ret

;----------------------------------------------------------------------------------------

_home:
	
	jb		homed, ret_home
		
	clr		startConveyors
	clr		greenLight
	clr		redLight
	;clr		yellowLight
		
	jnb		palletSent, sub_home_1
	;else if a pallet has already been sent run the roller conveyors for x time
	setb	startRollerConveyors
	
	;wait 8 seconds and then stop the RollerConveyors
	mov		r0, #homeDelayCounter
	acall	_timer_long_delay
	;jmp if return value is not 0 (done)
	cjne	r2, #00h, ret_home
	
	;8 seconds are now over
	clr		palletSent
	
	sub_home_1:
	
		clr		startRollerConveyors
		setb	homed
		
	ret_home:
		
ret
;----------------------------------------------------------------------------------------
_new_cycle:
	
	;reset bit memory
	mov		20h, #00h
	mov		21h, #00h
	mov		22h, #00h
	mov		23h, #00h
	;reset package count
	mov		packagesDetected, #00h

ret
;----------------------------------------------------------------------------------------
;Utilities
;----------------------------------------------------------------------------------------

_timer_long_delay:

	acall	_timer_operation
	;if return value <> 0 jmp to busy
	
	cjne	r2, #0d, ret_tld_busy
	;else point to loop counter 
	inc		r0
	
	acall	_timer_operation
						
	ret_tld_busy:
	
ret

_timer_operation:

	;reset return value
	mov 	r2, #0d
	;increase delay counter
	inc		@r0
	;mov delay counter to Acc
	mov		A, @r0
	;increase r0 address and point to desired delay
	inc		r0
	mov		timerBuffer, @r0
	;jmp if delay counter and desired delay not equal
	cjne	A, timerBuffer, ret_top_busy
	;decrease pointer address and point to delay counter again
	dec		r0
	;reset delay counter
	mov		@r0, #00h
	;point to desired delay
	inc		r0
	
	jmp		ret_top_done
	
	ret_top_busy:
		;return value 1 means busy
		mov r2, #1d
		
	ret_top_done:
ret

_debug_delayer:
	;2-cycles
	mov		debugBuffer, #00h
	debug_loop:
		;1-cycle
		inc		debugBuffer
		;1-cycle
		mov		A, debugBuffer
		;2-cycle
		cjne	A, #250, debug_loop
		; debug_loop 		= 5-cycle * call
		; total				= 5-cycle * 250 	= 1250-cycles + 2-cycles	= 1252-cycles
		; 12-ticks * cycle 	= 12 * 1252			= 15.024-ticks
		; 15.024 / 10Mhz	= 1.5024ms
		; Every time _debug_delayer gets called we have a delay of 1.5024ms
ret

;----------------------------------------------------------------------------------------
;SERIAL_SEND_CHAR						   	
;----------------------------------------------------------------------------------------

_serial_send_char:

	jnb		ti, end_send_char
		
	mov		sbuf, A	
	clr		ti
	inc		serialCounter
	end_send_char:
	
ret


;----------------------------------------------------------------------------------------
;SERIAL_SEND_STRING						   	
;----------------------------------------------------------------------------------------

_serial_send_string:

	jnb		serialSend, end_serial_out
	jb		serialBusy, serial_out
	clr		A
	mov		serialCounter, #0d
	
	serial_out:

		
		mov		A, serialCounter
		movc	A, @A+DPTR
		
		clr		serialBusy
		clr		serialSend
		
		jz		end_serial_out
		
		setb	serialBusy
		setb	serialSend
		
		call     _serial_send_char
	
	end_serial_out:

ret

;----------------------------------------------------------------------------------------

;----------------------------------------------------------------------------------------
;Send message						   	
;----------------------------------------------------------------------------------------

_send_message:
;copy the segment memory bit to check into A
	mov 	A, r3
	;check if message has been already sent
	anl		A, @r0
	;if A is not zero then the message has been sent
	jnz		end_send_message
	;else
	
	;set the message as sent
	mov 	A, r3		
	orl		A, @r0
	mov		@r0, A
	setb	serialSend
	acall	_serial_send_string
	
	end_send_message:
	;send the message
ret

END
