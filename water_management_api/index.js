const app = require('./app');
const port = 3307;



app.listen(port, ()=>{
    console.log('the api running on http://localhost:33060', port);
})