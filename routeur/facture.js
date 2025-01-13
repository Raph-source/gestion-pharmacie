//inclusion des module
const express = require("express")
const multer = require('multer')
const { log } = require("console")

//inclusion des contrôlleurs
const Facture = require('../app/controllers/facture')

//pour le stockage des upload
const stockage = multer.diskStorage({
    destination : (req, file, cb) =>{
        cb(null, './uploads/')
    },
    filename : (req, file, cb) =>{
        cb(null, Date.now() + "_" + file.originalname)
    }
})

const upload = multer({
    storage : stockage
})

const facture = express.Router()

//LES ENDPOINTS

//POST
facture.post('/vente', upload.none(), async (req, res) =>{ Facture.createFacture(req, res)})

module.exports = facture;