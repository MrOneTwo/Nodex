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

  //fea3aa    f8b88b    faf884    
  //baed91    b2cefe    f2a2e8

  var color_inactive:Int = 0xff444444;
  var color_connected_in:Int = 0xffbaed91;  // green
  var color_connected_out:Int = 0xffb2cefe;  // blue
  var color_empty_in:Int = 0xffbaed91;
  var color_empty_out:Int = 0xffb2cefe;
  var color:Int = 0xff444444;

  var outline:h2d.filter.Outline;

  var state:State = Empty;

  var body:h2d.Interactive;
  var g:h2d.Graphics;
  var cons:ConsContainer;
  var sceneMain:h2d.Scene;
  var globalPos:{x:Float, y:Float};

  var ctx:Context;

  public function new(scene:h2d.Scene,
                      context:Context,
                      connectionsContainer:ConsContainer,
                      parent:h2d.Object,
                      _x:Float, _y:Float,
                      inDir:Direction) {
    super(parent);
    x = _x; y = _y;

    ctx = context;

    body = new h2d.Interactive(radius*2, radius*2, this);
    body.isEllipse = true;
    body.x = -radius; body.y = -radius;

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

    cons = connectionsContainer;
    sceneMain = scene;

    globalPos = {x:0, y:0};
  }

  function clbk_onPush(e:hxd.Event):Void {
    switch(flow) {
      case In: {
        ctx.setAction(DRAGGING_CONNECTION_IN_TO_OUT);
        ctx.setHotConnectionOrigin(globalPos.x, globalPos.y);
      };
      case Out: {
        ctx.setAction(DRAGGING_CONNECTION_OUT_TO_IN);
        ctx.setHotConnectionOrigin(globalPos.x, globalPos.y);
      };
      body.startDrag(clbk_startDrag);
    }
  }

  // startDrag is used to lock focus on specific Interactive and specific callbacks
  function clbk_startDrag(e:hxd.Event):Void {
    ctx.setHotConnectionDestination(sceneMain.mouseX, sceneMain.mouseY);
    ctx.drawHotConnection();
  }

  function clbk_onRelease(e:hxd.Event):Void {
    body.stopDrag();
    ctx.resetHotConnection();
    ctx.setAction(IDLE);
    switch(ctx.getAction()) {
      case IDLE: {

      };
      case DRAGGING_CONNECTION_OUT_TO_IN: {

      };
      case DRAGGING_CONNECTION_IN_TO_OUT: {

      };
    }
  }

  function clbk_onOver(e:hxd.Event):Void {
    switch(flow) {
      case In: {
      };
      case Out: {
      };
      case _: trace("Throw, panic etc...");
    }
  }
  
  public function redraw () {
    g.beginFill(color);
    g.drawCircle(0, 0, radius);
    g.endFill();

    g.beginFill(0x11000000);
    g.drawCircle(0, 0, radius*2/3);
    g.endFill();
  }

  public function setGlobalPosition(_x:Float, _y:Float) {
    globalPos = {x:_x, y:_y};
  }
}
