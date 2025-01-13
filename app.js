const express = require("express")
const bodyParser = require('body-parser');
const cors = require('cors');

const app =  express()

app.use(cors());
// Middleware pour parser les données JSON
app.use(express.json());

//le type des données des formulaires
app.use(bodyParser.urlencoded({ extended: true }));

//les routes
const facture = require("./routeur/facture")
const pharmacien = require("./routeur/pharmacien")
const produit = require("./routeur/produit")

//entrée des endpoints
app.use('/facture/', facture);
app.use('/pharmacien/', pharmacien);
app.use('/produit/', produit);

app.listen(3000, ()=>{
    //date actuelle
    const date = new Date()

    const annee = date.getFullYear();
    const mois = String(date.getMonth() + 1).padStart(2, '0');
    const jour = String(date.getDate()).padStart(2, '0');
    const heure = String(date.getHours()).padStart(2, '0');
    const minute = String(date.getMinutes()).padStart(2, '0');
    const seconde = String(date.getSeconds()).padStart(2, '0');

    const dateActuelle = annee + '-' + mois + '-' + jour + ' ' + heure + ':' + minute + ':' + seconde

    console.log("Serveur lancé à " + dateActuelle)
})
