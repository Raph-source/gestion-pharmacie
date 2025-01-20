const {PrismaClient} = require('@prisma/client');
const Produit = require('./produit');
const prisma = new PrismaClient()

class Facture{
    //crée une facture
    static async createFacture(produits){      
        
        let facture = await prisma.facture.create({
            data: {
              produits: {
                create: produits.map((p) => ({
                  produitId: Number(p.id),
                  quantite: Number(p.quantite),
                })),
              },
            },
            include: { produits: true },
        });
      
        // Mise à jour des quantités en stock
        for (const p of produits) {
            await prisma.produit.update({
              where: { id: Number(p.id) },
              data: { quantite: { decrement: Number(p.quantite) } },
            });
        }

        //ajout des noms et prix et du prix total
        let prixTotal = 0
        for (const produit of facture.produits) {          
          produit.nom = await Produit.getNom(produit.produitId);
          produit.prix = await Produit.getPrix(produit.produitId);
          prixTotal += produit.prix * produit.quantite
        }

        const TVA = (prixTotal * 20) / prixTotal
        facture.prixTotal = prixTotal + TVA
        facture.tva = TVA
        
        
        return facture
    }

}

module.exports = Facture