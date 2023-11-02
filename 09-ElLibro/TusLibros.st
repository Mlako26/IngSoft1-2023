!classDefinition: #TestCart category: 'TusLibros'!
TestCase subclass: #TestCart
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestCart methodsFor: 'as yet unclassified' stamp: 'natan 11/2/2023 00:39:00'!
test01CreateEmptyCart
	| cart stock|

	stock := TusLibrosStock new.
	
	cart := TusLibrosCart of: stock.
	
	self assert: cart isEmpty. 
	! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'natan 11/2/2023 00:41:26'!
test02addingBookMakesCartNotEmpty
	| cart stock harryPotter|
	
	harryPotter := 'Harry Potter'.
	stock := TusLibrosStock with: harryPotter.
	cart := TusLibrosCart of: stock.
	
	
	cart add: harryPotter amount: 1.
	self deny: cart isEmpty . 
	! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'natan 11/2/2023 00:39:48'!
test03addedBookIsInCart
	| cart stock book|
	
	book := 'Harry Potter'.
	stock := TusLibrosStock with: book.
	cart := TusLibrosCart of: stock.
	
	cart add: book amount: 1.
	self assert: (cart includes: book)
	! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'natan 11/2/2023 00:39:56'!
test04addingSameBookMultipleTimes
	| cart stock book|
	
	book := 'Harry Potter'.
	stock := TusLibrosStock with: book.
	cart := TusLibrosCart of: stock.
	
	cart add: book amount: 2.
	self assert: (cart amountOf: book) equals: 2.
	! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'natan 11/2/2023 00:41:02'!
test05listingBooksInCart
	| cart stock harryPotter percyJackson expectedBooks|
	
	harryPotter := 'Harry Potter'.
	percyJackson := 'Percy Jackson'.
	
	stock := TusLibrosStock with: harryPotter with: percyJackson.
	cart := TusLibrosCart of: stock.

	cart add: harryPotter amount: 2.
	cart add: percyJackson amount: 1.
	
	expectedBooks := Dictionary new.
	expectedBooks add: harryPotter -> 2; add: percyJackson -> 1.
	
	self assert: (cart listBooks) equals: expectedBooks.
	! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'natan 11/2/2023 00:41:36'!
test06addingAmountIsPositive
	| cart stock harryPotter|
	
	harryPotter := 'Harry Potter'.
	stock := TusLibrosStock with: harryPotter.
	cart := TusLibrosCart of: stock.
	
	self
		should: [ cart add: harryPotter amount: 0]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosCart invalidAmountErrorDescription ].
		
	self
		should: [ cart add: harryPotter amount: -1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosCart invalidAmountErrorDescription].
	! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'natan 11/2/2023 00:42:33'!
test07createEmptyStock
	| stock| 
	
	stock := TusLibrosStock new.
	
	self assert: (stock isEmpty).

	! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'natan 11/2/2023 00:42:55'!
test08AddToStock
	| stock| 
	
	stock := TusLibrosStock new.
	
	self assert: (stock isEmpty).

	! !



!classDefinition: #TusLibrosCart category: 'TusLibros'!
Object subclass: #TusLibrosCart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosCart methodsFor: 'as yet unclassified' stamp: 'natan 11/2/2023 00:19:27'!
add: aBook amount: anAmount  
	anAmount <= 0 ifTrue: [^ self error: self class invalidAmountErrorDescription].
	books at: aBook put: (self amountOf: aBook) + anAmount.! !

!TusLibrosCart methodsFor: 'as yet unclassified' stamp: 'natan 11/1/2023 23:46:41'!
amountOf: aBook
	^books at: aBook ifAbsent: [0].
	! !

!TusLibrosCart methodsFor: 'as yet unclassified' stamp: 'natan 11/1/2023 23:50:37'!
includes: aBook
	^(books keys) includes: aBook.! !

!TusLibrosCart methodsFor: 'as yet unclassified' stamp: 'natan 11/1/2023 23:38:20'!
initialize
	books := Dictionary new.
	! !

!TusLibrosCart methodsFor: 'as yet unclassified' stamp: 'natan 11/1/2023 23:19:54'!
isEmpty
	^ self size = 0.! !

!TusLibrosCart methodsFor: 'as yet unclassified' stamp: 'natan 11/1/2023 23:59:44'!
listBooks 
	^books.! !

!TusLibrosCart methodsFor: 'as yet unclassified' stamp: 'natan 11/1/2023 23:30:52'!
size 
	^books size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosCart class' category: 'TusLibros'!
TusLibrosCart class
	instanceVariableNames: ''!

!TusLibrosCart class methodsFor: 'as yet unclassified' stamp: 'natan 11/2/2023 00:17:01'!
invalidAmountErrorDescription
	^ 'no podes agregar una cantidad no positiva de libros al carrito'.! !


!classDefinition: #TusLibrosStock category: 'TusLibros'!
Object subclass: #TusLibrosStock
	instanceVariableNames: 'stock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosStock methodsFor: 'as yet unclassified' stamp: 'natan 11/2/2023 00:24:33'!
initialize
	stock := OrderedCollection new.! !

!TusLibrosStock methodsFor: 'as yet unclassified' stamp: 'natan 11/2/2023 00:24:55'!
isEmpty 
	^stock isEmpty.! !
