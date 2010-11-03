Object subclass: PrefConfiguration [
    | sections |

    sections [
	sections ifNil: [sections := Dictionary new]
    ]

    groupAt: name [
	^sections at: name ifAbsent: [SystemException.NotFound signal: 'The group ', name, ' does not exist in the configuration' ]
    ]
]
