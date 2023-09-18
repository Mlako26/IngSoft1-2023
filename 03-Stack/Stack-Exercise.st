!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MLNV 9/18/2023 14:09:28'!
test01NoElementsMatchingWithinEmptyStack

	| sentenceFinder stack matchingElements |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.

	matchingElements := sentenceFinder findSentencesMatching: 'natan' withinStack: stack.
	
	self assert: matchingElements size = 0.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MLNV 9/18/2023 14:09:24'!
test02NoElementsMatchingWithinNotEmptyStack

	| sentenceFinder stack matchingElements |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	stack push: 'manuel'.

	matchingElements := sentenceFinder findSentencesMatching: 'natan' withinStack: stack.
	
	self assert: matchingElements size = 0.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MLNV 9/18/2023 14:14:37'!
test03ElementsMatchingWithinNotEmptyStack

	| sentenceFinder stack matchingElements |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	stack push: 'natan'.

	matchingElements := sentenceFinder findSentencesMatching: 'natan' withinStack: stack.
	
	self assert: matchingElements size = 1.
	self assert: matchingElements last = 'natan'.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MLNV 9/18/2023 14:10:47'!
test04MatchedElementsAreCaseSensitive

	| sentenceFinder stack matchingElements |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	stack push: 'Natan'.

	matchingElements := sentenceFinder findSentencesMatching: 'natan' withinStack: stack.
	
	self assert: matchingElements size = 0.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MLNV 9/18/2023 14:45:03'!
test05StackRemainsUnmodified

	| sentenceFinder stack firstPushedObject secondPushedObject |
	
	sentenceFinder := SentenceFinderByPrefix new.
	firstPushedObject := 'natan'.
	secondPushedObject := 'manuel'.
	
	stack := OOStack new.	
	stack push: firstPushedObject.
	stack push: secondPushedObject.

	sentenceFinder findSentencesMatching: 'manuel' withinStack: stack.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MLNV 9/18/2023 14:47:29'!
test06MoreThanOneElementMatches

	| sentenceFinder stack matchingElements |
	
	sentenceFinder := SentenceFinderByPrefix new.	
	stack := OOStack new.	
	stack push: 'natan'.
	stack push: 'manuel'.
	stack push: 'natanvek'.
	stack push: 'manuellak'.

	matchingElements := sentenceFinder findSentencesMatching: 'natan' withinStack: stack.
	
	self assert: matchingElements size = 2.
	self assert: matchingElements includes: 'natan'.
	self assert: matchingElements includes: 'natanvek'.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MLNV 9/18/2023 15:13:14'!
test07MatchesOnlyHalfWay

	| sentenceFinder stack matchingElements |
	
	sentenceFinder := SentenceFinderByPrefix new.	
	stack := OOStack new.	
	stack push: 'natan'.
	stack push: 'nat'.

	matchingElements := sentenceFinder findSentencesMatching: 'nato' withinStack: stack.
	
	self assert: matchingElements size = 0.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'previousState state top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'capacity' stamp: 'MLNV 9/18/2023 00:27:10'!
isEmpty
	
	^state isEmpty.! !

!OOStack methodsFor: 'capacity' stamp: 'natan 9/18/2023 02:10:51'!
size
	
	^state size.! !


!OOStack methodsFor: 'initializing' stamp: 'natan 9/18/2023 02:09:55'!
initialize
	state := EmptyStackState basicNew.! !


!OOStack methodsFor: 'accessing' stamp: 'natan 9/18/2023 02:11:08'!
top

	^state top! !


!OOStack methodsFor: 'modifiers' stamp: 'natan 9/18/2023 02:27:37'!
pop
	|actualTop|
	actualTop := state top.
	state := state pop. 
	^ actualTop.! !

!OOStack methodsFor: 'modifiers' stamp: 'natan 9/18/2023 02:17:29'!
push: elementToStack
	state := NotEmptyStackState basicNew withPreviousState: state andTop: elementToStack.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'MLNV 9/18/2023 01:06:23'!
new
	
	^self basicNew initialize.
! !

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #EmptyStackState category: 'Stack-Exercise'!
OOStack subclass: #EmptyStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStackState methodsFor: 'accessing' stamp: 'natan 9/18/2023 02:25:01'!
top
	^self error: self class stackEmptyErrorDescription.! !


!EmptyStackState methodsFor: 'capacity' stamp: 'MLNV 9/18/2023 00:12:23'!
isEmpty
	
	^true.! !

!EmptyStackState methodsFor: 'capacity' stamp: 'natan 9/18/2023 01:53:00'!
size
	^0! !


!classDefinition: #NotEmptyStackState category: 'Stack-Exercise'!
OOStack subclass: #NotEmptyStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmptyStackState methodsFor: 'modifiers' stamp: 'natan 9/18/2023 02:28:59'!
pop
	^previousState.! !


!NotEmptyStackState methodsFor: 'capacity' stamp: 'MLNV 9/18/2023 00:12:28'!
isEmpty
	
	^false.! !

!NotEmptyStackState methodsFor: 'capacity' stamp: 'natan 9/18/2023 01:53:22'!
size
	^ previousState size + 1.! !


!NotEmptyStackState methodsFor: 'accessing' stamp: 'natan 9/18/2023 02:43:40'!
top
	^top! !


!NotEmptyStackState methodsFor: 'initializing' stamp: 'natan 9/18/2023 02:40:21'!
withPreviousState: aStackState andTop: anElementToStack
	previousState := aStackState.
	top  := anElementToStack.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'processedSentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'findSentences' stamp: 'MLNV 9/18/2023 14:57:48'!
findSentencesMatching: prefix withinStack: stack
	
	| allSentences matchingSentences |
	
	allSentences := OrderedCollection new.
	stack size timesRepeat: [allSentences add: stack pop].
	
	matchingSentences := allSentences select: [:aSentence | (aSentence copyFrom: 1 to: (prefix size min: aSentence size)) = prefix].
	
	allSentences size timesRepeat: [stack push: allSentences removeLast].
	
	^matchingSentences.
	! !
