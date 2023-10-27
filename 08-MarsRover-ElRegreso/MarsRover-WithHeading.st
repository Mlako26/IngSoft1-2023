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

!MarsRoverTest methodsFor: 'tests' stamp: 'natanvek 10/27/2023 16:44:27'!
test17RoverLogEmpty
	
	 | marsRover marsLog |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	marsLog := MarsRoverLog of: marsRover.
	
	self assert: (marsLog show) isEmpty.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'natanvek 10/27/2023 16:44:33'!
test18RoverLogMovesForward
	
	 | marsRover marsLog |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	marsLog := MarsRoverLog of: marsRover.

	marsRover process: 'f'.
	
	self assert: (marsLog show) equals: (OrderedCollection with: 1@2).
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'natanvek 10/27/2023 16:44:37'!
test19RoverLogMovesForwardTwice
	
	 | marsRover marsLog |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	marsLog := MarsRoverLog of: marsRover.

	marsRover process: 'ff'.
	
	self assert: (marsLog show) equals: (OrderedCollection with: 1@2 with: 1@3).
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'natanvek 10/27/2023 16:44:44'!
test20RoverLogMovesForwardMultipleTimes
	
	 | marsRover marsLog expectedLog |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	marsLog := MarsRoverLog of: marsRover.

	marsRover process: 'fffff'.
	
	expectedLog := OrderedCollection new. 
	expectedLog add: 1@2; add: 1@3; add: 1@4; add: 1@5;		 add: 1@6.
		
	self assert: (marsLog show) equals: expectedLog .
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'natanvek 10/27/2023 16:44:49'!
test21RoverLogMovesForwardMultipleTimesFromAnyPosition
	
	 | marsRover marsLog expectedLog |
	
	marsRover := MarsRover at: 2 @1 heading: self north . 
	
	marsLog := MarsRoverLog of: marsRover.

	marsRover process: 'fffff'.
	
	expectedLog := OrderedCollection new. 
	expectedLog add: 2@2; add: 2@3; add: 2@4; add: 2@5;		 add: 2@6.
		
	self assert: (marsLog show) equals: expectedLog .
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'natanvek 10/27/2023 16:44:21'!
test22RoverLogChangesHeading
	
	 | marsRover marsLog expectedLog |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	marsLog := MarsRoverLog of: marsRover.

	marsRover process: 'r'.
	
	expectedLog := OrderedCollection new. 
	expectedLog add: 'East'.
		
	self assert: (marsLog show) equals: expectedLog .
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'natanvek 10/27/2023 16:44:15'!
test23RoverLogUpdatesUntilInvalidCommand
	
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
			self assert: (marsLog show) equals: expectedLog.	 ].	
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'natanvek 10/27/2023 16:45:02'!
test24
	
	 | marsRover expectedHead  expectedPosition marsWindow|
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	marsWindow := MarsRoverWindow of: marsRover.
	expectedHead := ''. 
	expectedPosition := ''. 
		
	self assert: (marsWindow head ) equals: expectedHead.
	self assert: (marsWindow position) equals: expectedPosition.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'natanvek 10/27/2023 16:44:09'!
test25ProcessAnyMovement
	
	 | marsRover expectedHead  expectedPosition marsWindow|
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	marsWindow := MarsRoverWindow of: marsRover.
	
	expectedHead := ''. 
	expectedPosition := '1@3'. 
		
	marsRover process: 'fbff'.	
	self assert: (marsWindow head ) equals: expectedHead.
	self assert: (marsWindow position) equals: expectedPosition.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'natanvek 10/27/2023 16:45:12'!
test26ProcessAnyRotation
	
	 | marsRover expectedHead  expectedPosition marsWindow|
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	marsWindow := MarsRoverWindow of: marsRover.
	
	expectedHead := 'Apuntando al Norte'. 
	expectedPosition := ''. 
		
	marsRover process: 'rllr'.
	self assert: (marsWindow head ) equals: expectedHead.
	self assert: (marsWindow position) equals: expectedPosition.
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
	instanceVariableNames: 'position head myLogs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'natanvek 10/27/2023 15:30:56'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self .
	myLogs := OrderedCollection new.! !


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

!MarsRover methodsFor: 'heading' stamp: 'natanvek 10/27/2023 15:42:35'!
rotateLeft
	
	head rotateLeft.
	self updateHeadingInLogs.! !

!MarsRover methodsFor: 'heading' stamp: 'natanvek 10/27/2023 15:42:23'!
rotateRight
	
	head rotateRight.
	self updateHeadingInLogs.! !


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


!MarsRover methodsFor: 'moving' stamp: 'natanvek 10/27/2023 15:42:08'!
moveBackward
	
	head moveBackward.
	self updatePositionInLogs.! !

!MarsRover methodsFor: 'moving' stamp: 'natanvek 10/27/2023 15:41:10'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'natanvek 10/27/2023 15:41:57'!
moveForward
	
	head moveForward.
	self updatePositionInLogs.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:12'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:34'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'natanvek 10/27/2023 15:29:02'!
addLog: aLog
	
	myLogs add: aLog.
	! !

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

!MarsRover methodsFor: 'command processing' stamp: 'natanvek 10/27/2023 15:49:03'!
updateHeadingInLogs
	
	myLogs do:[:aLog | head updateLog: aLog].
	! !

!MarsRover methodsFor: 'command processing' stamp: 'natanvek 10/27/2023 15:40:14'!
updatePositionInLogs
	
	myLogs do:[:aLog | aLog logPosition: position].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverFollower category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverFollower
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverFollower methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 16:41:38'!
logHeadingEast

	self subclassResponsibility! !

!MarsRoverFollower methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 16:41:42'!
logHeadingNorth

	self subclassResponsibility! !

!MarsRoverFollower methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 16:41:49'!
logHeadingSouth

	self subclassResponsibility! !

!MarsRoverFollower methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 16:41:56'!
logHeadingWest

	self subclassResponsibility! !

!MarsRoverFollower methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 16:42:05'!
logPosition: aPosition

	self subclassResponsibility! !

!MarsRoverFollower methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 16:43:00'!
show

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverFollower class' category: 'MarsRover-WithHeading'!
MarsRoverFollower class
	instanceVariableNames: ''!

!MarsRoverFollower class methodsFor: 'instance creation' stamp: 'natanvek 10/27/2023 16:39:41'!
of: marsRover 
	| follower | 
	follower := self new initialize.
	marsRover addLog: follower.
	^follower ! !


!classDefinition: #MarsRoverLog category: 'MarsRover-WithHeading'!
MarsRoverFollower subclass: #MarsRoverLog
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLog methodsFor: 'initialization' stamp: 'natanvek 10/27/2023 16:41:01'!
initialize
	log := OrderedCollection new.! !


!MarsRoverLog methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 15:46:51'!
logHeadingEast
	log add: 'East'! !

!MarsRoverLog methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 15:46:45'!
logHeadingNorth
	log add: 'North'! !

!MarsRoverLog methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 15:46:27'!
logHeadingSouth
	log add: 'South'! !

!MarsRoverLog methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 15:46:35'!
logHeadingWest
	log add: 'West'! !

!MarsRoverLog methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 15:24:46'!
logPosition: aPosition 
	log add: aPosition.! !

!MarsRoverLog methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 16:42:50'!
show
	^log! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
MarsRoverFollower subclass: #MarsRoverWindow
	instanceVariableNames: 'position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 16:43:28'!
head
	^head! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 16:40:14'!
initialize 
	head := ''.
	position := ''.! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 16:10:04'!
logHeadingEast
	head := 'Apuntando al Este'
	! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 16:09:57'!
logHeadingNorth
	head := 'Apuntando al Norte'! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 16:09:47'!
logHeadingSouth
	head := 'Apuntando al Sur'! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 16:09:39'!
logHeadingWest
	head := 'Apuntando al Oeste'! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 16:10:21'!
logPosition: aPosition 
	position := aPosition asString.! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 16:43:53'!
position
	^position! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'natanvek 10/27/2023 16:42:41'!
show
	^position , ' ' , head! !


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

!MarsRoverHeading methodsFor: 'heading' stamp: 'natanvek 10/27/2023 15:50:07'!
updateLog: aLog

	self subclassResponsibility! !


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

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'natanvek 10/27/2023 15:51:30'!
updateLog: aLog

	aLog logHeadingEast! !


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


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'natanvek 10/27/2023 15:51:40'!
updateLog: aLog

	aLog logHeadingNorth! !


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


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'natanvek 10/27/2023 15:52:01'!
updateLog: aLog

	aLog logHeadingSouth! !


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


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'natanvek 10/27/2023 15:52:12'!
updateLog: aLog

	aLog logHeadingWest! !
