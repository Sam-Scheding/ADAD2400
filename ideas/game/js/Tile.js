
function Tile(x, y) {
  this.x = x;
  this.y = y;
  this.height = TILE_HEIGHT;
  this.width = TILE_WIDTH;
  this.pVal = noise(x*noiseScale, y*noiseScale) * 255;



  this.display = function() {
    if(this.type == 'T'){
      let c = color(30, 150, 40);
      fill(c);
    } else if (this.type == '~') {
      let c = color(30, 20, 190);
      fill(c);
    } else {
      let c = color(200, 200, 200);
      fill(c);
    }
    textSize(12);
    text(this.type, this.x*this.width, this.y*this.height);
  }


  this.getType = function(){

    if(this.pVal < 60 ){
      return '~';
    } else if (this.pVal > 160) {
      return 'T';
    } else {
      return ' ';
    }
  }

  this.type = this.getType();
}
