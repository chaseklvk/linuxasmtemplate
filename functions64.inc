;
;Include file for the functions library
;

;Print a string with an ending 00h delimiter to the console
;Stack Contents:
;	Address of the String (Stack)
;Example Usage:
;	push	stringVariable
;	call	PrintString
;
extern		PrintString

;Print a space to the console
;Stack Contents:
;	None
;Example Usage:
;	call	PrintSpace
;
extern		PrintSpace

;Print 'x' number of spaces
;Stack Contents:
;	the total spaces to print
;Example Usage:
;	push	DWORD 5
;	call	PrintSpaces
;
extern		PrintSpaces

;Print a comma to the console
;Stack Contents:
;	None
;Example Usage:
;	call	PrintComma
;
extern		PrintComma

;Print a new line to the console
;Stack Contents:
;	None
;Example Usage:
;	call	Printendl
;
extern		Printendl

;Print a string which is not null terminated
;Stack contents:
;	The Address of the string to print
;	The length of the string to print
;Example Usage:
;	push	stringVariable
;	push	stringVariable.len
;	call	PrintText
;
extern		PrintText

;Convert and then print a 64bit hex number
;Stack contents:
;	Value to Convert to an Ascii String
;Example Usage:
;	push	QWORD [quadWordVariable]
;	call	Print64bitNumHex
;
extern		Print64bitNumHex
   
;Convert and then print a 64bit octal number
;Stack contents:
;	Value to Convert to an Ascii String
;Example Usage:
;	push	QWORD [quadWordVariable]
;	call	Print64bitNumOctal
;
extern		Print64bitNumOctal

;Convert and then print a 64bit decimal number
;Stack contents:
;	Value to Convert to an Ascii String
;Example Usage:
;	push QWORD [quadwordvariable]
;	call	Print64bitNumDecimal
;
extern		Print64bitNumDecimal

;Convert and then print a signed 64bit decimal number
;Stack contents:
;	Value to Convert to an Ascii String
;Example Usage:
;	push QWORD [quadwordvariable]
;	call	Print64bitNumDecimal
;
extern		Print64bitSNumDecimal

;Convert and then print a 64bit binary number
;Stack contents:
;	Value to Convert to an Ascii String
;Example Usage:
;	push QWORD [quadwordvariable]
;	call	Print64bitNumBinary
;
extern		Print64bitNumBinary

;Print a full 64bit binary number including leading zeros
;Stack contents:
;	Value to Convert to an Ascii String
;Example Usage:
;	push QWORD [quadwordvariable]
;	call	Print64bitFullBinary
;
extern		Print64bitFullBinary

;This routine prints a string to the screen left justified
;Stack contents:
;	Address of the string [ebp + 16]
;	Number of characters it will be justified within [ebp + 24]
;Example Usage:
;	push	stringVariable
;	push	QWORD 80
;	call	PrintLeft
;
extern		PrintLeft

;This routine prints a string to the screen right justified
;Stack contents:
;	Address of the string [ebp + 16]
;	Number of characters it will be justified within [ebp + 24]
;Example Usage:
;	push	stringVariable
;	push	QWORD 80
;	call	PrintRight
;
extern		PrintRight

;This routine prints a string to the screen center justified
;Stack contents:
;	Address of the string [ebp + 16]
;	Number of characters it will be justified within [ebp + 24]
;Example Usage:
;	push	stringVariable
;	push	QWORD 80
;	call	PrintCenter
;
extern		PrintCenter

;Print all 64bit Registers to the screen
;Stack contents:
;	None
;Example Usage:
;	call	PrintRegisters
;
extern		PrintRegisters

;Call the necessary interrupt with the necessary register values to read data from the keyboard
;Stack Contents:
;	Address of keyboard buffer
;	Size of the keyboard buffer
;Return:
;	Rax will contain the usigned ingeter
;	Carry flag will be set if invalid integer was input
extern		ReadText

;Input UnSigned Int 
;This function will let the user input a string.  It will then convert the ASCII 
;string into a QWORD and return that value in the RAX register.
;Arguments: None
;Return: 	rax will contain the usigned ingeter
;			Carry flag will be set if invalid integer was input
;Example Usage:
;	call	InputInt
;	Note: eax will contain the value of the unsigned integer entered
;	jnc		validIntegerInput
;	Otherwise, an invalid integer was input
extern		InputUInt

;Input Signed Int 
;This function will let the user input a string, then it will check it to make sure it
;is a positive integer.  It will then convert the ASCII string into a DWORD and return
;that value in the EAX register.
;Arguments: None
;Return: 	eax will contain the usigned ingeter
;			Carry flag will be set if invalid integer was input
;Example Usage:
;	call	InputSInt
;	Note: eax will contain the value of the signed integer entered
;	jnc		validIntegerInput
;	Otherwise, an invalid integer was input
extern		InputSInt

;Call the necessary interrupt with the necessary register values to read data from the keyboard
;Stack Contents:
;	Address of the string to print
;	Address of keyboard buffer
;	Size of the keyboard buffer
;Return:
;	Rax will contain the number of characters input
;Example Usage:
;	push	inputPromptVariable
;	push	keyboardBufferVariable
;	push	keyboardBufferVariable.len  ;This is the maximum size of the buffer
;	call	ReadTextWPrompt
extern		ReadTextWPrompt

