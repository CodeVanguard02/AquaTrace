const app = require('./app');
const port = 5080;



app.listen(port, ()=>{
    console.log('the api running on http://localhost:%d', port);
})