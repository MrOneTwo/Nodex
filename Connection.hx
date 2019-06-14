class ConsContainer {
  var container:Array<Connection>;

  public function new() {
    container = new Array<Connection>();
  }

  public function addConnection(con:Connection) {
    container.push(con);
  }
}

class Connection extends h2d.Object {
  var g:h2d.Graphics;
  var source:{x:Float, y:Float};
  var destination:{x:Float, y:Float};
  public var sourceID:Int;
  public var destinationID:Int;

  public function new(parent:h2d.Object) {
    super(parent);
    g = new h2d.Graphics(this);
    // TODO(michalc): should it flush here?
    source = {x:0, y:0};
    destination = {x:0, y:0};
  }

  public function setOrigin(_x:Float, _y:Float) {
    source = {x:_x, y:_y};
  }

  public function setDestination(_x:Float, _y:Float) {
    destination = {x:_x, y:_y};
  }

  public function redraw() {
    g.clear();
    g.lineStyle(7, 0xffdd0b35, 1.0);
    g.lineTo(source.x, source.y);
    g.lineTo(destination.x, destination.y);
  }

  public function reset() {
    setOrigin(0, 0);
    setDestination(0, 0);
    g.clear();
  }
}
