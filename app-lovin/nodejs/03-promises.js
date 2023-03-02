const {readFile,writeFile} = require('fs')
const util = require('util')
const readFilePromise = util.promisify(readFile)
const writeFilePromise = util.promisify(writeFile)
/*
const getText=(path)=> {
    return new Promise((resolve,reject)=>{
        readFile(path,'utf8',(err,data) =>{
            if (err) {                
                reject(err)
            }else{
                resolve(data)
            }
        
        })        
    })
}
*/

//getText('./test-file-01.txt')
//    .then((result) => console.log(result))
//    .catch((err) => console.log(err))


const start = async() => {
    try {
        const first = await readFilePromise('./test-file-01.txt','utf-8')
        const second = await readFilePromise('./test-file-02.txt', 'utf-8')
        await writeFilePromise('./result-file-01.txt',`This is awesome : ${first} ${second}`)
        console.log(first, second)
    } catch(error) {    
        console.log(error)
    }
}

start()