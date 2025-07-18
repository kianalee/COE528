;*****************************************************************
;* This stationery serves as the framework for a                 *
;* user application (single file, absolute assembly application) *
;* For a more comprehensive program that                         *
;* demonstrates the more advanced functionality of this          *
;* processor, please see the demonstration applications          *
;* located in the examples subdirectory of the                   *
;* Freescale CodeWarrior for the HC12 Program directory          *
;*****************************************************************

; export symbols
            XDEF Entry, _Startup            ; export 'Entry' symbol
            ABSENTRY Entry        ; for absolute assembly: mark this as application entry point



; Include derivative-specific definitions 
		INCLUDE 'derivative.inc' 


; variable/data section
            ORG $4000

Entry:
_Startup:
            
;************************************************************
;* Motor Control *
;************************************************************
            BSET DDRA,%00000011
            BSET DDRT,%00110000
            
                        
            JSR STAROFF
            JSR PORTOFF
            
            JSR STARFWD
            JSR PORTFWD

            
            JSR STARREV
            JSR PORTREV
            
            JSR STARON
            JSR PORTON

            BRA *
            
;***********************************
; Motor speed
;***********************************
            
STARON      LDAA PTT
            ORAA #%00100000
            STAA PTT
            RTS
            
STAROFF     LDAA PTT
            ANDA #%11011111
            STAA PTT
            RTS

PORTON      LDAA PTT
            ORAA #%00010000
            STAA PTT
            RTS
                        
PORTOFF     LDAA PTT
            ANDA #%11101111
            STAA PTT
            RTS
            
;***********************************
; Motor direction
;***********************************

STARFWD     LDAA PORTA
            ANDA #%11111101
            STAA PORTA
            RTS            
STARREV     LDAA PORTA
            ORAA #%00000010
            STAA PORTA
            RTS

PORTFWD     LDAA PORTA
            ANDA #%11111110
            STAA PORTA
            RTS
            
PORTREV     LDAA PORTA
            ORAA #%00000001
            STAA PORTA
            RTS
            
;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************
            ORG   $FFFE
            DC.W  Entry           ; Reset Vector