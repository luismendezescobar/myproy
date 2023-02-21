const fs=require('fs')

console.log('start')

fs.readFile('./test-file-01.txt','utf8',(err,result) =>{
    if (err) {
        console.log(err)
    }
    const first_file =result
    fs.readFile('./test-file-02.txt','utf8',(err,result) =>{
        if (err) {
            console.log(err)
        }
        const second_file =result
        fs.writeFile(
            './result-file-01.txt',
            `Here is the result: ${first_file}, plus ${second_file} `,
            (err,result) => {
                if(err) {
                    console.log(err)
                    return
                }
                console.log('done with this task')
            }
        )
    })    
})

console.log('starting next task')