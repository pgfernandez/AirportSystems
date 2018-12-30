var restify = require('restify');
var mongojs = require("mongojs");

var http = require('http');
var url = require('url');
var fs = require('fs');
var sys = require('sys');

var amqp = require('amqp');


//COMUNICACION CON EL ESB
var connection = amqp.createConnection({ host: '127.0.0.1' });

// Wait for connection to become established.
connection.on('ready', function () {
  // Use the default 'amq.topic' exchange
  connection.queue('bhs', function(q){
      // Catch all messages
      q.bind('#');
      console.log('Connected to queue bhs');

      // Receive messages
      q.subscribe(function (message) {
        // Print messages to stdout
        console.log(message.BELT);

        updateCarrouselDepartureFlight(message.flight, message.BELT);


      });
  });
});


//WEB SERVER

var server;
// the HTTP port
var port = 8180;

server = http.createServer(function(req, res){
  var path = url.parse(req.url).pathname;
  if (path == '/') {
    path = '/home.html'
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
console.log("HTTP server running at http://127.0.0.1:" + port );




//REST API and SERVER 

var ip_addr = '127.0.0.1';
var port    =  '8181';
 
var server = restify.createServer({
    name : "aodb"
});
 
server.listen(port, function(){
    console.log('%s listening at %s ', server.name , server.url);
});

//server.use(restify.queryParser());
//server.use(restify.bodyParser());
//server.use(restify.CORS());

//DATABASE

var connection_string = '127.0.0.1:27017/aeriaa';
var db = mongojs(connection_string, ['aodb']);
var departures = db.collection("departures");

//AODB WEB SERVICES REST API
var PATH = '/departures'
server.get({path : PATH , version : '0.0.1'} , findAllDeparturesFlights);
server.get({path : PATH + '/:Gate', version : '0.0.1'} , findDeparturesFlightsByGate);
//server.get({path : PATH +'/:Flight' , version : '0.0.1'} , findDepartureFlight);
server.get({path : PATH +'/Counter/:Counter' , version : '0.0.1'} , findCounterFlights);
server.post({path : PATH +'/:Flight', version: '0.0.1'} ,postNewDepartureFlight);
//server.put({path : PATH +'/:Flight', version: '0.0.1'} , updateDepartureFlight);
server.del({path : PATH +'/:Flight' , version: '0.0.1'} ,deleteDepartureFlight);
//falta actualizar

//AODB FUNCTIONS

function findAllDeparturesFlights(req, res , next){
    res.setHeader('Access-Control-Allow-Origin','*');
    departures.find().sort({postedOn : -1}, function(err , success){
        console.log('Response success '+success);
        console.log('Response error '+err);
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
    departures.findOne({_id:mongojs.ObjectId(req.params.Flight)} , function(err , success){
        console.log('Response success '+success);
        console.log('Response error '+err);
        if(success){
            res.send(200 , success);
            return next();
        }
        return next(err);
    })
}

function findCounterFlights(req, res , next){
    res.setHeader('Access-Control-Allow-Origin','*');
    console.log("buscando vuelos del mostrador: " + req.params.Counter);
    departures.find({Counter:req.params.Counter}, function(err , success){
        console.log('Response success '+success);
        console.log('Response error '+err);
        if(success){
            res.send(200 , success);
            return next();
        }
        return next(err);
    })
}
 

function findDeparturesFlightsByGate(req, res , next){
    res.setHeader('Access-Control-Allow-Origin','*');
    departures.find({Gate:req.params.Gate} , function(err , success){
        console.log('Response success '+success);
        console.log('Response error '+err);
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
    departures.remove({_id:mongojs.ObjectId(req.params.Flight)} , function(err , success){
        console.log('Response success '+success);
        console.log('Response error '+err);
        if(success){
            res.send(204);
            return next();      
        } else{
            return next(err);
        }
    })
 
}

function updateDepartureFlight(req , res , next){
    res.setHeader('Access-Control-Allow-Origin','*');
     console.log ('recibido del BHS ' + req.params.Flight);
    /*departures.remove({_id:mongojs.ObjectId(req.params.Flight)} , function(err , success){
        console.log('Response success '+success);
        console.log('Response error '+err);
        if(success){
            res.send(204);
            return next();      
        } else{
            return next(err);
        }
        })*/

        res.send(204);
        return next();
}

function updateCarrouselDepartureFlight(flight, carrousel){

departures.update({Flight:flight},{$set:{ BELT: carrousel}}, function(error , success){
          if(success){
            
              console.log('actualizado el hipodromo de salida ' + carrousel + ' del vuelo ' + flight);

         

      }else{
      console.log('Find Carrousel Response error '+ err);

      }
      
      }); 

}

