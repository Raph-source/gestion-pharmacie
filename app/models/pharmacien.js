const {PrismaClient} = require('@prisma/client')
const prisma = new PrismaClient()

class Pharmacien{
    // retourne true le matricule de l'étudiant existe et false sinon
    static async checkPharmacien(pseudo, mdp){
        const trouver = await prisma.pharmacien.findUnique({
            where: {
                pseudo: pseudo,
                mdp: mdp
            }
        })

        if(trouver)
            return true
        return false
    }
}

module.exports = Pharmacien