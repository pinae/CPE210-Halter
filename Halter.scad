winkel = 81.38;
stangendurchmesser = 15;
routerbreite = 80;
hoehe = 22;
fittingdurchmesser = 50;
fittingbreite = 40;
dicke = 15;

module fitting() {
  difference() {
    union() {
      translate([0, -sqrt((fittingdurchmesser/2)*(fittingdurchmesser/2)-((fittingbreite/2)*(fittingbreite/2))), 0]) {
        cylinder(d=fittingdurchmesser, h=hoehe, $fn=128);
      }
      translate([-fittingdurchmesser/2-5, -dicke, 0]) {
        cube([fittingdurchmesser+10, dicke, hoehe]);
      }
    }
    translate([-fittingdurchmesser/2-1, -fittingdurchmesser, -1]) {
      cube([fittingdurchmesser+2, fittingdurchmesser-dicke
, hoehe+9]);
    }
    for(i=[-1, 1]) {
      translate([i*(fittingbreite/2+3), -dicke/2, 10]) {
        cube([6, dicke+2, 6], center=true);
      }
      translate([i*(fittingbreite/2+3), -dicke/2, 13]) {
        rotate([0, 45, 0]) {
          cube([sqrt(2*3*3), dicke+2, sqrt(2*3*3)], center=true);
        }
      }
    }
  }
}

module screws() {
  for(i=[-1, 1]) {
    translate([i*(stangendurchmesser/2+dicke/2), -15-stangendurchmesser/2-dicke, hoehe/2]) {
      rotate([-90, 30, 0]) {
        translate([0, 0, stangendurchmesser+2*dicke-34]) {
          cylinder(d=5, h=stangendurchmesser/2+dicke, $fn=16);
        }
        cylinder(d=2*4/cos(30), h=stangendurchmesser+2*dicke-30, $fn=6);
        translate([0, 0, stangendurchmesser+2*dicke-14]) {
          cylinder(d=8.7, h=stangendurchmesser+2*dicke-30, $fn=16);
        }
        
      }
    }
  }
}

module holder() {
  difference() {
    union() {
      rotate([0, 0, -winkel/2]) {
        translate([routerbreite/2+stangendurchmesser/2+dicke-4, 0, 0]) {
          fitting();
        }
      }
      rotate([0, 0, winkel/2]) {
        translate([-routerbreite/2-stangendurchmesser/2-dicke+4, 0, 0]) {
          fitting();
        }
      }
      translate([0, -15, 0]) {
        cylinder(d=stangendurchmesser+2*dicke, h=hoehe, $fn=128);
      }
    }
    translate([0, -15, -1]) {
      cylinder(d=stangendurchmesser, h=hoehe+2, $fn=64);
    }
    translate([-stangendurchmesser/2-dicke-1, -15, -1]) {
      cube([stangendurchmesser+2*dicke+2, stangendurchmesser/2+dicke+1, hoehe+2]);
    }
    screws();
  }
}

module clamp() {
  difference() {
    translate([0, -15, 0]) {
      cylinder(d=stangendurchmesser+2*dicke, h=hoehe, $fn=128);
    }
    translate([0, -15, -1]) {
      cylinder(d=stangendurchmesser, h=hoehe+2, $fn=64);
    }
    translate([-stangendurchmesser/2-dicke-1, -15-stangendurchmesser/2-dicke-1, -1]) {
      cube([stangendurchmesser+2*dicke+2, stangendurchmesser/2+dicke+1+2, hoehe+2]);
    }
    screws();
  }
}

holder();
translate([0, -42, 13]) {
  rotate([90, 0, 0]) {
    clamp();
  }
}
