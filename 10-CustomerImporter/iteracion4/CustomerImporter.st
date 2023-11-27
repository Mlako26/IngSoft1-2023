!classDefinition: #PersistentSet category: 'CustomerImporter'!
Set subclass: #PersistentSet
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentSet methodsFor: 'initialization' stamp: 'MLNV 11/26/2023 21:05:46'!
initializeOn: aSession from: aNonPersistentSet

	session := aSession.
	self addAll: aNonPersistentSet ! !


!PersistentSet methodsFor: 'adding' stamp: 'MLNV 11/26/2023 21:05:46'!
add: newObject

	super addCustomer: newObject.
	session persist: newObject.
	
	^newObject! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersistentSet class' category: 'CustomerImporter'!
PersistentSet class
	instanceVariableNames: ''!

!PersistentSet class methodsFor: 'instance creation' stamp: 'MLNV 11/26/2023 21:05:46'!
on: aSession

	^self on: aSession from: #()! !

!PersistentSet class methodsFor: 'instance creation' stamp: 'MLNV 11/26/2023 21:05:46'!
on: aSession from: aNonPersistentSet

	^self new initializeOn: aSession from: aNonPersistentSet
! !


!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:43'!
test01ValidDataIsImportedCorrectly

	CustomerImporter valueFrom: self validImportData into: system.
		
	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:43'!
test02CanNotImportAddressWithoutCustomer

	self
		should: [ CustomerImporter valueFrom: self addressWithoutCustomerData into: system. ]
		raise: Error - MessageNotUnderstood
		withMessageText: CustomerImporter canNotImportAddressWithoutCustomerErrorDescription

	! !

!ImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:43'!
test03DoesNotImportRecordsStartingWithCButMoreCharacters

	self
		shouldFailImporting: self invalidCustomerRecordStartData
		withImporter: CustomerImporter messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:43'!
test04DoesNotImportRecordsStartingWithAButMoreCharacters

	self
		shouldFailImporting: self invalidAddressRecordStartData
		withImporter: CustomerImporter messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:44'!
test05CanNotImportAddressRecordWithLessThanSixFields

	self
		shouldFailImporting: self addressRecordWithLessThanSixFields
		withImporter: CustomerImporter messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:43'!
test06CanNotImportAddressRecordWithMoreThanSixFields

	self
		shouldFailImporting: self addressRecordWithMoreThanSixFields
		withImporter: CustomerImporter messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:43'!
test07CanNotImportCustomerRecordWithLessThanFiveFields

	self
		shouldFailImporting: self customerRecordWithLessThanFiveFields
		withImporter: CustomerImporter messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:43'!
test08CanNotImportCustomerRecordWithMoreThanFiveFields

	self
		shouldFailImporting: self customerRecordWithMoreThanFiveFields
		withImporter: CustomerImporter messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:43'!
test09CannotImportEmptyLine

	self
		shouldFailImporting: self emptyLine
		withImporter: CustomerImporter messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !


!ImportTest methodsFor: 'assertions' stamp: 'MLNV 11/26/2023 21:05:43'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'MLNV 11/26/2023 21:05:43'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := system customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'MLNV 11/26/2023 21:05:43'!
assertImportedOneCustomerWithoutAddress

	| importedCustomer |

	self assert: 1 equals: system numberOfCustomers.
	importedCustomer := system customerWithIdentificationType: 'D' number: '22333444'.
	self assert: importedCustomer isAddressesEmpty
	! !

!ImportTest methodsFor: 'assertions' stamp: 'MLNV 11/26/2023 21:05:43'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: system numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'MLNV 11/26/2023 21:05:43'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'MLNV 11/26/2023 21:05:43'!
assertNoCustomerWasImported

	^ self assert: 0 equals: system numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'MLNV 11/26/2023 21:05:44'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !

!ImportTest methodsFor: 'assertions' stamp: 'MLNV 11/26/2023 21:05:43'!
shouldFailImporting: aReadStream withImporter: anImporter messageText: anErrorMessageText asserting: anAssertionBlock

	self
		should: [ anImporter valueFrom: aReadStream into: system. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anErrorMessageText equals: anError messageText.
			anAssertionBlock value ]

	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'MLNV 11/26/2023 21:05:43'!
setUp

	system := Environment current createCustomerSystem.
	system start.
	system beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'MLNV 11/26/2023 21:05:43'!
tearDown

	system commit.
	system stop
	! !


!ImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:43'!
addressRecordWithLessThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'! !

!ImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:43'!
addressRecordWithMoreThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,x'! !

!ImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:44'!
addressWithoutCustomerData

	^ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:43'!
customerRecordWithLessThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D'! !

!ImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:43'!
customerRecordWithMoreThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444,x'! !

!ImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:44'!
emptyLine

	^ReadStream on: '
'! !

!ImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:43'!
invalidAddressRecordStartData

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:43'!
invalidCustomerRecordStartData

	^ReadStream on: 'CC,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:43'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #SupplierImportTest category: 'CustomerImporter'!
ImportTest subclass: #SupplierImportTest
	instanceVariableNames: 'pattern'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!SupplierImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:48'!
test01SupplierIsImportedCorrectly
	
	| stream supplier |
	stream := ReadStream on: 'S,Supplier1,D,123'. 
	SupplierImporter valueFrom: stream into: system.

	self assert: system numberOfSuppliers equals: 1.
	supplier := system supplierWithIdentificationType: 'D' number: '123'.
	self assert: supplier firstName equals: 'Supplier1'.! !

!SupplierImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:47'!
test02SupplierImporterImportsAddresses
	
	| stream supplier |
	stream := ReadStream on: 
'S,Supplier1,D,123
A,San Martin,3322,Olivos,1636,BsAs'. 

	SupplierImporter valueFrom: stream into: system.

	self assert: system numberOfSuppliers equals: 1.
	supplier := system supplierWithIdentificationType: 'D' number: '123'.
	self assert: supplier firstName equals: 'Supplier1'.
	
	self assert: (supplier amountOfAddresses) equals: 1.
	self assertAddressOf: supplier at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	
	
	
	! !

!SupplierImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:19:53'!
test03SupplierImporterImportsNewCustomer
	
	| stream supplier |
	stream := ReadStream on: 
'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444'. 

	SupplierImporter valueFrom: stream into: system.

	self assert: system numberOfSuppliers equals: 1.
	supplier := system supplierWithIdentificationType: 'D' number: '123'.
	self assert: supplier firstName equals: 'Supplier1'.
	
	self assert: supplier amountOfCustomers equals: 1.
	self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.	
	self assertCustomerOf: supplier WithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.	
	
	
	
	
	! !

!SupplierImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:19:56'!
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
	
	self assert: supplier amountOfCustomers equals: 1.
	self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.	
	self assertCustomerOf: supplier WithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.	
	
	
	
	
	! !

!SupplierImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:48'!
test05DoesNotImportRecordsStartingWithSButMoreCharacters
	
	self
		shouldFailImporting: self invalidSupplierRecordStartData
		withImporter: SupplierImporter messageText: SupplierImporter invalidRecordTypeErrorDescription
		asserting: [ 
			self assert: 0 equals: system numberOfSuppliers
			]
	
	
	! !

!SupplierImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:47'!
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

!SupplierImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:48'!
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

!SupplierImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:48'!
test08CannotImportEmptyLine

	self
		shouldFailImporting: self emptyLine
		withImporter: SupplierImporter messageText: SupplierImporter invalidRecordTypeErrorDescription
		asserting: [ self assert: 0 equals: system numberOfSuppliers ]
! !

!SupplierImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:47'!
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

!SupplierImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:46'!
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

!SupplierImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:47'!
test11CanNotImportAddressWithoutSupplier

	self
		should: [ SupplierImporter valueFrom: self addressWithoutSupplierInvalidData into: system. ]
		raise: Error - MessageNotUnderstood
		withMessageText: SupplierImporter canNotImportWithoutASupplierErrorDescription

	! !

!SupplierImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:46'!
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

!SupplierImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:49'!
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

!SupplierImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:47'!
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

!SupplierImportTest methodsFor: 'tests' stamp: 'MLNV 11/26/2023 21:05:48'!
test17CanNotImportExistingNewCustomer

	self
		shouldFailImporting: self existingNewCustomerInvalidData 
		withImporter: SupplierImporter messageText: SupplierImporter canNotImportExistingNewCustomer 
		asserting: [
			 | importedSupplier |
			self assert: 1 equals: system numberOfSuppliers.
			importedSupplier := system supplierWithIdentificationType: 'D' number: '123'.
			self deny: importedSupplier isCustomersEmpty
			 ]

	! !


!SupplierImportTest methodsFor: 'assertions' stamp: 'MLNV 11/26/2023 21:05:46'!
assertCustomerOf: supplier WithIdentificationType: anIdType number:anIdNumber  hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |
	
	importedCustomer := supplier customerWithIDType: anIdType andIdNumber: anIdNumber ifNone: [ self fail ].
	
	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.! !


!SupplierImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:47'!
addressWithoutSupplierInvalidData

	^ ReadStream on: 
'A,San Martin,3322,Olivos,1636,BsAs'! !

!SupplierImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:49'!
existingCustomerWithoutSupplierInvalidData

	^ ReadStream on: 
'EC,D,5456774'! !

!SupplierImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:46'!
existingNewCustomerInvalidData
	
	^ ReadStream on: 
'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444
NC,Pepe,Sanchez,D,22333444'! !

!SupplierImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:49'!
invalidExistingCustomerRecordStartData

	^ReadStream on: 
'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444
S,Supplier2,D,456
ECC,D,22333444'. ! !

!SupplierImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:49'!
invalidNewCustomerRecordStartData

	^ReadStream on: 
'S,Supplier1,D,22333444
NCC,Pepe,Sanchez,D,22333444'. ! !

!SupplierImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:48'!
invalidSupplierRecordStartData

	^ReadStream on: 'SS,Pepe,D,22333444'! !

!SupplierImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:47'!
lessThanFiveFieldsNewCustomerRecordForSuppliers

	^ ReadStream on: 
'S,Pepe,D,22333444
NC,Pepe,Sanchez,D22333444'! !

!SupplierImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:47'!
lessThanSixFieldsAddressRecordForSuppliers

	^ ReadStream on: 
'S,Pepe,D,22333444
A,San Martin,3322,Olivos'! !

!SupplierImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:47'!
lessThanThreeFieldsExistingCustomerRecordForSuppliers

	^ ReadStream on: 
'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444
S,Supplier2,D,456
EC,D'. ! !

!SupplierImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:48'!
moreThanFiveFieldsNewCustomerRecordForSuppliers

	^ ReadStream on: 
'S,Pepe,D,22333444
NC,Pepe,Sanchez,D,22333,444'! !

!SupplierImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:48'!
moreThanSixFieldsAddressRecordForSuppliers

	^ ReadStream on: 
'S,Pepe,D,22333444
A,San Martin,3322,Olivos,1636,234,234'! !

!SupplierImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:49'!
moreThanThreeFieldsExistingCustomerRecordForSuppliers

	^ ReadStream on: 
'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444
S,Supplier2,D,456
EC,D,22333,444'. ! !

!SupplierImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:48'!
newCustomerWithoutSupplierInvalidData

	^ ReadStream on: 
'NC,Pepe,Sanchez,D,22333444'! !

!SupplierImportTest methodsFor: 'test data' stamp: 'MLNV 11/26/2023 21:05:46'!
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

!Address methodsFor: 'province' stamp: 'MLNV 11/26/2023 21:05:42'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'MLNV 11/26/2023 21:05:42'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'MLNV 11/26/2023 21:05:42'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'MLNV 11/26/2023 21:05:42'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'MLNV 11/26/2023 21:05:42'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'MLNV 11/26/2023 21:05:42'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'MLNV 11/26/2023 21:05:42'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'MLNV 11/26/2023 21:05:42'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'MLNV 11/26/2023 21:05:42'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'MLNV 11/26/2023 21:05:42'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'MLNV 11/26/2023 21:05:42'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #CSVImporter category: 'CustomerImporter'!
Object subclass: #CSVImporter
	instanceVariableNames: 'readStream line record system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CSVImporter methodsFor: 'evaluating - private' stamp: 'MLNV 11/26/2023 21:05:42'!
assertRecordNotEmpty

	record isEmpty ifTrue: [ self error: self class invalidRecordTypeErrorDescription ]! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'MLNV 11/26/2023 21:05:42'!
createRecord

	^ record := line findTokens: $,! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'MLNV 11/26/2023 21:05:42'!
hasLineToImport

	line := readStream nextLine.
	^line notNil! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'MLNV 11/26/2023 21:05:42'!
importRecord

	self subclassResponsibility! !


!CSVImporter methodsFor: 'evaluating' stamp: 'MLNV 11/26/2023 21:05:42'!
value

	[ self hasLineToImport ] whileTrue: [
		self createRecord.
		self importRecord ].

	! !


!CSVImporter methodsFor: 'initialization' stamp: 'MLNV 11/26/2023 21:05:42'!
initializeFrom: aReadStream into: aSystem

	readStream := aReadStream.
	system := aSystem ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CSVImporter class' category: 'CustomerImporter'!
CSVImporter class
	instanceVariableNames: ''!

!CSVImporter class methodsFor: 'error messages' stamp: 'MLNV 11/26/2023 21:05:42'!
invalidRecordTypeErrorDescription

	^'Invalid record type'! !


!CSVImporter class methodsFor: 'instance creation' stamp: 'MLNV 11/26/2023 21:05:42'!
from: aReadStream into: aSystem

	^self new initializeFrom: aReadStream into: aSystem! !


!CSVImporter class methodsFor: 'importing' stamp: 'MLNV 11/26/2023 21:05:42'!
valueFrom: aReadStream into: aSystem

	^(self from: aReadStream into: aSystem) value! !


!classDefinition: #PartyImporter category: 'CustomerImporter'!
CSVImporter subclass: #PartyImporter
	instanceVariableNames: 'newCustomer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PartyImporter methodsFor: 'customer' stamp: 'MLNV 11/26/2023 21:05:46'!
assertValidCustomerRecord

	^ record size ~= 5 ifTrue: [ self error: self class invalidCustomerRecordErrorDescription ]! !

!PartyImporter methodsFor: 'customer' stamp: 'MLNV 11/26/2023 21:05:45'!
importCustomer

	self assertValidCustomerRecord.

	newCustomer := Customer
		 withFirstName: record second 
		 lastName: record third 
		 idType: record fourth 
		 idNumber: record fifth.
		
	system addCustomer: newCustomer! !


!PartyImporter methodsFor: 'address' stamp: 'MLNV 11/26/2023 21:05:45'!
assertValidAddressRecord

	^ record size ~= 6 ifTrue: [ self error: self class invalidAddressRecordErrorDescription ]! !

!PartyImporter methodsFor: 'address' stamp: 'MLNV 11/26/2023 21:05:45'!
importAddress: party

	| newAddress |

	self assertValidAddressRecord.

	newAddress := Address new.
	party addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth! !

!PartyImporter methodsFor: 'address' stamp: 'MLNV 11/26/2023 21:05:45'!
isAddressRecord

	^ record first = 'A'! !


!PartyImporter methodsFor: 'evaluating - private' stamp: 'MLNV 11/26/2023 21:05:46'!
importAddress

	self subclassResponsibility! !

!PartyImporter methodsFor: 'evaluating - private' stamp: 'MLNV 11/26/2023 21:21:25'!
importRecord

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PartyImporter class' category: 'CustomerImporter'!
PartyImporter class
	instanceVariableNames: ''!

!PartyImporter class methodsFor: 'error messages' stamp: 'MLNV 11/26/2023 21:05:46'!
invalidAddressRecordErrorDescription

	^'Address record has to have six fields'! !

!PartyImporter class methodsFor: 'error messages' stamp: 'MLNV 11/26/2023 21:05:46'!
invalidCustomerRecordErrorDescription

	^'Invalid Customer record'! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
PartyImporter subclass: #CustomerImporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'customer' stamp: 'MLNV 11/26/2023 21:05:42'!
isCustomerRecord

	^ record first = 'C'! !


!CustomerImporter methodsFor: 'address' stamp: 'MLNV 11/26/2023 21:05:42'!
assertCustomerWasImported

	^ newCustomer ifNil: [ self error: self class canNotImportAddressWithoutCustomerErrorDescription ]! !


!CustomerImporter methodsFor: 'evaluating - private' stamp: 'MLNV 11/26/2023 21:05:42'!
importAddress

	self assertCustomerWasImported.
	self importAddress: newCustomer! !

!CustomerImporter methodsFor: 'evaluating - private' stamp: 'MLNV 11/26/2023 21:05:42'!
importRecord

	self assertRecordNotEmpty.

	self isCustomerRecord ifTrue: [ ^self importCustomer ].
	self isAddressRecord ifTrue: [^self importAddress ].

	self error: self class invalidRecordTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'error messages' stamp: 'MLNV 11/26/2023 21:05:42'!
canNotImportAddressWithoutCustomerErrorDescription

	^'Cannot import address without customer'! !


!classDefinition: #SupplierImporter category: 'CustomerImporter'!
PartyImporter subclass: #SupplierImporter
	instanceVariableNames: 'newSupplier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!SupplierImporter methodsFor: 'customer' stamp: 'MLNV 11/26/2023 21:05:50'!
assertCustomerIsNew
	
	
	 [system customerWithIdentificationType: (record fourth) number: (record fifth)] on: Error do: [^self].
	
	self error: self class canNotImportExistingNewCustomer.! !

!SupplierImporter methodsFor: 'customer' stamp: 'MLNV 11/26/2023 21:05:49'!
assertValidExistingCustomerRecord

	^ record size ~= 3 ifTrue: [ self error: self class invalidCustomerRecordErrorDescription ]! !

!SupplierImporter methodsFor: 'customer' stamp: 'MLNV 11/26/2023 21:05:49'!
importExistingCustomer

	| existingCustomer |
	self assertSupplierWasImported.
	self assertValidExistingCustomerRecord.
	
	existingCustomer := system customerWithIdentificationType: (record second) number: (record third).
	newSupplier addCustomer: existingCustomer.
	! !

!SupplierImporter methodsFor: 'customer' stamp: 'MLNV 11/26/2023 21:05:49'!
importNewCustomer
	
	self assertSupplierWasImported.
	self assertCustomerIsNew.
	
	self importCustomer.

	newSupplier addCustomer: newCustomer.
	! !

!SupplierImporter methodsFor: 'customer' stamp: 'MLNV 11/26/2023 21:05:50'!
isExistingCustomerRecord

	^ record first = 'EC'! !

!SupplierImporter methodsFor: 'customer' stamp: 'MLNV 11/26/2023 21:05:50'!
isNewCustomerRecord

	^ record first = 'NC'! !


!SupplierImporter methodsFor: 'address' stamp: 'MLNV 11/26/2023 21:05:50'!
importAddress

	self assertSupplierWasImported.
	super importAddress: newSupplier.! !


!SupplierImporter methodsFor: 'supplier' stamp: 'MLNV 11/26/2023 21:05:50'!
assertSupplierWasImported

	^ newSupplier ifNil: [ self error: self class canNotImportWithoutASupplierErrorDescription ]! !

!SupplierImporter methodsFor: 'supplier' stamp: 'MLNV 11/26/2023 21:05:50'!
importSupplier
		
	newSupplier := Supplier
		 withFirstName: record second 
		 idType: record third 
		 idNumber: record fourth.
	
	system addSupplier: newSupplier! !

!SupplierImporter methodsFor: 'supplier' stamp: 'MLNV 11/26/2023 21:05:50'!
isSupplierRecord

	^ record first = 'S'! !


!SupplierImporter methodsFor: 'evaluating - private' stamp: 'MLNV 11/26/2023 21:05:50'!
importRecord

	self assertRecordNotEmpty.
	
	self isSupplierRecord ifTrue: [ ^self importSupplier].
	self isNewCustomerRecord ifTrue: [ ^self importNewCustomer].
	self isExistingCustomerRecord ifTrue: [ ^self importExistingCustomer].
	self isAddressRecord ifTrue: [^self importAddress.].
	
	self error: self class invalidRecordTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SupplierImporter class' category: 'CustomerImporter'!
SupplierImporter class
	instanceVariableNames: ''!

!SupplierImporter class methodsFor: 'error messages' stamp: 'MLNV 11/26/2023 21:05:50'!
canNotImportExistingNewCustomer

	^'No se puede importar un customer como nuevo si ya esta en la base de datos.'.! !

!SupplierImporter class methodsFor: 'error messages' stamp: 'MLNV 11/26/2023 21:05:50'!
canNotImportWithoutASupplierErrorDescription

	^'Cannot import address without supplier'! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id inTransaction closed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'MLNV 11/26/2023 21:05:43'!
beginTransaction

	inTransaction := true.! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'MLNV 11/26/2023 21:05:42'!
commit

	inTransaction := false.! !


!DataBaseSession methodsFor: 'closing' stamp: 'MLNV 11/26/2023 21:05:42'!
close

	closed := true.! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'MLNV 11/26/2023 21:05:42'!
assertCanUseDatabase

	self assertIsOpen.
	self assertInTransaction ! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'MLNV 11/26/2023 21:05:42'!
assertInTransaction

	inTransaction ifFalse: [ self error: 'Not in transaction' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'MLNV 11/26/2023 21:05:42'!
assertIsOpen

	closed ifTrue: [ self error: 'Connection with database closed' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'MLNV 11/26/2023 21:05:42'!
assertTypeIsPersisted: aType

	(configuration includes: aType) ifFalse: [ self error: 'Object of type ', aType name, ' are not configured to be persisted' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'MLNV 11/26/2023 21:05:43'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'MLNV 11/26/2023 21:05:43'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'MLNV 11/26/2023 21:05:42'!
isRelationToPersist: possibleRelation

	^ possibleRelation class = Set! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'MLNV 11/26/2023 21:05:42'!
persistPossibleRelationOf: anObject at: anInstVarOffset

	| possibleRelation |
		
	possibleRelation := anObject instVarAt: anInstVarOffset.
	(self isRelationToPersist: possibleRelation) ifTrue: [ self persistRelationOf: anObject at: anInstVarOffset with: possibleRelation ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'MLNV 11/26/2023 21:05:42'!
persistRelationOf: anObject at: anInstVarOffset with: aRelation

	| persistentRelation |
	
	persistentRelation := PersistentSet on: self from: aRelation.
	anObject instVarAt: anInstVarOffset put: persistentRelation! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'MLNV 11/26/2023 21:05:42'!
persistRelationsOf: anObject

	anObject class instVarNamesAndOffsetsDo: [ :anInstVarName :anInstVarOffset | self persistPossibleRelationOf: anObject at: anInstVarOffset]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'MLNV 11/26/2023 21:05:42'!
tableOfType: aType

	^ tables at: aType ifAbsentPut: [ Set new ]! !


!DataBaseSession methodsFor: 'initialization' stamp: 'MLNV 11/26/2023 21:05:42'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.
	inTransaction := false.
	closed := false.! !


!DataBaseSession methodsFor: 'id' stamp: 'MLNV 11/26/2023 21:05:42'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'MLNV 11/26/2023 21:05:42'!
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


!DataBaseSession methodsFor: 'selecting' stamp: 'MLNV 11/26/2023 21:05:43'!
select: aCondition ofType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'MLNV 11/26/2023 21:05:42'!
selectAllOfType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'MLNV 11/26/2023 21:05:43'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


!classDefinition: #Environment category: 'CustomerImporter'!
Object subclass: #Environment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Environment methodsFor: 'customer system' stamp: 'MLNV 11/26/2023 21:05:43'!
createCustomerSystem

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Environment class' category: 'CustomerImporter'!
Environment class
	instanceVariableNames: ''!

!Environment class methodsFor: 'current' stamp: 'MLNV 11/26/2023 21:05:43'!
current

	^(self subclasses detect: [ :anEnvironmentClass | anEnvironmentClass isCurrent ]) new! !

!Environment class methodsFor: 'current' stamp: 'MLNV 11/26/2023 21:05:43'!
environmentKey

	^ #ENV! !

!Environment class methodsFor: 'current' stamp: 'MLNV 11/26/2023 21:05:43'!
environmentVariable

	^ Smalltalk at: self environmentKey! !

!Environment class methodsFor: 'current' stamp: 'MLNV 11/26/2023 21:05:43'!
identifier

	self subclassResponsibility! !

!Environment class methodsFor: 'current' stamp: 'MLNV 11/26/2023 21:05:43'!
isCurrent

	self subclassResponsibility ! !

!Environment class methodsFor: 'current' stamp: 'MLNV 11/26/2023 21:05:43'!
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

!DevelopmentEnvironment methodsFor: 'customer system' stamp: 'MLNV 11/26/2023 21:05:43'!
createCustomerSystem

	^TransientCustomerSystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DevelopmentEnvironment class' category: 'CustomerImporter'!
DevelopmentEnvironment class
	instanceVariableNames: ''!

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'MLNV 11/26/2023 21:05:43'!
identifier

	^ #DEV! !

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'MLNV 11/26/2023 21:05:43'!
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

!IntegrationEnvironment methodsFor: 'customer system' stamp: 'MLNV 11/26/2023 21:05:44'!
createCustomerSystem

	^PersistentCustomerSystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegrationEnvironment class' category: 'CustomerImporter'!
IntegrationEnvironment class
	instanceVariableNames: ''!

!IntegrationEnvironment class methodsFor: 'current' stamp: 'MLNV 11/26/2023 21:05:44'!
identifier

	^ #INT! !

!IntegrationEnvironment class methodsFor: 'current' stamp: 'MLNV 11/26/2023 21:05:44'!
isCurrent

	"
	self makeCurrent
	"
	^self environmentVariable = self identifier! !


!classDefinition: #Party category: 'CustomerImporter'!
Object subclass: #Party
	instanceVariableNames: 'firstName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Party methodsFor: 'addresses' stamp: 'MLNV 11/26/2023 21:05:44'!
addAddress: anAddress

	addresses add: anAddress ! !

!Party methodsFor: 'addresses' stamp: 'MLNV 11/26/2023 21:05:45'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Party methodsFor: 'addresses' stamp: 'MLNV 11/26/2023 21:05:45'!
amountOfAddresses

	^ addresses size.! !

!Party methodsFor: 'addresses' stamp: 'MLNV 11/26/2023 21:05:45'!
isAddressesEmpty

	^addresses isEmpty ! !


!Party methodsFor: 'name' stamp: 'MLNV 11/26/2023 21:05:45'!
firstName

	^firstName ! !


!Party methodsFor: 'identification' stamp: 'MLNV 11/26/2023 21:05:45'!
identificationNumber

	^identificationNumber ! !

!Party methodsFor: 'identification' stamp: 'MLNV 11/26/2023 21:05:44'!
identificationType

	^identificationType ! !


!classDefinition: #Customer category: 'CustomerImporter'!
Party subclass: #Customer
	instanceVariableNames: 'lastName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'name' stamp: 'MLNV 11/26/2023 21:05:42'!
lastName

	^lastName ! !


!Customer methodsFor: 'initialization' stamp: 'MLNV 11/26/2023 21:16:24'!
initializeWithFirstName: aFirstName lastName: aLastName idType: anIdType idNumber: anIdNumber.
		
	firstName := aFirstName.
	lastName := aLastName.
	identificationType := anIdType.
	identificationNumber := anIdNumber.
	addresses := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: 'CustomerImporter'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'instance creation' stamp: 'MLNV 11/26/2023 21:05:42'!
withFirstName: firstName lastName: lastName idType: idType idNumber: idNumber
	^Customer new initializeWithFirstName: firstName lastName: lastName idType: idType idNumber: idNumber.
	! !


!classDefinition: #Supplier category: 'CustomerImporter'!
Party subclass: #Supplier
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Supplier methodsFor: 'customers' stamp: 'MLNV 11/26/2023 21:05:46'!
addCustomer: aCustomer

	customers add: aCustomer ! !

!Supplier methodsFor: 'customers' stamp: 'MLNV 11/26/2023 21:19:37'!
amountOfCustomers

	^customers size.! !

!Supplier methodsFor: 'customers' stamp: 'MLNV 11/26/2023 21:05:46'!
customerWithIDType: anIdType andIdNumber: anIdNumber ifNone: aNoneBlock

	^customers detect: [ :aCustomer | aCustomer identificationType = anIdType and: 
								[aCustomer identificationNumber = anIdNumber ]] 
			ifNone: aNoneBlock. ! !

!Supplier methodsFor: 'customers' stamp: 'MLNV 11/26/2023 21:05:46'!
isCustomersEmpty

	^customers isEmpty ! !


!Supplier methodsFor: 'initialization' stamp: 'MLNV 11/26/2023 21:16:55'!
initializeWithFirstName: aFirstName idType: anIdType idNumber: anIdNumber.
		
	firstName := aFirstName.
	identificationType := anIdType.
	identificationNumber := anIdNumber.
	addresses := OrderedCollection new.
	customers := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Supplier class' category: 'CustomerImporter'!
Supplier class
	instanceVariableNames: ''!

!Supplier class methodsFor: 'instance creation' stamp: 'MLNV 11/26/2023 21:05:46'!
withFirstName: firstName idType: idType idNumber: idNumber
	^Supplier new initializeWithFirstName: firstName idType: idType idNumber: idNumber.
	! !


!classDefinition: #PartySystem category: 'CustomerImporter'!
Object subclass: #PartySystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PartySystem methodsFor: 'customers' stamp: 'MLNV 11/26/2023 21:05:46'!
addCustomer: aCustomer

	self subclassResponsibility ! !

!PartySystem methodsFor: 'customers' stamp: 'MLNV 11/26/2023 21:05:46'!
customerWithIdentificationType: anIdType number: anIdNumber

	self subclassResponsibility ! !

!PartySystem methodsFor: 'customers' stamp: 'MLNV 11/26/2023 21:05:46'!
numberOfCustomers

	self subclassResponsibility ! !


!PartySystem methodsFor: 'transactions' stamp: 'MLNV 11/26/2023 21:05:46'!
beginTransaction

	self subclassResponsibility ! !

!PartySystem methodsFor: 'transactions' stamp: 'MLNV 11/26/2023 21:05:46'!
commit

	self subclassResponsibility ! !


!PartySystem methodsFor: 'system lifecycle' stamp: 'MLNV 11/26/2023 21:05:46'!
start

	self subclassResponsibility ! !

!PartySystem methodsFor: 'system lifecycle' stamp: 'MLNV 11/26/2023 21:05:46'!
stop

	self subclassResponsibility ! !


!PartySystem methodsFor: 'suppliers' stamp: 'MLNV 11/26/2023 21:05:46'!
addSupplier: aSupplier

	self subclassResponsibility! !

!PartySystem methodsFor: 'suppliers' stamp: 'MLNV 11/26/2023 21:05:46'!
numberOfSuppliers

	self subclassResponsibility! !

!PartySystem methodsFor: 'suppliers' stamp: 'MLNV 11/26/2023 21:05:46'!
supplierWithIdentificationType: anIdType number: anIdNumber

	self subclassResponsibility! !


!classDefinition: #PersistentCustomerSystem category: 'CustomerImporter'!
PartySystem subclass: #PersistentCustomerSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentCustomerSystem methodsFor: 'customers' stamp: 'MLNV 11/26/2023 21:05:46'!
addCustomer: aCustomer

	^session persist: aCustomer ! !

!PersistentCustomerSystem methodsFor: 'customers' stamp: 'MLNV 11/26/2023 21:05:46'!
customerWithIdentificationType: anIdType number: anIdNumber

	^(session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !

!PersistentCustomerSystem methodsFor: 'customers' stamp: 'MLNV 11/26/2023 21:05:46'!
numberOfCustomers

	^(session selectAllOfType: Customer) size! !


!PersistentCustomerSystem methodsFor: 'transactions' stamp: 'MLNV 11/26/2023 21:05:46'!
beginTransaction

	session beginTransaction.
! !

!PersistentCustomerSystem methodsFor: 'transactions' stamp: 'MLNV 11/26/2023 21:05:46'!
commit

	session commit ! !


!PersistentCustomerSystem methodsFor: 'system lifecycle' stamp: 'MLNV 11/26/2023 21:05:46'!
start

	session := DataBaseSession for: (Array with: Address with: Customer with: Supplier).
	! !

!PersistentCustomerSystem methodsFor: 'system lifecycle' stamp: 'MLNV 11/26/2023 21:05:46'!
stop

	session close! !


!PersistentCustomerSystem methodsFor: 'suppliers' stamp: 'MLNV 11/26/2023 21:05:46'!
addSupplier: aSupplier

	^session persist: aSupplier ! !

!PersistentCustomerSystem methodsFor: 'suppliers' stamp: 'MLNV 11/26/2023 21:05:46'!
numberOfSuppliers
	
	^(session selectAllOfType: Supplier) size! !

!PersistentCustomerSystem methodsFor: 'suppliers' stamp: 'MLNV 11/26/2023 21:05:46'!
supplierWithIdentificationType: anIdType number: anIdNumber
	
	^(session select: [ :aSupplier | aSupplier identificationType = anIdType and: [ aSupplier identificationNumber = anIdNumber ]]
		ofType: Supplier) anyOne! !


!classDefinition: #TransientCustomerSystem category: 'CustomerImporter'!
PartySystem subclass: #TransientCustomerSystem
	instanceVariableNames: 'customers suppliers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientCustomerSystem methodsFor: 'system lifecycle' stamp: 'MLNV 11/26/2023 21:05:51'!
start

	customers := OrderedCollection new.
	suppliers := OrderedCollection new.! !

!TransientCustomerSystem methodsFor: 'system lifecycle' stamp: 'MLNV 11/26/2023 21:05:51'!
stop

	customers := nil.
	suppliers := nil.! !


!TransientCustomerSystem methodsFor: 'transactions' stamp: 'MLNV 11/26/2023 21:05:51'!
beginTransaction

	! !

!TransientCustomerSystem methodsFor: 'transactions' stamp: 'MLNV 11/26/2023 21:05:51'!
commit

	! !


!TransientCustomerSystem methodsFor: 'customers' stamp: 'MLNV 11/26/2023 21:05:51'!
addCustomer: aCustomer

	customers add: aCustomer ! !

!TransientCustomerSystem methodsFor: 'customers' stamp: 'MLNV 11/26/2023 21:05:51'!
customerWithIdentificationType: anIdType number: anIdNumber

	^customers detect: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]! !

!TransientCustomerSystem methodsFor: 'customers' stamp: 'MLNV 11/26/2023 21:05:51'!
numberOfCustomers

	^customers size! !


!TransientCustomerSystem methodsFor: 'suppliers' stamp: 'MLNV 11/26/2023 21:05:51'!
addSupplier: aSupplier

	suppliers add: aSupplier ! !

!TransientCustomerSystem methodsFor: 'suppliers' stamp: 'MLNV 11/26/2023 21:05:51'!
numberOfSuppliers
	^suppliers size.! !

!TransientCustomerSystem methodsFor: 'suppliers' stamp: 'MLNV 11/26/2023 21:05:51'!
supplierWithIdentificationType: anIdType number: anIdNumber
	
	^suppliers detect: [ :aSupplier | aSupplier identificationType = anIdType and: [ aSupplier identificationNumber = anIdNumber ]]! !
