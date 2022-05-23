!ieskoti_lizinguotoju.
!ieskoti_autentifikuotoju.
!inicializuoti_vartotojo_sasaja.

+!inicializuoti_vartotojo_sasaja
  <-  makeArtifact("gui","c4j.GUI",[],Id);
      focus(Id).

+terminuoti_agenta
  <-  .my_name(Me);
      .kill_agent(Me).

+!ieskoti_autentifikuotoju
   : true
   <- .print("Ieškomi autentifikuotojai sistemoje");
   .broadcast(achieve,pasidalinti_autentifikuotoju_kontaktais).

+!ieskoti_lizinguotoju
   : true
   <- .print("Ieškomi lizinguotojai sistemoje");
   .broadcast(achieve,pasidalinti_lizinguotoju_kontaktais).

+!prideti_lizinguotojo_kontakta[source(Lizinguotojas)]
   : true
   <- .print("Rastas naujas lizinguotojas - ", Lizinguotojas);
      // Saugome tik vieną kontaktą
      -Lizinguotojas(_);
      +Lizinguotojas(Lizinguotojas).

// Tapatybes patvirtinimas ----------------------------
+patvirtinti_tapatybe(AsmensKodas) 
  : Autentifikuotojas(A)
  <- println("Inicijuotas tapatybės patvirtinimas su asmens kodu: ",AsmensKodas);
     .send(A, achieve, patvirtinti_tapatybe(AsmensKodas))).

+tapatybes_patvirtinimo_sesija(KontrolinisKodas)
 <- +kontrolinisKodas(KontrolinisKodas);
    .atnaujintiKontroliniKoda(KontrolinisKodas).

 +tapatybe_patvirtinta(AsmensKodas, SesijosKodas) 
  <- -KontrolinisKodas(_);
     .atidarytiParaiskosLanga.

// Paraiškos pateikimas --------------------------------
+!pateikti_paraiska(Lizinguotojas)
   : asmensKodas(AsmensKodas) &
   pajamos(Pajamos) &
   isipareigojimai(Isipareigojimai) &
   isiskolinimas(Isiskolinimas) &
   isankstinisMokejimas(IsankstinisMokejimas) &
   prekesVerte(PrekesVerte) &
   periodas(Periodas)
   <- .print("Pateikiama paraiška lizinguotojui ", Lizinguotojas);
   .send(Lizinguotojas, achieve, ivertinti_paraiska(AsmensKodas, Pajamos, Isipareigojimai, Isiskolinimas, IsankstinisMokejimas, PrekesVerte, Periodas)).

// Įvertinimas pateikiamas skaitine reikšme, 1 - paraiška priimta, 0 - paraiška atmesta.
+paraiska_ivertinta(Ivertinimas)[source(Lizinguotojas)]
   <= .print("Paraiškos įvertinimo statusas gautas iš:", Lizinguotojas, ". Statusas:", Ivertinimas).
      .atidarytiParaiskosIvertinimoLanga(Ivertinimas).