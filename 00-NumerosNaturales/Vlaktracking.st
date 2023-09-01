!classDefinition: #I category: 'Vlaktracking'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Vlaktracking'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Vlaktracking'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'operadoresAritmeticos' stamp: 'MLNV 8/29/2023 22:09:54'!
* numero
	^numero! !

!I class methodsFor: 'operadoresAritmeticos' stamp: 'MLNV 8/29/2023 21:29:14'!
+ unSumando
	^unSumando next.! !

!I class methodsFor: 'operadoresAritmeticos' stamp: 'MLNV 8/29/2023 22:01:21'!
- numero
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'operadoresAritmeticos' stamp: 'MLNV 8/29/2023 21:57:39'!
/ divisor
	(self = divisor) ifTrue: [^I].
	^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !


!I class methodsFor: 'operadoresRelacionales' stamp: 'popo 8/28/2023 17:54:28'!
< numero
	^(numero = self) not.! !

!I class methodsFor: 'operadoresRelacionales' stamp: 'popo 8/28/2023 17:49:24'!
= numero
	^self name = numero name.! !

!I class methodsFor: 'operadoresRelacionales' stamp: 'popo 8/28/2023 17:50:41'!
> numero
	^false.! !


!I class methodsFor: 'operadoresDeAdyacencia' stamp: 'MLNV 8/29/2023 21:29:14'!
next
	^II.! !


!I class methodsFor: 'mensajesDeError' stamp: 'MLNV 8/29/2023 21:59:11'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor en el dominio de los Naturales'.! !

!I class methodsFor: 'mensajesDeError' stamp: 'MLNV 8/29/2023 22:00:59'!
descripcionDeErrorDeNumerosNegativosNoSoportados.
	^'No puedo restarle numeros al I ya que estamos en el dominio de los naturales'.! !


!I class methodsFor: 'metodosAuxiliares' stamp: 'MLNV 8/29/2023 21:29:48'!
resta: numero
	^numero previous! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'MLNV 9/1/2023 14:28:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !


!classDefinition: #II category: 'Vlaktracking'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Vlaktracking'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Vlaktracking'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'operadoresAritmeticos' stamp: 'MLNV 8/29/2023 21:29:48'!
* numero
	^numero + (self previous * numero).! !

!II class methodsFor: 'operadoresAritmeticos' stamp: 'MLNV 8/29/2023 21:29:48'!
+ unSumando
	^self previous + unSumando next.! !

!II class methodsFor: 'operadoresAritmeticos' stamp: 'popo 8/28/2023 18:01:22'!
- numero
	^ numero resta: self.
	! !

!II class methodsFor: 'operadoresAritmeticos' stamp: 'MLNV 9/1/2023 14:26:38'!
/ divisor
	(self < divisor) ifTrue: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	((self = divisor) or: [self - divisor < divisor]) ifTrue: [^I].
	^I + ((self - divisor) / divisor).! !


!II class methodsFor: 'operadoresRelacionales' stamp: 'MLNV 8/29/2023 21:29:48'!
< numero
	^(self previous < numero) and: ((self = numero) not).
	! !

!II class methodsFor: 'operadoresRelacionales' stamp: 'popo 8/28/2023 17:50:04'!
= numero
	^self name = numero name.
	! !


!II class methodsFor: 'mensajesDeError' stamp: 'MLNV 8/29/2023 21:59:18'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor en el dominio de los Naturales'.! !


!II class methodsFor: 'operadoresDeAdyacencia' stamp: 'MLNV 8/29/2023 21:30:12'!
next
	next ifNotNil: [^next].
	next := II createChildNamed: self name, 'I'.
	next previous: self.
	^next.! !

!II class methodsFor: 'operadoresDeAdyacencia' stamp: 'MLNV 8/29/2023 21:29:48'!
previous
	^previous.! !


!II class methodsFor: 'mensajesAuxiliares' stamp: 'MLNV 8/29/2023 21:30:12'!
previous: unPrevio
	previous := unPrevio.
	! !

!II class methodsFor: 'mensajesAuxiliares' stamp: 'MLNV 8/29/2023 21:29:48'!
resta: numero 
	^numero previous - self previous.
	! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'MLNV 9/1/2023 14:28:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Vlaktracking'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Vlaktracking'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Vlaktracking'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'MLNV 9/1/2023 14:28:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Vlaktracking'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Vlaktracking'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Vlaktracking'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'MLNV 9/1/2023 14:28:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'Vlaktracking'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Vlaktracking'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Vlaktracking'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'MLNV 9/1/2023 14:28:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: 'Vlaktracking'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Vlaktracking'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Vlaktracking'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'MLNV 9/1/2023 14:28:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIIII.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!