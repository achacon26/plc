VAR
  tTonPulse: TON; 
  xPulseOneCycle: BOOL;             
END_VAR

tTonPulse(IN:= TRUE, PT:= T#200ms);
IF tTonPulse.Q THEN
    tTonPulse(IN:= FALSE);
    xPulseOneCycle := TRUE;
END_IF;

IF xPulseOneCycle THEN
    // Aquí puedes realizar las acciones que deseas mientras el xPulseOneCycle esté activo
    // Por ejemplo, encender una salida
    xPulseOneCycle := FALSE;
END_IF;
