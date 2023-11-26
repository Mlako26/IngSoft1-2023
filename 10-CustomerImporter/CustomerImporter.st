!classDefinition: #PersistentSet category: 'CustomerImporter'!
Set subclass: #PersistentSet
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentSet methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:25:31'!
initializeOn: aSession from: aNonPersistentSet

	session := aSession.
	self addAll: aNonPersistentSet ! !


!PersistentSet methodsFor: 'adding' stamp: 'HAW 11/14/2023 08:23:40'!
add: newObject

	super add: newObject.
	session persist: newObject.
	
	^newObject! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersistentSet class' category: 'CustomerImporter'!
PersistentSet class
	instanceVariableNames: ''!

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:24:32'!
on: aSession

	^self on: aSession from: #()! !

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:25:00'!
on: aSession from: aNonPersistentSet

	^self new initializeOn: aSession from: aNonPersistentSet
! !


!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 19:30:00'!
test01ValidDataIsImportedCorrectly

	CustomerImporter valueFrom: self validImportData into: system.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 21:15:52'!
test02CanNotImportAddressWithoutCustomer

	self
		should: [ CustomerImporter valueFrom: self addressWithoutCustomerData into: system. ]
		raise: Error - MessageNotUnderstood
		withMessageText: CustomerImporter canNotImportAddressWithoutCustomerErrorDescription

	! !

!ImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 20:05:02'!
test03DoesNotImportRecordsStartingWithCButMoreCharacters

	self
		shouldFailImporting: self invalidCustomerRecordStartData
		withImporter: CustomerImporter messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 20:05:02'!
test04DoesNotImportRecordsStartingWithAButMoreCharacters

	self
		shouldFailImporting: self invalidAddressRecordStartData
		withImporter: CustomerImporter messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 20:05:02'!
test05CanNotImportAddressRecordWithLessThanSixFields

	self
		shouldFailImporting: self addressRecordWithLessThanSixFields
		withImporter: CustomerImporter messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 20:05:02'!
test06CanNotImportAddressRecordWithMoreThanSixFields

	self
		shouldFailImporting: self addressRecordWithMoreThanSixFields
		withImporter: CustomerImporter messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 20:05:02'!
test07CanNotImportCustomerRecordWithLessThanFiveFields

	self
		shouldFailImporting: self customerRecordWithLessThanFiveFields
		withImporter: CustomerImporter messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 20:05:02'!
test08CanNotImportCustomerRecordWithMoreThanFiveFields

	self
		shouldFailImporting: self customerRecordWithMoreThanFiveFields
		withImporter: CustomerImporter messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 20:05:02'!
test09CannotImportEmptyLine

	self
		shouldFailImporting: self emptyLine
		withImporter: CustomerImporter messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:34:30'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := system customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:34:37'!
assertImportedOneCustomerWithoutAddress

	| importedCustomer |

	self assert: 1 equals: system numberOfCustomers.
	importedCustomer := system customerWithIdentificationType: 'D' number: '22333444'.
	self assert: importedCustomer isAddressesEmpty
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:33:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: system numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:33:24'!
assertNoCustomerWasImported

	^ self assert: 0 equals: system numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !

!ImportTest methodsFor: 'assertions' stamp: 'pepe 11/23/2023 20:05:20'!
shouldFailImporting: aReadStream withImporter: anImporter messageText: anErrorMessageText asserting: anAssertionBlock

	self
		should: [ anImporter valueFrom: aReadStream into: system. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anErrorMessageText equals: anError messageText.
			anAssertionBlock value ]

	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 21:36:16'!
setUp

	system := Environment current createCustomerSystem.
	system start.
	system beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 20:12:16'!
tearDown

	system commit.
	system stop
	! !


!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:41:20'!
addressRecordWithLessThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:51:35'!
addressRecordWithMoreThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,x'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:14:13'!
addressWithoutCustomerData

	^ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:53:41'!
customerRecordWithLessThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:55:59'!
customerRecordWithMoreThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444,x'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 20:02:57'!
emptyLine

	^ReadStream on: '
'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:34:25'!
invalidAddressRecordStartData

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:22:55'!
invalidCustomerRecordStartData

	^ReadStream on: 'CC,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #SupplierImportTest category: 'CustomerImporter'!
ImportTest subclass: #SupplierImportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!SupplierImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 19:31:59'!
test01SupplierIsImportedCorrectly
	
	| stream supplier |
	stream := ReadStream on: 'S,Supplier1,D,123'. 
	SupplierImporter valueFrom: stream into: system.

	self assert: system numberOfSuppliers equals: 1.
	supplier := system supplierWithIdentificationType: 'D' number: '123'.
	self assert: supplier firstName equals: 'Supplier1'.! !

!SupplierImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 19:32:05'!
test02SupplierImporterImportsAddresses
	
	| stream supplier |
	stream := ReadStream on: 
'S,Supplier1,D,123
A,San Martin,3322,Olivos,1636,BsAs'. 

	SupplierImporter valueFrom: stream into: system.

	self assert: system numberOfSuppliers equals: 1.
	supplier := system supplierWithIdentificationType: 'D' number: '123'.
	self assert: supplier firstName equals: 'Supplier1'.
	
	self assert: supplier addresses size equals: 1.
	self assertAddressOf: supplier at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	
	
	
	! !

!SupplierImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 19:32:10'!
test03SupplierImporterImportsNewCustomer
	
	| stream supplier |
	stream := ReadStream on: 
'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444'. 

	SupplierImporter valueFrom: stream into: system.

	self assert: system numberOfSuppliers equals: 1.
	supplier := system supplierWithIdentificationType: 'D' number: '123'.
	self assert: supplier firstName equals: 'Supplier1'.
	
	self assert: supplier customers size equals: 1.
	self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.	
	self assertCustomerOf: supplier WithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.	
	
	
	
	
	! !

!SupplierImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 19:32:16'!
test04SupplierImporterImportsNewCustomer
	
	| stream supplier |
	stream := ReadStream on: 
'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444
S,Supplier2,D,456
EC,D,22333444'. 

	SupplierImporter valueFrom: stream into: system.

	self assert: system numberOfSuppliers equals: 2.
	supplier := system supplierWithIdentificationType: 'D' number: '456'.
	self assert: supplier firstName equals: 'Supplier2'.
	
	self assert: supplier customers size equals: 1.
	self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.	
	self assertCustomerOf: supplier WithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.	
	
	
	
	
	! !

!SupplierImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 20:06:12'!
test05DoesNotImportRecordsStartingWithSButMoreCharacters
	
	self
		shouldFailImporting: self invalidSupplierRecordStartData
		withImporter: SupplierImporter messageText: SupplierImporter invalidRecordTypeErrorDescription
		asserting: [ 
			self assert: 0 equals: system numberOfSuppliers
			]
	
	
	! !

!SupplierImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 20:22:39'!
test06DoesNotImportRecordsStartingWithNCButMoreCharacters
	
	self
		shouldFailImporting: self invalidNewCustomerRecordStartData 
		withImporter: SupplierImporter messageText: SupplierImporter invalidRecordTypeErrorDescription
		asserting: [ 
			| importedSupplier |
			self assert: 1 equals: system numberOfSuppliers.
			importedSupplier := system supplierWithIdentificationType: 'D' number: '22333444'.
			self assert: importedSupplier isCustomersEmpty
			]
	
	
	! !

!SupplierImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 20:27:41'!
test07DoesNotImportRecordsStartingWithECButMoreCharacters
	
	self
		shouldFailImporting: self invalidExistingCustomerRecordStartData
		withImporter: SupplierImporter messageText: SupplierImporter invalidRecordTypeErrorDescription
		asserting: [ 
			| importedSupplier |
			self assert: 2 equals: system numberOfSuppliers.
			importedSupplier := system supplierWithIdentificationType: 'D' number: '456'.
			self assert: importedSupplier isCustomersEmpty
			]
	
	
	! !

!SupplierImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 20:28:47'!
test08CannotImportEmptyLine

	self
		shouldFailImporting: self emptyLine
		withImporter: SupplierImporter messageText: SupplierImporter invalidRecordTypeErrorDescription
		asserting: [ self assert: 0 equals: system numberOfSuppliers ]
! !

!SupplierImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 20:38:37'!
test09CanNotImportAddressRecordWithLessThanSixFields

	self
		shouldFailImporting: self lessThanSixFieldsAddressRecordForSuppliers
		withImporter: SupplierImporter messageText: SupplierImporter invalidAddressRecordErrorDescription
		asserting: [
			 | importedSupplier |
			self assert: 1 equals: system numberOfSuppliers.
			importedSupplier := system supplierWithIdentificationType: 'D' number: '22333444'.
			self assert: importedSupplier isAddressesEmpty
			 ]

	! !

!SupplierImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 20:38:49'!
test10CanNotImportAddressRecordWithMoreThanSixFields

	self
		shouldFailImporting: self moreThanSixFieldsAddressRecordForSuppliers
		withImporter: SupplierImporter messageText: SupplierImporter invalidAddressRecordErrorDescription
		asserting: [
			 | importedSupplier |
			self assert: 1 equals: system numberOfSuppliers.
			importedSupplier := system supplierWithIdentificationType: 'D' number: '22333444'.
			self assert: importedSupplier isAddressesEmpty
			 ]

	! !

!SupplierImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 20:57:47'!
test11CanNotImportAddressWithoutSupplier

	self
		should: [ SupplierImporter valueFrom: self addressWithoutSupplierInvalidData into: system. ]
		raise: Error - MessageNotUnderstood
		withMessageText: SupplierImporter canNotImportWithoutASupplierErrorDescription

	! !

!SupplierImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 20:57:15'!
test12CanNotImportCustomerWithoutSupplier

	self
		should: [ SupplierImporter valueFrom: self newCustomerWithoutSupplierInvalidData into: system. ]
		raise: Error - MessageNotUnderstood
		withMessageText: SupplierImporter canNotImportWithoutASupplierErrorDescription.
		
	self
		should: [ SupplierImporter valueFrom: self existingCustomerWithoutSupplierInvalidData into: system. ]
		raise: Error - MessageNotUnderstood
		withMessageText: SupplierImporter canNotImportWithoutASupplierErrorDescription.

	! !

!SupplierImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 21:12:28'!
test15CanNotImportExistingCustomerRecordWithMoreThanThreeFields

	self
		shouldFailImporting: self moreThanThreeFieldsExistingCustomerRecordForSuppliers 
		withImporter: SupplierImporter messageText: SupplierImporter invalidCustomerRecordErrorDescription
		asserting: [
			 | importedSupplier |
			self assert: 2 equals: system numberOfSuppliers.
			importedSupplier := system supplierWithIdentificationType: 'D' number: '456'.
			self assert: importedSupplier isCustomersEmpty
			 ]

	! !

!SupplierImportTest methodsFor: 'tests' stamp: 'pepe 11/23/2023 21:12:36'!
test16CanNotImportExistingCustomerRecordWithLessThanThreeFields

	self
		shouldFailImporting: self lessThanThreeFieldsExistingCustomerRecordForSuppliers 
		withImporter: SupplierImporter messageText: SupplierImporter invalidCustomerRecordErrorDescription
		asserting: [
			 | importedSupplier |
			self assert: 2 equals: system numberOfSuppliers.
			importedSupplier := system supplierWithIdentificationType: 'D' number: '456'.
			self assert: importedSupplier isCustomersEmpty
			 ]

	! !


!SupplierImportTest methodsFor: 'assertions' stamp: 'pepe 11/23/2023 19:31:15'!
assertCustomerOf: supplier WithIdentificationType: anIdType number:anIdNumber  hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |
	
	importedCustomer := supplier customerWithIDType: anIdType andIdNumber: anIdNumber ifNone: [ self fail ].
	
	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.! !


!SupplierImportTest methodsFor: 'test data' stamp: 'pepe 11/23/2023 20:44:30'!
addressWithoutSupplierInvalidData

	^ ReadStream on: 
'A,San Martin,3322,Olivos,1636,BsAs'! !

!SupplierImportTest methodsFor: 'test data' stamp: 'pepe 11/23/2023 20:47:55'!
existingCustomerWithoutSupplierInvalidData

	^ ReadStream on: 
'EC,D,5456774'! !

!SupplierImportTest methodsFor: 'test data' stamp: 'pepe 11/23/2023 20:25:49'!
invalidExistingCustomerRecordStartData

	^ReadStream on: 
'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444
S,Supplier2,D,456
ECC,D,22333444'. ! !

!SupplierImportTest methodsFor: 'test data' stamp: 'pepe 11/23/2023 20:25:42'!
invalidNewCustomerRecordStartData

	^ReadStream on: 
'S,Supplier1,D,22333444
NCC,Pepe,Sanchez,D,22333444'. ! !

!SupplierImportTest methodsFor: 'test data' stamp: 'pepe 11/23/2023 20:05:53'!
invalidSupplierRecordStartData

	^ReadStream on: 'SS,Pepe,D,22333444'! !

!SupplierImportTest methodsFor: 'test data' stamp: 'pepe 11/23/2023 21:03:50'!
lessThanFiveFieldsNewCustomerRecordForSuppliers

	^ ReadStream on: 
'S,Pepe,D,22333444
NC,Pepe,Sanchez,D22333444'! !

!SupplierImportTest methodsFor: 'test data' stamp: 'pepe 11/23/2023 21:03:31'!
lessThanSixFieldsAddressRecordForSuppliers

	^ ReadStream on: 
'S,Pepe,D,22333444
A,San Martin,3322,Olivos'! !

!SupplierImportTest methodsFor: 'test data' stamp: 'pepe 11/23/2023 21:04:58'!
lessThanThreeFieldsExistingCustomerRecordForSuppliers

	^ ReadStream on: 
'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444
S,Supplier2,D,456
EC,D'. ! !

!SupplierImportTest methodsFor: 'test data' stamp: 'pepe 11/23/2023 21:02:55'!
moreThanFiveFieldsNewCustomerRecordForSuppliers

	^ ReadStream on: 
'S,Pepe,D,22333444
NC,Pepe,Sanchez,D,22333,444'! !

!SupplierImportTest methodsFor: 'test data' stamp: 'pepe 11/23/2023 20:39:44'!
moreThanSixFieldsAddressRecordForSuppliers

	^ ReadStream on: 
'S,Pepe,D,22333444
A,San Martin,3322,Olivos,1636,234,234'! !

!SupplierImportTest methodsFor: 'test data' stamp: 'pepe 11/23/2023 21:04:48'!
moreThanThreeFieldsExistingCustomerRecordForSuppliers

	^ ReadStream on: 
'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444
S,Supplier2,D,456
EC,D,22333,444'. ! !

!SupplierImportTest methodsFor: 'test data' stamp: 'pepe 11/23/2023 20:48:11'!
newCustomerWithoutSupplierInvalidData

	^ ReadStream on: 
'NC,Pepe,Sanchez,D,22333444'! !

!SupplierImportTest methodsFor: 'test data' stamp: 'pepe 11/23/2023 19:31:03'!
validSupplierData

	^ ReadStream on: 
'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444
EC,D,5456774
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 19:38:32'!
isAddressesEmpty

	^addresses isEmpty ! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #Supplier category: 'CustomerImporter'!
Customer subclass: #Supplier
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Supplier methodsFor: 'as yet unclassified' stamp: 'pepe 11/23/2023 19:04:09'!
addCustomer: aCustomer

	customers add: aCustomer ! !

!Supplier methodsFor: 'as yet unclassified' stamp: 'pepe 11/23/2023 19:00:59'!
customerWithIDType: anIdType andIdNumber: anIdNumber ifNone: aNoneBlock

	^customers detect: [ :aCustomer | aCustomer identificationType = anIdType and: 
								[aCustomer identificationNumber = anIdNumber ]] 
			ifNone: aNoneBlock. ! !

!Supplier methodsFor: 'as yet unclassified' stamp: 'pepe 11/23/2023 18:52:30'!
customers
	^customers.! !

!Supplier methodsFor: 'as yet unclassified' stamp: 'pepe 11/23/2023 18:53:04'!
initialize

	super initialize.
	customers := OrderedCollection new.
	! !

!Supplier methodsFor: 'as yet unclassified' stamp: 'pepe 11/23/2023 20:23:43'!
isCustomersEmpty

	^customers isEmpty ! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'readStream newCustomer line record system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 21:15:17'!
initializeFrom: aReadStream into: aCustomerSystem

	readStream := aReadStream.
	system := aCustomerSystem ! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'HAW 5/22/2022 18:48:58'!
value

	[ self hasLineToImport ] whileTrue: [
		self createRecord.
		self importRecord ].

	! !


!CustomerImporter methodsFor: 'customer' stamp: 'HAW 5/22/2022 19:59:39'!
assertValidCustomerRecord

	^ record size ~= 5 ifTrue: [ self error: self class invalidCustomerRecordErrorDescription ]! !

!CustomerImporter methodsFor: 'customer' stamp: 'HAW 5/22/2022 21:13:47'!
importCustomer

	self assertValidCustomerRecord.

	newCustomer := Customer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth.
	system add: newCustomer! !

!CustomerImporter methodsFor: 'customer' stamp: 'HAW 5/22/2022 19:23:55'!
isCustomerRecord

	^ record first = 'C'! !


!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:58:41'!
assertCustomerWasImported

	^ newCustomer ifNil: [ self error: self class canNotImportAddressWithoutCustomerErrorDescription ]! !

!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:59:12'!
assertValidAddressRecord

	^ record size ~= 6 ifTrue: [ self error: self class invalidAddressRecordErrorDescription ]! !

!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:59:12'!
importAddress

	| newAddress |

	self assertCustomerWasImported.
	self assertValidAddressRecord.

	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth! !

!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:37:45'!
isAddressRecord

	^ record first = 'A'! !


!CustomerImporter methodsFor: 'evaluating - private' stamp: 'HAW 5/22/2022 20:04:35'!
assertRecordNotEmpty

	record isEmpty ifTrue: [ self error: self class invalidRecordTypeErrorDescription ]! !

!CustomerImporter methodsFor: 'evaluating - private' stamp: 'HAW 5/22/2022 18:47:26'!
createRecord

	^ record := line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating - private' stamp: 'HAW 5/22/2022 18:49:33'!
hasLineToImport

	line := readStream nextLine.
	^line notNil! !

!CustomerImporter methodsFor: 'evaluating - private' stamp: 'HAW 5/22/2022 20:04:06'!
importRecord

	self assertRecordNotEmpty.

	self isCustomerRecord ifTrue: [ ^self importCustomer ].
	self isAddressRecord ifTrue: [ ^self importAddress ].

	self error: self class invalidRecordTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 21:15:35'!
from: aReadStream into: aCustomerSystem

	^self new initializeFrom: aReadStream into: aCustomerSystem! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 21:15:52'!
valueFrom: aReadStream into: aCustomerSystem

	^(self from: aReadStream into: aCustomerSystem) value! !


!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:13:48'!
canNotImportAddressWithoutCustomerErrorDescription

	^'Cannot import address without customer'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:41:39'!
invalidAddressRecordErrorDescription

	^'Address record has to have six fields'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:53:56'!
invalidCustomerRecordErrorDescription

	^'Invalid Customer record'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:24:11'!
invalidRecordTypeErrorDescription

	^'Invalid record type'! !


!classDefinition: #SupplierImporter category: 'CustomerImporter'!
CustomerImporter subclass: #SupplierImporter
	instanceVariableNames: 'newSupplier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!SupplierImporter methodsFor: 'as yet unclassified' stamp: 'pepe 11/23/2023 20:56:33'!
assertSupplierWasImported

	^ newSupplier ifNil: [ self error: self class canNotImportWithoutASupplierErrorDescription ]! !

!SupplierImporter methodsFor: 'as yet unclassified' stamp: 'pepe 11/23/2023 21:09:35'!
assertValidExistingCustomerRecord

	^ record size ~= 3 ifTrue: [ self error: self class invalidCustomerRecordErrorDescription ]! !

!SupplierImporter methodsFor: 'as yet unclassified' stamp: 'pepe 11/23/2023 20:51:40'!
importAddress

	| newAddress |
	
	self assertValidAddressRecord.
	self assertSupplierWasImported.
	
	newAddress := Address new.
	newSupplier addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth! !

!SupplierImporter methodsFor: 'as yet unclassified' stamp: 'pepe 11/23/2023 21:10:04'!
importExistingCustomer

	| existingCustomer |
	self assertSupplierWasImported.
	self assertValidExistingCustomerRecord.
	
	existingCustomer := system customerWithIdentificationType: (record second) number: (record third).
	newSupplier addCustomer: existingCustomer.
	! !

!SupplierImporter methodsFor: 'as yet unclassified' stamp: 'pepe 11/23/2023 21:10:44'!
importNewCustomer
	
	self assertSupplierWasImported.
	
	self importCustomer.

	newSupplier addCustomer: newCustomer.
	! !

!SupplierImporter methodsFor: 'as yet unclassified' stamp: 'pepe 11/23/2023 20:54:29'!
importRecord

	self assertRecordNotEmpty.
	
	self isSupplierRecord ifTrue: [ ^self importSupplier].
	self isNewCustomerRecord ifTrue: [ ^self importNewCustomer].
	self isExistingCustomerRecord ifTrue: [ ^self importExistingCustomer].
	self isAddressRecord ifTrue: [ ^self importAddress ].
	
	self error: self class invalidRecordTypeErrorDescription! !

!SupplierImporter methodsFor: 'as yet unclassified' stamp: 'pepe 11/23/2023 18:25:24'!
importSupplier
	
	newSupplier := Supplier new.
	newSupplier firstName: record second.
	newSupplier identificationType: record third.
	newSupplier identificationNumber: record fourth.
	system addSupplier: newSupplier! !

!SupplierImporter methodsFor: 'as yet unclassified' stamp: 'pepe 11/23/2023 19:08:40'!
isExistingCustomerRecord

	^ record first = 'EC'! !

!SupplierImporter methodsFor: 'as yet unclassified' stamp: 'pepe 11/23/2023 19:02:12'!
isNewCustomerRecord

	^ record first = 'NC'! !

!SupplierImporter methodsFor: 'as yet unclassified' stamp: 'pepe 11/23/2023 18:46:22'!
isSupplierRecord

	^ record first = 'S'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SupplierImporter class' category: 'CustomerImporter'!
SupplierImporter class
	instanceVariableNames: ''!

!SupplierImporter class methodsFor: 'as yet unclassified' stamp: 'pepe 11/23/2023 20:56:33'!
canNotImportWithoutASupplierErrorDescription

	^'Cannot import address without supplier'! !


!classDefinition: #CustomerSystem category: 'CustomerImporter'!
Object subclass: #CustomerSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:17:57'!
add: aCustomer

	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:18:38'!
customerWithIdentificationType: anIdType number: anIdNumber

	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:18:51'!
numberOfCustomers

	self subclassResponsibility ! !


!CustomerSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:18:04'!
beginTransaction

	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:18:16'!
commit

	self subclassResponsibility ! !


!CustomerSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:18:10'!
start

	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:18:13'!
stop

	self subclassResponsibility ! !


!classDefinition: #PersistentCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #PersistentCustomerSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:14:14'!
add: aCustomer

	^session persist: aCustomer ! !

!PersistentCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:09:50'!
customerWithIdentificationType: anIdType number: anIdNumber

	^(session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !

!PersistentCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:08:47'!
numberOfCustomers

	^(session selectAllOfType: Customer) size! !


!PersistentCustomerSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 20:12:39'!
beginTransaction

	session beginTransaction.
! !

!PersistentCustomerSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 20:13:00'!
commit

	session commit ! !


!PersistentCustomerSystem methodsFor: 'system lifecycle' stamp: 'HAW 11/14/2023 09:21:54'!
start

	session := DataBaseSession for: (Array with: Address with: Customer).
	! !

!PersistentCustomerSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 20:13:10'!
stop

	session close! !


!classDefinition: #TransientCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #TransientCustomerSystem
	instanceVariableNames: 'customers suppliers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientCustomerSystem methodsFor: 'system lifecycle' stamp: 'pepe 11/23/2023 18:26:06'!
start

	customers := OrderedCollection new.
	suppliers := OrderedCollection new.! !

!TransientCustomerSystem methodsFor: 'system lifecycle' stamp: 'pepe 11/23/2023 18:26:19'!
stop

	customers := nil.
	suppliers := nil.! !


!TransientCustomerSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:21:20'!
beginTransaction

	! !

!TransientCustomerSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:23:01'!
commit

	! !


!TransientCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:21:32'!
add: aCustomer

	customers add: aCustomer ! !

!TransientCustomerSystem methodsFor: 'customers' stamp: 'pepe 11/23/2023 18:25:46'!
addSupplier: aSupplier

	suppliers add: aSupplier ! !

!TransientCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:22:52'!
customerWithIdentificationType: anIdType number: anIdNumber

	^customers detect: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]! !

!TransientCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:21:43'!
numberOfCustomers

	^customers size! !


!TransientCustomerSystem methodsFor: 'as yet unclassified' stamp: 'pepe 11/23/2023 18:26:40'!
numberOfSuppliers
	^suppliers size.! !

!TransientCustomerSystem methodsFor: 'as yet unclassified' stamp: 'pepe 11/23/2023 18:27:38'!
supplierWithIdentificationType: anIdType number: anIdNumber
	
	^suppliers detect: [ :aSupplier | aSupplier identificationType = anIdType and: [ aSupplier identificationNumber = anIdNumber ]]! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id inTransaction closed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:25'!
beginTransaction

	inTransaction := true.! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:18'!
commit

	inTransaction := false.! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 11/14/2023 08:52:30'!
close

	closed := true.! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:49:30'!
assertCanUseDatabase

	self assertIsOpen.
	self assertInTransaction ! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:43'!
assertInTransaction

	inTransaction ifFalse: [ self error: 'Not in transaction' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:16'!
assertIsOpen

	closed ifTrue: [ self error: 'Connection with database closed' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:09:07'!
assertTypeIsPersisted: aType

	(configuration includes: aType) ifFalse: [ self error: 'Object of type ', aType name, ' are not configured to be persisted' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
isRelationToPersist: possibleRelation

	^ possibleRelation class = Set! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
persistPossibleRelationOf: anObject at: anInstVarOffset

	| possibleRelation |
		
	possibleRelation := anObject instVarAt: anInstVarOffset.
	(self isRelationToPersist: possibleRelation) ifTrue: [ self persistRelationOf: anObject at: anInstVarOffset with: possibleRelation ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:03'!
persistRelationOf: anObject at: anInstVarOffset with: aRelation

	| persistentRelation |
	
	persistentRelation := PersistentSet on: self from: aRelation.
	anObject instVarAt: anInstVarOffset put: persistentRelation! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:34'!
persistRelationsOf: anObject

	anObject class instVarNamesAndOffsetsDo: [ :anInstVarName :anInstVarOffset | self persistPossibleRelationOf: anObject at: anInstVarOffset]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:06:24'!
tableOfType: aType

	^ tables at: aType ifAbsentPut: [ Set new ]! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:44:19'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.
	inTransaction := false.
	closed := false.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 11/14/2023 09:06:24'!
persist: anObject

	| table |

	self assertCanUseDatabase.
	self assertTypeIsPersisted: anObject class.
	self delay.
	
	table := self tableOfType: anObject class.
	self defineIdOf: anObject.
	table add: anObject.
	self persistRelationsOf: anObject.
! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:06:56'!
select: aCondition ofType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:07:12'!
selectAllOfType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


!classDefinition: #Environment category: 'CustomerImporter'!
Object subclass: #Environment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Environment methodsFor: 'customer system' stamp: 'HAW 5/22/2022 21:41:06'!
createCustomerSystem

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Environment class' category: 'CustomerImporter'!
Environment class
	instanceVariableNames: ''!

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:37:10'!
current

	^(self subclasses detect: [ :anEnvironmentClass | anEnvironmentClass isCurrent ]) new! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:46'!
environmentKey

	^ #ENV! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:46'!
environmentVariable

	^ Smalltalk at: self environmentKey! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:09'!
identifier

	self subclassResponsibility! !

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:41:36'!
isCurrent

	self subclassResponsibility ! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:46:01'!
makeCurrent

	"
	Tener en cuenta que en Smalltalk se podría poner directamente la clase de environment,
	esto es DevelopmentEnvironment o IntegrationEnvironmet o hasta una instancia de ellas,
	pero se está simulando el hecho de que esto esté definido por fuera del sistema, como una
	variable del sistema operativo - Hernan"
	
	Smalltalk at: self environmentKey put: self identifier! !


!classDefinition: #DevelopmentEnvironment category: 'CustomerImporter'!
Environment subclass: #DevelopmentEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DevelopmentEnvironment methodsFor: 'customer system' stamp: 'HAW 5/22/2022 21:38:39'!
createCustomerSystem

	^TransientCustomerSystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DevelopmentEnvironment class' category: 'CustomerImporter'!
DevelopmentEnvironment class
	instanceVariableNames: ''!

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:42:50'!
identifier

	^ #DEV! !

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:43:52'!
isCurrent

	"
	self makeCurrent
	"
	^self environmentVariable = self identifier! !


!classDefinition: #IntegrationEnvironment category: 'CustomerImporter'!
Environment subclass: #IntegrationEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!IntegrationEnvironment methodsFor: 'customer system' stamp: 'HAW 5/22/2022 21:40:48'!
createCustomerSystem

	^PersistentCustomerSystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegrationEnvironment class' category: 'CustomerImporter'!
IntegrationEnvironment class
	instanceVariableNames: ''!

!IntegrationEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:43:07'!
identifier

	^ #INT! !

!IntegrationEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:04'!
isCurrent

	"
	self makeCurrent
	"
	^self environmentVariable = self identifier! !
