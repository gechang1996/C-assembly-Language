

.text
.global dumb_multiply
.global multiply
.global signed_multiply


@
@ Multiply two numbers together by brute force
@ r0 - First unsigned value
@ r1 - Second unsigned value
@ Returns r0 * r1
@
dumb_multiply:
	bx lr

@
@ Multiply two numbers together efficiently
@ r0 - First unsigned value
@ r1 - Second unsigned value
@ Returns r0 * r1
@
multiply:
	bx lr


@
@ Multiply two signed numbers together efficiently
@ r0 - First  value
@ r1 - Second value
@ Returns r0 * r1
@
signed_multiply:
	bx lr
