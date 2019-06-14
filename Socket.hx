import Connection;

enum Direction {
  In;
  Out;
}

enum State {
  Inactive;
  Connected;
  Empty;
}

class Socket extends h2d.Object {
  var radius:Float = 10;
  var flow:Direction = In;

  var color_inactive:Int = 0xff444444;
  var color_connected_in:Int = 0xff444444;
  var color_connected_out:Int = 0xff444444;
  var color_empty_in:Int = 0xffdd0b35;
  var color_empty_out:Int = 0xffddaa35;
  var color:Int = 0xff444444;

  var state:State = Empty;

  var body:h2d.Interactive;
  var g:h2d.Graphics;
  var con:Connection;
  var cons:ConsContainer;
  var scene:h2d.Scene;
  var globalPos:{x:Float, y:Float};

  var ctx:Context;

  public function new(inScene:h2d.Scene,
                      inOutContext:Context,
                      inOutCons:ConsContainer,
                      parent:h2d.Object,
                      inX:Float, inY:Float,
                      inDir:Direction) {
    super(parent);
    x = inX;
    y = inY;

    ctx = inOutContext;

    body = new h2d.Interactive(radius*2, radius*2, this);
    body.isEllipse = true;
    body.x = -radius;
    body.y = -radius;

    flow = inDir;
    if (flow == In) {
      color = color_empty_in;
    }
    else if (flow == Out) {
      color = color_empty_out;
    }
    else {
      color = color_inactive;
    }

    g = new h2d.Graphics(this);
    redraw();

    body.onRelease = clbk_onRelease;
    body.onPush = clbk_onPush;
    body.onOver = clbk_onOver;

    con = new Connection(this);
    cons = inOutCons;
    scene = inScene;

    globalPos = {x:0, y:0};
  }

  function clbk_onPush(e:hxd.Event):Void {
    body.startDrag(clbk_startDrag);
    con.setOrigin(0, 0);
    con.setDestination(0, 0);
    if (flow == In)
    {
      ctx.setAction(DRAGGING_CONNECTION_IN);
    }
    else if (flow == Out) {
      ctx.setAction(DRAGGING_CONNECTION_OUT);
    }
  }

  // startDrag is used to lock focus on specific Interactive and specific callbacks
  function clbk_startDrag(e:hxd.Event):Void {
    var destX:Float = scene.mouseX - x - globalPos.x;
    var destY:Float = scene.mouseY - y - globalPos.y;
    con.setDestination(destX, destY);
    con.redraw();
  }

  function clbk_onRelease(e:hxd.Event):Void {
    var docked:Bool = false;
    // TODO(michalc): check if hovering over a valid socket and decide if that means 'docked'.
    if (docked) {
      body.stopDrag();
      cons.addConnection(con);
    } else
    {
      body.stopDrag();
      con.reset();
    }
    ctx.setAction(IDLE);
  }

  function clbk_onOver(e:hxd.Event):Void {
    switch(flow) {
      case In: {
        if (ctx.getAction() == DRAGGING_CONNECTION_OUT) {
          color += 0x00222222;
          redraw();
        }
        else {
        }
      };
      case Out: {
        trace("smth...");
      };
      case _: trace("Throw, panic etc...");
    }
  }
  
  public function redraw () {
    g.beginFill(color);
    g.drawCircle(0, 0, radius);
    g.endFill();

    g.beginFill(0x931c34);
    g.drawCircle(0, 0, radius*2/3);
    g.endFill();
  }

  public function setGlobalPosition(_x:Float, _y:Float) {
    globalPos = {x:_x, y:_y};
  }
}
