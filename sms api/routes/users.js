const {User, validateUser} = require('../models/user');
const moongoose=require('mongoose');
const express =require('express');
const router = express.Router();
const bcrypt = require('bcrypt')
const _ =require('lodash')
const auth =require("../middleware/auth")
const {adminPower} =require("../middleware/admin")
router.post("/",[auth, adminPower], async(req, res)=>{
    const {error} = validateUser(req.body) 
    if(error) return res.status(400).send("Unable to register user")
    let user =await User.findOne({username: req.body.username})
    if(user) return res.status(400).send("Invalid username")
    let password = req.body.password
    let seed =await bcrypt.genSalt(10)
    password = await bcrypt.hash(password, seed)
    user = User({
        username: req.body.username,
        password: password,
        role: req.body.role
    })
    user =await user.save()
    res.send(_.pick(user, ["username", "role"]))
})

module.exports =router