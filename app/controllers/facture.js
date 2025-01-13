const Facture_M = require('../models/facture')
const Produit_M = require('../models/produit')

class Facture{
    static async createFacture(req, res){
        const { produits } = req.body; // [{ produitId, quantite }]
        
        try {
            if(typeof produits != "undefined" && Array.isArray(produits)){
                
                //vérifier la disponobilité des produits
                for (const p of produits) {
                    let idProduit = Number(p.id)
                    let quantiteProduit = Number(p.quantite)
                    
                    let quantiteStock = await Produit_M.getQuantite(idProduit)

                    if(quantiteStock < quantiteProduit){
                        let nomProduit = await Produit_M.getNom(idProduit)

                        res.status(400).json({
                            reponse: "le produit " + nomProduit + " n'est pas disponible"
                        })                        
                        console.log(nomProduit);
                        
                        return
                    }
                }

                const facture = await Facture_M.createFacture(produits)

                res.status(200).json({
                    reponse: facture
                })
            }
            else{
                res.status(403).json({
                    reponse: "interdit"
                })
            }
        } catch (error) {            
            res.status(500).json({
                reponse: "erreur serveur"
            })
        }
    }
}

module.exports = Facture