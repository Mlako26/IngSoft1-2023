!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'mensajesDeTestingAuxiliares' stamp: 'MLNV 9/6/2023 15:14:17'!
cronometrar: unBloque

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	unBloque value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^millisecondsAfterRunning  - millisecondsBeforeRunning.
	
! !

!CustomerBookTest methodsFor: 'mensajesDeTestingAuxiliares' stamp: 'MLNV 9/5/2023 20:37:07'!
evaluar: unaAccion yEnCasoDe: mensajeDeError checkeamosQueValgan: lasCondiciones

	[unaAccion value.
	self fail ]
		on:  mensajeDeError
		do: [:anError | lasCondiciones do: [:unaCondicion | self assert: (unaCondicion value: anError).]].	! !

!CustomerBookTest methodsFor: 'mensajesDeTestingAuxiliares' stamp: 'MLNV 9/6/2023 15:07:14'!
inicializarCustomerBookConCustomersActivos: activos yCustomersSuspendidos: suspendidos 

	| customerBook |
	
	customerBook := CustomerBook new.
	
	activos do: [:aName | customerBook addCustomerNamed: aName].
	suspendidos do: [:aName | customerBook addCustomerNamed: aName.
						   customerBook suspendCustomerNamed: aName].
	
	^customerBook
	

	

	
! !

!CustomerBookTest methodsFor: 'mensajesDeTestingAuxiliares' stamp: 'MLNV 9/5/2023 21:04:24'!
validamosQue: customerBook tengaUnaCantidadDeActivos: activos yUnaCantidadDeSuspendidos: suspendidos
	
	self assert: activos equals: customerBook numberOfActiveCustomers.
	self assert: suspendidos equals: customerBook numberOfSuspendedCustomers.
	self assert: (activos + suspendidos) equals: customerBook numberOfCustomers.	

	
! !


!CustomerBookTest methodsFor: 'testing' stamp: 'MLNV 9/6/2023 15:10:36'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook tiempoDeAgregadoDeCliente|
	
	customerBook := self inicializarCustomerBookConCustomersActivos: {} yCustomersSuspendidos: {}. 
	
	tiempoDeAgregadoDeCliente := self cronometrar: [customerBook addCustomerNamed: 'John Lennon'.].
	self assert: tiempoDeAgregadoDeCliente < (50 * millisecond).
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MLNV 9/6/2023 15:10:22'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook tiempoDeBorradoDeCliente paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self inicializarCustomerBookConCustomersActivos: {paulMcCartney} yCustomersSuspendidos: {}.
	
	tiempoDeBorradoDeCliente := self cronometrar: [customerBook removeCustomerNamed: paulMcCartney.].
	self assert: tiempoDeBorradoDeCliente < (100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MLNV 9/6/2023 15:10:48'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook lasCondiciones unaOperacion|
			
	customerBook := self inicializarCustomerBookConCustomersActivos: {} yCustomersSuspendidos: {}. 
	
	lasCondiciones := Set with: [:anError | anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage]
					    with: [:anError | customerBook isEmpty].
	
	unaOperacion := [customerBook addCustomerNamed: ''].
	
	self evaluar: unaOperacion yEnCasoDe: Error checkeamosQueValgan: lasCondiciones.
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MLNV 9/6/2023 15:11:05'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon lasCondiciones unaOperacion |
			
	johnLennon := 'John Lennon'.
	customerBook := self inicializarCustomerBookConCustomersActivos: {johnLennon} yCustomersSuspendidos: {}. 
	
	lasCondiciones := Set with: [:anError | customerBook numberOfCustomers = 1]
					    with: [:anError | (customerBook includesCustomerNamed: johnLennon)].
	
	unaOperacion := [customerBook removeCustomerNamed: 'Paul McCartney'].

	self evaluar: unaOperacion yEnCasoDe: NotFound checkeamosQueValgan: lasCondiciones.
		
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MLNV 9/6/2023 15:11:25'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self inicializarCustomerBookConCustomersActivos: {} yCustomersSuspendidos: {paulMcCartney}. 
	
	self validamosQue: customerBook tengaUnaCantidadDeActivos: 0 yUnaCantidadDeSuspendidos: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MLNV 9/6/2023 15:12:34'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self inicializarCustomerBookConCustomersActivos: {} yCustomersSuspendidos: {paulMcCartney}. 
	customerBook removeCustomerNamed: paulMcCartney.
	
	self validamosQue: customerBook tengaUnaCantidadDeActivos: 0 yUnaCantidadDeSuspendidos: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MLNV 9/6/2023 15:13:35'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon lasCondiciones unaOperacion |
			
	johnLennon := 'John Lennon'.
	customerBook := self inicializarCustomerBookConCustomersActivos: {johnLennon} yCustomersSuspendidos: {}. 
	
	unaOperacion := [customerBook suspendCustomerNamed: 'George Harrison'].
	
	lasCondiciones := Set with: [:anError | customerBook numberOfCustomers = 1.]
					    with: [:anError | customerBook includesCustomerNamed: johnLennon].
	
	self evaluar: unaOperacion yEnCasoDe: CantSuspend checkeamosQueValgan: lasCondiciones.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MLNV 9/6/2023 15:13:53'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon lasCondiciones unaOperacion |
			
	johnLennon := 'John Lennon'.
	customerBook := self inicializarCustomerBookConCustomersActivos: {} yCustomersSuspendidos: {johnLennon}. 
	
	unaOperacion := [customerBook suspendCustomerNamed: johnLennon].
	
	lasCondiciones := Set with: [:anError | customerBook numberOfCustomers = 1.]
					    with: [:anError | customerBook includesCustomerNamed: johnLennon].
	
	self evaluar: unaOperacion yEnCasoDe: CantSuspend checkeamosQueValgan: lasCondiciones.
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'MLNV 9/6/2023 15:16:44'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MLNV 9/6/2023 15:16:51'!
removeCustomerNamed: aName 

	(self includesCustomerNamed: aName) ifFalse: [^NotFound signal].
	
	active remove: aName ifAbsent: [].
	suspended remove: aName ifAbsent: [].
	
	^aName.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/4/2023 17:02:48'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/4/2023 17:02:52'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
