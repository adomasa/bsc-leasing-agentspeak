maxDTI(0.49). // procentai dešimtainiu formatu
maxLTV(0.95). // procentai dešimtainiu formatu
minPajamos(700).
maxPeriodas(60). // mėnesiai
minIsankstinisMokejimas(0.1). // prekės vertės dalis

!ieskoti_soc_draudimo_atstovu.

+!ieskoti_soc_draudimo_atstovu
   : true
   <- .print("Ieškomi socialinio draudimo atstovai sistemoje");
   .broadcast(achieve,pasidalinti_soc_draudejo_kontaktais).

leidziamaFinansuoti(Pajamos, Isipareigojimai, Isiskolinimas, IsankstinisMokejimas, PrekesVerte, Periodas) 
   :- maxDTI(MaxDTI) & (Isipareigojimai + Isiskolinimas / Periodas) / Pajamos <= MaxDTI & 
      maxLTV(MaxLTV) & (Isiskolinimas - IsankstinisMokejimas) / PrekesVerte <= MaxLTV &
      minPajamos(MinPajamos) & Pajamos >= MinPajamos &
      maxPeriodas(MaxPeriodas) & Periodas <= MaxPeriodas &
      minIsankstinisMokejimas(MinIsankstinisMokejimas) & IsankstinisMokejimas / PrekesVerte >= MinIsankstinisMokejimas

+ivertinti_paraiska(AsmensKodas, Pajamos, Isipareigojimai, Isiskolinimas, IsankstinisMokejimas, PrekesVerte, Periodas)[source(Pirkejas)]
: socialinisDraudejas(SocialinisDraudejas)
<- .print("Gauta lizingo paraiška iš pirkėjo: ", Pirkejas);
   +paraiska(Pirkejas, AsmensKodas, Pajamos, Isipareigojimai, Isiskolinimas, IsankstinisMokejimas, PrekesVerte, Periodas);
   .send(SocialinisDraudejas, achieve, pateikti_finansinius_duomenis(AsmensKodas)).

+finansiniai_duomenys(AsmensKodas, Pajamos, Isipareigojimai)
 : paraiska(Pirkejas, AsmensKodas, Pajamos, Isipareigojimai, Isiskolinimas, IsankstinisMokejimas, PrekesVerte, Periodas) &
   leidziamaFinansuoti(Pajamos, Isipareigojimai, Isiskolinimas, IsankstinisMokejimas, PrekesVerte, Periodas)
   <- .print("Lizingo paraiška priimta pirkėjui: ", Pirkejas);
      .send(Pirkejas, tell, paraiska_ivertinta(1)).

+finansiniai_duomenys(AsmensKodas, Pajamos, Isipareigojimai)
   : paraiska(Pirkejas, AsmensKodas, Pajamos, Isipareigojimai, Isiskolinimas, IsankstinisMokejimas, PrekesVerte, Periodas) |
     not leidziamaFinansuoti(Income, Obligations, LeaseAmount, LeasePeriod)
   <- .print("Lizingavmo paraiška atmesta pirkėjui: ", Pirkejas);
      .send(Pirkejas, tell, paraiska_ivertinta(0)).
