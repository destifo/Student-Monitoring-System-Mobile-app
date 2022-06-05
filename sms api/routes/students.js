const {Student, validateStudent} = require('../models/student');
const {Subject, validateSubject} = require('../models/subject'); 
const mongoose = require('mongoose');
const express = require('express');
const router = express.Router();
const auth =require("../middleware/auth");
const { User } = require('../models/user');
const res = require('express/lib/response');
const bcrypt = require('bcrypt');

async function getStudent(id){
    const student = await Student.findById(id);

    return {
        name: student.name,
        sectionName: student.sectionName,
        username: student.username,
        gender: student.gender
    };
}
async function updateStudent(id, information, req){
    const user =await User.findById(req.user._id)
    const info ={
        username: information.username,
        gender: information.gender,
        name: information.name,
        sectionName: information.sectionName
    }
    const { error } = validateStudent(info);
    if (error)
        res.status(400).send("update error");

    let student = await Student.findById(id);
    if (!student)
        return;
    if(String(student.username) != String(user.username)){
        if(String(user.role) != 'admin'){
            return res.status(403).send("Forbidden access")
        } 
    }
    console.log(student.username)
    let same_user = await User.findOne({username: student.username })
    console.log(same_user)
    let seed =await bcrypt.genSalt(10)
    password = await bcrypt.hash(information.password, seed)
    same_user.username= information.username
    same_user.password =password
    await same_user.save()
    console.log(student)
    student.name=info.name 
    student.username= info.username,
    student.gender= info.gender,
    student.sectionName= info.sectionName,
    await student.save()
    return {
        _id: student._id,
        name: student.name,
        sectionName: student.sectionName,
        username: student.username,
        gender: student.gender
    };
}

async function removeStudent(id) {
    const student = await Student.findById(id);
    const same_user = await User.findOneAndDelete({username: student.username})
    const removedStudent = await Student.findByIdAndRemove(id);

    return {name: removedStudent.name,
        sectionName: removedStudent.sectionName,
        username: removedStudent.username,
        gender: removedStudent.gender};
}

router.get('/', auth, async (req, res) => {
    const students = await Student.find().sort('name');
    let students_collection=[]
    for(let student of students){
        let s =Student(student)
        students_collection.push({
            _id: s._id,
            name: s.name,
            sectionName: s.sectionName,
            username: s.username,
            gender: s.gender
        })
    }
    res.send(students_collection);
  });
router.post('/',auth, async (req, res) => {
    subjectNames =["history", "physics","chemistry","geography", "math", "ICT", "HPE" , "biology", "amharic", "aptitude", "civics", "bussiness", "economics"]
    let subjects=[]
    const { error } = validateStudent(req.body); 
    if (error) return res.status(400).send(error.details[0].message);
    
    for (let subject of subjectNames){
        s= Subject()
        s.subjectName= subject
        s.test2=-100
        s.test1=-100
        s.mid =-100
        s.final =-100
        s.assesment=-100
        subjects.push(s)
    }

    let student = new Student(
    { 
        name: req.body.name,
        gender: req.body.gender,
        username: req.body.username,
        sectionName: req.body.sectionName,     
        subjects: subjects
    }
    );
    
    student = await student.save();

    res.send({
        _id: student._id,
        name: student.name,
        sectionName: student.sectionName,
        username: student.username,
        gender: student.gender
    });
});
router.get('/:id',auth, async (req, res) => {
    const student =await getStudent(req.params.id);
    if (!student)
        res.status(404).send(student);
        
    res.status(200).send({
        _id: student._id,
        name: student.name,
        sectionName: student.sectionName,
        username: student.username,
        gender: student.gender
    });
});

router.put('/:id',auth, async (req, res) => {
    
    const updatedStudent = await updateStudent(req.params.id, req.body, req);
    if (!updatedStudent)
        res.status(400).send("sdjfks");
    
    res.send({
        _id: updatedStudent._id,
        name: updatedStudent.name,
        sectionName: updatedStudent.sectionName,
        username: updatedStudent.username,
        gender: updatedStudent.gender
    });
});

router.delete('/:id',auth, async (req, res) => {
    const deletedStudent = await removeStudent(req.params.id);
    if (!deletedStudent)
        res.status(404).send('Student was not found');

    res.send({
        _id: deletedStudent._id,
        name: deletedStudent.name,
        sectionName: deletedStudent.sectionName,
        username: deletedStudent.username,
        gender: deletedStudent.gender
    });
})
module.exports = router; 