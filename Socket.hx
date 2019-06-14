import Connection;

enum Direction {
  In;
  Out;
}

class Socket extends h2d.Object {
  var radius:Float = 10;
  var flow:Direction = In;

  var color:Int = 0xff444444;

  var body:h2d.Interactive;
  var g:h2d.Graphics;
  var con:Connection;
  var cons:ConsContainer;
  var scene:h2d.Scene;
  var globalPos:{x:Float, y:Float};

  public function new(inScene:h2d.Scene, inOutCons:ConsContainer, parent:h2d.Object, inX:Float, inY:Float, inDir:Direction) {
    super(parent);
    x = inX;
    y = inY;

    body = new h2d.Interactive(radius*2, radius*2, this);
    body.isEllipse = true;
    body.x = -radius;
    body.y = -radius;

    if (flow == In)
    {
      color = 0xffdd0b35;
    }
    else
    {
      color = 0xff000b35;
    }

    g = new h2d.Graphics(this);
    g.beginFill(color);
    g.drawCircle(0, 0, radius);
    g.endFill();

    g.beginFill(0x931c34);
    g.drawCircle(0, 0, radius*2/3);
    g.endFill();

    body.onRelease = clbk_onRelease;
    body.onPush = clbk_onPush;

    con = new Connection(this);
    cons = inOutCons;
    scene = inScene;

    globalPos = {x:0, y:0};
  }

  function clbk_onPush(e:hxd.Event):Void {
    body.startDrag(clbk_startDrag);
    con.setOrigin(0, 0);
    con.setDestination(0, 0);
  }

  // startDrag is used to lock focus on specific Interactive and specific callbacks
  function clbk_startDrag(e:hxd.Event):Void {
    con.setDestination(scene.mouseX - x - globalPos.x, scene.mouseY - y - globalPos.y);
    con.redraw();
  }

  function clbk_onRelease(e:hxd.Event):Void {
    var docked:Bool = false;
    // TODO(michalc): check if hovering over a valid socket and decide if that means 'docked'.
    if (docked)
    {
      body.stopDrag();
      cons.addConnection(con);
    }
    else
    {
      body.stopDrag();
      con.reset();
    }
  }

  public function setGlobalPosition(_x:Float, _y:Float) {
    globalPos = {x:_x, y:_y};
  }
}
