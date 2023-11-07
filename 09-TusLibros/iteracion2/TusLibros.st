!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'MLNV 11/5/2023 21:31:25'!
test01CantCreateCardWithoutIdentifierOfSize16
	
	self 
	should: [CreditCard 
			withIdentifier: '11'
			expiracyMonth: '12'
			expiracyYear: '2025'
			andOwner: 'Abigail'.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = CreditCard invalidCardFormatErrorDescription .]
	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'MLNV 11/5/2023 21:32:18'!
test02CantCreateCardWithoutMonthOfSize2
	
	self 
	should: [CreditCard 
			withIdentifier: '1234567890123456'
			expiracyMonth: '1'
			expiracyYear: '2025'
			andOwner: 'Abigail'.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = CreditCard invalidCardFormatErrorDescription .]
	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'MLNV 11/5/2023 21:33:50'!
test03CantCreateCardWithoutYearOfSize4
	
	self 
	should: [CreditCard 
			withIdentifier: '1234567890123456'
			expiracyMonth: '12'
			expiracyYear: '202'
			andOwner: 'Abigail'.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = CreditCard invalidCardFormatErrorDescription .]
	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'MLNV 11/5/2023 21:36:24'!
test04CantCreateCardWithoutAnOwner
	
	self 
	should: [CreditCard 
			withIdentifier: '1234567890123456'
			expiracyMonth: '12'
			expiracyYear: '2025'
			andOwner: ''.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = CreditCard invalidCardFormatErrorDescription .]
	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'MLNV 11/5/2023 21:41:49'!
test05CantCreateCardWithInvalidOwnerName
	
	self 
	should: [CreditCard 
			withIdentifier: '1234567890123456'
			expiracyMonth: '12'
			expiracyYear: '2025'
			andOwner: '#Abigail'.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = CreditCard invalidCardFormatErrorDescription .]
	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'MLNV 11/5/2023 22:10:30'!
test06CantCreateCardWithInvalidMonth
	
	self 
	should: [CreditCard 
			withIdentifier: '1234567890123456'
			expiracyMonth: '00'
			expiracyYear: '2025'
			andOwner: 'Abigail'.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = CreditCard invalidCardFormatErrorDescription .]
	! !


!CreditCardTest methodsFor: 'tests' stamp: 'MLNV 11/5/2023 23:21:19'!
test07CantCreateCardWithOwnerNameLongerThan30Characters
	
	self 
	should: [CreditCard 
			withIdentifier: '1234567890123456'
			expiracyMonth: '12'
			expiracyYear: '2025'
			andOwner: 'AbigailAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = CreditCard invalidCardFormatErrorDescription .]
	! !


!classDefinition: #TusLibrosTest category: 'TusLibros'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'support' stamp: 'MLNV 11/5/2023 20:08:42'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!TusLibrosTest methodsFor: 'support' stamp: 'MLNV 11/5/2023 20:19:56'!
defaultCatalog
	
	^ Array 
		with: self itemSellByTheStore 
		with: self fiveDollarItem
		with: self sevenDollarItem .! !

!TusLibrosTest methodsFor: 'support' stamp: 'MLNV 11/5/2023 20:30:45'!
fiveDollarItem
	
	^ 'validFiveDollarBook'.! !

!TusLibrosTest methodsFor: 'support' stamp: 'MLNV 11/5/2023 20:09:49'!
itemSellByTheStore
	
	^ 'validBook'! !

!TusLibrosTest methodsFor: 'support' stamp: 'MLNV 11/5/2023 20:29:31'!
sevenDollarItem
	
	^ 'validSevenDollarBook'! !


!classDefinition: #CartTest category: 'TusLibros'!
TusLibrosTest subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:35'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemSellByTheStore withOcurrences: 0  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:46'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add:  self itemNotSellByTheStore withOcurrences: 2  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:59'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore withOcurrences: 2.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'MLNV 11/5/2023 20:09:29'!
itemNotSellByTheStore
	
	^'invalidBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TusLibrosTest subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'MLNV 11/5/2023 21:54:03'!
createValidCard

	^ CreditCard 
			withIdentifier: '1234567890123456'
			expiracyMonth: '12'
			expiracyYear: '2025'
			andOwner: 'Abigail'! !

!CashierTest methodsFor: 'tests' stamp: 'MLNV 11/5/2023 20:40:04'!
test01CostOfEmptyCartShouldBeZero

	| cart cashier |
	
	cart := self createCart.
	cashier := self createCashier.
	
	self assert: (cashier costOf: cart) equals: 0.
	! !

!CashierTest methodsFor: 'tests' stamp: 'MLNV 11/5/2023 20:37:04'!
test02CostOfCartWithOneItemIsPriceOfItem

	| cart cashier |
	
	cart := self createCart.
	cart add: self fiveDollarItem .
	
	cashier := self createCashier .
	
	self assert: (cashier costOf: cart) equals: 5.
	! !

!CashierTest methodsFor: 'tests' stamp: 'MLNV 11/5/2023 20:42:36'!
test03CostOfCartIsSumOfItemsPrice

	| cart cashier |
	
	cart := self createCart.
	cart add: self fiveDollarItem.
	cart add: self sevenDollarItem .	
	cashier := self createCashier.
	
	self assert: (cashier costOf: cart) equals: 12.
	! !

!CashierTest methodsFor: 'tests' stamp: 'MLNV 11/6/2023 00:09:07'!
test04CantPayWithAnExpiredCreditCard

	| cashier cart expiredCard |
		
	cashier := self createCashier.
	cart := self createCart.
	expiredCard := CreditCard 
			withIdentifier: '1234567890123456'
			expiracyMonth: '10'
			expiracyYear: '2023'
			andOwner: 'Abigail'.
	
	self 
	should: [cashier checkOut: cart payingWith: expiredCard]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = MerchantProcessor invalidParametersErrorDescription .]


! !

!CashierTest methodsFor: 'tests' stamp: 'MLNV 11/6/2023 00:20:52'!
test05CantPayAnAmountExceeding15Digits

	| creditCard |
		
	creditCard := CreditCard 
			withIdentifier: '1234567890123456'
			expiracyMonth: '12'
			expiracyYear: '2025'
			andOwner: 'Abigail'.
	
	self 
	should: [(MerchantProcessor new) 
		debit: ((10^15) asString, '.00') from: creditCard 
		]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = MerchantProcessor invalidParametersErrorDescription .]


! !

!CashierTest methodsFor: 'tests' stamp: 'MLNV 11/6/2023 00:25:24'!
test06CantPayAnAmountWithoutTwoDecimalPlaces

	| creditCard |
		
	creditCard := CreditCard 
			withIdentifier: '1234567890123456'
			expiracyMonth: '12'
			expiracyYear: '2025'
			andOwner: 'Abigail'.

	self 
	should: [	(MerchantProcessor new) 
		debit: 1 asString from: creditCard 
		]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = MerchantProcessor invalidParametersErrorDescription .]


! !


!CashierTest methodsFor: 'support' stamp: 'MLNV 11/5/2023 20:37:04'!
createCashier

	^ Cashier with: self defaultPriceList! !

!CashierTest methodsFor: 'support' stamp: 'MLNV 11/5/2023 20:34:02'!
defaultPriceList
	
	^(Dictionary new)
		add: 'validFiveDollarBook' -> 5; 
		add: 'validSevenDollarBook' -> 7; 
		add: 'validBook' -> 0;
		yourself.! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:30'!
add: anItem

	^ self add: anItem withOcurrences: 1 ! !

!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:19'!
add: anItem withOcurrences: aQuantity

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'prices merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'operations' stamp: 'MLNV 11/6/2023 00:26:53'!
checkOut: cart payingWith: creditCard 

	^merchantProcessor debit: (self parse: (self costOf: cart)) from: creditCard.! !

!Cashier methodsFor: 'operations' stamp: 'MLNV 11/5/2023 23:24:50'!
costOf: cart 
		
	^prices keys sum: [:anItem | (cart occurrencesOf: anItem) * (prices at: anItem)].! !

!Cashier methodsFor: 'operations' stamp: 'MLNV 11/6/2023 00:27:44'!
parse: anAmount
	"Deberia truncar a 2 digitos decimales?"
	
	^anAmount
	! !


!Cashier methodsFor: 'initialization' stamp: 'MLNV 11/5/2023 22:13:10'!
initializeWith: aPriceList 

	prices := aPriceList.
	merchantProcessor := MerchantProcessor new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'MLNV 11/5/2023 20:35:29'!
with: aPriceList 

	^self new initializeWith: aPriceList ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'identifier name month year'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'MLNV 11/5/2023 21:22:28'!
initializeWithIdentifier: anIdentifier expiracyMonth: aMonth expiracyYear: aYear andOwner: aName 

	identifier := anIdentifier.
	month := aMonth.
	year := aYear.
	name := aName.! !


!CreditCard methodsFor: 'query' stamp: 'MLNV 11/5/2023 23:17:54'!
expiracyDate 

	^(month, '/', year) asMonth.! !

!CreditCard methodsFor: 'query' stamp: 'MLNV 11/5/2023 23:34:35'!
identifier 

	^identifier 
	! !

!CreditCard methodsFor: 'query' stamp: 'MLNV 11/5/2023 23:17:33'!
isExpired

	^self expiracyDate end < DateAndTime today.! !

!CreditCard methodsFor: 'query' stamp: 'MLNV 11/5/2023 23:34:40'!
month

	^month
	! !

!CreditCard methodsFor: 'query' stamp: 'MLNV 11/5/2023 23:34:54'!
owner

	^name! !

!CreditCard methodsFor: 'query' stamp: 'MLNV 11/5/2023 23:34:45'!
year

	^year! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'MLNV 11/5/2023 21:24:33'!
invalidCardFormatErrorDescription

	^'Los datos ingresados son invalidos'.! !

!CreditCard class methodsFor: 'instance creation' stamp: 'MLNV 11/5/2023 21:51:14'!
withIdentifier: anIdentifier expiracyMonth: aMonth expiracyYear: aYear andOwner: aName 
	
	self assertValidFormatWithIdentifier: anIdentifier 
		expiracyMonth: aMonth 
		expiracyYear: aYear 
		andOwner: aName.

	^self new initializeWithIdentifier: anIdentifier expiracyMonth: aMonth expiracyYear: aYear andOwner: aName 
	
! !


!CreditCard class methodsFor: 'assertions' stamp: 'MLNV 11/5/2023 23:22:19'!
assertValidFormatWithIdentifier: anIdentifier expiracyMonth: aMonth expiracyYear: aYear andOwner: aName 
	
	"El hijo de Elon Musk tiene numeros en su nombre..."
	((anIdentifier size = 16 and: 
		[aName isEmpty not] and: 
		[aName isAlphaNumeric] and:
		[aMonth size = 2] and: 
		[aYear size = 4]) and:
		[aName size <= 30]) ifFalse: [self error: self invalidCardFormatErrorDescription].
		
	[(aMonth, '/', aYear) asMonth] on: Error do: [self error: self invalidCardFormatErrorDescription ].
	

	
! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'debit' stamp: 'MLNV 11/6/2023 00:25:42'!
debit: aTransactionAmount from: aCreditCard 
	
	"| XXXString |"
	
	
	"XXXString := 'https://merchanttest.com/debit?creditCardNumber=', aCreditCard identifier,
			'&creditCardExpiration=', aCreditCard month, aCreditCard year,
			'&creditCardOwner=', aCreditCard owner,
			'&transactionAmount=', aTransactionAmount truncateTo: 0.01".
	
	aCreditCard isExpired ifTrue: [self error: self class invalidParametersErrorDescription ]	.
	aTransactionAmount asNumber >= (10^15) ifTrue: [self error: self class invalidParametersErrorDescription ].
	((aTransactionAmount size < 3) or: [(aTransactionAmount at: (aTransactionAmount size - 2)  = '.') not]) ifTrue: [self error: self class invalidParametersErrorDescription]	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: 'TusLibros'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'errors' stamp: 'MLNV 11/6/2023 00:08:38'!
invalidParametersErrorDescription

	^'HTTP 400'! !
