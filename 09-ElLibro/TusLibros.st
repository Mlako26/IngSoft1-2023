!classDefinition: #TestCart category: 'TusLibros'!
TestCase subclass: #TestCart
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestCart methodsFor: 'tests' stamp: 'MLNV 11/2/2023 01:06:20'!
test01NewCartStartsEmpty
	| cart stock|

	stock := TusLibrosStock new.
	
	cart := TusLibrosCart of: stock.
	
	self assert: cart isEmpty. 
	! !

!TestCart methodsFor: 'tests' stamp: 'MLNV 11/2/2023 00:48:59'!
test02AddingBookMakesCartNotEmpty
	| cart stock harryPotter|
	
	harryPotter := 'Harry Potter'.
	stock := TusLibrosStock with: harryPotter.
	cart := TusLibrosCart of: stock.
	
	
	cart add: harryPotter amount: 1.
	self deny: cart isEmpty . 
	! !

!TestCart methodsFor: 'tests' stamp: 'MLNV 11/2/2023 01:00:37'!
test03AddedBookIsInCart
	| cart stock harryPotter |
	harryPotter := 'Harry Potter'.
	stock := TusLibrosStock with: harryPotter.
	cart := TusLibrosCart of: stock.
	cart
		add: harryPotter
		amount: 1.
	self assert: (cart includes: harryPotter).! !

!TestCart methodsFor: 'tests' stamp: 'MLNV 11/2/2023 01:12:25'!
test04SameBookAddedMultipleTimesIsInCart
	| cart stock book|
	
	book := 'Harry Potter'.
	stock := TusLibrosStock with: book.
	cart := TusLibrosCart of: stock.
	
	cart add: book amount: 2.
	self assert: (cart amountOf: book) equals: 2.
	! !

!TestCart methodsFor: 'tests' stamp: 'MLNV 11/2/2023 00:49:08'!
test05ListingBooksInCart
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

!TestCart methodsFor: 'tests' stamp: 'MLNV 11/2/2023 01:13:20'!
test06AddingAmountMustBePositive
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

!TestCart methodsFor: 'tests' stamp: 'MLNV 11/2/2023 01:06:16'!
test07NewStockStartsEmpty
	| stock| 
	
	stock := TusLibrosStock new.
	
	self assert: (stock isEmpty).

	! !

!TestCart methodsFor: 'tests' stamp: 'MLNV 11/2/2023 00:56:58'!
test08AddToStock
	| stock |
	stock := TusLibrosStock new.
	stock add: 'Harry Potter'.
	self deny: stock isEmpty.
	self
		assert: (stock includes: 'Harry Potter').! !

!TestCart methodsFor: 'tests' stamp: 'MLNV 11/2/2023 01:02:02'!
test09BookMustBeInStock
	| cart stock  |
	stock := TusLibrosStock with: 'Harry Potter'.
	cart := TusLibrosCart of: stock.
	self
		should: [
			cart
				add: 'Percy Jackson'
				amount: 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosCart invalidBookErrorDescription ].! !


!classDefinition: #TusLibrosCart category: 'TusLibros'!
Object subclass: #TusLibrosCart
	instanceVariableNames: 'books stock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosCart methodsFor: 'adding' stamp: 'MLNV 11/2/2023 01:04:47'!
add: aBook amount: anAmount
	anAmount <= 0 ifTrue: [ ^ self error: self class invalidAmountErrorDescription ].
	(stock includes: aBook) ifFalse: [^self error: self class invalidBookErrorDescription ].
	books
		at: aBook
		put: (self amountOf: aBook) + anAmount.! !


!TusLibrosCart methodsFor: 'accessing' stamp: 'natan 11/1/2023 23:46:41'!
amountOf: aBook
	^books at: aBook ifAbsent: [0].
	! !

!TusLibrosCart methodsFor: 'accessing' stamp: 'natan 11/1/2023 23:50:37'!
includes: aBook
	^(books keys) includes: aBook.! !

!TusLibrosCart methodsFor: 'accessing' stamp: 'natan 11/1/2023 23:59:44'!
listBooks 
	^books.! !


!TusLibrosCart methodsFor: 'initialization' stamp: 'MLNV 11/2/2023 00:54:25'!
initializeOf: aStock 
	
	stock := aStock.
	books := Dictionary new.! !


!TusLibrosCart methodsFor: 'private' stamp: 'natan 11/1/2023 23:19:54'!
isEmpty
	^ self size = 0.! !

!TusLibrosCart methodsFor: 'private' stamp: 'natan 11/1/2023 23:30:52'!
size 
	^books size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosCart class' category: 'TusLibros'!
TusLibrosCart class
	instanceVariableNames: ''!

!TusLibrosCart class methodsFor: 'errors' stamp: 'natan 11/2/2023 00:17:01'!
invalidAmountErrorDescription
	^ 'no podes agregar una cantidad no positiva de libros al carrito'.! !

!TusLibrosCart class methodsFor: 'errors' stamp: 'MLNV 11/2/2023 01:02:29'!
invalidBookErrorDescription
	^ 'no podes agregar un libro que no pertenezca al stock al carrito'.! !


!TusLibrosCart class methodsFor: 'instance creation' stamp: 'MLNV 11/2/2023 00:53:58'!
of: aStock 

	^self new initializeOf: aStock ! !


!classDefinition: #TusLibrosStock category: 'TusLibros'!
Object subclass: #TusLibrosStock
	instanceVariableNames: 'stock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosStock methodsFor: 'initialization' stamp: 'natan 11/2/2023 00:24:33'!
initialize
	stock := OrderedCollection new.! !


!TusLibrosStock methodsFor: 'accessing' stamp: 'MLNV 11/2/2023 00:59:36'!
includes: aBook

	^stock includes: aBook! !


!TusLibrosStock methodsFor: 'private' stamp: 'natan 11/2/2023 00:24:55'!
isEmpty 
	^stock isEmpty.! !


!TusLibrosStock methodsFor: 'adding' stamp: 'MLNV 11/2/2023 00:58:17'!
add: aBook

	stock add: aBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosStock class' category: 'TusLibros'!
TusLibrosStock class
	instanceVariableNames: ''!

!TusLibrosStock class methodsFor: 'instance creation' stamp: 'MLNV 11/2/2023 00:58:48'!
with: aBook

	^(self new) add: aBook.! !

!TusLibrosStock class methodsFor: 'instance creation' stamp: 'MLNV 11/2/2023 00:59:06'!
with: aBook with: anotherBook
	^ (self new) add: aBook; add: anotherBook.! !
