// The console and process modules are global and don't need to be required to use!
const os = require('os');
const util = require('util');

const local = {  
    'Home Directory': os.homedir(),    
    'Operating System': os.type(),
    'Last Reboot': os.uptime(),
    'Hostname' : os.hostname()
  }

 console.log(local); 

 console.log(process.memoryUsage().heapUsed);
 console.log(process.memoryUsage());
 console.log(process.env.NODE_ENV);
 console.log(process.argv[2]);

const today = new Date();
const earthDay = 'April 22, 2022';
 
console.log(util.types.isDate(today));
console.log(util.types.isDate(earthDay));


/*
const timeoutfunc=setTimeout((name)=> console.log('hello, ${name}!, after a second'),1000)
console.log(timeoutfunc);
*/

/*const time2= name2 => {
  setTimeout((name2) => console.log('hello, ${name2}!, from inside'),1000);
};
console.log(time2);
*/

const sayHi= (name3) => console.log(`hello there ${name3}`)

sayHi('pedro')
