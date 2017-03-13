//
//  GameLogic.swift
//  KingsCup
//
//  Created by Scott Crocker on 2017-03-13.
//  Copyright © 2017 Scott Crocker. All rights reserved.
//

import Foundation

let defaultRules : [Int:String] = [1 : "Vattenfall: Alla börjar dricka, spelaren som drog kortet får sluta dricka när den vill, spelaren efter får inte sluta förrän spelaren som drog kortet har slutat dricka, detta fortsätter laget runt medurs.",
                                   2 : "Spelaren som drog kortet får ge bort två klunkar",
                                   3 : "Spelaren som drog kortet tar tre klunkar",
                                   4 : "Damerna dricker",
                                   5 : "Dansa: Spelaren som drog kortet gör en dansrörelse, sedan fortsätter det varvet runt tills någon klantar sig och får då dricka.",
                                   6 : "Männen dricker",
                                   7 : "Alla spelare sträcker upp händerna i luften, den som gör det sist får dricka.",
                                   8 : "Spelaren som drog kortet får välja en kompanjon, när antingen spelaren eller sin kompanjon ska dricka så ska båda dricka, missar man att dricka när sin kompanjon gör det så får man en straffklunk.",
                                   9 : "Rimma: Spelaren som drog kortet får säga ett ord, spelaren efter ska rimma på det ordet och detta fortsätter runt medurs, om man inte kan komma på ett ord som rimmar så får man dricka.",
                                   10 : "Kategorier: Spelaren som drog kortet får välja en kategori, sedan ska varje spelare säga något som passar in i den kategorin, kan man inte komma på något så får man dricka.",
                                   11 : "Regel: Spelaren som drog kortet får skapa en regel som måste följas till spelets slut, t.ex. får man förbjuda alla spelare från att svära, att gå på toaletten eller använda någon annan spelares förnamn, bryter man mot regeln så får man dricka, man kan även använda detta kort för att ta bort en tidigare regel.",
                                   12 : "Svara i frågor: Spelaren som drog kortet får endast sina frågor besvarade i en fråga, svarar man inte i en fråga till spelaren som drog kortet så får man dricka. Detta kort håller tills någon annan spelare dragit en dam.",
                                   13 : "King's Cup: Spelaren som drar detta kort får hälla lite av sin dryck i bägaren på bordet, den som drar den sista kungen får dricka upp innehållet i bägaren, efter sista kungen blivit dragen så är spelet slut!"]
