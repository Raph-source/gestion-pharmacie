//inclusion des module
const express = require("express")
const multer = require('multer')
const { log } = require("console")

//inclusion du contrôlleur
const Pharmacien = require("../app/controllers/pharmacien")

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

const pharmacien = express.Router()

//LES ENDPOINTS

//POST
pharmacien.post('/login', upload.none(), (req, res) =>{ Pharmacien.login(req, res)})

module.exports = pharmacien;