!classDefinition: #MarsRoverTests category: 'Mars-Rover-Exercise'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 14:51:23'!
test1InitializeMarsRover
	| rover | 
	rover := MarsRover at: 0 @ 0 direction: $N.
	
	self assert: (rover position) equals: 0 @ 0.
	self assert: (rover direction) equals: $N.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 14:53:33'!
test2InitializeRoverAnywhere
	| rover | 
	rover := MarsRover at: 1 @ 0 direction: $S.
	
	self assert: (rover position) equals: 1 @ 0.
	self assert: (rover direction) equals: $S.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:04:25'!
test3RotateClockwise
	| rover | 
	rover := MarsRover at: 1 @ 0 direction: $S.
	
	rover rotateClockwise.
	self assert: (rover direction) equals: $O.
! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:05:08'!
test4RotateCounterClockwise
	| rover | 
	rover := MarsRover at: 1 @ 0 direction: $S.
	
	rover rotateCounterClockwise.
	self assert: (rover direction) equals: $E.
! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:07:58'!
test5MultipleRotation
	| rover | 
	rover := MarsRover at: 1 @ 0 direction: $O.
	
	rover rotateCounterClockwise.
	rover rotateClockwise.
	rover rotateClockwise.	
	
	self assert: (rover direction) equals: $N.
! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:47:27'!
test6MoveForward
	| rover | 
	rover := MarsRover at: 0 @ 0 direction: $E.
	
	rover moveForward.
	
	self assert: rover position equals: 1 @ 0.
! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:51:06'!
test7MoveForwardFromAnywhere
	| rover | 
	rover := MarsRover at: 1 @ 2 direction: $S.
	
	rover moveForward.
	
	self assert: rover position equals: 1 @ 1.
! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 16:09:39'!
test8MoveBackwardsFromAnywhere
	| rover | 
	rover := MarsRover at: 1 @ 2 direction: $S.
	
	rover moveBackwards.
	
	self assert: rover position equals: 1 @ 3.
! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 17:04:12'!
test9ExecuteCommands
	| rover commands | 
	rover := MarsRover at: 0 @ 0 direction: $E.
	
	commands := 'lffrrbxbblllrfff'.
	rover executeCommands: commands.
		
	self assert: rover position equals: 0 @ 3.
	self assert: rover direction equals: $S.! !


!classDefinition: #MarsRover category: 'Mars-Rover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'coordinate directionState commandTable'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!MarsRover methodsFor: 'initialization' stamp: 'natan 10/10/2023 17:03:16'!
initializeAt: aCoordinate direction: aCardinalDirection 
	coordinate := aCoordinate.
	directionState := MarsRoverDirectionState stateFor: aCardinalDirection.
	
	commandTable := Dictionary new.				
	commandTable add: $l->[self rotateCounterClockwise];
				 add: $r->[self rotateClockwise];
				 add: $f->[self moveForward];
				 add: $b->[self moveBackwards].! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:37:40'!
direction
	^directionState direction.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 17:05:40'!
executeCommands: commands 
	
	commands do:[:command | 
		(commandTable at: command ifAbsent:[ [^self] ]) value	].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 16:11:28'!
moveBackwards
	directionState moveBackwards: self.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 16:01:34'!
moveEast
	coordinate := coordinate + (1 @ 0)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 16:07:28'!
moveForward
	directionState moveForward: self! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 16:01:26'!
moveNorth
	coordinate := coordinate + (0 @ 1)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 16:01:21'!
moveSouth
	coordinate := coordinate + (0 @ -1)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 16:01:07'!
moveWest
	coordinate := coordinate + (-1 @ 0)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 14:55:28'!
position
	^coordinate.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:37:04'!
rotateClockwise
	directionState := directionState rotateClockwise.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:37:17'!
rotateCounterClockwise
	directionState := directionState rotateCounterClockwise.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars-Rover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'natan 10/10/2023 14:47:51'!
at: aCoordinate direction: aCardinalDirection 
	^self new initializeAt: aCoordinate direction: aCardinalDirection ! !


!classDefinition: #MarsRoverDirectionState category: 'Mars-Rover-Exercise'!
Object subclass: #MarsRoverDirectionState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!MarsRoverDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:40:53'!
direction

	^ self class direction.! !

!MarsRoverDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 16:02:41'!
moveForward: aRover

	self subclassResponsibility! !

!MarsRoverDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:26:55'!
rotateClockwise

	self subclassResponsibility! !

!MarsRoverDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:27:06'!
rotateCounterClockwise

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverDirectionState class' category: 'Mars-Rover-Exercise'!
MarsRoverDirectionState class
	instanceVariableNames: ''!

!MarsRoverDirectionState class methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:41:36'!
direction

	self subclassResponsibility! !

!MarsRoverDirectionState class methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:43:59'!
stateFor: aCardinalDirection
	^ (self subclasses detect: [:cardinalDirectionState | cardinalDirectionState direction = aCardinalDirection]) new.! !


!classDefinition: #EastDirectionState category: 'Mars-Rover-Exercise'!
MarsRoverDirectionState subclass: #EastDirectionState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!EastDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 16:10:49'!
moveBackwards: aRover

	aRover moveWest! !

!EastDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 16:03:30'!
moveForward: aRover

	aRover moveEast! !

!EastDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:28:12'!
rotateClockwise
	^ SouthDirectionState new .! !

!EastDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:28:26'!
rotateCounterClockwise
	^ NorthDirectionState new .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EastDirectionState class' category: 'Mars-Rover-Exercise'!
EastDirectionState class
	instanceVariableNames: ''!

!EastDirectionState class methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:41:48'!
direction
	^ $E.! !


!classDefinition: #NorthDirectionState category: 'Mars-Rover-Exercise'!
MarsRoverDirectionState subclass: #NorthDirectionState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!NorthDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 16:11:00'!
moveBackwards: aRover

	aRover moveSouth! !

!NorthDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 16:03:51'!
moveForward: aRover

	aRover moveNorth! !

!NorthDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:28:39'!
rotateClockwise
	^ EastDirectionState new .! !

!NorthDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:28:49'!
rotateCounterClockwise
	^ WestDirectionState new .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NorthDirectionState class' category: 'Mars-Rover-Exercise'!
NorthDirectionState class
	instanceVariableNames: ''!

!NorthDirectionState class methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:41:57'!
direction
	^ $N.! !


!classDefinition: #SouthDirectionState category: 'Mars-Rover-Exercise'!
MarsRoverDirectionState subclass: #SouthDirectionState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!SouthDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 16:11:08'!
moveBackwards: aRover

	aRover moveNorth! !

!SouthDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 16:04:04'!
moveForward: aRover

	aRover moveSouth! !

!SouthDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:29:04'!
rotateClockwise
	^ WestDirectionState new .! !

!SouthDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:29:09'!
rotateCounterClockwise
	^ EastDirectionState new .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SouthDirectionState class' category: 'Mars-Rover-Exercise'!
SouthDirectionState class
	instanceVariableNames: ''!


!SouthDirectionState class methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:42:06'!
direction
	^ $S.! !


!classDefinition: #WestDirectionState category: 'Mars-Rover-Exercise'!
MarsRoverDirectionState subclass: #WestDirectionState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!WestDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 16:11:13'!
moveBackwards: aRover

	aRover moveEast! !

!WestDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 16:04:18'!
moveForward: aRover

	aRover moveWest! !

!WestDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:29:23'!
rotateClockwise
	^ NorthDirectionState new .! !

!WestDirectionState methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:29:31'!
rotateCounterClockwise
	^ SouthDirectionState new .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WestDirectionState class' category: 'Mars-Rover-Exercise'!
WestDirectionState class
	instanceVariableNames: ''!

!WestDirectionState class methodsFor: 'as yet unclassified' stamp: 'natan 10/10/2023 15:42:14'!
direction
	^ $O.! !
