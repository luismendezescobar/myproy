const EventEmitter = require('events')
const customEmitter = new EventEmitter()
const myEmitter = new EventEmitter();

customEmitter.on('response',(name,id) => {
    console.log(`data received ${name} ${id}`)
})

customEmitter.on('response',() => {
    console.log(`some other logic here`)
})

customEmitter.emit('response','luis',48)

///// another example:
let listenerCallback = (data) => {
    console.log('Celebrate ' + data);
}
myEmitter.on('celebration', listenerCallback);


myEmitter.emit('celebration','your birthday')