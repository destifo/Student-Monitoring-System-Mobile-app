const mongoose = require('mongoose');
const Joi = require('joi');
const jwt = require('jsonwebtoken')
const config = require('config')

const userSchema = mongoose.Schema({
    password: {
        type: String,
        required: true,
        min: 5,
        max: 1024
    },
    role: {
        type: String,
        enum: ['parent', 'admin', 'teacher'],
        lowercase: true,
    },
    username: {
        type: String,
        required: true,
        min: 5,
    }
});

userSchema.methods.generateAuthToken = function(){
    const token =jwt.sign({_id: this._id}, config.get('myKey'));
    return token
}

const User = mongoose.model('User', userSchema);

function validateUser(user) {
    const schema = Joi.object({
        password: Joi.string().required().min(5).max(255),
        username: Joi.string().required().min(5),
        role: Joi.string().valid('parent', 'admin', 'teacher'),

    });

    return schema.validate(user);
}

module.exports.User = User;
module.exports.validateUser = validateUser;