(*
**unX64**

	Union to convert between byte and value.
	
**Description**

	Can be used e.g. to split a REAL into BYTE or WORD.
	
	Example(s):
	
	  - WORD <-> BYTE:	unX64.aw[0] <-> unX64.ab[0..1]
	  - REAL <-> WORD:	unX64.ar[0] <-> unX64.aw[0..1]
	  - REAL <-> WORD <-> BYTE:	unX64.ar[0] <-> unX64.aw[0..1] <-> unX64.ab[0..3]

*)
{attribute 'naming' := 'omit'}	//Ignore parameter name convention(s)
{attribute 'analysis' := '-33'} //Ignore unused parameters
TYPE unX64 :
UNION
	lw:		LWORD;					// 1x 64Bit
	adw:	ARRAY[0..1] OF DWORD;	// 2x 32Bit
	aw:		ARRAY[0..3] OF WORD;	// 4x 16Bit
	ab:		ARRAY[0..7] OF BYTE;	// 8x  8bit
	
	uli:	ULINT;					// 1x 64Bit unsigned INT
	audi:	ARRAY[0..1] OF UDINT;	// 2x 32Bit unsigned INT
	aui:	ARRAY[0..3] OF UINT;	// 4x 16Bit unsigned INT
	ausi:	ARRAY[0..7] OF USINT;	// 8x  8bit unsigned INT
	
	li:		LINT;					// 1x 64Bit signed INT
	adi:	ARRAY[0..1] OF DINT;	// 2x 32Bit signed INT
	ai:		ARRAY[0..3] OF INT;		// 4x 16Bit signed INT
	asi:	ARRAY[0..7] OF SINT;	// 8x  8bit signed INT
	
	lr:		LREAL;					// 1x 64Bit REAL
	ar:		ARRAY[0..1] OF REAL;	// 2x 32Bit REAL
END_UNION
END_TYPE

VAR_TEMP
	_unX64				: unX64;	// Type converter; e.g. "2x WORD <-> REAL"
END_VAR

// Current
_unX64.aw[0]	:= _typMbMasterResponse.awData[2]; 
_unX64.aw[1]	:= _typMbMasterResponse.awData[3]; 
rCurrent_L1 	:= _unX64.ar[0];

_unX64.aw[0] 	:= _typMbMasterResponse.awData[4]; 
_unX64.aw[1] 	:= _typMbMasterResponse.awData[5]; 
rCurrent_L2 	:= _unX64.ar[0];

_unX64.aw[0] 	:= _typMbMasterResponse.awData[6]; 
_unX64.aw[1] 	:= _typMbMasterResponse.awData[7]; 
rCurrent_L3 	:= _unX64.ar[0];

_unX64.aw[0] 	:= _typMbMasterResponse.awData[8]; 
_unX64.aw[1] 	:= _typMbMasterResponse.awData[9]; 
rCurrent_N 		:= _unX64.ar[0];

// Voltage
_unX64.aw[0] 	:= _typMbMasterResponse.awData[10]; 
_unX64.aw[1] 	:= _typMbMasterResponse.awData[11]; 
rVoltage_L1_N 	:= _unX64.ar[0];

_unX64.aw[0] 	:= _typMbMasterResponse.awData[12]; 
_unX64.aw[1] 	:= _typMbMasterResponse.awData[13]; 
rVoltage_L2_N 	:= _unX64.ar[0];

_unX64.aw[0] 	:= _typMbMasterResponse.awData[14]; 
_unX64.aw[1] 	:= _typMbMasterResponse.awData[15]; 
rVoltage_L3_N 	:= _unX64.ar[0];

_unX64.aw[0] 	:= _typMbMasterResponse.awData[16]; 
_unX64.aw[1] 	:= _typMbMasterResponse.awData[17]; 
rVoltage_L12 	:= _unX64.ar[0];

_unX64.aw[0] 	:= _typMbMasterResponse.awData[18]; 
_unX64.aw[1] 	:= _typMbMasterResponse.awData[19]; 
rVoltage_L23 	:= _unX64.ar[0];

_unX64.aw[0] 	:= _typMbMasterResponse.awData[20]; 
_unX64.aw[1] 	:= _typMbMasterResponse.awData[21]; 
rVoltage_L31 	:= _unX64.ar[0];

// Active power
_unX64.aw[0] 	:= _typMbMasterResponse.awData[22]; 
_unX64.aw[1] 	:= _typMbMasterResponse.awData[23]; 
rActivePower_L1	:= _unX64.ar[0] / 1000;

_unX64.aw[0] 	:= _typMbMasterResponse.awData[24]; 
_unX64.aw[1] 	:= _typMbMasterResponse.awData[25]; 
rActivePower_L2	:= _unX64.ar[0] / 1000;

_unX64.aw[0] 	:= _typMbMasterResponse.awData[26]; 
_unX64.aw[1] 	:= _typMbMasterResponse.awData[27]; 
rActivePower_L3	:= _unX64.ar[0] / 1000;

// Apparent power
_unX64.aw[0] 	:= _typMbMasterResponse.awData[28]; 
_unX64.aw[1] 	:= _typMbMasterResponse.awData[29]; 
rApparentPower_L1:= _unX64.ar[0] / 1000;

_unX64.aw[0] 	:= _typMbMasterResponse.awData[30]; 
_unX64.aw[1] 	:= _typMbMasterResponse.awData[31]; 
rApparentPower_L2:= _unX64.ar[0] / 1000;

_unX64.aw[0] 	:= _typMbMasterResponse.awData[32]; 
_unX64.aw[1] 	:= _typMbMasterResponse.awData[33]; 
rApparentPower_L3:= _unX64.ar[0] / 1000;

// Reactive power
_unX64.aw[0] 	:= _typMbMasterResponse.awData[34]; 
_unX64.aw[1] 	:= _typMbMasterResponse.awData[35]; 
rReactivePower_L1:= _unX64.ar[0] / 1000;

_unX64.aw[0] 	:= _typMbMasterResponse.awData[36]; 
_unX64.aw[1] 	:= _typMbMasterResponse.awData[37]; 
rReactivePower_L2:= _unX64.ar[0] / 1000;

_unX64.aw[0] 	:= _typMbMasterResponse.awData[38]; 
_unX64.aw[1] 	:= _typMbMasterResponse.awData[39]; 
rReactivePower_L3:= _unX64.ar[0] / 1000;

// Frequency
_unX64.aw[0] 	:= _typMbMasterResponse.awData[46];
_unX64.aw[1] 	:= _typMbMasterResponse.awData[47];
rFrequency_L1	:= _unX64.ar[0];

_unX64.aw[0] 	:= _typMbMasterResponse.awData[48];
_unX64.aw[1] 	:= _typMbMasterResponse.awData[49];
rFrequency_L2	:= _unX64.ar[0];

_unX64.aw[0] 	:= _typMbMasterResponse.awData[50]; 
_unX64.aw[1] 	:= _typMbMasterResponse.awData[51]; 
rFrequency_L3	:= _unX64.ar[0];

// Summation & scaling
_rActivePower_Sum 	:= rActivePower_L1 + rActivePower_L2 + rActivePower_L3;
_rApparentPower_Sum	:= MAX (rApparentPower_L1 + rApparentPower_L2 + rApparentPower_L3, _rActivePower_Sum);

rApparentPower	:= _rApparentPower_Sum;//[kVA]
rActivePower 	:= _rActivePower_Sum; // [kW]
// rReactivePower 	:= SQRT (EXPT(rApparentPower_Sum, 2) - EXPT(rActivePower_Sum, 2)); // [kVar]
rReactivePower 	:= rReactivePower_L1 + rReactivePower_L2 + rReactivePower_L3; // [kVar]
rAvgVoltage_LN	:= (rVoltage_L1_N + rVoltage_L2_N + rVoltage_L3_N) / 3; // [V]
rAvgVoltage_LL	:= (rVoltage_L12 + rVoltage_L23 + rVoltage_L31) / 3; // [V]
rAvgFrequency		:= (rFrequency_L1 + rFrequency_L2 + rFrequency_L3) / 3; // [Hz]
rAvgCurrent 		:= (rCurrent_L1 + rCurrent_L2 + rCurrent_L3) / 3;

(* Set timestamp information *)
dtDataValid := WagoAppTime.FuGetLocalDateAndTime();
