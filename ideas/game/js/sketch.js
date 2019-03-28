
let noiseScale = 0.1;

function setup() {

  var canvas = createCanvas(WIDTH, HEIGHT);
  canvas.parent('map');
  background(10);
  noLoop();
  for(let row = 0; row < ROWS; row++){
    for(let col = 0; col < COLS; col++){

      var tile = new Tile(col, row);
      tile.display();
    }
  }
}



function draw() {
  textSize(14);
  var res = String.fromCharCode(190);
  text('@', floor(COLS*TILE_WIDTH/2), floor(ROWS*TILE_HEIGHT/2));

}
