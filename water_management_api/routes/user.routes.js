const router = require('express').Router();
const UserController = require('../controller/user.controller');

router.post('/registeruser',UserController.registeruser);
router.post('/login',UserController.getuser);
router.post('/addissue', UserController.addissue);
router.post('/getissue',UserController.getissue);
router.post('/addreport',UserController.addreport);
router.post('/getreport', UserController.getreport);
router.post('/addwaterusage',UserController.addwaterusage);
router.post('/addtransaction', UserController.addtransaction);
router.post('/gettransactions',UserController.gettransactions);

module.exports = router;