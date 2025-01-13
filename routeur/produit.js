//inclusion des module
const express = require("express")
const multer = require('multer')
const path = require("path")
const { log } = require("console")

//inclusion du contrôlleur
const Produit = require("../app/controllers/produit")

//pour le stockage des upload
const stockage = multer.diskStorage({
    destination : (req, file, cb) =>{
        cb(null, './uploads/')
    },
    filename : (req, file, cb) =>{
        cb(null, Date.now() + "_" + file.originalname)
    }
})
//les extensions permis du fichier excel
const extension = (req, file, cb) => {
    const extensionPermis = /xlsx/; // l'extensions autorisée
    const mimetype = extensionPermis.test(file.mimetype); // Vérifie le type MIME du fichier
    const extname = extensionPermis.test(path.extname(file.originalname).toLowerCase()); // Vérifie l'extension du fichier

    if (extname) {
        return cb(null, true);
    } else {
        cb(new Error("L'extension ou le type MIME du fichier n'est pas valide"), false); // Indique que l'upload doit être rejeté
    }
}
const upload = multer({
    storage : stockage,
    fileFilter : extension
})

const produit = express.Router()

//LES ENDPOINTS

//POST
produit.post('/ajouter-produit', upload.none(), (req, res) =>{ Produit.ajouterProduit(req, res)})

//GET
produit.get('/liste-produit', (req, res) =>{ Produit.getProduit(res)})

//PUT
produit.put('/modifier-produit/:id', (req, res) =>{ Produit.updateProduit(req, res)})

//DELETE
produit.delete('/supprimer-produit/:id', (req, res) =>{ Produit.deleteProduit(req, res)})


module.exports = produit;