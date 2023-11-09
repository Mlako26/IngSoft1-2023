!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #InterfaceTest category: 'TusLibros'!
TestCase subclass: #InterfaceTest
	instanceVariableNames: 'testObjectsFactory authenticationValue time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfaceTest methodsFor: 'tests' stamp: 'MLNV 11/9/2023 17:08:52'!
now

	^time.! !

!InterfaceTest methodsFor: 'tests' stamp: 'MLNV 11/8/2023 22:45:39'!
test01CantCreateCartWithInvalidCredentials

	| interface |
	
	authenticationValue := false.
	
	interface := Interface withAuthenticator: self.
		
	self 
		should: [interface createCartWithClientId: 'pepe' andPassword: 'pepito']
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: (anError messageText = interface invalidCredentialsErrorDescription).
		]! !

!InterfaceTest methodsFor: 'tests' stamp: 'MLNV 11/9/2023 14:23:49'!
test02CanCreateCartWithValidCredentials

	| interface cartId |
	
	authenticationValue := true.
	
	interface := Interface withAuthenticator: self.
	
	cartId := interface createCartWithClientId: 'pepeBueno' andPassword: 'pepito'.
	
	self assert: (interface listCart: cartId) isEmpty.
! !

!InterfaceTest methodsFor: 'tests' stamp: 'MLNV 11/9/2023 16:17:43'!
test03InterfaceAddsValidItemToCart

	| interface cartId item expected |
	
	authenticationValue := true.
	
	interface := Interface 
		withCatalog: testObjectsFactory defaultCatalog
		andAuthenticator: self.
	
	item := testObjectsFactory itemSellByTheStore .
	
	expected := Dictionary new.
	expected at: item put: 1.
	
	cartId := interface createCartWithClientId: 'pepeBueno' andPassword: 'pepito'.
	interface addToCartWithId: cartId item: item withOcurrances: 1.
	
	self assert: (interface listCart: cartId) equals: expected.! !

!InterfaceTest methodsFor: 'tests' stamp: 'MLNV 11/9/2023 16:17:43'!
test04InterfaceAddsMultipleValidItemsToCart

	| interface cartId item expected |
	
	authenticationValue := true.
	
	interface := Interface 
		withCatalog: testObjectsFactory defaultCatalog
		andAuthenticator: self.
	
	item := testObjectsFactory itemSellByTheStore .
	
	expected := Dictionary new.
	expected at: item put: 2.
	
	cartId := interface createCartWithClientId: 'pepeBueno' andPassword: 'pepito'.
	interface addToCartWithId: cartId item: item withOcurrances: 1.
	interface addToCartWithId: cartId item: item withOcurrances: 1.
	
	self assert: (interface listCart: cartId) equals: expected.! !

!InterfaceTest methodsFor: 'tests' stamp: 'MLNV 11/9/2023 16:17:43'!
test05InterfacelistsAllItemsOfCart

	| interface cartId item anotherItem expected |
	
	authenticationValue := true.
	
	interface := Interface 
		withCatalog: testObjectsFactory defaultCatalog
		andAuthenticator: self.
	
	item := testObjectsFactory itemSellByTheStore .
	anotherItem := testObjectsFactory anotherItemSellByTheStore.
	
	expected := Dictionary new.
	expected at: item put: 3.
	expected at: anotherItem put: 2.
	
	cartId := interface createCartWithClientId: 'pepeBueno' andPassword: 'pepito'.
	interface addToCartWithId: cartId item: item withOcurrances: 3.
	interface addToCartWithId: cartId item: anotherItem withOcurrances: 2.
	
	self assert: (interface listCart: cartId) equals: expected.
	

! !

!InterfaceTest methodsFor: 'tests' stamp: 'MLNV 11/9/2023 16:17:43'!
test06CantAddItemThatIsNotInTheCatalog

	| interface cartId item |
	
	authenticationValue := true.
	
	interface := Interface 
		withCatalog: testObjectsFactory defaultCatalog
		andAuthenticator: self.
	
	item := testObjectsFactory itemNotSellByTheStore .
	
	cartId := interface createCartWithClientId: 'pepeBueno' andPassword: 'pepito'.
	
	self 
		should: [	interface addToCartWithId: cartId item: item withOcurrances: 1.]
		raise:  Error - MessageNotUnderstood
		withExceptionDo: [:anError |
				self assert: anError messageText = Interface invalidItemErrorDescription
			]

	
	
	
! !

!InterfaceTest methodsFor: 'tests' stamp: 'MLNV 11/9/2023 16:17:43'!
test07CantAddANonPositiveAmountOfItems

	| interface cartId item |
	
	authenticationValue := true.
	
	interface := Interface 
		withCatalog: testObjectsFactory defaultCatalog
		andAuthenticator: self.
	
	item := testObjectsFactory itemSellByTheStore .
	
	cartId := interface createCartWithClientId: 'pepeBueno' andPassword: 'pepito'.
	
	self 
		should: [	interface addToCartWithId: cartId item: item withOcurrances: -1.]
		raise:  Error - MessageNotUnderstood
		withExceptionDo: [:anError |
				self assert: anError messageText = Interface invalidAmountErrorDescription
			]

	
	
	
! !

!InterfaceTest methodsFor: 'tests' stamp: 'MLNV 11/9/2023 16:17:43'!
test08InterfaceFullfilsValidPurchase

	| interface cartId item card clientID password itemList expectedSale |
	
	authenticationValue := true.
	
	interface := Interface 
		withCatalog: testObjectsFactory defaultCatalog
		andAuthenticator: self
		through: self.
		
	clientID := 'pepeBueno'.
	password := 'pepito'.
	item := testObjectsFactory itemSellByTheStore .
	card := testObjectsFactory notExpiredCreditCard.
	
	itemList := Dictionary new.
	itemList at: item put: 1.
	
	expectedSale := Sale of: 10 forItems: itemList.
	
	cartId := interface createCartWithClientId: clientID andPassword: password.
	interface addToCartWithId: cartId item: item withOcurrances: 1.
	
	interface checkOut: cartId with: card.
	
	self assert: 	(interface listPurchasesOfClient: clientID withPassword: password) equals: expectedSale .

	
	
	
! !

!InterfaceTest methodsFor: 'tests' stamp: 'MLNV 11/9/2023 16:17:43'!
test09InterfaceListsPurchasesOfASingleClient

	| interface cartId item anotherItem card clientID password itemList expectedSale |
		
	interface := Interface 
		withCatalog: testObjectsFactory defaultCatalog
		andAuthenticator: self
		through: self.
		
	clientID := 'pepeBueno'.
	password := 'pepito'.
	item := testObjectsFactory itemSellByTheStore .
	anotherItem := testObjectsFactory anotherItemSellByTheStore .
	card := testObjectsFactory notExpiredCreditCard.
	
	itemList := Dictionary new.
	itemList at: item put: 3.
	itemList at: anotherItem put: 2.
	
	expectedSale := Sale of: 50 forItems: itemList.
	
	cartId := interface createCartWithClientId: clientID andPassword: password.
	interface addToCartWithId: cartId item: item withOcurrances: 3.
	interface addToCartWithId: cartId item: anotherItem withOcurrances: 2.
	
	interface checkOut: cartId with: card.
	
	self assert: 	(interface listPurchasesOfClient: clientID withPassword: password) equals: expectedSale .

	
	
	
! !

!InterfaceTest methodsFor: 'tests' stamp: 'MLNV 11/9/2023 16:17:43'!
test10InterfaceListsPurchasesOfMultipleCartsOfASingleClient

	| interface cartId secondCartId item card clientID password itemList expectedSale |
		
	interface := Interface 
		withCatalog: testObjectsFactory defaultCatalog
		andAuthenticator: self
		through: self.
		
	clientID := 'pepeBueno'.
	password := 'pepito'.
	item := testObjectsFactory itemSellByTheStore .
	card := testObjectsFactory notExpiredCreditCard.
	
	itemList := Dictionary new.
	itemList at: item put: 2.
	
	expectedSale := Sale of: 20 forItems: itemList.
	
	cartId := interface createCartWithClientId: clientID andPassword: password.
	secondCartId := interface createCartWithClientId: clientID andPassword: password.
	interface addToCartWithId: cartId item: item withOcurrances: 1.
	interface addToCartWithId: secondCartId item: item withOcurrances: 1.
	
	interface checkOut: cartId with: card.
	interface checkOut: secondCartId with: card.
	
	self assert: 	(interface listPurchasesOfClient: clientID withPassword: password) equals: expectedSale .

	
	
	
! !

!InterfaceTest methodsFor: 'tests' stamp: 'MLNV 11/9/2023 16:34:58'!
test11InterfaceSeparatesPurchasesOfDifferentClients

	| interface cartId secondCartId item card firstClientID secondClientID password itemList expectedSale |
		
	interface := Interface 
		withCatalog: testObjectsFactory defaultCatalog
		andAuthenticator: self
		through: self.
		

	firstClientID := 'pepeBueno'.
	secondClientID := 'pepeMalo'.
	password := 'pepito'.
	item := testObjectsFactory itemSellByTheStore .
	card := testObjectsFactory notExpiredCreditCard.
	
	itemList := Dictionary new.
	itemList at: item put: 1.
	
	expectedSale := Sale of: 10 forItems: itemList.
	
	cartId := interface createCartWithClientId: firstClientID andPassword: password.
	secondCartId := interface createCartWithClientId: secondClientID andPassword: password.
	interface addToCartWithId: cartId item: item withOcurrances: 1.
	interface addToCartWithId: secondCartId item: item withOcurrances: 1.
	
	interface checkOut: cartId with: card.
	interface checkOut: secondCartId with: card.
	
	self assert: 	(interface listPurchasesOfClient: firstClientID withPassword: password) equals: expectedSale.
	self assert: 	(interface listPurchasesOfClient: secondClientID withPassword: password) equals: expectedSale.

	
	
	
! !

!InterfaceTest methodsFor: 'tests' stamp: 'MLNV 11/9/2023 17:12:37'!
test12CantAddItemOnACartAfter30MinutesOfInactivity

	| interface cartId clientID password item|
	
	time := DateAndTime now.
	
	interface := Interface 
		withCatalog: testObjectsFactory defaultCatalog
		andAuthenticator: self
		through: self
		andTimeSystem: self.
		
	clientID := 'pepeBueno'.
	password := 'pepito'.
	item := testObjectsFactory itemSellByTheStore.	
	
	cartId := interface createCartWithClientId: clientID andPassword: password.
	
	time := time + 30 minutes.
	
	self 
		should: [interface addToCartWithId: cartId item: item withOcurrances: 1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
				self assert: anError messageText = Interface expiredCartErrorDescription.
			]
! !

!InterfaceTest methodsFor: 'tests' stamp: 'MLNV 11/9/2023 17:16:56'!
test12UsingACartRefreshesItsExpiration

	| interface cartId clientID password item|
	
	time := DateAndTime now.
	
	interface := Interface 
		withCatalog: testObjectsFactory defaultCatalog
		andAuthenticator: self
		through: self
		andTimeSystem: self.
		
	clientID := 'pepeBueno'.
	password := 'pepito'.
	item := testObjectsFactory itemSellByTheStore.	
	
	cartId := interface createCartWithClientId: clientID andPassword: password.
	
	time := time + 20 minutes.
	
	interface addToCartWithId: cartId item: item withOcurrances: 1.
	
	time := time + 20 minutes.
	
	self shouldnt: [interface addToCartWithId: cartId item: item withOcurrances: 1.] raise: Error.
! !


!InterfaceTest methodsFor: 'setup' stamp: 'MLNV 11/8/2023 22:39:22'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	authenticationValue := true.! !


!InterfaceTest methodsFor: 'support' stamp: 'SC 11/6/2023 20:54:50'!
attemptLoginTo: aClientId with: aPassword 
	
	^authenticationValue! !

!InterfaceTest methodsFor: 'support' stamp: 'MLNV 11/9/2023 15:34:59'!
debit: anAmount from: aCard

	^self.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'MLNV 11/8/2023 22:52:49'!
listItems
	
	| cartItems |
	
	cartItems := items asSet.
	
	^cartItems inject: Dictionary new into: [:occurrencesDictionary :anItem |
		occurrencesDictionary at: anItem put: (items occurrencesOf: anItem); yourself
		]
	! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartProxy category: 'TusLibros'!
Object subclass: #CartProxy
	instanceVariableNames: 'proxee lastOperationTimestamp timeSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartProxy methodsFor: 'initialization' stamp: 'MLNV 11/9/2023 17:17:15'!
doesNotUnderstand: aMessage

	((lastOperationTimestamp + 30 minutes) <= timeSystem now) ifTrue: [self error: self class expiredCartErrorDescription].
	lastOperationTimestamp := timeSystem now.
	^aMessage sendTo: proxee.! !

!CartProxy methodsFor: 'initialization' stamp: 'MLNV 11/9/2023 16:57:51'!
initializeForCatalog: aCatalog andTimeSystem: aTimeSystem

	proxee := Cart acceptingItemsOf: aCatalog.
	timeSystem := aTimeSystem.
	lastOperationTimestamp := timeSystem now.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartProxy class' category: 'TusLibros'!
CartProxy class
	instanceVariableNames: ''!

!CartProxy class methodsFor: 'instance creation' stamp: 'MLNV 11/9/2023 16:59:53'!
forCatalog: aCatalog andTimeSystem: aTimeSystem

	^ self new initializeForCatalog: aCatalog andTimeSystem: aTimeSystem.! !


!CartProxy class methodsFor: 'error descriptions' stamp: 'MLNV 11/9/2023 16:50:41'!
expiredCartErrorDescription

	^'Cart is already expired'.! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'MLNV 11/9/2023 15:21:08'!
createSale

	^ Sale 
		of: total
		forItems: cart listItems
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration owner identifier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

!CreditCard methodsFor: 'initialization' stamp: 'MLNV 11/9/2023 12:20:24'!
initializeExpiringOn: aMonth withIdentifier: anIdentifier andOwner: aName 

	expiration := aMonth.
	identifier := anIdentifier.
	owner := aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !

!CreditCard class methodsFor: 'instance creation' stamp: 'MLNV 11/9/2023 12:19:34'!
expiringOn: aMonth withIdentifier: anIdentifier andOwner: aName 

	^self new initializeExpiringOn: aMonth withIdentifier: anIdentifier andOwner: aName ! !


!classDefinition: #Interface category: 'TusLibros'!
Object subclass: #Interface
	instanceVariableNames: 'credentialAuthenticator carts catalog merchantProcessor purchases owners timeSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Interface methodsFor: 'initialization' stamp: 'MLNV 11/9/2023 17:06:44'!
initializeWith: aCredentialAuthenticator 

	credentialAuthenticator := aCredentialAuthenticator.
	carts := OrderedCollection new.
	owners := OrderedCollection new.
	timeSystem := DateAndTime.
	purchases := Dictionary new.! !

!Interface methodsFor: 'initialization' stamp: 'SC 11/6/2023 21:05:04'!
initializeWithCatalog: anItemCatalog andAuthenticator: anAuthenticator 

	self initializeWith: anAuthenticator.
	catalog := anItemCatalog.
	! !

!Interface methodsFor: 'initialization' stamp: 'MLNV 11/9/2023 17:06:25'!
initializeWithCatalog: aCatalog andAuthenticator: anAuthenticator through: aMerchantProcessor 

	self initializeWithCatalog: aCatalog andAuthenticator: anAuthenticator.
	merchantProcessor := aMerchantProcessor.
	! !

!Interface methodsFor: 'initialization' stamp: 'MLNV 11/9/2023 17:05:42'!
initializeWithCatalog: aCatalog andAuthenticator: anAuthenticator through: aMerchantProcessor andTimeSystem: aTimeSystem.

	self initializeWithCatalog: aCatalog andAuthenticator: anAuthenticator through: aMerchantProcessor.
	timeSystem := aTimeSystem.! !


!Interface methodsFor: 'operators' stamp: 'MLNV 11/9/2023 16:17:43'!
addToCartWithId: cartId item: item withOcurrances: aQuantity

	(carts at: cartId) add: aQuantity of: item

	 
	! !

!Interface methodsFor: 'operators' stamp: 'MLNV 11/9/2023 16:30:41'!
checkOut: cartId with: card 
	
	| aCart aCashier clientId |
	
	clientId := (owners at: cartId).
	
	(purchases keys includes: (clientId)) ifFalse: [purchases at: clientId put: OrderedCollection new].
	
	aCart := carts at: cartId.

	aCashier := Cashier
		toCheckout: aCart 
		charging: card
		throught: merchantProcessor 
		on: DateAndTime now
		registeringOn: (purchases at: (clientId)).
	
	aCashier checkOut.
	
	
	
		
	
	
	! !

!Interface methodsFor: 'operators' stamp: 'MLNV 11/9/2023 17:02:37'!
createCartWithClientId: aClientId andPassword: aPassword

	(credentialAuthenticator attemptLoginTo: aClientId with: aPassword) ifFalse: [self error: self invalidCredentialsErrorDescription].
	
	carts add: (CartProxy forCatalog: 	catalog andTimeSystem: timeSystem).
	owners add: aClientId.
	
	^ carts size.
	! !

!Interface methodsFor: 'operators' stamp: 'MLNV 11/8/2023 22:53:59'!
listCart: cartId

	^(carts at: cartId) listItems.
	
! !

!Interface methodsFor: 'operators' stamp: 'MLNV 11/9/2023 16:31:17'!
listPurchasesOfClient: clientId withPassword: password 
	
	^(purchases at: clientId) inject: (Sale of: 0) into:
		 [:finalSale :aSale | finalSale mergeSale: aSale].
	! !


!Interface methodsFor: 'error descriptions' stamp: 'SC 11/6/2023 20:11:34'!
invalidCredentialsErrorDescription

	^'papu no matchean'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Interface class' category: 'TusLibros'!
Interface class
	instanceVariableNames: ''!

!Interface class methodsFor: 'instance creation' stamp: 'MLNV 11/8/2023 22:44:38'!
withAuthenticator: aCredentialAuthenticator 

	^self new initializeWith: aCredentialAuthenticator ! !

!Interface class methodsFor: 'instance creation' stamp: 'SC 11/6/2023 20:50:48'!
withCatalog: anItemCatalog andAuthenticator: anAuthenticator 

	^self new initializeWithCatalog: anItemCatalog andAuthenticator: anAuthenticator ! !

!Interface class methodsFor: 'instance creation' stamp: 'MLNV 11/9/2023 14:46:35'!
withCatalog: aCatalog andAuthenticator: anAuthenticator through: aMerchantProcessor 

	^self new initializeWithCatalog: aCatalog andAuthenticator: anAuthenticator through: aMerchantProcessor ! !

!Interface class methodsFor: 'instance creation' stamp: 'MLNV 11/9/2023 17:04:54'!
withCatalog: aCatalog andAuthenticator: anAuthenticator through: aMerchantProcessor andTimeSystem: aTimeSystem

	^self new 
		initializeWithCatalog: aCatalog 
		andAuthenticator: anAuthenticator 
		through: aMerchantProcessor 
		andTimeSystem: aTimeSystem.! !


!Interface class methodsFor: 'error descriptions' stamp: 'MLNV 11/9/2023 16:51:03'!
expiredCartErrorDescription

	^'Cart is already expired'.! !

!Interface class methodsFor: 'error descriptions' stamp: 'MLNV 11/8/2023 23:35:57'!
invalidAmountErrorDescription
	
	^'Invalid number of items'! !

!Interface class methodsFor: 'error descriptions' stamp: 'MLNV 11/8/2023 23:35:37'!
invalidItemErrorDescription

	^'Item is not in catalog'! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total itemList clientId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'items' stamp: 'MLNV 11/9/2023 15:43:35'!
itemList

	^itemList.! !


!Sale methodsFor: 'private' stamp: 'MLNV 11/9/2023 15:43:28'!
= aSale

	^total = aSale total and: [itemList = aSale itemList]! !

!Sale methodsFor: 'private' stamp: 'MLNV 11/9/2023 16:03:30'!
mergeItems: aSale
	
	| newItemList |
	
	newItemList := itemList.
	
	aSale itemList keys do: [:anItem | 
		newItemList 
			at: anItem 
			put: ((newItemList at: anItem ifAbsent: [0]) + (aSale itemList at: anItem))
		].
	
	^newItemList.! !

!Sale methodsFor: 'private' stamp: 'MLNV 11/9/2023 15:56:37'!
mergeSale: aSale

	^Sale 
		of: total + aSale total
		forItems: (self mergeItems: aSale)! !


!Sale methodsFor: 'initialization' stamp: 'MLNV 11/9/2023 15:51:53'!
initializeTotal: aTotal

	total := aTotal .
	itemList := Dictionary new.! !

!Sale methodsFor: 'initialization' stamp: 'MLNV 11/9/2023 15:25:34'!
initializeTotal: aTotal  forItems: anItemList
	
	itemList := anItemList.
	total := aTotal.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !

!Sale class methodsFor: 'instance creation' stamp: 'MLNV 11/9/2023 15:24:46'!
of: aTotal forItems: anItemList

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal  forItems: anItemList! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'MLNV 11/8/2023 22:58:01'!
anotherItemSellByTheStore
	
	^ 'another validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'MLNV 11/8/2023 23:08:48'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'MLNV 11/9/2023 00:18:29'!
notExpiredCreditCard
	
	^CreditCard 
		expiringOn: (Month month: today monthIndex year: today yearNumber + 1)
		withIdentifier: '1234567890123456'
		andOwner: 'Abigail'.
		! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
