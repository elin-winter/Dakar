%%%%%%%%%%%%%%%%%%%%%%%% Rally Dakar %%%%%%%%%%%%%%%%%%%%%%%

/*

auto(modelo)
moto(anioDeFabricacion, suspensionesExtras)
camion(items)
cuatri(marca)

*/

ganador(1997,peterhansel,moto(1995, 1)).
ganador(1998,peterhansel,moto(1998, 1)).
ganador(2010,sainz,auto(touareg)).
ganador(2010,depress,moto(2009, 2)).
ganador(2010,karibov,camion([vodka, mate])).
ganador(2010,patronelli,cuatri(yamaha)).
ganador(2011,principeCatar,auto(touareg)).
ganador(2011,coma,moto(2011, 2)).
ganador(2011,chagin,camion([repuestos, mate])).
ganador(2011,patronelli,cuatri(yamaha)).
ganador(2012,peterhansel,auto(countryman)).
ganador(2012,depress,moto(2011, 2)).
ganador(2012,deRooy,camion([vodka, bebidas])).
ganador(2012,patronelli,cuatri(yamaha)).
ganador(2013,peterhansel,auto(countryman)).
ganador(2013,depress,moto(2011, 2)).
ganador(2013,nikolaev,camion([vodka, bebidas])).
ganador(2013,patronelli,cuatri(yamaha)).
ganador(2014,coma,auto(countryman)).
ganador(2014,coma,moto(2013, 3)).
ganador(2014,karibov,camion([tanqueExtra])).
ganador(2014,casale,cuatri(yamaha)).
ganador(2015,principeCatar,auto(countryman)).
ganador(2015,coma,moto(2013, 2)).
ganador(2015,mardeev,camion([])).
ganador(2015,sonic,cuatri(yamaha)).
ganador(2016,peterhansel,auto(2008)).
ganador(2016,prince,moto(2016, 2)).
ganador(2016,deRooy,camion([vodka, mascota])).
ganador(2016,patronelli,cuatri(yamaha)).
ganador(2017,peterhansel,auto(3008)).
ganador(2017,sunderland,moto(2016, 4)).
ganador(2017,nikolaev,camion([ruedaExtra])).
ganador(2017,karyakin,cuatri(yamaha)).
ganador(2018,sainz,auto(3008)).
ganador(2018,walkner,moto(2018, 3)).
ganador(2018,nicolaev,camion([vodka, cama])).
ganador(2018,casale,cuatri(yamaha)).
ganador(2019,principeCatar,auto(hilux)).
ganador(2019,prince,moto(2018, 2)).
ganador(2019,nikolaev,camion([cama, mascota])).
ganador(2019,cavigliasso,cuatri(yamaha)).

pais(peterhansel,francia).
pais(sainz,espania).
pais(depress,francia).
pais(karibov,rusia).
pais(patronelli,argentina).
pais(principeCatar,catar).
pais(coma,espania).
pais(chagin,rusia).
pais(deRooy,holanda).
pais(nikolaev,rusia).
pais(casale,chile).
pais(mardeev,rusia).
pais(sonic,polonia).
pais(prince,australia).
pais(sunderland,reinoUnido).
pais(karyakin,rusia).
pais(walkner,austria).
pais(cavigliasso,argentina).


%%%%%%%%%%%%%%%%%%%%%%%%% Punto 1

% Parte A

marca(peugeot, 2008).
marca(peugeot, 3008).
marca(mini, countryman).
marca(volkswagen, touareg).
marca(toyota, hilux).

% Parte B

/*

Para agregar que buggy es de mini solo basta escribirlo como hecho
en la base de conocimientos, por ejemplo: marca(mini, buggy).

No es necesario colocar hechos de cosas que no son en la base de conocimientos
porque Prolog se maneja con el Principio de Universo Cerrado donde todo aquello que
no se encuentre en la base de conocimientos es falso. 

Por lo tanto, aquellas cosas que son falsas o que no son verdades absolutas, 
por ejemplo cosas que desconocemos, no se colocan en la base de conocimiento. Que dkr no es
de mini no es necesario ponerlo, si supieramos de que marca es, ahí si lo colocaríamos. 

*/

%%%%%%%%%%%%%%%%%%%%%%%%% Punto 2

ganadorReincidente(Competidor):-
    ganador(Anio1, Competidor, _),
    ganador(Anio2, Competidor, _),
    Anio1 \= Anio2.

%%%%%%%%%%%%%%%%%%%%%%%%% Punto 3

inspiraA(Conductor1, Conductor2):-
    mismoPais(Conductor1, Conductor2),
    condicionInspirar(Conductor1, Conductor2),
    Conductor1 \= Conductor2.

condicionInspirar(Conductor1, Conductor2):-
    ganador(_, Conductor1, _),
    not(ganador(_, Conductor2, _)).

condicionInspirar(Conductor1, Conductor2):-
    ganador(Anio1, Conductor1, _),
    ganador(Anio2, Conductor2, _),
    Anio1 < Anio2.

competidor(Competidor):-
    pais(Competidor, _).

mismoPais(Conductor1, Conductor2):-
    pais(Conductor1, Pais),
    pais(Conductor2, Pais).

%%%%%%%%%%%%%%%%%%%%%%%%% Punto 4

marcaDeLaFortuna(Conductor, Marca):-
    ganador(_, Conductor, V),
    marcaVehiculo(V, Marca),
    forall(ganador(_, Conductor, Vehiculo), marcaVehiculo(Vehiculo, Marca)).

marcaVehiculo(cuatri(Marca), Marca).
marcaVehiculo(auto(Modelo), Marca):-
    marca(Marca, Modelo).
marcaVehiculo(moto(Anio, _), ktm):-
    Anio >= 2000.
marcaVehiculo(moto(Anio, _), yamaha):-
    Anio < 2000.
marcaVehiculo(camion(Items), kamaz):-
    member(vodka, Items).
marcaVehiculo(camion(Items), iveco):-
    not(member(vodka, Items)).

%%%%%%%%%%%%%%%%%%%%%%%%% Punto 5

heroePopular(Corredor):-
    inspiraA(Corredor, _),
    ganador(Anio, Corredor, Vehiculo),
    not(vehiculoCaro(Vehiculo)),
    forall(
        (ganador(Anio, Corredor2, Vehiculo2), 
        Corredor2 \= Corredor), 
        vehiculoCaro(Vehiculo2)).

vehiculoCaro(Vehiculo):-
    marcaVehiculo(Vehiculo, Marca),
    marcaCara(Marca).

vehiculoCaro(moto(_, SuspensionesExtras)):-
    SuspensionesExtras > 3.

vehiculoCaro(cuatri(_)).  % porque siempre llevan 4, 4 > 3

marcaCara(mini).
marcaCara(toyota).
marcaCara(iveco).

%%%%%%%%%%%%%%%%%%%%%%%%% Punto 6

etapa(marDelPlata,santaRosa,60).
etapa(santaRosa,sanRafael,290).
etapa(sanRafael,sanJuan,208).
etapa(sanJuan,chilecito,326).
etapa(chilecito,fiambala,177).
etapa(fiambala,copiapo,274).
etapa(copiapo,antofagasta,477).

etapa(antofagasta,iquique,557).
etapa(iquique,arica,377).
etapa(arica,arequipa,478).
etapa(arequipa,nazca,246).
etapa(nazca,pisco,276).
etapa(pisco,lima,29).

% Parte A

kmEntre(L1, L2, _, KM):-
    etapa(L1, L2, KM).

kmEntre(L1, L2, _, KM):-
    etapa(L2, L1, KM).

kmEntre(L1, L2, Visitados, KM):-
    etapa(L1, LIntermedia, KMIntermedio),
    not(member(L1, Visitados)),
    kmEntre(LIntermedia, L2, [L1 | Visitados], KMInter),
    KM is KMInter + KMIntermedio.

kmEntre(L1, L2, Visitados, KM):-
    etapa(LIntermedia, L1, KMIntermedio),
    not(member(L1, Visitados)),
    kmEntre(LIntermedia, L2, Visitados, KMInter),
    KM is KMInter + KMIntermedio.

% Parte B

distanciaSinParar(camion(Items), Distancia):-
    length(Items, CantItems),
    Distancia is CantItems * 1000.

distanciaSinParar(Vehiculo, 2000):-
    vehiculoCaro(Vehiculo).

distanciaSinParar(Vehiculo, 1800):-
    not(vehiculoCaro(Vehiculo)).

% Parte C

destinoMasLejano(Vehiculo, Origen, Destino) :-
    distanciaSinParar(Vehiculo, DistMax),
    kmEntre(Origen, Destino, [], KM),
    KM =< DistMax,
    forall((kmEntre(Origen, OtroDest, [], KMOtro), OtroDest \= Destino, KMOtro =< DistMax),
           KM >= KMOtro).
