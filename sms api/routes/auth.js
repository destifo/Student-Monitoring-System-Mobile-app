const {User, validateUser} = require('../models/user');
const moongoose=require('mongoose');
const express =require('express');
const router = express.Router();
const bcrypt = require('bcrypt')
const _ =require('lodash');
const Joi = require('joi');
const jwt = require("jsonwebtoken")
const config= require('config')
const {Student} = require('../models/student')
const {Teacher} = require('../models/teacher')
router.post("/", async(req, res)=>{
    const {error} =validate(req.body);
    if(error) return res.status(400).send(error.details[0].message)
    let user =await User.findOne({username: req.body.username})
    if(!user) return res.status(400).send("Invalid username or password")
    const validated = await bcrypt.compare(req.body.password, user.password)
    if(!validated) return res.status(400).send("Invalid username or password")
    const token = user.generateAuthToken()
    let _id = await findId(user);
    console.log(user.role);
    res.send({
        "token": token,
        "_id": _id,
        "role": user.role
    })
})
function validate(user) {
    const schema = Joi.object({
        password: Joi.string().required().min(6).max(255),
        username: Joi.string().required().min(5),
    });

    return schema.validate(user);
}
async function findId(user){
    if (user.role =="parent"){
        let student = await Student.findOne({username: user.username})
        return student._id 
    }
    if (user.role =="teacher"){
        let teacher =await Teacher.findOne({username: user.username})
        return teacher._id
    }
    else{
        return null
    }
}
module.exports =router