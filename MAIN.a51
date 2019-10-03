$INCLUDE(PUBLIC_ACCESS.INC)
$INCLUDE(PUBLIC_PROCEDURES.INC)


__MAIN SEGMENT CODE 
RSEG __MAIN
	
acall _init
	
start_main:

	acall	_cycle_start
	
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
	
	jmp		end_main 

check_cycle:
	
	acall	_stop_conveyors
	mov		r0, #errCycleDelayCounter
	acall	_timer_operation
	cjne	r2, #0d, end_check_cycle
	cpl		redLight
	
	end_check_cycle:
	
		jmp		end_main
	
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
	jmp		end_main
	
	
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
	jmp		end_main
	
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
	
		jmp		end_main
	
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
	
		jmp		end_main
	
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
	
		jmp		end_main
	
pallet_on_route:

	jnb		pallElevFrontLimit,	end_pallet_on_route
	;palletizer front limit reached
	
	clr		elevatorForw
	mov		r0, #palletizerDelayCounter
	call	_timer_long_delay
	cjne	r2, #0d, end_main
	clr 	palletizerChainForw
	setb	palletOnRoute
	
		end_pallet_on_route:
		jmp		end_main
	
pallet_in_palletizer:

	;setb	palletizerChainBack
	;clr	palletizerChainBack
	setb	palletInPalletizer
	jmp		end_main
	
pallet_in_upper_pos:

	setb	palletizerElevatorUp
	setb	palletizerElevMoveLimit
	mov		r0, #palletizerDelayCounter2
	call	_timer_long_delay
	cjne	r2, #0d, end_main
	
	clr		palletizerElevatorUp
	clr		palletizerElevMoveLimit
	setb	palletInUpperPos
	setb	handshakeAllowOpen
	
	jmp		end_main

op_thread_2_part_2:

	jnb		packageOnPallet, package_on_pallet
	jnb		palletInLowerPos, pallet_in_lower_pos
	jnb		palletExiting, pallet_exiting
	jnb		palletExited, pallet_exited
	jnb		palletProcessEnd, pallet_process_end
	
	jmp		end_main
	
	
package_on_pallet:

	jb		handshakeAllowOpen, end_main
	mov		r0, #palletizerDelayCounter5
	call	_timer_long_delay
	cjne	r2, #0d, end_main
	setb	packageOnPallet
	
	jmp		end_main
	
pallet_in_lower_pos:

	setb	palletizerElevatorDown
	setb	palletizerElevMoveLimit
	
	mov		r0, #palletizerDelayCounter6
	call	_timer_long_delay
	cjne	r2, #0d, end_main
	
	clr		palletizerElevatorDown
	clr		palletizerElevMoveLimit
	setb	handshakeAllowClose
	setb	palletInLowerPos
	
	jmp		end_main
	
pallet_exiting:

	setb	startRollerConveyors
	setb	palletizerChainForw
	jb		pallElevFrontLimit, end_main
	setb	palletExiting
	jmp		end_main
	
pallet_exited:
	
	mov		r0, #rollerConvDelayCounter
	call	_timer_long_delay
	cjne	r2, #0d, end_main
	setb	palletExited
	jmp		end_main
	
pallet_process_end:

	acall	_new_cycle
	jmp		end_main
	
;----------------------------------------------------------------------------------------
;Main application ends here				   	
;----------------------------------------------------------------------------------------
end_main:
	
	acall	_wait_end_cycle
	ajmp 	start_main

END