console. log('One')

setTimeout(()=>{
    for(let i=0;i<1;i++){
        for(let j=0;j<10;j++){
            console.log(`${i} ${j}`)
        }
    }    
    console.log('two')   // Callback gets stored into quene until everything finishes running. 
},0)

console.log('three')

console.log('four')


console.log('five')

