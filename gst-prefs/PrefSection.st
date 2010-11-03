Object subclass: PrefSection [
    | name subsections variables parent |

    subsections [
	^subsections ifNil: [subsections := OrderedCollection new]
    ]

    name [
	^name
    ]

    name: aString [
	name := aString
    ]

    variables [
	^variables ifNil: [variables := Dictionary new]
    ]

    sectionAt: name [
	^subsections detect: [each | each name = name] 
		     ifNone: [SystemExceptions.NotFound signal: 'The section', name, ' is not found in ', self printString]
    ]

    printOn: aStream [
	parent ifNotNil: [
	    parent printOn: aStream.
	    aStream nextPut: $.
	].
	aStream nextPutAll: 'name'
    ]

    variableAt: name [
	^variables at: name
    ]

    variableAt: name put: value [
	
    ]
]
