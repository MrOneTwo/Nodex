class ConsContainer {
  var container:Array<Connection>;

  public function new() {
    container = new Array<Connection>();
  }

  public function addConnection(con:Connection) {
    container.push(con);
  }

  public function drawAll() {
    for (con in container) {
      con.redraw();
    }
  }
}

class Connection extends h2d.Object {
  var g:h2d.Graphics;
  var origin:{x:Float, y:Float};  // this is in the Parent coords - parent = Socket usually
  var destination:{x:Float, y:Float};  // this is in the Parent coords - parent = Socket usually
  public var sourceID:Int;
  public var destinationID:Int;

  var scenePosSource:{x:Float, y:Float};
  var scenePosDestination:{x:Float, y:Float};

  public function new(parent:h2d.Object) {
    super(parent);
    g = new h2d.Graphics(this);
    // TODO(michalc): should it flush here?
    origin = {x:0, y:0};
    destination = {x:0, y:0};
  }

  /**
    Setting origin of the connection in the Socket coordinates (sure?).
  **/
  public function setOrigin(_x:Float, _y:Float) {
    origin = {x:_x, y:_y};
  }

  public function setDestination(_x:Float, _y:Float) {
    destination = {x:_x, y:_y};
  }

  /**
    Setting origin of the connection in the main scene coordinates.
  **/
  public function getOriginScene() {
    return scenePosSource;
  }

  public function redraw() {
    g.clear();
    g.lineStyle(7, 0xffdd0b35, 1.0);
    g.lineTo(origin.x, origin.y);
    g.lineTo(destination.x, destination.y);
  }

  public function reset() {
    setOrigin(0, 0);
    setDestination(0, 0);
    g.clear();
  }
}
