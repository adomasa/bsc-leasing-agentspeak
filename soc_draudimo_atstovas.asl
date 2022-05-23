// Suma, asmens kodas
Pajamos(2000, 00000000000).
Pajamos(1500, 00000000033).
Pajamos(700, 00000001008).

// Suma, asmens kodas
Isipareigojimai(100, 00000000000).
Isipareigojimai(0, 00000000033).
Isipareigojimai(38, 00000001008).

+!pasidalinti_soc_draudejo_kontaktais[source(Lizinguotojas)]
   : true
   <- .send(Lizinguotojas, tell, socialinisDraudejas(AsmensKodas, Pajamos, Isipareigojimai)).

+!pateikti_finansinius_duomenis(AsmensKodas)[source(Lizinguotojas)]
   : Pajamos(Pajamos, AsmensKodas) & 
     Isipareigojimai(Isipareigojimai, AsmensKodas)
   <- .print("Grąžinami finansiniai duomenys apie pirkėją: ", AsmensKodas);
      .send(Lizinguotojas, tell, finansiniai_duomenys(AsmensKodas, Pajamos, Isipareigojimai)).

+!pateikti_finansinius_duomenis(AsmensKodas)[source(Lizinguotojas)]
   : true
   <- .print("Nerasti finansiniai duomenys apie pirkėją: ", AsmensKodas);
      .send(Lizinguotojas, tell, finansiniai_duomenys(AsmensKodas, 0, 0)).