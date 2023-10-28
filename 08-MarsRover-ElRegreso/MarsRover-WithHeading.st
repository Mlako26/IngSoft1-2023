!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MLNV 10/27/2023 18:10:24'!
test17RoverLogEmpty
	
	 | marsRover marsLog |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	marsLog := MarsRoverLog of: marsRover.
	
	self assert: marsLog show isEmpty.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MLNV 10/27/2023 18:10:32'!
test18RoverLogMovesForward
	
	 | marsRover marsLog |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	marsLog := MarsRoverLog of: marsRover.

	marsRover process: 'f'.
	
	self assert: marsLog show equals: (OrderedCollection with: 1@2).
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MLNV 10/27/2023 18:10:36'!
test20RoverLogMovesForwardMultipleTimes
	
	 | marsRover marsLog expectedLog |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	marsLog := MarsRoverLog of: marsRover.

	marsRover process: 'fffff'.
	
	expectedLog := OrderedCollection new. 
	expectedLog add: 1@2; add: 1@3; add: 1@4; add: 1@5;		 add: 1@6.
		
	self assert: marsLog show equals: expectedLog .
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MLNV 10/27/2023 18:10:40'!
test21RoverLogMovesBackwardMultipleTimes
	
	 | marsRover marsLog expectedLog |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	marsLog := MarsRoverLog of: marsRover.

	marsRover process: 'bbb'.
	
	expectedLog := OrderedCollection new. 
	expectedLog add: 1@0; add: 1@-1; add: 1@-2.
		
	self assert: marsLog show equals: expectedLog .
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MLNV 10/27/2023 18:10:45'!
test22RoverLogMovesMultipleTimesFromAnyPosition
	
	 | marsRover marsLog expectedLog |
	
	marsRover := MarsRover at: 2 @1 heading: self north . 
	
	marsLog := MarsRoverLog of: marsRover.

	marsRover process: 'fffff'.
	
	expectedLog := OrderedCollection new. 
	expectedLog add: 2@2; add: 2@3; add: 2@4; add: 2@5;		 add: 2@6.
		
	self assert: marsLog show equals: expectedLog .
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MLNV 10/27/2023 18:10:50'!
test23RoverLogRotatingTowardsEast
	
	 | marsRover marsLog expectedLog |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	marsLog := MarsRoverLog of: marsRover.

	marsRover process: 'r'.
	
	expectedLog := OrderedCollection new. 
	expectedLog add: 'East'.
		
	self assert: marsLog show equals: expectedLog .
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MLNV 10/27/2023 18:10:54'!
test24RoverLogRotatingTowardsWest
	
	 | marsRover marsLog expectedLog |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	marsLog := MarsRoverLog of: marsRover.

	marsRover process: 'l'.
	
	expectedLog := OrderedCollection new. 
	expectedLog add: 'West'.
		
	self assert: marsLog show equals: expectedLog .
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MLNV 10/27/2023 18:10:58'!
test25RoverLogRotatingTowardsSouth
	
	 | marsRover marsLog expectedLog |
	
	marsRover := MarsRover at: 1@1 heading: self east . 
	
	marsLog := MarsRoverLog of: marsRover.

	marsRover process: 'r'.
	
	expectedLog := OrderedCollection new. 
	expectedLog add: 'South'.
		
	self assert: marsLog show equals: expectedLog .
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MLNV 10/27/2023 18:11:02'!
test26RoverLogRotatingTowardsNorth
	
	 | marsRover marsLog expectedLog |
	
	marsRover := MarsRover at: 1@1 heading: self east . 
	
	marsLog := MarsRoverLog of: marsRover.

	marsRover process: 'l'.
	
	expectedLog := OrderedCollection new. 
	expectedLog add: 'North'.
		
	self assert: marsLog show equals: expectedLog .
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MLNV 10/27/2023 18:11:09'!
test27RoverLogUpdatesUntilInvalidCommand
	
	 | marsRover marsLog expectedLog |
	
	marsRover := MarsRover at: 1@1 heading: self north.
	marsLog := MarsRoverLog of: marsRover.

	expectedLog := OrderedCollection new. 
	expectedLog add: 'East'; add: 2@1; add: 1@1; add: 0@1; add: 'North'.
		
		
	self 
		should: [ marsRover process: 'rfbblxfll'.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: marsLog show equals: expectedLog.	 ].	
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MLNV 10/27/2023 18:13:01'!
test28RoverWindowEmpty
	
	 | marsRover expectedHead  expectedPosition marsWindow|
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	marsWindow := MarsRoverWindow of: marsRover.
	expectedHead := ''. 
	expectedPosition := ''. 
		
	self assert: marsWindow head equals: expectedHead.
	self assert: marsWindow position equals: expectedPosition.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MLNV 10/28/2023 19:21:34'!
test29RoverWindowAnyMovement
	
	 | marsRover expectedHead  expectedPosition marsWindow|
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	marsWindow := MarsRoverWindow of: marsRover.
	
	expectedHead := ''. 
	expectedPosition := '1@3'. 
		
	marsRover process: 'fbff'.	
	self assert: marsWindow head equals: expectedHead.
	self assert: marsWindow position equals: expectedPosition.

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MLNV 10/27/2023 18:18:36'!
test30RoverWindowNorthRotation
	
	 | marsRover expectedHead  expectedPosition marsWindow|
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	marsWindow := MarsRoverWindow of: marsRover.
	
	expectedHead := 'Apuntando al Norte'. 
	expectedPosition := ''. 
		
	marsRover process: 'rl'.
	self assert: marsWindow head equals: expectedHead.
	self assert: marsWindow position equals: expectedPosition.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MLNV 10/27/2023 18:18:51'!
test31RoverWindowSouthRotation
	
	 | marsRover expectedHead  expectedPosition marsWindow|
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	marsWindow := MarsRoverWindow of: marsRover.
	
	expectedHead := 'Apuntando al Sur'. 
	expectedPosition := ''. 
		
	marsRover process: 'rr'.
	self assert: marsWindow head equals: expectedHead.
	self assert: marsWindow position equals: expectedPosition.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MLNV 10/27/2023 18:19:05'!
test32RoverWindowEastRotation
	
	 | marsRover expectedHead  expectedPosition marsWindow|
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	marsWindow := MarsRoverWindow of: marsRover.
	
	expectedHead := 'Apuntando al Este'. 
	expectedPosition := ''. 
		
	marsRover process: 'r'.
	self assert: marsWindow head equals: expectedHead.
	self assert: marsWindow position equals: expectedPosition.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MLNV 10/27/2023 20:55:41'!
test33RoverWindowWestRotation
	
	 | marsRover expectedHead  expectedPosition marsWindow|
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	marsWindow := MarsRoverWindow of: marsRover.
	
	expectedHead := 'Apuntando al Oeste'. 
	expectedPosition := ''. 
		
	marsRover process: 'l'.
	self assert: marsWindow head equals: expectedHead.
	self assert: marsWindow position equals: expectedPosition.
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'MLNV 10/27/2023 20:31:39'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self .
	observers := OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:02'!
headEast
	
	head := MarsRoverHeadingEast for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:12'!
headNorth
	
	head := MarsRoverHeadingNorth for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:17'!
headSouth
	
	head := MarsRoverHeadingSouth for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:24'!
headWest
	
	head := MarsRoverHeadingWest for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'MLNV 10/27/2023 20:32:00'!
rotateLeft
	
	head rotateLeft.
	self updateObserversHeading.! !

!MarsRover methodsFor: 'heading' stamp: 'MLNV 10/27/2023 20:32:00'!
rotateRight
	
	head rotateRight.
	self updateObserversHeading.! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'MLNV 10/27/2023 20:32:34'!
moveBackward
	
	head moveBackward.
	self updateObserversPosition.! !

!MarsRover methodsFor: 'moving' stamp: 'natanvek 10/27/2023 15:41:10'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'MLNV 10/27/2023 20:32:34'!
moveForward
	
	head moveForward.
	self updateObserversPosition.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:12'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:34'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'natanvek 10/27/2023 15:40:42'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | 
		self processCommand: aCommand.
	]
! !

!MarsRover methodsFor: 'command processing' stamp: 'natanvek 10/27/2023 15:05:55'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].
	
	self signalInvalidCommand.! !


!MarsRover methodsFor: 'observing' stamp: 'MLNV 10/27/2023 20:31:39'!
addObserver: anObserver
	
	observers add: anObserver.
	! !

!MarsRover methodsFor: 'observing' stamp: 'MLNV 10/27/2023 20:32:57'!
updateObserversHeading
	
	observers do:[:anObserver | head updateObserver: anObserver].
	! !

!MarsRover methodsFor: 'observing' stamp: 'MLNV 10/27/2023 20:32:34'!
updateObserversPosition
	
	observers do:[:anObserver | anObserver logPosition: position].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !


!MarsRoverHeading methodsFor: 'observing' stamp: 'MLNV 10/27/2023 20:33:59'!
updateObserver: anObserver

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'observing' stamp: 'MLNV 10/27/2023 20:34:10'!
updateObserver: anObserver

	anObserver logHeadingEast! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'observing' stamp: 'MLNV 10/27/2023 20:34:26'!
updateObserver: anObserver

	anObserver logHeadingNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'observing' stamp: 'MLNV 10/27/2023 20:34:31'!
updateObserver: anObserver

	anObserver logHeadingSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'observing' stamp: 'MLNV 10/27/2023 20:34:35'!
updateObserver: anObserver

	anObserver logHeadingWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #MarsRoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserver methodsFor: 'initialization' stamp: 'MLNV 10/28/2023 20:26:47'!
initialize: aMarsRover

	self subclassResponsibility! !


!MarsRoverObserver methodsFor: 'logging' stamp: 'natanvek 10/27/2023 16:41:38'!
logHeadingEast

	self subclassResponsibility! !

!MarsRoverObserver methodsFor: 'logging' stamp: 'natanvek 10/27/2023 16:41:42'!
logHeadingNorth

	self subclassResponsibility! !

!MarsRoverObserver methodsFor: 'logging' stamp: 'natanvek 10/27/2023 16:41:49'!
logHeadingSouth

	self subclassResponsibility! !

!MarsRoverObserver methodsFor: 'logging' stamp: 'natanvek 10/27/2023 16:41:56'!
logHeadingWest

	self subclassResponsibility! !

!MarsRoverObserver methodsFor: 'logging' stamp: 'natanvek 10/27/2023 16:42:05'!
logPosition: aPosition

	self subclassResponsibility! !


!MarsRoverObserver methodsFor: 'display' stamp: 'MLNV 10/27/2023 20:53:28'!
display

	self subclassResponsibility! !

!MarsRoverObserver methodsFor: 'display' stamp: 'natanvek 10/27/2023 16:43:00'!
show

	self subclassResponsibility! !

!MarsRoverObserver methodsFor: 'display' stamp: 'MLNV 10/28/2023 20:33:34'!
startObservingHead

	marsRover attachHeadUpdateBlock: [:aHeading | aHeading updateObserver: self].! !

!MarsRoverObserver methodsFor: 'display' stamp: 'MLNV 10/28/2023 20:34:45'!
startObservingPosition

	marsRover attachPositionUpdateBlock: [:aPosition | self logPosition: aPosition].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverObserver class' category: 'MarsRover-WithHeading'!
MarsRoverObserver class
	instanceVariableNames: ''!

!MarsRoverObserver class methodsFor: 'instance creation' stamp: 'MLNV 10/28/2023 20:23:35'!
of: marsRover 
	
	^self new initialize: marsRover.
! !


!classDefinition: #MarsRoverLog category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverLog
	instanceVariableNames: 'logs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLog methodsFor: 'initialization' stamp: 'MLNV 10/28/2023 20:27:13'!
initialize: aMarsRover

	logs := OrderedCollection new.
	marsRover := aMarsRover.! !


!MarsRoverLog methodsFor: 'logging' stamp: 'MLNV 10/27/2023 20:56:44'!
logHeadingEast

	logs add: 'East'.! !

!MarsRoverLog methodsFor: 'logging' stamp: 'MLNV 10/27/2023 20:56:47'!
logHeadingNorth

	logs add: 'North'.! !

!MarsRoverLog methodsFor: 'logging' stamp: 'MLNV 10/27/2023 20:56:50'!
logHeadingSouth

	logs add: 'South'.! !

!MarsRoverLog methodsFor: 'logging' stamp: 'MLNV 10/27/2023 20:56:52'!
logHeadingWest

	logs add: 'West'.! !

!MarsRoverLog methodsFor: 'logging' stamp: 'MLNV 10/27/2023 20:56:29'!
logPosition: aPosition
 
	logs add: aPosition.! !


!MarsRoverLog methodsFor: 'display' stamp: 'MLNV 10/27/2023 20:49:43'!
display

	TranscriptWindow openTranscript.
	Transcript clear.
	Transcript newLine.
	
	logs do: [: logEntry | Transcript show: logEntry. Transcript newLine].
	
	Transcript newLine.
	Transcript endEntry.! !

!MarsRoverLog methodsFor: 'display' stamp: 'MLNV 10/27/2023 20:56:57'!
show

	^logs.! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverWindow
	instanceVariableNames: 'position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'initialization' stamp: 'MLNV 10/28/2023 20:28:14'!
initialize: aMarsRover

	head := ''.
	position := ''.
	marsRover := aMarsRover.
	! !


!MarsRoverWindow methodsFor: 'logging' stamp: 'MLNV 10/27/2023 20:58:28'!
logHeadingEast

	head := 'Apuntando al Este'.
	! !

!MarsRoverWindow methodsFor: 'logging' stamp: 'MLNV 10/27/2023 20:58:23'!
logHeadingNorth

	head := 'Apuntando al Norte'.! !

!MarsRoverWindow methodsFor: 'logging' stamp: 'MLNV 10/27/2023 20:58:20'!
logHeadingSouth

	head := 'Apuntando al Sur'.! !

!MarsRoverWindow methodsFor: 'logging' stamp: 'MLNV 10/27/2023 20:58:17'!
logHeadingWest

	head := 'Apuntando al Oeste'.! !

!MarsRoverWindow methodsFor: 'logging' stamp: 'MLNV 10/27/2023 20:58:14'!
logPosition: aPosition 

	position := aPosition asString.! !


!MarsRoverWindow methodsFor: 'display' stamp: 'MLNV 10/27/2023 20:55:14'!
display

	TranscriptWindow openTranscript.
	Transcript clear.
	Transcript newLine.
	
	Transcript show: ('Posición: ', position); newLine.
	Transcript show: ('Heading: ', head); newLine.
	
	Transcript newLine.
	Transcript endEntry.! !

!MarsRoverWindow methodsFor: 'display' stamp: 'MLNV 10/27/2023 20:57:03'!
head

	^head.! !

!MarsRoverWindow methodsFor: 'display' stamp: 'MLNV 10/27/2023 20:57:06'!
position

	^position.! !

!MarsRoverWindow methodsFor: 'display' stamp: 'MLNV 10/27/2023 20:57:12'!
show

	^position , ' ' , head.! !


!classDefinition: #MarsRoverProxy category: 'MarsRover-WithHeading'!
ProtoObject subclass: #MarsRoverProxy
	instanceVariableNames: 'proxee observersUpdateBlocks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverProxy methodsFor: 'as yet unclassified' stamp: 'MLNV 10/28/2023 20:19:08'!
doesNotUnderstand: aMessage
	
	self updateObservers.
	^aMessage sendTo: proxee.! !

!MarsRoverProxy methodsFor: 'as yet unclassified' stamp: 'MLNV 10/28/2023 20:18:22'!
initializeFor: aProxee

	proxee := aProxee.
	observersUpdateBlocks := OrderedCollection new.! !

!MarsRoverProxy methodsFor: 'as yet unclassified' stamp: 'MLNV 10/28/2023 20:18:51'!
updateObservers
	
	observersUpdateBlocks do:[:ABlock | ABlock value: proxee].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverProxy class' category: 'MarsRover-WithHeading'!
MarsRoverProxy class
	instanceVariableNames: ''!

!MarsRoverProxy class methodsFor: 'as yet unclassified' stamp: 'MLNV 10/28/2023 19:34:40'!
for: aProxee

	^self new initializeFor: aProxee.! !
