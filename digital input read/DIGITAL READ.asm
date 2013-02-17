	PROCESSOR 16F84A
	INCLUDE <P16F84A.INC>

	__config _XT_OSC & _WDT_OFF & _PWRTE_OFF & _CP_OFF

CNT_0	EQU	0x20 ;DEFINE COUNTER 0
CNT_1	EQU	0x21 ;DEFINE COUNTER 1
CNT_2	EQU	0x22 ;DEFINE COUNTER 2

	ORG	0x00
INIT:
	MOVLW	B'00100000' ;GOTO BANK 1
	MOVWF	STATUS

	MOVLW	B'00000010' ;SET ALL PORTB BITS AS OUTPUTS EXCEPT PB1
	MOVWF	TRISB

	MOVLW	B'00000000'
	MOVWF	STATUS ;GOTO BANK 0

	;SET COUNTERS
	MOVLW 0xFF
	MOVWF CNT_0
	MOVLW 0xFF
	MOVWF CNT_1
	MOVLW 0x0E
	MOVWF CNT_2

MAIN:

L1:
	BTFSS	PORTB, 1 ;LOOP UNTIL PB1 BECOME HIGH
	GOTO L1
	MOVLW	B'00000001' ;SET PB0 LOW
	MOVWF	PORTB
	;CALL DELAY

L2:
	BTFSC	PORTB, 1 ;LOOP UNTIL PB1 BECOME LOW
	GOTO L2
	MOVLW	B'00000000' ;SET PB0 HIGH
	MOVWF	PORTB
	;CALL DELAY

	GOTO	MAIN

DELAY:

;DELAY_K
DELAY_K:
	;DELAY_J
DELAY_J:
		;DELAY_I
DELAY_I:
	DECFSZ CNT_0
	GOTO DELAY_I
		;END DELAY_I
	MOVLW 0xFF
	MOVWF CNT_0

	DECFSZ CNT_1
	GOTO DELAY_J
	;END DELAY_J
	MOVLW 0xFF
	MOVWF CNT_1

	DECFSZ CNT_2
	GOTO DELAY_K
;END DELAY_K

	;RESET COUNTERS
	MOVLW 0xFF
	MOVWF CNT_0
	MOVLW 0xFF
	MOVWF CNT_1
	MOVLW 0x0E
	MOVWF CNT_2

	RETURN

	END