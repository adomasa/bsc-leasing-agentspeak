+!patvirtinti_tapatybe(AsmensKodas)[source(Agentas)]
   : .random(R) &
     KontrolinisKodas = 1000 + (8999*R)
   <- .print("Inicijuotas tapatybės patvirtinimas agentui: ", Agentas, " su asmens kodu: ", AsmensKodas);
      .wait(500) // Imituojama integracija su trečiųjų šalių tapatybės patvirtinimo sistemomis
      // Trečiųjų šalių sistema turėtų atsiųsti tapatybės patvirtinimo sesijos kodą
      .send(Agentas, tell, tapatybes_patvirtinimo_sesija(AsmensKodas, KontrolinisKodas));
      .wait(3000); // Vartotojas trečiųjų šalių sistmoje turėtų patvirtinti savo tapatybę, o sistema atsiųsti autentifikuotojui patvirtinimą
      .send(Agentas, tell,  tapatybe_patvirtinta(AsmensKodas, SesijosKodas).