Object subclass: PrefIniReader [
    | stream config group linePeeked |

    PrefIniReader class >> parse: fileName [
	<category: 'instance-creation'>
	^self parseStream: (FileStream on: fileName)
    ]

    PrefIniFile class >> parseStream: fileStream [
	<category: 'instance-creation'>
	^(self new)
	    parseStream: fileStream
    ]

    config [
	<category: 'accessing'>
	^config ifNil: [config := PrefConfiguration new]
    ]

    parseStream: aStream [
	| currentLine group |
	stream := aStream.
	self parse
    ]

    parse [
	| line result |
	[(line := self nextMeaningfulLine) ~= nil ]
	    whileTrue: [
		result := line searchRegex: '^[ \t]*\[(\w*)\]'.
		result matched ifFalse:[self error: 'Expexted group declaration ', line,  ' given'].
		group := self config addGroup: (result at: 1).
		self parseGroup
	    ]
    ]

    parseGroup [
	| line |
	[(line := self peelMeaningfullLine) ~= nil and: [(line matchRegex: '^[ \t]*\[(\w*)\]']) not ]
	    whileTrue:[
		self parseSection
	    ]
	    
    ]
    
    parseSection [
	
    ]

    peekMeaningfulLine [
	^linePeeked 
            ifNotNil: [linePeeked]
	    ifNil: [linePeeked := self nextMeaninfulLine].
	
    ]

    nextMeaningfulLine [
	| currentLine |
	linePeeked ifNotNil: [
	    | return |
	    return := linePeeked.
	    linePeeked := nil.
	    ^return
	]
	currentLine := ''.
	[
	    ((currentLine indexOfRegex: '^[ \t]*#') ~= nil
	            or: [currentLine matchRegex: '^[ \t]*'])
	] whileTrue: [
	    self atEnd ifTrue: [^nil].
	    currentLine := stream nextLine.].
	^currentLine
    ]

    atEnd [
	^stream atEnd
    ]
]
