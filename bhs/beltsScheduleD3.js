 var w = 800;
  var h = 400;



//COGER LOS DATOS.....

  var svg = d3.selectAll(".svg")
  //.selectAll("svg")
  .append("svg")
  .attr("width", w)
  .attr("height", h)
  .attr("class", "svg");


    var taskArray = [
  {
    task: "IBE3459",
    type: "Belt 1",
    startTime: "06:45", 
    endTime: "07:45",
    details: "This actually didn't take any conceptualization"
},

{
    task: "BA3459",
    type: "Belt 2",
    startTime: "07:45", 
    endTime: "08:45",
    details: "No sketching either, really"
},

{
    task: "Belt 6",
    type: "development",
    startTime: "09:45", 
    endTime: "10:45",
}

];

var dateFormat = d3.time.format("%H-%M");

var timeScale = d3.time.scale()
        .domain([d3.min(taskArray, function(d) {return dateFormat.parse(d.startTime);}),
                 d3.max(taskArray, function(d) {return dateFormat.parse(d.endTime);})])
        .range([0,w-150]); //REVISAR


//BHS
var belts = ["Belt 1", "Belt 2", "Belt 3", "Belt 4", "Belt 5", "Belt 5", "Belt 6", "Belt 7", "Belt 8", "Belt 9", "Belt 10", "Belt 11", "Belt 12"];

var catsUnfiltered = belts; //for vert labels VEREMOS SI SIRVE DE ALGO DESPUÉS
 
makeGant(taskArray, w, h); //comienza la creación del gantt

var title = svg.append("text")
              .text("Today's Flights Schedule")
              .attr("x", w/2)
              .attr("y", 25)
              .attr("text-anchor", "middle")
              .attr("font-size", 18)
              .attr("fill", "#009FFC");



function makeGant(tasks, pageWidth, pageHeight){

var barHeight = 20;
var gap = barHeight + 4;
var topPadding = 75;
var sidePadding = 75;

var colorScale = d3.scale.linear()
    .domain([0, belts.length])
    .range(["#00B9FA", "#F95002"])
    .interpolate(d3.interpolateHcl);

makeGrid(sidePadding, topPadding, pageWidth, pageHeight);
drawRects(tasks, gap, topPadding, sidePadding, barHeight, colorScale, pageWidth, pageHeight);
vertLabels(gap, topPadding, sidePadding, barHeight, colorScale);

}


function drawRects(theArray, theGap, theTopPad, theSidePad, theBarHeight, theColorScale, w, h){

var bigRects = svg.append("g")
    .selectAll("rect")
   .data(theArray)
   .enter()
   .append("rect")
   .attr("x", 0)
   .attr("y", function(d, i){
      return i*theGap + theTopPad - 2;
  })
   .attr("width", function(d){
      return w-theSidePad/2;
   })
   .attr("height", theGap)
   .attr("stroke", "none")
   .attr("fill", function(d){
    for (var i = 0; i < belts.length; i++){
        if (d.type == belts[i]){
          return d3.rgb(theColorScale(i));
        }
    }
   })
   .attr("opacity", 0.2);


     var rectangles = svg.append('g')
     .selectAll("rect")
     .data(theArray)
     .enter();


   var innerRects = rectangles.append("rect")
             .attr("rx", 3)
             .attr("ry", 3)
             .attr("x", function(d){
              return timeScale(dateFormat.parse(d.startTime)) + theSidePad;
              })
             .attr("y", function(d, i){
                return i*theGap + theTopPad;
            })
             .attr("width", function(d){
                return (timeScale(dateFormat.parse(d.endTime))-timeScale(dateFormat.parse(d.startTime)));
             })
             .attr("height", theBarHeight)
             .attr("stroke", "none")
             .attr("fill", function(d){
              for (var i = 0; i < belts.length; i++){
                  if (d.type == belts[i]){
                    return d3.rgb(theColorScale(i));
                  }
              }
             })
   

         var rectText = rectangles.append("text")
               .text(function(d){
                return d.task;
               })
               .attr("x", function(d){
                return (timeScale(dateFormat.parse(d.endTime))-timeScale(dateFormat.parse(d.startTime)))/2 + timeScale(dateFormat.parse(d.startTime)) + theSidePad;
                })
               .attr("y", function(d, i){
                  return i*theGap + 14+ theTopPad;
              })
               .attr("font-size", 11)
               .attr("text-anchor", "middle")
               .attr("text-height", theBarHeight)
               .attr("fill", "#fff");


rectText.on('mouseover', function(e) {
 // console.log(this.x.animVal.getItem(this));
               var tag = "";

         if (d3.select(this).data()[0].details != undefined){
          tag = "Task: " + d3.select(this).data()[0].task + "<br/>" + 
                "Type: " + d3.select(this).data()[0].type + "<br/>" + 
                "Starts: " + d3.select(this).data()[0].startTime + "<br/>" + 
                "Ends: " + d3.select(this).data()[0].endTime + "<br/>" + 
                "Details: " + d3.select(this).data()[0].details;
         } else {
          tag = "Task: " + d3.select(this).data()[0].task + "<br/>" + 
                "Type: " + d3.select(this).data()[0].type + "<br/>" + 
                "Starts: " + d3.select(this).data()[0].startTime + "<br/>" + 
                "Ends: " + d3.select(this).data()[0].endTime;
         }
         var output = document.getElementById("tag");

          var x = this.x.animVal.getItem(this) + "px";
          var y = this.y.animVal.getItem(this) + 25 + "px";

         output.innerHTML = tag;
         output.style.top = y;
         output.style.left = x;
         output.style.display = "block";
       }).on('mouseout', function() {
         var output = document.getElementById("tag");
         output.style.display = "none";
             });


innerRects.on('mouseover', function(e) {
 //console.log(this);
         var tag = "";

         if (d3.select(this).data()[0].details != undefined){
          tag = "Task: " + d3.select(this).data()[0].task + "<br/>" + 
                "Type: " + d3.select(this).data()[0].type + "<br/>" + 
                "Starts: " + d3.select(this).data()[0].startTime + "<br/>" + 
                "Ends: " + d3.select(this).data()[0].endTime + "<br/>" + 
                "Details: " + d3.select(this).data()[0].details;
         } else {
          tag = "Task: " + d3.select(this).data()[0].task + "<br/>" + 
                "Type: " + d3.select(this).data()[0].type + "<br/>" + 
                "Starts: " + d3.select(this).data()[0].startTime + "<br/>" + 
                "Ends: " + d3.select(this).data()[0].endTime;
         }
         var output = document.getElementById("tag");

         var x = (this.x.animVal.value + this.width.animVal.value/2) + "px";
         var y = this.y.animVal.value + 25 + "px";

         output.innerHTML = tag;
         output.style.top = y;
         output.style.left = x;
         output.style.display = "block";
       }).on('mouseout', function() {
         var output = document.getElementById("tag");
         output.style.display = "none";

 });



}


function makeGrid(theSidePad, theTopPad, w, h){

var xAxis = d3.svg.axis()
    .scale(timeScale)
    .orient('bottom')
    .ticks(d3.time.days, 1)
    .tickSize(-h+theTopPad+20, 0, 0)
    .tickFormat(d3.time.format('%d %b'));

var grid = svg.append('g')
    .attr('class', 'grid')
    .attr('transform', 'translate(' +theSidePad + ', ' + (h - 50) + ')')
    .call(xAxis)
    .selectAll("text")  
            .style("text-anchor", "middle")
            .attr("fill", "#000")
            .attr("stroke", "none")
            .attr("font-size", 10)
            .attr("dy", "1em");
}

function vertLabels(theGap, theTopPad, theSidePad, theBarHeight, theColorScale){
  var numOccurances = new Array();
  var prevGap = 0;

  for (var i = 0; i < belts.length; i++){
    numOccurances[i] = [belts[i], getCount(belts[i], catsUnfiltered)];
  }

  var axisText = svg.append("g") //without doing this, impossible to put grid lines behind text
   .selectAll("text")
   .data(numOccurances)
   .enter()
   .append("text")
   .text(function(d){
    return d[0];
   })
   .attr("x", 10)
   .attr("y", function(d, i){
    if (i > 0){
        for (var j = 0; j < i; j++){
          prevGap += numOccurances[i-1][1];
         // console.log(prevGap);
          return d[1]*theGap/2 + prevGap*theGap + theTopPad;
        }
    } else{
    return d[1]*theGap/2 + theTopPad;
    }
   })
   .attr("font-size", 11)
   .attr("text-anchor", "start")
   .attr("text-height", 14)
   .attr("fill", function(d){
    for (var i = 0; i < belts.length; i++){
        if (d[0] == belts[i]){
        //  console.log("true!");
          return d3.rgb(theColorScale(i)).darker();
        }
    }
   });

}


//from this stackexchange question: http://stackoverflow.com/questions/14227981/count-how-many-strings-in-an-array-have-duplicates-in-the-same-array
function getCounts(arr) {
    var i = arr.length, // var to loop over
        obj = {}; // obj to store results
    while (i) obj[arr[--i]] = (obj[arr[i]] || 0) + 1; // count occurrences
    return obj;
}

// get specific from everything
function getCount(word, arr) {
    return getCounts(arr)[word] || 0;
}