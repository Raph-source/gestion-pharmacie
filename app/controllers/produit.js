const Produit_M = require('../models/produit')


const validator = require("validator")
const nodemailer = require('nodemailer')
const { text } = require('body-parser')
const { resolve } = require('path')
const { log } = require('console')
const e = require('express')

class Produit{

    static async ajouterProduit(req, res) {
        let { nom, prix, quantite } = req.body

        try {
            if(typeof nom != "undefined" && typeof prix != "undefined" && typeof quantite != "undefined") {
                if(nom && prix && quantite) {
                    prix = Number(prix)
                    quantite = Number(quantite)
                    //vérifier si le produit n'existe pas
                    if(!await Produit_M.checkProduit(nom)){
                        const produit = await Produit_M.creerProduit(nom, prix, quantite)

                        res.status(200).json({
                            reponse: produit
                        })
                    }
                    else{
                        res.status(400).json({
                            reponse: 'le produit existe déjà'
                        })
                    }
                }
                else {
                    res.status(400).json({
                        reponse: "vide"
                    })
                }
            }
            else {
                res.status(403).json({
                    reponse: "interdit"
                })
            }
        }
        catch(erreur) {
            console.log(erreur);
            
            res.status(500).json({
                reponse: "erreur serveur"
            })
        }
    }

    static async getProduit(res) {
        try {
            res.status(200).json({
                reponse: await Produit_M.getProduit()
            })
        }
        catch(erreur) {
            res.status(500).json({
                reponse: "erreur serveur"
            })
        }
    }

    //modifier un produit
    static async updateProduit(req, res) {
        let {id} = req.params
        let {nom, prix} = req.body

        try {
            if(typeof id != "undefined" && typeof nom != "undefined" && typeof prix != "undefined") {
                if(id && nom && prix) {
                    id = Number(id)
                    prix = Number(prix)

                    //vérifier l'id du produit
                    if(await Produit_M.checkId(id)){
                        //modifier le produit
                        const produit = await Produit_M.updateProduit(id, nom, prix)

                        res.status(200).json({
                            reponse: produit
                        })
                    }
                    else{
                        res.status(400).json({
                            reponse: "le produit n'existe pas"
                        })
                    }
                }
                else{
                    res.status(400).json({
                        reponse: "vide"
                    })
                }
            }
            else{
                res.status(403).json({
                    reponse: "interdit"
                })
            }
        } 
        catch(erreur) {
            res.status(500).json({
                reponse: "erreur"
            })
        }
        
    }

    //supprimer un produit
    static async deleteProduit(req, res) {
        let {id} = req.params

        try {
            if(typeof id != "undefined") {
                if(id) {
                    id = Number(id)

                    //vérifier l'id du produit
                    if(await Produit_M.checkId(id)){
                        //supprimer le produit
                        await Produit_M.deleteProduit(id)

                        res.status(200).json({
                            reponse: "succès"
                        })
                    }
                    else{
                        res.status(400).json({
                            reponse: "le produit n'existe pas"
                        })
                    }
                }
                else{
                    res.status(400).json({
                        reponse: "vide"
                    })
                }
            }
            else{
                res.status(403).json({
                    reponse: "interdit"
                })
            }
        } 
        catch(erreur) {
            res.status(500).json({
                reponse: "erreur"
            })
        }
        
    }
    
    static async getDateActuelle(){
        //la date actuelle
        const date = new Date()

        const annee = date.getFullYear();
        const mois = String(date.getMonth() + 1).padStart(2, '0');
        const jour = String(date.getDate()).padStart(2, '0');
        const heure = String(date.getHours()).padStart(2, '0');
        const minute = String(date.getMinutes()).padStart(2, '0');
        const seconde = String(date.getSeconds()).padStart(2, '0');
  
        return annee + '-' + mois + '-' + jour + 'T' + heure + ':' + minute + ':' + seconde +'Z'
    }
}

module.exports = Produit