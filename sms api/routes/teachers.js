const {Teacher, validateTeacher} = require('../models/teacher');
const mongoose = require('mongoose');
const express = require('express');
const router = express.Router();
const auth =require("../middleware/auth")
const {adminPower}= require('../middleware/admin')
const {User} =require('../models/user');
const res = require('express/lib/response');
const bcrypt =require('bcrypt')
async function getTeacher(id){
    const teacher = await Teacher.findById(id);

    return teacher;
}

async function updateTeacher(id, information, req){
    const user =await User.findById(req.user._id)
    const info ={
        username: information.username,
        gender: information.gender,
        name: information.name,
        sections: information.sections,
        subjectName: information.subjectName
    }
    
    const { error } = validateTeacher(info);
    if (error)
        res.status(400).send(error.details[0].message);

    let teacher = await Teacher.findById(id);
    console.log(id)
    if (!teacher)
        return res.status(400).send("No teacher found");
    if(String(teacher.username) != String(user.username)){
        if(String(user.role) != 'admin'){
            return res.status(403).send("Forbidden access")
        } 
    }
    let same_user = await User.findOne({username: teacher.username })
    let seed =await bcrypt.genSalt(10)
    password = await bcrypt.hash(information.password, seed)
    same_user.username=  information.username
    same_user.password= password
    await same_user.save()
    teacher.name = info.name
    teacher.username = info.username
    teacher.gender = info.gender
    teacher.sections=  info.sections
    teacher.subjectName = info.subjectName

    const result = await teacher.save();
    return result;
}

async function removeTeacher(id) {
    const teacher = await Teacher.findById(id);
    const same_user = await User.findOneAndDelete({username: teacher.username})
    const removedTeacher = await Teacher.findByIdAndRemove(id);
    return removedTeacher;
}

router.get('/',auth, async (req, res) => {
    const teachers = await Teacher.find().sort('name');
    res.send(teachers);
  });
router.post('/', [auth, adminPower], async (req, res) => {
    const { error } = validateTeacher(req.body); 
    if (error) return res.status(400).send(error.details[0].message);

    let teacher = new Teacher(
    { 
        name: req.body.name,
        gender: req.body.gender,
        username: req.body.username,
        sections: req.body.sections,     
        subjectName: req.body.subjectName
    }
    );
    
    teacher = await teacher.save();

    res.send(teacher);
});
router.get('/:id', auth,async (req, res) => {
    const teacher = await getTeacher(req.params.id);
    console.log(teacher);
    if (!teacher)
        res.status(404).send(teacher);
    res.status(200).send(teacher);
});

router.put('/:id', auth,async (req, res) => {
    const updatedTeacher = await updateTeacher(req.params.id, req.body, req);
    if (!updatedTeacher)
        res.status(400).send("sdjfks");

    res.send(updatedTeacher);
});

router.delete('/:id',[auth, adminPower] , async (req, res) => {
    const deletedTeacher = await removeTeacher(req.params.id);
    if (!deletedTeacher)
        res.status(404).send('Teacher was not found');

    res.send(deletedTeacher);
})
module.exports = router; 