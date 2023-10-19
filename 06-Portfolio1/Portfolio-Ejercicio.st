!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TestPortfolio category: 'Portfolio-Ejercicio'!
TestCase subclass: #TestPortfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TestPortfolio methodsFor: 'as yet unclassified' stamp: 'MC 10/9/2023 21:36:48'!
test01InitialBalanceIsZero

	| aPortfolio |
	
	aPortfolio := Portfolio new.
	
	self assert: 0 equals: aPortfolio balance.! !

!TestPortfolio methodsFor: 'as yet unclassified' stamp: 'MLNV 10/16/2023 23:24:19'!
test02AddAccountWith100Balance

	| aPortfolio account|
	
	aPortfolio := Portfolio new.
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	aPortfolio add: account.
	
	self assert: 100 equals: aPortfolio balance.! !

!TestPortfolio methodsFor: 'as yet unclassified' stamp: 'MLNV 10/16/2023 23:24:23'!
test03AddAccountWithAnyBalance

	| aPortfolio account|
	
	aPortfolio := Portfolio new.
	account := ReceptiveAccount  new.
	Deposit register: 200 on: account.
	aPortfolio add: account.
	
	self assert: 200 equals: aPortfolio balance.! !

!TestPortfolio methodsFor: 'as yet unclassified' stamp: 'MLNV 10/16/2023 23:25:19'!
test04AddManyAccountsWithAnyBalance

	| aPortfolio firstAccount secondAccount thirdAccount |
	
	aPortfolio := Portfolio new.
	
	firstAccount := ReceptiveAccount  new.
	Deposit register: 200 on: firstAccount .
	aPortfolio add: firstAccount .
	
	secondAccount := ReceptiveAccount  new.
	Deposit register: 500 on: secondAccount .
	aPortfolio add: secondAccount .
	
	thirdAccount := ReceptiveAccount  new.
	Withdraw register: 100 on: thirdAccount .
	aPortfolio add: thirdAccount .
	
	self assert: 600 equals: aPortfolio balance.! !

!TestPortfolio methodsFor: 'as yet unclassified' stamp: 'MLNV 10/16/2023 23:25:04'!
test05AddPortfoliosWithAnyBalance

	| aPortfolio aSecondPortfolio anAccount |
	
	aPortfolio := Portfolio new.
	aSecondPortfolio := Portfolio new.
	
	anAccount := ReceptiveAccount  new.
	Deposit register: 200 on: anAccount.
	aSecondPortfolio add: anAccount.
	aPortfolio add: aSecondPortfolio.
	
	self assert: 200 equals: aPortfolio balance.! !

!TestPortfolio methodsFor: 'as yet unclassified' stamp: 'MLNV 10/16/2023 23:25:36'!
test06CantAddSameRecordOnFirstLevel

	| aPortfolio anAccount |
	
	aPortfolio := Portfolio new.

	anAccount := ReceptiveAccount  new.
	Deposit register: 200 on: anAccount.
	aPortfolio add: anAccount .
	
	self
		should: [aPortfolio add: anAccount .]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio alreadyInPortfolioErrorDescription].
		! !

!TestPortfolio methodsFor: 'as yet unclassified' stamp: 'MLNV 10/16/2023 23:39:44'!
test07CantAddSameRecordOnLowerLevels

	| aPortfolio aSecondPortfolio anAccount |
	
	aPortfolio := Portfolio new.
	aSecondPortfolio := Portfolio new.

	anAccount := ReceptiveAccount  new.
	Deposit register: 200 on: anAccount.
	aSecondPortfolio add: anAccount.
	
	aPortfolio add: aSecondPortfolio.
	
	self
		should: [aPortfolio add: anAccount.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio alreadyInPortfolioErrorDescription].
		! !

!TestPortfolio methodsFor: 'as yet unclassified' stamp: 'MLNV 10/16/2023 23:40:15'!
test08CantAddSameRecordOnHigherLevels

	| aPortfolio aSecondPortfolio anAccount |
	
	aPortfolio := Portfolio new.
	aSecondPortfolio := Portfolio new.

	anAccount := ReceptiveAccount  new.
	Deposit register: 200 on: anAccount.
	aPortfolio add: anAccount.
	
	aPortfolio add: aSecondPortfolio.
	
	self
		should: [aSecondPortfolio add: anAccount.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio alreadyInPortfolioErrorDescription].
		! !

!TestPortfolio methodsFor: 'as yet unclassified' stamp: 'MLNV 10/17/2023 00:31:00'!
test09PortfolioHasRegisteredATransaction

	| aPortfolio  anAccount aTransaction|
	
	aPortfolio := Portfolio new.

	anAccount := ReceptiveAccount  new.
	aTransaction := Deposit register: 200 on: anAccount.
	aPortfolio add: anAccount.

	self assert: (aPortfolio hasRegistered: aTransaction).
		! !

!TestPortfolio methodsFor: 'as yet unclassified' stamp: 'MLNV 10/17/2023 00:31:12'!
test10GetAllTransactions

	| aPortfolio  anAccount aTransaction|
	
	aPortfolio := Portfolio new.

	anAccount := ReceptiveAccount  new.
	aTransaction := Deposit register: 200 on: anAccount.
	aPortfolio add: anAccount.

	self assert: (OrderedCollection with: aTransaction) equals: (aPortfolio transactions)
		! !

!TestPortfolio methodsFor: 'as yet unclassified' stamp: 'natan 10/19/2023 19:11:55'!
test11HolaManuSosMuySexy

	| aPortfolio aSecondPortfolio anAccount|
	
	aPortfolio := Portfolio new.
	aSecondPortfolio := Portfolio new.

	anAccount := ReceptiveAccount  new.
	Deposit register: 200 on: anAccount.
	aPortfolio add: anAccount.
	
	aSecondPortfolio add: anAccount.

	self
		should: [aPortfolio add: aSecondPortfolio.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio alreadyInPortfolioErrorDescription].
		! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'MC 10/9/2023 21:09:13'!
applyToBalance: aBalance

	^ aBalance + value.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'MC 10/9/2023 21:16:28'!
applyToBalance: aBalance

	^aBalance - value.! !

!Withdraw methodsFor: 'value' stamp: 'MC 10/9/2023 21:01:06'!
value

	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'MC 10/9/2023 20:43:21'!
for: aValue

	^ self new initializeFor: aValue! !


!classDefinition: #FinancialRecords category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialRecords
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialRecords methodsFor: 'transactions' stamp: 'MLNV 10/17/2023 00:54:16'!
balance

	self subclassResponsibility! !

!FinancialRecords methodsFor: 'transactions' stamp: 'MLNV 10/17/2023 00:54:18'!
hasRegistered: aTransaction

	self subclassResponsibility! !

!FinancialRecords methodsFor: 'transactions' stamp: 'MLNV 10/17/2023 00:54:34'!
transactions

	self subclassResponsibility! !


!FinancialRecords methodsFor: 'initialization' stamp: 'MLNV 10/17/2023 00:54:27'!
initialize

	self subclassResponsibility! !


!FinancialRecords methodsFor: 'private' stamp: 'MLNV 10/17/2023 00:54:04'!
addFather: aFinancialRecord

	self subclassResponsibility! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialRecords subclass: #Portfolio
	instanceVariableNames: 'records fathers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'transactions' stamp: 'MLNV 10/18/2023 09:06:32'!
addTransactionsInto: aTransactionList

	records do: [:aFinancialRecord | aFinancialRecord addTransactionsInto: aTransactionList].! !

!Portfolio methodsFor: 'transactions' stamp: 'MLNV 10/17/2023 01:11:27'!
balance

	^ records sum: [:aPortfolioOrAccount | aPortfolioOrAccount balance] ifEmpty: [0].! !

!Portfolio methodsFor: 'transactions' stamp: 'MLNV 10/17/2023 01:11:27'!
hasRegistered: aTransaction 
	
	^records anySatisfy: [:aFinancialRecord | aFinancialRecord hasRegistered: aTransaction].! !

!Portfolio methodsFor: 'transactions' stamp: 'MLNV 10/18/2023 09:06:44'!
transactions
	
	| allTransactions |
	
	allTransactions := OrderedCollection new.
	
	self addTransactionsInto: allTransactions.
	
	^allTransactions. ! !


!Portfolio methodsFor: 'addRecords' stamp: 'natan 10/19/2023 19:07:02'!
add: aFinancialRecord 
	
	(self rootsIntersect: aFinancialRecord) ifTrue: [self error: self class alreadyInPortfolioErrorDescription].
	
	records add: aFinancialRecord .
	aFinancialRecord addFather: self.! !


!Portfolio methodsFor: 'private' stamp: 'MLNV 10/16/2023 23:52:17'!
addFather: aFinancialRecord 
	
	fathers add: aFinancialRecord.! !

!Portfolio methodsFor: 'private' stamp: 'MLNV 10/17/2023 01:11:38'!
includes: aFinancialRecordToCheck

	^records anySatisfy: [:aFinancialRecord | aFinancialRecord includes: aFinancialRecordToCheck].! !

!Portfolio methodsFor: 'private' stamp: 'natan 10/19/2023 19:02:20'!
intersect: aFinancialRecordToCheck
	^records anySatisfy: [:aFinancialRecord | aFinancialRecord intersect: aFinancialRecordToCheck].! !

!Portfolio methodsFor: 'private' stamp: 'natan 10/19/2023 19:09:23'!
rootsIntersect: aFinancialRecordToCheck

	^fathers isEmpty 
		ifTrue: [self intersect: aFinancialRecordToCheck .]
		ifFalse: [fathers anySatisfy: [:aFinancialRecord | aFinancialRecord rootsIntersect: aFinancialRecordToCheck]].! !


!Portfolio methodsFor: 'initialization' stamp: 'MLNV 10/17/2023 01:11:27'!
initialize
	
	records := OrderedCollection new.
	fathers := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'MLNV 10/16/2023 23:23:53'!
alreadyInPortfolioErrorDescription

	^'No se puede agregar una cuenta repetida al mismo portfolio'.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'MC 10/9/2023 21:35:25'!
new

	^self basicNew initialize.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialRecords subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'MLNV 10/18/2023 09:05:19'!
addTransactionsInto: aTransactionsList
	
	aTransactionsList addAll: transactions.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'MC 10/9/2023 21:50:05'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'MC 10/9/2023 21:15:15'!
balance
	| aBalance |
	
	aBalance := 0.
	
	transactions do: [:aTransaction| aBalance := aTransaction applyToBalance: aBalance].
	
	^aBalance.
	
	
					! !


!ReceptiveAccount methodsFor: 'private' stamp: 'MLNV 10/16/2023 23:52:32'!
addFather: aFinancialRecord

	^self.! !

!ReceptiveAccount methodsFor: 'private' stamp: 'MLNV 10/16/2023 23:37:56'!
includes: aFinancialRecord

	^aFinancialRecord = self.
	
	
					! !

!ReceptiveAccount methodsFor: 'private' stamp: 'natan 10/19/2023 19:02:46'!
intersect: aFinancialRecord

	^aFinancialRecord includes: self.
	
	
					! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
