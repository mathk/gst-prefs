Object subclass: PrefVariable [
    | name value section |

    PrefVariable class >> in: section name: aString value: aValue [
	^(self new)
	    name: aString;
	    value: aValue;
	    section: section;
	    yourself
    ]

    section: aSection [
	section := aSection
    ]
    
    name [
	^name
    ]

    name: aString [
	name := aString
    ]

    value [
	^value
    ]

    value: aValue [
	value := aValue
    ]

]
