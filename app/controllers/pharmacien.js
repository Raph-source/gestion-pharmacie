const Pharmacien_M = require('../models/pharmacien')

class Pharmacien{

    static async login(req, res){        
        const { pseudo, mdp } = req.body;

        try{
            if(typeof pseudo !== 'undefined' && typeof mdp !== 'undefined'){
                //vérifier si le pharmacien existe
                if(await Pharmacien_M.checkPharmacien(pseudo, mdp)){
                    res.status(200).json({
                        reponse: "succès"
                    })
                }
                else{
                    res.status(400).json({
                        reponse: "authentification échouée"
                    })
                }
            }
            else{
                res.status(403).json({
                    reponse: "interdit"
                })
            }
        }
        catch(erreur){
            res.status(500).json({
                reponse: "erreur serveur"
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

module.exports = Pharmacien