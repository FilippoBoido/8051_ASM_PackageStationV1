$INCLUDE(PUBLIC_ACCESS.INC)

__PROCEDURES SEGMENT CODE 
RSEG __PROCEDURES

;----------------------------------------------------------------------------------------
;Main Sub-Routines						   	
;----------------------------------------------------------------------------------------

	
PUBLIC _stop_elevator
PUBLIC _stop_conveyors
PUBLIC _start_light
PUBLIC _stop_light
PUBLIC _init_message_segment
PUBLIC _home  
PUBLIC _new_cycle
PUBLIC _timer_long_delay
PUBLIC _timer_operation
PUBLIC _debug_delayer
PUBLIC _serial_send_char
PUBLIC _serial_send_string
PUBLIC _send_message
PUBLIC _wait_end_cycle
PUBLIC _cycle_start
PUBLIC _serial_com
PUBLIC _init
	
;----------------------------------------------------------------------------------------
;Application is run cyclically every 1ms
;----------------------------------------------------------------------------------------

_cycle_start:


	;Zeit zurücksetzen					
	clr 	tr0					
	;1ms cycle					
	mov 	tl0, #0BFh
	mov 	th0, #0FCh
	clr 	tf0
	;starte den Timer
	setb	tr0
	
ret

;----------------------------------------------------------------------------------------
;Wait here for the end of the cycle	
;----------------------------------------------------------------------------------------

_wait_end_cycle:

	;check if tf0 is already set before starting the wait_end_cycle loop
	;if tf0 is alread set it means that we have exceeded the cyle limit
	;this will set the cycleTimeError and stop the machine
	jnb		tf0, end_cycle_loop
	;else 
	setb	cycleTimeError
	
	end_cycle_loop:
	
	acall 	_serial_com
	;wait until the overflow bit is not set. 
	jnb		tf0, end_cycle_loop

ret

;----------------------------------------------------------------------------------------
;INIT procedure
;----------------------------------------------------------------------------------------

_init:

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
	acall	_init_timers
	
	
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
	
ret

;----------------------------------------------------------------------------------------
;Timer initialization
;----------------------------------------------------------------------------------------

_init_timers:

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
ret

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
;SERIAL_COM						   	
;----------------------------------------------------------------------------------------

_serial_com:

	jnb		serialBusy, end_serial_com
	acall 	_serial_send_string
	end_serial_com:
	
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