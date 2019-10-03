;----------------------------------------------------------------------------------------
;Access to bit memory						   	
;----------------------------------------------------------------------------------------

EXTRN BIT (cycleTimeError)
EXTRN BIT (capacityReached)			
EXTRN BIT (fallingFlank)			
EXTRN BIT (packagesInPos)			
EXTRN BIT (homed)								
EXTRN BIT (errCycleTimerStarted)	
EXTRN BIT (palletSent)				
EXTRN BIT (palletExited)			
EXTRN BIT (palletPickedUp)			
EXTRN BIT (palletProcessStart)		
EXTRN BIT (palletProcessEnd)		
EXTRN BIT (palletInElevator)		
EXTRN BIT (palletInPalletizer)		
EXTRN BIT (palletOnRoute)			
EXTRN BIT (palletExiting)			
EXTRN BIT (palletInUpperPos)		
EXTRN BIT (openPalletizerPort)		
EXTRN BIT (pushPackages)			
EXTRN BIT (handshakeAllowOpen)		
EXTRN BIT (handshakeAllowClose)		
EXTRN BIT (packageOnPallet)			
EXTRN BIT (closePalletizerPort)		
EXTRN BIT (palletInLowerPos)	
EXTRN BIT (clampPackages)			
EXTRN BIT (unclampPackages)			
EXTRN BIT (conveyorsStarted)		
EXTRN BIT (secondWave)				
EXTRN BIT (serialBusy)				
EXTRN BIT (serialSend)

;----------------------------------------------------------------------------------------
;Access to io						   	
;----------------------------------------------------------------------------------------

EXTRN BIT (safetyOK)		
EXTRN BIT (palletizerElevMoving)	
EXTRN BIT (pallElevBackLimit)		
EXTRN BIT (pallElevFrontLimit)		
EXTRN BIT (elevatorRightLimit)		
EXTRN BIT (elevatorLeftLimit)		
EXTRN BIT (startButton)				
   
EXTRN BIT (packageDetected)			

EXTRN BIT (startConveyors) 			
EXTRN BIT (palletizerChainBack)		
EXTRN BIT (palletizerChainForw)		
EXTRN BIT (palletizerConvBack)		
EXTRN BIT (palletizerConvForw)		
EXTRN BIT (palletizerOpen)			
EXTRN BIT (palletizerClamp)			
EXTRN BIT (palletizerElevatorDown)	
EXTRN BIT (palletizerElevatorUp)	
EXTRN BIT (palletizerPush)			
EXTRN BIT (palletizerElevMoveLimit)	
EXTRN BIT (startRollerConveyors)	
EXTRN BIT (emitter1)				
EXTRN BIT (emitter2)				
EXTRN BIT (greenLight)				
EXTRN BIT (redLight)				
EXTRN BIT (yellowLight)				
EXTRN BIT (warning)					
EXTRN BIT (siren)
EXTRN BIT (elevatorUp)		
EXTRN BIT (elevatorDown)		
EXTRN BIT (elevatorBack)		
EXTRN BIT (elevatorForw)		
EXTRN BIT (startButtonLight)

;----------------------------------------------------------------------------------------
;Access to byte memory						   	
;----------------------------------------------------------------------------------------	

EXTRN DATA (packagesDetected)	
EXTRN DATA (buffer)			
EXTRN DATA (debugBuffer)		
EXTRN DATA (timerBuffer)		
EXTRN DATA (serialCounter)	
	
;----------------------------------------------------------------------------------------
;Access to message memory						   	
;----------------------------------------------------------------------------------------	

EXTRN DATA (mesSegment1)	
EXTRN DATA (mesSegment2)	
EXTRN DATA (mesSegment3)	
EXTRN DATA (mesSegment4)	
EXTRN DATA (mesSegment5)	
EXTRN DATA (mesSegment6)	
EXTRN DATA (mesSegment7)	
EXTRN DATA (mesSegment8)	
EXTRN DATA (mesSegment9)	
EXTRN DATA (mesSegment10)

;----------------------------------------------------------------------------------------
;Access to timers						   	
;----------------------------------------------------------------------------------------

EXTRN DATA (homeDelayCounter 		 )
EXTRN DATA (homeDesiredDelay		 )
EXTRN DATA (homeLoopCounter			 )
EXTRN DATA (homeDesiredLoop			 )
EXTRN DATA (errCycleDelayCounter 	 )
EXTRN DATA (errCycleDesiredDelay	 )
EXTRN DATA (elevatorDelayCounter	 )
EXTRN DATA (elevatorDesiredDelay	 )
EXTRN DATA (elevatorLoopCounter		 )
EXTRN DATA (elevatorDesiredLoop		 )
EXTRN DATA (elevatorDelayCounter2	 )
EXTRN DATA (elevatorDesiredDelay2	 )
EXTRN DATA (elevatorLoopCounter2	 )
EXTRN DATA (elevatorDesiredLoop2	 )
EXTRN DATA (palletizerDelayCounter	 )
EXTRN DATA (palletizerDesiredDelay	 )
EXTRN DATA (palletizerLoopCounter	 )
EXTRN DATA (palletizerDesiredLoop	 )
EXTRN DATA (palletizerDelayCounter2  )
EXTRN DATA (palletizerDesiredDelay2	 )
EXTRN DATA (palletizerLoopCounter2	 )
EXTRN DATA (palletizerDesiredLoop2	 )
EXTRN DATA (palletizerDelayCounter3  )
EXTRN DATA (palletizerDesiredDelay3	 )
EXTRN DATA (palletizerLoopCounter3	 )
EXTRN DATA (palletizerDesiredLoop3	 )
EXTRN DATA (palletizerDelayCounter4  )
EXTRN DATA (palletizerDesiredDelay4	 )
EXTRN DATA (palletizerLoopCounter4	 )
EXTRN DATA (palletizerDesiredLoop4	 )
EXTRN DATA (palletizerDelayCounter5  )
EXTRN DATA (palletizerDesiredDelay5	 )
EXTRN DATA (palletizerLoopCounter5	 )
EXTRN DATA (palletizerDesiredLoop5	 )
EXTRN DATA (palletizerDelayCounter6  )
EXTRN DATA (palletizerDesiredDelay6	 )
EXTRN DATA (palletizerLoopCounter6	 )
EXTRN DATA (palletizerDesiredLoop6	 )
EXTRN DATA (palletizerDelayCounter7  )
EXTRN DATA (palletizerDesiredDelay7	 )
EXTRN DATA (palletizerLoopCounter7	 )
EXTRN DATA (palletizerDesiredLoop7	 )
EXTRN DATA (rollerConvDelayCounter   )
EXTRN DATA (rollerConvDesiredDelay	 )
EXTRN DATA (rollerConvLoopCounter	 )
EXTRN DATA (rollerConvDesiredLoop	 )
	
;----------------------------------------------------------------------------------------
;Access to messages						   	
;----------------------------------------------------------------------------------------

EXTRN CODE (mes_seg1_1               )
EXTRN CODE (mes_seg1_2               )
EXTRN CODE (mes_seg1_3               )
EXTRN CODE (mes_seg1_4               )
EXTRN CODE (mes_seg1_5               )
EXTRN CODE (mes_seg1_6               )
		
;----------------------------------------------------------------------------------------
;Access to constants						   	
;----------------------------------------------------------------------------------------	

EXTRN DATA (cMaxCapacity               )
