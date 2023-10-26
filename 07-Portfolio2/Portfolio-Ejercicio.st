!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'MC 10/9/2023 21:36:48'!
test01InitialBalanceIsZero

	| aPortfolio |
	
	aPortfolio := Portfolio new.
	
	self assert: 0 equals: aPortfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MLNV 10/24/2023 19:04:57'!
test02AddAccountWith100Balance

	| aPortfolio account|
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	aPortfolio := Portfolio with: account.
	
	self assert: 100 equals: aPortfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MLNV 10/24/2023 19:05:37'!
test03AddAccountWithAnyBalance

	| aPortfolio account|
	
	account := ReceptiveAccount  new.
	Deposit register: 200 on: account.
	aPortfolio := Portfolio with: account.
	
	self assert: 200 equals: aPortfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MLNV 10/16/2023 23:25:19'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'MLNV 10/24/2023 19:06:24'!
test05AddPortfoliosWithAnyBalance

	| aPortfolio aSecondPortfolio anAccount |
	
	aPortfolio := Portfolio new.
	
	anAccount := ReceptiveAccount  new.
	Deposit register: 200 on: anAccount.
	
	aSecondPortfolio := Portfolio with: anAccount.
	aPortfolio := Portfolio with: aSecondPortfolio.
		
	self assert: 200 equals: aPortfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MLNV 10/24/2023 19:06:45'!
test06CantAddSameRecordOnFirstLevel

	| aPortfolio anAccount |
	
	anAccount := ReceptiveAccount  new.
	Deposit register: 200 on: anAccount.
	aPortfolio := Portfolio with: anAccount .
	
	self
		should: [aPortfolio add: anAccount .]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio alreadyInPortfolioErrorDescription].
		! !

!PortfolioTest methodsFor: 'tests' stamp: 'MLNV 10/24/2023 19:07:17'!
test07CantAddSameRecordOnLowerLevels

	| aPortfolio aSecondPortfolio anAccount |
	
	anAccount := ReceptiveAccount  new.
	Deposit register: 200 on: anAccount.
	aSecondPortfolio := Portfolio with: anAccount.
	
	aPortfolio := Portfolio with: aSecondPortfolio .
	
	self
		should: [aPortfolio add: anAccount.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio alreadyInPortfolioErrorDescription].
		! !

!PortfolioTest methodsFor: 'tests' stamp: 'MLNV 10/24/2023 19:08:10'!
test08CantAddSameRecordOnHigherLevels

	| aPortfolio aSecondPortfolio anAccount |
	
	aSecondPortfolio := Portfolio new.

	anAccount := ReceptiveAccount  new.
	Deposit register: 200 on: anAccount.
	aPortfolio := Portfolio with: anAccount.
	
	aPortfolio add: aSecondPortfolio.
	
	self
		should: [aSecondPortfolio add: anAccount.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio alreadyInPortfolioErrorDescription].
		! !

!PortfolioTest methodsFor: 'tests' stamp: 'MLNV 10/24/2023 19:08:27'!
test09PortfolioHasRegisteredATransaction

	| aPortfolio  anAccount aTransaction|
	

	anAccount := ReceptiveAccount  new.
	aTransaction := Deposit register: 200 on: anAccount.
	aPortfolio := Portfolio with: anAccount.

	self assert: (aPortfolio hasRegistered: aTransaction).
		! !

!PortfolioTest methodsFor: 'tests' stamp: 'MLNV 10/24/2023 19:08:54'!
test10GetAllTransactions

	| aPortfolio  anAccount aTransaction|
	
	anAccount := ReceptiveAccount  new.
	aTransaction := Deposit register: 200 on: anAccount.
	aPortfolio := Portfolio with: anAccount.

	self assert: (OrderedCollection with: aTransaction) equals: (aPortfolio transactions)
		! !

!PortfolioTest methodsFor: 'tests' stamp: 'MLNV 10/24/2023 19:09:34'!
test11CantAddPortfolioWithAnySameRecord

	| aPortfolio aSecondPortfolio anAccount|
	
	anAccount := ReceptiveAccount  new.
	Deposit register: 200 on: anAccount.
	aPortfolio := Portfolio with: anAccount.
	
	aSecondPortfolio := Portfolio with: anAccount.

	self
		should: [aPortfolio add: aSecondPortfolio.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio alreadyInPortfolioErrorDescription].
		! !


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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MLNV 10/25/2023 18:03:51'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value.
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MLNV 10/24/2023 20:23:32'!
test08TransferBetweenAccounts

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Transfer register: 50 from: account1 to: account2.
		
	self assert: -50 equals: account1 balance.
	self assert: 50 equals: account2 balance.! !


!classDefinition: #ReportTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReportTest methodsFor: 'tests' stamp: 'MLNV 10/26/2023 09:59:32'!
test01AccountSummaryForEmptyAccount

	| account report |
	
	account := ReceptiveAccount new.
	report := AccountSummary for: account.
	
	self assert: report generate equals: (OrderedCollection with: 'Balance = 0').	
	 ! !

!ReportTest methodsFor: 'tests' stamp: 'MLNV 10/25/2023 21:17:32'!
test04AccountSummaryForDepositsAndWithdraws

	| account  expectedReport |
	
	account := ReceptiveAccount new.
	Deposit register: 40 on: account.
	Withdraw register: 20 on: account.
	Deposit register: 20 on: account.
	Withdraw register: 10 on: account.
	expectedReport := OrderedCollection 
				with: 'Depósito por 40.' 
				with: 'Extracción por 20.'
				with: 'Depósito por 20.' 
				with: 'Extracción por 10.'
				with: 'Balance = 30'.
		
	self assert: (AccountSummary for: account) generate equals: expectedReport.
	
	 ! !

!ReportTest methodsFor: 'tests' stamp: 'MLNV 10/25/2023 21:18:14'!
test05AccountSummaryForTransfer

	| firstAccount secondAccount firstReport secondReport |
	
	firstAccount := ReceptiveAccount new.	
	secondAccount := ReceptiveAccount new.
	
	Transfer register: 40 from: firstAccount to: secondAccount.
	
	firstReport := OrderedCollection 
				with: 'Salida por transferencia de 40.' 
				with: 'Balance = -40'.
				
	secondReport := OrderedCollection 
				with: 'Entrada por transferencia de 40.' 
				with: 'Balance = 40'.
				
	self assert: (AccountSummary for: firstAccount ) generate equals: firstReport.
	self assert: (AccountSummary for: secondAccount ) generate equals: secondReport.
		

	
	 ! !

!ReportTest methodsFor: 'tests' stamp: 'MLNV 10/25/2023 21:19:02'!
test06TransferNetReportForAccount

	| firstAccount secondAccount firstReport secondReport |
	
	firstAccount := ReceptiveAccount new.	
	secondAccount := ReceptiveAccount new.
	
	Transfer register: 40 from: firstAccount to: secondAccount.	
	Transfer register: 20 from: secondAccount to: firstAccount.
	
	firstReport := -20.
				
	secondReport := 20.
				
	self assert: (TransferNet for: firstAccount) generate equals: firstReport.
	self assert: (TransferNet for: secondAccount ) generate equals: secondReport.
		

	
	 ! !

!ReportTest methodsFor: 'tests' stamp: 'MLNV 10/25/2023 23:07:34'!
test07AccountSummaryForEmptyPortfolio

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self assert: (AccountSummary for: portfolio ) generate equals:(OrderedCollection with: 'Balance = 0').
				
	
		

	
	 ! !

!ReportTest methodsFor: 'tests' stamp: 'MLNV 10/25/2023 23:08:26'!
test08AccountSummaryForPortfolioWithOneAccount

	| account portfolio report|
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	report := OrderedCollection 
			with: 'Depósito por 100.'
			with: 'Balance = 100'.
	
	self assert: (AccountSummary for: portfolio) generate equals: report.

				
	
		

	
	 ! !

!ReportTest methodsFor: 'tests' stamp: 'MLNV 10/25/2023 23:08:23'!
test09AccountSummaryForPortfolioWithMultipleAccounts

	| anAccount anotherAccount portfolio report|
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	portfolio := Portfolio with: anAccount.
	
	anotherAccount := ReceptiveAccount new.
	Withdraw register: 100 on: anotherAccount.
	portfolio add: anotherAccount.
	
	report := OrderedCollection 
			with: 'Depósito por 100.'
			with: 'Extracción por 100.'
			with: 'Balance = 0'.
	
	self assert: (AccountSummary for: portfolio) generate equals: report.
	
		

	
	 ! !

!ReportTest methodsFor: 'tests' stamp: 'MLNV 10/25/2023 23:08:38'!
test10AccountSummaryForPorfolioWithTransfer

	| anAccount anotherAccount portfolio report|
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Transfer register: 100 from: anAccount to: anotherAccount.
	
	portfolio := (Portfolio with: anAccount) add: anotherAccount.

	
	report := OrderedCollection 
			with: 'Salida por transferencia de 100.'
			with: 'Entrada por transferencia de 100.'
			with: 'Balance = 0'.
	
	self assert: (AccountSummary for: portfolio) generate equals: report.
				
	
		

	
	 ! !

!ReportTest methodsFor: 'tests' stamp: 'MLNV 10/25/2023 23:08:54'!
test11AccountSummaryForAnidatedPortfolios

	| anAccount portfolio anotherPortfolio report|
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	
	anotherPortfolio := Portfolio with: anAccount.
	portfolio := Portfolio with: anotherPortfolio.
	
	report := OrderedCollection 
			with: 'Depósito por 100.'
			with: 'Balance = 100'.
	
	self assert: (AccountSummary for: portfolio) generate equals: report.
				
	
		

	
	 ! !

!ReportTest methodsFor: 'tests' stamp: 'MLNV 10/25/2023 23:09:06'!
test12TransferNetForPortfolio

	| anAccount anotherAccount portfolio report|
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Transfer register: 100 from: anAccount to: anotherAccount.
	
	portfolio := (Portfolio with: anAccount) add: anotherAccount .
	
	report := 0.
	
	self assert: (TransferNet for: portfolio) generate equals: report.
				
	
		

	
	 ! !

!ReportTest methodsFor: 'tests' stamp: 'MLNV 10/26/2023 09:59:15'!
test13NameTreeForEmptyPortfolio

	| portfolio  report |
	
	portfolio := Portfolio new.
	portfolio setName: 'Portfolio de test vacio'.
	report := OrderedCollection with: 'Portfolio de test vacio'.
	
	self assert: (PortfolioNameTree for: portfolio) generate equals: report.
				
	
		

	
	 ! !

!ReportTest methodsFor: 'tests' stamp: 'MLNV 10/26/2023 09:59:10'!
test14NameTreeForPortfolioWithManyAccounts

	| portfolio account report |
	
	account := ReceptiveAccount named: 'Cuenta de Messi'.
	portfolio := Portfolio named: 'Portfolio de Antonella' with: account.
	report := OrderedCollection 
			with: 'Portfolio de Antonella'
			with: '    Cuenta de Messi'.
	
	self assert: (PortfolioNameTree for: portfolio) generate equals: report.
				
	
		

	
	 ! !

!ReportTest methodsFor: 'tests' stamp: 'MLNV 10/26/2023 09:59:01'!
test15NameTreeForAnidatedPortfolios

	| aPortfolio aSecondPortfolio account report |
	
	account := ReceptiveAccount named: 'Cuenta de Messi'.
	aSecondPortfolio := Portfolio named: 'Portfolio de Antonella' with: account.
	aPortfolio := Portfolio named: 'Portfolio futbol' with: aSecondPortfolio.
	report := OrderedCollection 
			with: 'Portfolio futbol'
			with: '    Portfolio de Antonella'
			with: '        Cuenta de Messi'.

	
	self assert: (PortfolioNameTree for: aPortfolio) generate equals: report.
				
	
		

	
	 ! !

!ReportTest methodsFor: 'tests' stamp: 'MLNV 10/26/2023 10:03:18'!
test16NameTreeForPortfolioWithTransactions

	| aPortfolio aSecondPortfolio anAccount anotherAccount report |
	
	anAccount := ReceptiveAccount named: 'Cuenta de Messi'.
	anotherAccount := ReceptiveAccount named: 'Cuenta de Scaloni'.
	Deposit register: 100 on: anAccount.
	aSecondPortfolio := Portfolio named: 'Portfolio de Antonella' with: anAccount.
	aPortfolio := Portfolio named: 'Portfolio futbol' with: aSecondPortfolio with: anotherAccount.
	
	report := OrderedCollection 
			with: 'Portfolio futbol'
			with: '    Portfolio de Antonella'
			with: '        Cuenta de Messi'
			with: '    Cuenta de Scaloni'.

	
	self assert: (PortfolioNameTree for: aPortfolio) generate equals: report.
				
	
		

	
	 ! !


!classDefinition: #AccountOperation category: 'Portfolio-Ejercicio'!
Object subclass: #AccountOperation
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountOperation methodsFor: 'report generation' stamp: 'MLNV 10/26/2023 13:56:49'!
includeTransaction: aTransactionType into: aReport 
	
	| operationID |
	
	operationID := Array with: aTransactionType with: self class name.
		
	aReport include: operationID with: value.! !


!AccountOperation methodsFor: 'value' stamp: 'MLNV 10/25/2023 18:04:37'!
value

	^ value.! !


!AccountOperation methodsFor: 'balance' stamp: 'MLNV 10/25/2023 17:50:31'!
addToBalance: aBalance

	^aBalance + value.! !

!AccountOperation methodsFor: 'balance' stamp: 'MLNV 10/25/2023 17:50:44'!
substractFromBalance: aBalance

	^aBalance - value.! !


!classDefinition: #BasicOperation category: 'Portfolio-Ejercicio'!
AccountOperation subclass: #BasicOperation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BasicOperation methodsFor: 'initialization' stamp: 'MLNV 10/25/2023 18:00:42'!
initializeFor: aValue

	value := aValue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BasicOperation class' category: 'Portfolio-Ejercicio'!
BasicOperation class
	instanceVariableNames: ''!

!BasicOperation class methodsFor: 'instance creation' stamp: 'MLNV 10/25/2023 18:00:42'!
for: aValue

	^self new initializeFor: aValue.! !


!classDefinition: #Transfer category: 'Portfolio-Ejercicio'!
AccountOperation subclass: #Transfer
	instanceVariableNames: 'depositAccount withdrawAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'MLNV 10/26/2023 14:11:40'!
depositAccount
	
	^depositAccount.! !

!Transfer methodsFor: 'initialization' stamp: 'MLNV 10/25/2023 15:33:02'!
initializeFor: aValue from: accountToWithdraw to: accountToDeposit

	value := aValue.
	withdrawAccount := accountToWithdraw.
	depositAccount := accountToDeposit.! !

!Transfer methodsFor: 'initialization' stamp: 'MLNV 10/26/2023 14:11:51'!
withdrawAccount
	
	^withdrawAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'MLNV 10/26/2023 14:02:32'!
register: aValue from: accountToWithdraw to: accountToDeposit

	| transfer |
	
	transfer := self new initializeFor: aValue from: accountToWithdraw to: accountToDeposit.
	
	accountToWithdraw register: (Withdraw ofOperation: transfer).
	
	accountToDeposit register: (Deposit ofOperation: transfer).
			
	^ transfer 
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'operation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'MLNV 10/25/2023 18:04:48'!
value

	^ operation value.! !


!AccountTransaction methodsFor: 'initialization' stamp: 'MLNV 10/25/2023 18:01:43'!
initializeFor: anOperation

	operation := anOperation ! !


!AccountTransaction methodsFor: 'report generation' stamp: 'MLNV 10/26/2023 13:56:49'!
includeInto: aReport
	
	operation includeTransaction: (self class name) into: aReport.! !


!AccountTransaction methodsFor: 'balance' stamp: 'MLNV 10/26/2023 10:27:08'!
applyToBalance: aBalance

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'MLNV 10/25/2023 18:01:23'!
ofOperation: anOperation

	^ self new initializeFor: anOperation! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'MLNV 10/25/2023 18:00:21'!
register: aValue on: account

	| transaction |
	
	transaction := self ofOperation: (BasicOperation for: aValue).
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'balance' stamp: 'MLNV 10/25/2023 18:27:37'!
applyToBalance: aBalance

	^operation addToBalance: aBalance.! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'balance' stamp: 'MLNV 10/25/2023 18:27:46'!
applyToBalance: aBalance

	^operation substractFromBalance: aBalance.! !


!classDefinition: #FinancialRecord category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialRecord
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialRecord methodsFor: 'transactions' stamp: 'MLNV 10/17/2023 00:54:16'!
balance

	self subclassResponsibility! !

!FinancialRecord methodsFor: 'transactions' stamp: 'MLNV 10/17/2023 00:54:18'!
hasRegistered: aTransaction

	self subclassResponsibility! !


!FinancialRecord methodsFor: 'initialization' stamp: 'MLNV 10/17/2023 00:54:27'!
initialize

	self subclassResponsibility! !


!FinancialRecord methodsFor: 'naming' stamp: 'MLNV 10/25/2023 23:05:57'!
name

	^name.! !

!FinancialRecord methodsFor: 'naming' stamp: 'MLNV 10/25/2023 21:47:23'!
setName: aName.

	name := aName.! !


!FinancialRecord methodsFor: 'private' stamp: 'MLNV 10/17/2023 00:54:04'!
addFather: aFinancialRecord

	self subclassResponsibility! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialRecord subclass: #Portfolio
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


!Portfolio methodsFor: 'records' stamp: 'MLNV 10/26/2023 13:38:52'!
add: aFinancialRecord 
	
	(self rootsIntersectWith: aFinancialRecord) ifTrue: [self error: self class alreadyInPortfolioErrorDescription].
	
	records add: aFinancialRecord .
	aFinancialRecord addFather: self.! !

!Portfolio methodsFor: 'records' stamp: 'MLNV 10/26/2023 13:44:47'!
includes: aFinancialRecordToCheck
	
	^self = aFinancialRecordToCheck or: [records anySatisfy: [:childRecord | childRecord includes: aFinancialRecordToCheck]].! !


!Portfolio methodsFor: 'private' stamp: 'MLNV 10/16/2023 23:52:17'!
addFather: aFinancialRecord 
	
	fathers add: aFinancialRecord.! !

!Portfolio methodsFor: 'private' stamp: 'MLNV 10/26/2023 13:39:22'!
intersectsWith: aFinancialRecordToCheck
			
	^records isEmpty 
		ifTrue: [aFinancialRecordToCheck includes: self.]
		ifFalse: [records anySatisfy: [:aRecord | aRecord intersectsWith: aFinancialRecordToCheck]].
	! !

!Portfolio methodsFor: 'private' stamp: 'MLNV 10/26/2023 13:41:01'!
isRoot

	^fathers isEmpty.
	! !

!Portfolio methodsFor: 'private' stamp: 'MLNV 10/26/2023 13:42:47'!
rootsIntersectWith: aFinancialRecordToCheck

	^self isRoot 
		ifTrue: [self intersectsWith: aFinancialRecordToCheck]
		ifFalse: [fathers anySatisfy: [:aFinancialRecord | aFinancialRecord rootsIntersectWith: aFinancialRecordToCheck]].! !


!Portfolio methodsFor: 'initialization' stamp: 'MLNV 10/17/2023 01:11:27'!
initialize
	
	records := OrderedCollection new.
	fathers := OrderedCollection new.! !


!Portfolio methodsFor: 'report generation' stamp: 'MLNV 10/26/2023 13:31:16'!
generateReport: aReport 
	
	records do: [:aFinancialRecord | aReport generateSubtreeReport: aFinancialRecord]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'MLNV 10/25/2023 21:47:12'!
named: aName with: anAccount 

	^(self new) 
		setName: aName; 
		add: anAccount; 
		yourself.! !

!Portfolio class methodsFor: 'instance creation' stamp: 'MLNV 10/25/2023 21:46:44'!
named: aName with: anAccount with: anotherAccount

	^(self new) 
		setName: aName; 
		add: anAccount; 
		add: anotherAccount; 
		yourself.! !

!Portfolio class methodsFor: 'instance creation' stamp: 'MLNV 10/24/2023 19:04:18'!
with: aStartingRecord

	^(self new) add: aStartingRecord; yourself.! !


!Portfolio class methodsFor: 'error description' stamp: 'MLNV 10/16/2023 23:23:53'!
alreadyInPortfolioErrorDescription

	^'No se puede agregar una cuenta repetida al mismo portfolio'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialRecord subclass: #ReceptiveAccount
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

!ReceptiveAccount methodsFor: 'private' stamp: 'MLNV 10/26/2023 13:39:22'!
intersectsWith: aFinancialRecord

	^aFinancialRecord includes: self.
	
	
					! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'report generation' stamp: 'MLNV 10/26/2023 13:36:24'!
generateReport: aReport

	transactions do: [:aTransaction | aTransaction includeInto: aReport].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Ejercicio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'MLNV 10/25/2023 21:43:13'!
named: aName

	^self new setName: aName.
	! !


!classDefinition: #Report category: 'Portfolio-Ejercicio'!
Object subclass: #Report
	instanceVariableNames: 'financialRecord report operationToReportEntryDictionary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Report methodsFor: 'report generation' stamp: 'MLNV 10/25/2023 21:20:14'!
generate

	self subclassResponsibility! !

!Report methodsFor: 'report generation' stamp: 'MLNV 10/26/2023 13:31:16'!
generateSubtreeReport: aFinancialRecord

	^aFinancialRecord generateReport: self.! !

!Report methodsFor: 'report generation' stamp: 'MLNV 10/26/2023 13:22:08'!
include: aTransactionType with: aValue

	self subclassResponsibility! !


!Report methodsFor: 'initialization' stamp: 'MLNV 10/25/2023 21:20:17'!
initializeDetailDictionary

	self subclassResponsibility! !

!Report methodsFor: 'initialization' stamp: 'MLNV 10/25/2023 21:20:47'!
initializeFor: aFinancialRecord

	financialRecord := aFinancialRecord.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-Ejercicio'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'MLNV 10/25/2023 21:20:37'!
for: aFinancialRecord

	^self new initializeFor: aFinancialRecord.! !


!classDefinition: #AccountSummary category: 'Portfolio-Ejercicio'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountSummary methodsFor: 'initialization' stamp: 'MLNV 10/25/2023 20:53:33'!
initializeDetailDictionary

	operationToReportEntryDictionary := Dictionary new.
	
	operationToReportEntryDictionary 
		add: #(#Deposit #Transfer) -> [:value | 'Entrada por transferencia de ', value asString, '.'];
		add: #(#Withdraw #Transfer) -> [:value | 'Salida por transferencia de ', value asString, '.'];
		add: #(#Withdraw #BasicOperation) -> [:value | 'Extracción por ', value asString, '.'];
		add: #(#Deposit #BasicOperation) -> [:value | 'Depósito por ', value asString, '.'].! !


!AccountSummary methodsFor: 'report generation' stamp: 'MLNV 10/26/2023 13:24:24'!
generate
	
	self initializeDetailDictionary.
	
	report := OrderedCollection new.
	financialRecord generateReport: self.
	report add: 'Balance = ', financialRecord balance asString.
	
	^report.

	
	! !

!AccountSummary methodsFor: 'report generation' stamp: 'MLNV 10/26/2023 13:22:09'!
include: aTransactionType with: aValue

	report add: ((operationToReportEntryDictionary at: aTransactionType) value: aValue)! !


!classDefinition: #PortfolioNameTree category: 'Portfolio-Ejercicio'!
Report subclass: #PortfolioNameTree
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioNameTree methodsFor: 'report generation' stamp: 'natanvek 10/26/2023 02:11:57'!
generate

	report := OrderedCollection with: (financialRecord name).
	financialRecord generateReport: self.
	^report

	
	! !

!PortfolioNameTree methodsFor: 'report generation' stamp: 'MLNV 10/26/2023 13:31:16'!
generateSubtreeReport: aFinancialRecord

	| subtreeReport |

	subtreeReport := (self class for: aFinancialRecord) generate.
	subtreeReport := (subtreeReport collect:[:aReportEntry | '    ', aReportEntry]).
	report addAll: subtreeReport.
	
	
	
	! !

!PortfolioNameTree methodsFor: 'report generation' stamp: 'MLNV 10/26/2023 13:25:32'!
include: aTransactionType with: aValue
	
	^self.! !


!classDefinition: #TransferNet category: 'Portfolio-Ejercicio'!
Report subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferNet methodsFor: 'initialization' stamp: 'MLNV 10/25/2023 21:25:43'!
initializeDetailDictionary

	operationToReportEntryDictionary := Dictionary new.
	
	operationToReportEntryDictionary 
		add: #(#Deposit #Transfer) -> [:value | value];
		add: #(#Withdraw #Transfer) -> [:value | value negated];
		add: #(#Withdraw #BasicOperation) -> [:value | 0];
		add: #(#Deposit #BasicOperation) -> [:value | 0].! !


!TransferNet methodsFor: 'report generation' stamp: 'MLNV 10/26/2023 10:08:15'!
generate

	self initializeDetailDictionary.
	
	report := 0.
	financialRecord generateReport: self.
		
	^report.! !

!TransferNet methodsFor: 'report generation' stamp: 'MLNV 10/26/2023 13:22:09'!
include: aTransactionType with: aValue

	report := report + ((operationToReportEntryDictionary at: aTransactionType) value: aValue)! !
