 const {json} = require('body-parser');
const UserService = require('../service/user.service');




exports.registeruser = async (req,res,next) =>{

    try{
     const {email,name,surname,password,gender,phonenumber,address} = req.body;
     await UserService.registeruser(email,name,surname,password,gender,phonenumber,address);
     res.json({success: true, message: 'User was successfully registered'});
    }
    catch(e){
        next(e);
    }
}

exports.getuser = async (req,res,next) =>{
    try{
        const {email, password} = req.body;
        var data = await UserService.getuser(email,password);
        if(data != null){
            res.json({success: true, message: "user has successfully logged in", info : data});
        }
        else{
            res.json({success : false, message : "user was unsucceffuly logged in"});
        }
    }
    catch(e){
        next(e);
    }
}

exports.allocatecredit = async (req,res,next) =>{

    try{
      const {user_id,credit,water_allocated} = req.body;
      await UserService.allocatecredit(user_id,credit,water_allocated);
      res.json({success: true, message: "the credit was successfully allocated"});
    }
    catch(e){
        next(e);
    }
}

exports.getaccountinfo = async (req,res,next) =>{

    try{
      const {user_id} = req.body;
      var data = await UserService.getaccountinfo(user_id);
      if(data != null){
        res.json({success: true, message: })
      }

    }
    catch(e){
        next(e);
    }

}
exports.addissue = async (req,res,next) =>{
    try{
      const {account_id,description,datetime,picture1,picture2,picture3,picture4,status,location} = req.body;
      await UserService.addissue(account_id,description,datetime,picture1,picture2,picture3,picture4,status,location);
      res.json({success: true, message : 'the issue was successfully added'});
    }
    catch(e){
        next(e);
    }
}

exports.getissue = async (req,res,next) =>{

    try{
       const {account_id} = req.body;
       var data = await UserService.getissue(account_id);
       if(data != null){
        res.json({success: true, message: "issues have been successfully retrieved", info: data});
       }
       else {
        res.json({success: false, message: "issues not successfullly retrieved "});
       }
    }
    catch(e){
        next(e);
    }
}


exports.addreport = async (req,res,next) =>{
    try{
      const {plumber_id,issue_id,location,description,datetime,picture1,picture2,picture3,picture4} = req.body;
      await UserService.addreport(plumber_id,issue_id,location,description,datetime,picture1,picture2,picture3,picture4);
      res.json({success : true, message: "the report was successfully added"});
    }
    catch(e){
        next(e);
    }
}

exports.getreport = async (req,res,next) => {
    try{
      const {plumber_id} = req.body;
      var data = await UserService.getreport(plumber_id);
       if(data != null){
         res.json({success : true, message : "reports were successfully retrieved"});
       }
       else {
        res.json({success : true, message : "reports were not successfully retrieved"});
       }

    }
    catch(e){
        next(e);
    }
}

exports.addwaterusage = async (req,res,next) =>{
    try{
     const {account_id,datetime,amount_of_water} = req.body;
    await UserService.addwaterusage(account_id,datetime,amount_of_water);
    res.json({success: true, message : "the water usage was successfully added"});
    }
    catch(e){
        next(e);
    }
}

exports.addtransaction = async (req,res,next) =>{
    try{
     const {account_id,datetime,ammount,status} = req.body;
     await UserService.addtransaction(account_id,datetime,ammount,status);
     res.json({success : true, message: "the transaction was successfully added"});
    }
    catch(e){
        next(e);
    }
}

exports.gettransactions = async (req,res,next) =>{
    try{

        const {account_id} = req.body;
        var data = await UserService.gettransactions(account_id);
        if(data != null){
           res.json({success: true, message : "transactions were successfully retrieved"});
        }
        else{
            res.json({success: false, message: "no transactions were retrieved"});
        }

    }catch(e){
        next(e);
    }
}

