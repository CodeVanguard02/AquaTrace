const { query } = require('express');
const db = require('../config/db');
const { use } = require('../app');

class UserService{

static async registeruser(email,name,surname,password,gender,phonenumber,address){
 
    try{
       var query = '';
       query = 'INSERT INTO users(email,name,surname,password,gender,phonenumber,address) ';
       query += ' VALUES(?,?,?,?,?,?,?) ' ;
       await db.query(query,[email,name,surname,password,gender,phonenumber,address]);
       return true;
    }
    catch(e){
        throw e;
    }

}


static async getuser(email,password){
    
    try{
      var query = ' ';
      query = ' SELECT * FROM users ';
      query += ' WHERE email = ? AND password = ? ';
      const [users,_fields] = await db.query(query,[email,password]);
      return users[0];
    }
    catch(e){
        throw e;
    }

}


static async addplumber(user_id, employee_id,profile_picture){
   try{

    var query = ' ';
    query = ' INSERT INTO plumber(user_id, employee_id,profile_picture) ' ;
    query += ' VALUES(?,?,?) ';
    await db.query(query,[user_id, employee_id,profile_picture]);
    return true;
   }
   catch(e){
    throw e;
   }
}


static async allocatejob(plumber_id){
    
  
}


static async allocatecredit(ser_id,credit,water_allocated){
    try{
      var query= ' ';
       query = ' INSERT INTO accounts(user_id,credit,water_allocated) ';
       query += ' VALUES(?,?,?) ';
       await db.query(query,[ser_id,credit,water_allocated]);
    }
    catch(e){
        throw e;
    }
} 

static async getaccountinfo(user_id){

    try{
        var query = ' ';
        query = 'SELECT * FROM accounts ';
        query += ' WHERE user_id = ? ';
        const [accounts,_fields] = await db.query(query,[user_id]);
        return accounts[0];
    }
    catch(e){
        throw e;
    }
}

static async addissue(account_id,description,datetime,picture1,picture2,picture3,picture4,status,location){

    try{
      var query = ' ';
      query =  ' INSERT INTO issues(account_id,description,datetime,picture1,picture2,picture3,picture4,status,location) ';
      query += ' VALUES(?,?,?,?,?,?,?,?,?) ';
      await db.query(query,[account_id,description,datetime,picture1,picture2,picture3,picture4,status,location]);
      return true;
    }
    catch(e){
        throw e;
    }
}

static async getissue(account_id){

    try{
      var query = ' ';
      query = 'SELECT description,datetime,picture1,picture2,picture3,picture4,status,location ';
      query += ' FROM issues ';
      query += ' WHERE account_id = ? ';
      const [issues,_fields] = await db.query(query,[account_id]);
      return issues;
    }
    catch(e){
        throw e;
    }

}

static async addreport(plumber_id,issue_id,location,description,datetime,picture1,picture2,picture3,picture4){
    try{
        var query = ' ';
        query = ' INSERT INTO reports(plumber_id,issue_id,location,description,datetime,picture1,picture2,picture3,picture4) ';
        query += ' VALUES(?,?,?,?,?,?,?,?,?) ';
        await  db.query(query,[plumber_id,issue_id,location,description,datetime,picture1,picture2,picture3,picture4]);
        return true;
      }
      catch(e){
          throw e;
      }
}

static async getreport(plumber_id){
    try{
       var query = ' ';
       query = ' SELECT * FROM reports ';
       query += ' WHERE plumber_id = ? ';
       const [reports,_fields] = await db.query(query,[plumber_id]);
       return reports;

    }
    catch(e){
        throw e;
    }


}


static async addwaterusage(account_id,datetime,amount_of_water){
    try{
      var query = ' ';
      query = ' INSERT INTO water_usage(account_id,datetime,amount_of_water) ';
      query += 'VALUES(?,?,?) ';
      await db.query(query,[account_id,datetime,amount_of_water]);
      return true;
    }
    catch(e){
        throw e;
    }
}

static async addtransaction(account_id,datetime,ammount,status){

    try{
        var query = ' ';
        query = ' INSERT INTO(account_id,datetime,ammount,status) ';
        query += ' VALUES(?,?,?,?) ';
        await db.query(query,[account_id,datetime,ammount,status]);  
    }
    catch(e){
        throw e;
    }
}

static async gettransactions(account_id){

    try{
       var query = ' ';
       query = ' SELECT * FROM transactions ';
       query += ' WHERE account_id = ? ';
       await db.query(query,[account_id]);
       return true;
       
    }
    catch(e){
        throw e;
    }
}
}


module.exports = UserService;