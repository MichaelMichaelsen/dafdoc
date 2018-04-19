//
// using http://snapsvg.io/assets/js/snap.svg-min.js
//
// Usage:
// window.onload = function() { anidaf();}

var h = 17.320508076;
var ka = 20;
var hy = 10;
var kaka = ka + ka;
var kahy = ka + hy;
var kakahy = ka + ka + hy;
var toh = h+h;

colors = {
    moerk:'rgb(0, 81, 114)',
    lys:'rgb(255, 255, 255)',
    q1:{moerkbg:'rgb(0, 155, 214)',lysbg:'rgb(134, 220, 233)'},
    q2:{moerkbg:'rgb(32, 188, 224)',lysbg:'rgb(32, 188, 224)'},
    q3:{moerkbg:'rgb(134, 220, 233)',lysbg:'rgb(0, 155, 214)'},
    q4:{moerkbg:'rgb(255, 255, 255)',lysbg:'rgb(0, 81, 114)'}

}

function anim(){


    var slidetime = 700;
    var resttime = 1500;
    var dattime = 7000;
    RR = Math.random()*5;
    rand = Math.floor(RR);
    //console.log(RR, rand);
    switch(rand+1) {
    case 1:
      //box
        quin1.animate({transform: 't' + h + ',' + kaka + 'r-30,0,0'},slidetime );
        quin2.animate({transform: 't'+ h + ',0r30,0,0'},slidetime );
        quin3.animate({transform: 't0,' + kakahy + 'r-90,0,0'},slidetime );
        quin4.animate({transform: 't0,' + kakahy + ',r-30,0,0'},slidetime );
        setTimeout(function(){anim();},resttime);
        break;
    case 2:
      //bluespot
      quin1.animate({transform: 't0,0r30,0,0'},700 );
        quin2.animate({transform: 't'+ h + ',' + kahy + 'r-30,0,0'},slidetime );
        quin3.animate({transform: 't' + h + ',' + kahy + 'r-90,0,0'},slidetime );
        quin4.animate({transform: 't' + toh + ',' + kaka + ',r-30,0,0'},slidetime );
        setTimeout(function(){anim();},resttime);
         break;
    case 3:
      //plade
        quin1.animate({transform: 't0,' + kahy + 'r-30,0,0'},slidetime );
        quin2.animate({transform: 't'+ h + ',0r30,0,0'},slidetime );
        quin3.animate({transform: 't' + toh + ',' + kahy + 'r90,0,0'},slidetime );
        quin4.animate({transform: 't' + h + ',' + kaka + ',r-30,0,0'},slidetime );
        setTimeout(function(){anim();},resttime);
     break;
    case 4:
      //corolla
        quin1.animate({transform: 't'+ h + ',0r30,0,0'},slidetime );
      quin2.animate({transform: 't0,' + kahy + 'r-30,0,0'},slidetime );
        quin3.animate({transform: 't' + toh + ',' + kahy + 'r-90,0,0'},slidetime );
        quin4.animate({transform: 't' + toh + ',' + kahy +',r-30,0,0'},slidetime );
        setTimeout(function(){anim();},resttime);
       break;
    case 5:

      //daf
      quin1.animate({transform: 't'+ h + ',0r30,0,0'},slidetime );
      quin2.animate({transform: 't0,' + kahy + 'r-30,0,0'},slidetime );
      quin3.animate({transform: 't0,' + kahy + 'r30,0,0'},slidetime );
      quin4.animate({transform: 't0,' + kakahy + 'r-30,0,0'},slidetime );
        setTimeout(function(){anim();},dattime);

         break;
}
     }


    function anidaf() {
    //document.body.style.background = colors.moerk
      // like s = Snap(800, 600);
      //var bigCircle = s.circle(150, 50, 100);

       s = Snap(200,70);
      s.addClass('ani')

      quin1 = s.polyline(0, 0, ka, 0, ka+hy, h, hy, h).attr({fill: colors.q1.moerkbg});
      quin4 = quin1.clone().attr({fill:  colors.q4.moerkbg	});
      quin2 = quin1.clone().attr({fill:  colors.q2.moerkbg	});
      quin3 = quin1.clone().attr({fill:  colors.q3.moerkbg	});
      quin1.animate({transform: 't'+ h + ',0r30,0,0'},700 );
      quin2.animate({transform: 't0,' + kahy + 'r-30,0,0'},700 );
      quin3.animate({transform: 't0,' + kahy + 'r30,0,0'},700 );
      quin4.animate({transform: 't0,' + kakahy + 'r-30,0,0'},700 );

        setTimeout(function(){anim();},4000);




    };
