;Calculate the variance of an array of numbers
;Stack Contents:
;	Address of the Array
;   Number of elements in Array
;Return:
;   RAX will contain the variance
;Example Usage:
;	push	SampleArray
;   push    SampleArray.numElements
;	call	calcvariance

extern calcvariance