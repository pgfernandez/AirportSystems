var restify = require('restify');
var clients = require('restify-clients')
var mongojs = require("mongojs");

var http = require('http');
var url = require('url');
var fs = require('fs');
var sys = require('sys');
var amqp = require('amqp');

//DATABASE

var connection_string = '127.0.0.1:27017/aeriaa';
var db = mongojs(connection_string, ['bhs']);
var bhsDepartures = db.collection("bhsDepartures");
var bhsCarrouselsByProximity = db.collection("bhsCarrouselsByProximity");
var bhsBsms = db.collection("bhsBsms");



//COMUNICACION CON EL ESB para intercambiar con el AODB
var connection = amqp.createConnection({ host: '127.0.0.1' });
// Wait for connection to become established.
connection.on('ready', function () {
  // Use the default 'amq.topic' exchange
  connection.queue('bhs', function(q){
      // Catch all messages
      q.bind('#');
      console.log('Connected to queue bhs');
  });
});

//ESB's CONNECTION FOR AIRLINE BSM - Recommended Practice 1745
var connectionDCS = amqp.createConnection({ host: '127.0.0.1' });
// Wait for connection to become established.
connectionDCS.on('ready', function () {
  // Use the bsm topic' exchange
  connectionDCS.queue('bsm', function(q){
      // Catch all messages
      q.bind('#');
      console.log('Connected to queue bsm');

       // Receive messages
      q.subscribe(function (message) {
        // Print messages to stdout
        console.log(message.bsm);

        insertBSM(message);


      });
  });
});





//WEB SERVER

var server;
// the HTTP port
var port = 8081;

server = http.createServer(function(req, res){
  var path = url.parse(req.url).pathname;
  if (path == '/') {
    path = '/bhs/home.html'
  }
  console.log("serving " + path);
  fs.readFile(__dirname + path, function(err, data){
    if (err) {
      res.writeHead(404);
      res.end();
    } else {
      res.writeHead(200, {'Content-Type': contentType(path)});
      res.write(data, 'utf8');
      res.end();
    }
  });
});
    
function contentType(path) {
  if (path.match('.js$')) {
    return "text/javascript";
  } else if (path.match('.css$')) {
    return  "text/css";
  }  else {
    return "text/html";
  }
}
    
server.listen(port);
console.log("HTTP server running at http://0.0.0.0:" + port );

//REST CLIENT FOR REQUEST OTHER SYSTEMS
var client = clients.createJSONClient({
url : 'http://127.0.0.1:8181',
version : '*'
});

//load the departures flights
requestDeparturesFlightsToAODB();

//REST API and SERVER 

var ip_addr = '127.0.0.1';
var port    =  '8182';
 
var server = restify.createServer({
    name : "bhs"
});
 
server.listen(port ,ip_addr, function(){
    console.log('%s listening at %s ', server.name , server.url);
});

//server.use(restify.queryParser());
//server.use(restify.bodyParser());
//server.use(restify.CORS());



//AODB WEB SERVICES REST API

var PATH = '/bhs'
server.get({path : PATH , version : '0.0.1'} , findAllDeparturesFlights);
server.get({path : PATH +'/:bsms' , version : '0.0.1'} , findAllBsms);
server.get({path : PATH +'/:Flight' , version : '0.0.1'} , findDepartureFlight);
server.post({path : PATH +'/:Flight', version: '0.0.1'} ,postNewDepartureFlight);
//server.put({path : PATH +'/:Flight', version: '0.0.1'} , updateDepartureFlight);
server.del({path : PATH +'/:Flight' , version: '0.0.1'} ,deleteDepartureFlight);
//falta actualizar

//AODB FUNCTIONS

function findAllDeparturesFlights(req, res , next){
    res.setHeader('Access-Control-Allow-Origin','*');
    bhsDepartures.find().sort({postedOn : -1}, function(err , success){
    //departures.find().limit(20).sort({postedOn : -1} , function(err , success){
   //     console.log('Response success '+success);
     //   console.log('Response error '+err);
        if(success){
            res.send(200 , success);
            return next();
        }else{
            return next(err);
        }
 
    });
 
}

function findAllBsms(req, res , next){
    res.setHeader('Access-Control-Allow-Origin','*');
    bhsBsms.find().sort({postedOn : -1}, function(err , success){
    //departures.find().limit(20).sort({postedOn : -1} , function(err , success){
        //console.log('buscando bsms: '+success);
     //   console.log('Response error '+err);
        if(success){
            res.send(200 , success);
            return next();
        }else{
            return next(err);
        }
 
    });
 
}
 
function findDepartureFlight(req, res , next){
    res.setHeader('Access-Control-Allow-Origin','*');
    bhsDepartures.findOne({_id:mongojs.ObjectId(req.params.Flight)} , function(err , success){
 //       console.log('Response success '+success);
   //     console.log('Response error '+err);
        if(success){
            res.send(200 , success);
            return next();
        }
        return next(err);
    })
}
 
function postNewDepartureFlight(req , res , next){
    var flight = {};
    /*job.title = req.params.title;
    job.description = req.params.description;
    job.location = req.params.location;
    job.postedOn = new Date();
 
    res.setHeader('Access-Control-Allow-Origin','*');
 
    jobs.save(job , function(err , success){
        console.log('Response success '+success);
        console.log('Response error '+err);
        if(success){
            res.send(201 , job);
            return next();
        }else{
            return next(err);
        }
    });*/
}
 
function deleteDepartureFlight(req , res , next){
    res.setHeader('Access-Control-Allow-Origin','*');
    bhsDepartures.remove({_id:mongojs.ObjectId(req.params.Flight)} , function(err , success){
  //      console.log('Response success '+success);
    //    console.log('Response error '+err);
        if(success){
            res.send(204);
            return next();      
        } else{
            return next(err);
        }
    })
 
}

function requestDeparturesFlightsToAODB(){

  client.get('/departures', function (err, req, res, obj) {
  if(err){ 
    console.log("An error ocurred:", err);
  }else {
  //  console.log('Server returned: %j', obj);

    

  for(var i=0;i<obj.length;i++){
      var newFlight = obj[i];
      var gate = new String(obj[i].Gate);
      var flight = new String(obj[i].Flight);
      var std = new String(obj[i].STD);

     // console.log('Puerta recibida ' + gate);
      //Asignación, probando primero por proximidad
      //console.log('Puerta recogida '+obj[i].Gate);
      
      bhsDepartures.save(newFlight, function(err , success){
          if(success){
   //         console.log('Response success '+success);   
          }else{
          console.log('Response error '+err);
        }

      })
     
    // console.log('Despues de insertar voy a actualizar el vuelo ' + newFlight.Flight);
     assignCarrousel (gate, flight, std);

    }

  }
})

setTimeout(function(){
//console.log('********************** GENERANDO FICHERO ***********************'); //Espero 1 seg para asegurar que se ha guardado todo en BD
createAssignmentsFile();

}, 2000);

} 

function assignCarrousel (gate, flight, std) {

var gate = ""+ gate + "";
var flight = "" + flight + "";

var stdHour = std.substr(0,2);
var stdMinutes = std.substr(3,2);
var startTime = new Date();
var endTime = new Date();

//carrousel's assignment starts 3 hours before and ends 15 minutes before
startTime.setHours(stdHour - 2, stdMinutes, 0,0);
endTime.setHours(startTime.getHours() + 3, startTime.getMinutes() - 15, 0, 0);

var carrousel;
var messageToESB; 
bhsCarrouselsByProximity.findOne({Gate: gate}, function(err , results){
        if(results){
         carrousel = "" + results.Carrousel + "";

        bhsDepartures.update({Flight:flight},{$set:{ BELT: carrousel, START: startTime, END: endTime}}, function(error , success){
          if(success){
            
            messageESB = ''+  flight +'';
          
          //Publish the update for the ESB (mainly to AODB)
          connection.publish('bhs', {"flight": messageToESB, "BELT": carrousel});

          

      }else{
      console.log('Find Carrousel Response error '+ err);

      }
      
      });  
    }
  });
}

//temporalmente me creo el fichero aquí
     //consulto bhsDepartures cojo los campos ordenados por Carrousel y por hora ETD y el id debe ser secuencial/incremental
function createAssignmentsFile(){
    var assignedCarrouselsFile = "bhs/assignedCarrousels.json";
     var belt;
     var stream = fs.createWriteStream(assignedCarrouselsFile);
     
     bhsDepartures.find().sort({BELT:1, ETD:1}, function(err, results){
          
          var actualCarrousel;
          var previousCarrousel;//para ver si hemos cambiado de carrusel
          var id = 1; //id de la tarea en el gantt
          var parent = 1;
          var carrousel = 1;
          var carrouselCounter = 0;
          var date = new Date();
          //{id:1, text:"Carrousel #1",start_date:"01-04-2013 06:00:00", duration:24, progress: 0.6, open: true},

          if (results){
            stream.write('{"data":[\n' + '{"id":1, "text":"Carrousel #' + carrousel + '", "destination": "----", "start_date":"03-04-2013 00:00:00", "duration":24, "open": true},\n');
            
            previousCarrousel = results[0].BELT;
            date = results[0].START;
         
          for(var i=0;i<(results.length - 1);i++){
            
            id = id + 1;
            date = results[i].START;
            actualCarrousel = results[i].BELT;
            if (actualCarrousel == previousCarrousel){
              stream.write('{"id":'+ id +', "text":"' + results[i].Flight + '", "destination": "'+ results[i].Destination + '", "start_date":"03-04-2013 ' + date.getHours() + ':' + date.getMinutes() + ':00", "duration":2.5, "progress": 0.0, "open": true, "parent":' + parent + '},\n');

            }else{
              carrousel = carrousel + 1;
              previousCarrousel = actualCarrousel;
              parent = i + 2 + carrouselCounter;

              stream.write('{"id":' + id + ', "text":"Carrousel #' + carrousel + '", "destination": "----" , "start_date":"03-04-2013 00:00:00", "duration":24, "open": true},\n');
              stream.write('{"id":'+ (id + 1) +', "text":"' + results[i].Flight + '", "destination": "' + results[i].Destination + '", "start_date":"03-04-2013 ' + date.getHours() + ':' + date.getMinutes() + ':00", "duration":2.5, "progress": 0.0, "open": true, "parent":' + parent + '},\n');
              id = id + 1;
              carrouselCounter = carrouselCounter + 1;
            }
          }
          //escribo el último sin coma para que el JSON sea válido
          stream.write('{"id":'+ (id + 1) +', "text":"' + results[i].Flight + '", "destination": "' + results[i].Destination + '", "start_date":"03-04-2013 ' + date.getHours() + ':' + date.getMinutes() + ':00", "duration":2.5, "progress": 0.0, "open": true, "parent":' + parent + '}\n');          
          stream.write(']}');
          stream.end();
        }

     });
    }

    function insertBSM(message){

    bhsBsms.save(message, function(err , success){
          if(success){
            console.log('Response success '+success);   
          }else{
          console.log('Response error '+err);
        }

      })

    }


