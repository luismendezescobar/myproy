const http = require('http');

//req is what is comming in, res is what we are sending out
const server = http.createServer((req,res)=>{  
    if(req.url==='/'){
        res.end('Welcome to our home page changed')
    }else if(req.url==='/about'){
        for(let i=0;i<1000;i++){
            for(let j=0;j<1000;j++){
                console.log(`${i} ${j}`)
            }
        }
        
        res.end('About page changed')
    }
    else{
        res.end(`
        <h1> Ooops!</h1>
        <p>We can't seem to find the page you are looking for</p>
        <a href="/">back home</a>    
        `)
    }

})


server.listen(5000,()=>{
    console.log('Server is listening in port 5000...')
})