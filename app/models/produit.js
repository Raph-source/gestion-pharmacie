const {PrismaClient} = require('@prisma/client')
const prisma = new PrismaClient()

class Produit{
    //récupere les données du user
    static async creerProduit(nom, prix, quantite) {
        const produit = await prisma.produit.create({ data: { nom, prix, quantite } });

        return produit  
    }

    //retourne true si un produit exste et false sinon
    static async checkProduit(nom) {
        const trouver = await prisma.produit.findMany({
            where: {
                nom: nom
            }
        })

        if(trouver.length > 0)
            return true
        return false
    }

    //retourne true si l'id exste et false sinon
    static async checkId(id) {
        const trouver = await prisma.produit.findUnique({
            where: {
                id: id
            }
        })

        if(trouver)
            return true
        return false
    }

    //retourne tout les produits
    static async getProduit() {
        return await prisma.produit.findMany()
    }

    //modifie un produit
    static async updateProduit(id, nom, prix) {
        const produit = await prisma.produit.update({
            where: { id: Number(id) },
            data: { nom, prix},
        });

        return produit
    }

    //supprime un produit
    static async deleteProduit(id){
        await prisma.produit.delete({ where: { id: id } });
    }

    //retourne le nom d'un produit
    static async getNom(id){
        const trouver = await prisma.produit.findUnique({
            where: {
                id: id
            },
            select: {
                nom: true
            }
        })
                
        return trouver.nom
    }

    //retourne le prix d'un produit
    static async getPrix(id){
        const trouver = await prisma.produit.findUnique({
            where: {
                id: id
            },
            select: {
                prix: true
            }
        })
        
        return trouver.prix
    }

        //retourne le quantité d'un produit
        static async getQuantite(id){
            const trouver = await prisma.produit.findUnique({
                where: {
                    id: id
                },
                select: {
                    quantite: true
                }
            })
    
            return trouver.quantite
        }
}

module.exports = Produit