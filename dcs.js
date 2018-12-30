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
  // Use the default 'bsm topic exchange
  connection.queue('bsm', function(q){
      // Catch all messages
      q.bind('#');
      console.log('Connected to queue bsm');
  });
});


//WEB SERVER

var webServer;
// the HTTP port
var port = 8085;

webServer = http.createServer(function(req, res){
  var path = url.parse(req.url).pathname;
  if (path == '/') {
    path = '/dcs/home.html'
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
    
webServer.listen(port);
console.log("HTTP server running at http://0.0.0.0:" + port );



//REST CLIENT FOR REQUEST OTHER SYSTEMS
var client = restify.createJSONClient({
url : 'https://api.ba.com',
headers: {
    'Client-Key' : 'TO BE ACQUIRED'
  }

});


//REST API and SERVER 

var ip_addr = '127.0.0.1';
var port    =  '8183';
 
var server = restify.createServer({
    name : "dcs"
});

server.listen(port ,function(){ 
//server.listen(port ,ip_addr, function(){
    console.log('%s listening at %s ', server.name , server.url);
});

server.use(restify.queryParser());
server.use(restify.bodyParser());
server.use(restify.CORS());


//DATABASE

var connection_string = '127.0.0.1:27017/aeriaa';
var db = mongojs(connection_string, ['aodb']);
var paxSales = db.collection("paxSales");
var bhsBsms = db.collection("bhsBsms");
var bagsChecked = db.collection("bagsChecked");
var preCheckPax = db.collection("preCheckPax");

//AODB WEB SERVICES REST API

//DCS REST API
var PATH = '/dcs'
server.get({path : PATH +'/Counter/:Counter' , version : '0.0.1'} , requestDeparturesFlights);
server.get({path : PATH +'/CheckPax/:ResNumber' , version : '0.0.1'} , requestPaxData);
server.get({path : PATH +'/PreCheckPax' , version : '0.0.1'} , requestPreCheckPaxData);
server.get({path : PATH +'/CheckPax/BSM/:BSMNumber' , version : '0.0.1'} , sendBSM);
server.get({path : PATH +'/CheckPax/All' , version : '0.0.1'} , getPaxStatus);
server.post({path : PATH +'/Counter/:Counter/:Flight' , version : '0.0.1'} , paxChecked);
server.get({path : PATH +'/CheckPax/:ResNumber/:Bags' , version : '0.0.1'} , paxPreCheckBaggage);
//server.get({path : PATH +'/CheckPax/:ResNumber/location/:Place' , version : '0.0.1'} , paxLocation);
server.post({path : PATH +'/CheckPax/location/:Place' , version : '0.0.1'} , paxLocation);




function getPaxStatus(reqDCS, resDCS , next){
  
  resDCS.setHeader('Access-Control-Allow-Origin','*');
  console.log("Pedidos todos los estados de los paxs que van a venir");
  //resDCS.send(200 , {message: "pax checked for flight: " + reqDCS.params.Flight});
  
  
}

//load the departures flights
//requestDeparturesFlightsFromMAD();



function requestDeparturesFlights(reqDCS, resDCS , next){

  client.get('/rest-v1/v1/flights;departureLocation=MAD;arrivalLocation=LHR;scheduledDepartureDate=2014-05-15.json', function (err, req, res, obj) {
  if(err){ 
    console.log("An error ocurred: ", err);
    return next(err);
  }else {
        // console.log('Response success: '+ JSON.stringify(obj)); 
    
            resDCS.send(200 , obj);



            //return next(); Activar
        }
    

  })
     
}

function paxChecked(reqDCS, resDCS , next){
  
  resDCS.setHeader('Access-Control-Allow-Origin','*');
  console.log("vuelo recibido para facturar pax: "+ reqDCS.params.Flight);
  resDCS.send(200 , {message: "pax checked for flight: " + reqDCS.params.Flight});
  
  
}



function paxLocation(reqDCS, resDCS , next){
  
  resDCS.setHeader('Access-Control-Allow-Origin','*');
  console.log("Recibido en el body: "+ reqDCS.body.Flight);
  console.log("Ubicación del pax: "+ reqDCS.params.Place);
  //Con esto informar a la app de que hay un cambio de estado en un pasajero que viene con reserva 

  preCheckPax.save({resNumber: reqDCS.body.Reservation, Flight: reqDCS.body.Flight, Destination: reqDCS.body.destination, Name: reqDCS.body.Name, Surname: reqDCS.body.Surname, STD: reqDCS.body.STD, location: reqDCS.params.Place, date: new Date()}, function(err, success){

    if(success){
            console.log('Response success '+success);   
            resDCS.send(200 , success);
          }else{
          console.log('Response error '+err);
          resDCS.send(200 , err);
        }

      })

  //resDCS.send(200 , {message: "pax checked for flight: " + reqDCS.params.Flight});
  
  
}


function paxPreCheckBaggage(reqDCS, resDCS , next){
  
  resDCS.setHeader('Access-Control-Allow-Origin','*');
  console.log("Reserva recibida del Pax: "+ reqDCS.params.ResNumber);
  console.log("Número de equipajes: "+ reqDCS.params.Bags);
  resDCS.send(200 , {message: "pax reported number of bags: " + reqDCS.params.Bags});

  insertPreCheckBags(reqDCS.params.ResNumber, reqDCS.params.Bags);
  
}


function insertPreCheckBags(reservationNumber, bags){

    //var doc = '{resNumber:' + resNumber +' ,numberOfBags:' + bags + '}';
    bagsChecked.save({resNumber: reservationNumber ,numberOfBags: bags }, function(err , success){
          if(success){
            console.log('Response success '+success);   
          }else{
          console.log('Response error '+err);
        }

      })

    }

function requestPaxData(reqDCS, resDCS , next){

  //resDCS.setHeader('Access-Control-Allow-Origin','*');
  console.log("reserva recibida para facturar: "+ reqDCS.params.ResNumber);

  
    paxSales.find({Resnumber:reqDCS.params.ResNumber} , function(err , success){
        console.log('Response success '+success);
        console.log('Response error '+err);
        if(success){
            resDCS.send(200 , success);
            return next();
        }
        return next(err);
    })

}

function requestPreCheckPaxData(reqDCS, resDCS , next){

  //resDCS.setHeader('Access-Control-Allow-Origin','*');
  //console.log("reserva recibida para facturar: "+ reqDCS.params.ResNumber);
    resDCS.setHeader('Access-Control-Allow-Origin','*');
   preCheckPax.find().sort({date : -1}, function(err , success){
    //preCheckPax.distinct("resNumber", function(err , success){
        console.log('Response success '+success);
        console.log('Response error '+err);
        if(success){
            resDCS.send(200 , success);
            return next();
        }else{
            return next(err);
        }
 
    });

}

function sendBSM(reqDCS, resDCS , next){

  //resDCS.setHeader('Access-Control-Allow-Origin','*');
  console.log("BSM recibido para enviar: "+ reqDCS.params.BSMNumber);
//enviar mensaje al BHS (vía RabittMQ) e insertarlo en BBDD de BHS
//ya veremos como casar vuelos y maletas

  
            var bsm = '{bsm:' +  reqDCS.params.BSMNumber + '}';
            connection.publish('bsm', {"bsm": reqDCS.params.BSMNumber});
            
            console.log("Publicando el bsm al BHS" + bsm);

  
            resDCS.send(200 , success);
    

}


