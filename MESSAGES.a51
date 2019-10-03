PUBLIC mes_seg1_1
PUBLIC mes_seg1_2
PUBLIC mes_seg1_3
PUBLIC mes_seg1_4
PUBLIC mes_seg1_5
PUBLIC mes_seg1_6


__MESSAGES SEGMENT CODE
RSEG __MESSAGES
	
mes_seg1_1:		DB 	"Conveyors started\r\n"		,0
mes_seg1_2:		DB 	"Capacity reached\r\n"		,0
mes_seg1_3:		DB 	"Packages in position\r\n"	,0
mes_seg1_4:		DB 	"Pushing packages\r\n"		,0
mes_seg1_5:		DB 	"Clamping packages\r\n"		,0
mes_seg1_6:		DB 	"Unclamping packages\r\n"	,0

END