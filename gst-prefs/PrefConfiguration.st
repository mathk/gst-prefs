Object subclass: PrefConfiguration [
    | sections |


    sections [
	<category: 'accessing'>
	sections ifNil: [sections := Dictionary new]
    ]

    groupAt: name [
	<category: 'accessing'>
	^sections at: name ifAbsent: [SystemException.NotFound signal: 'The group ', name, ' does not exist in the configuration' ]
    ]

    addGroup: name [
	^section at: name put: OrderedCollection new.
    ]
]
