import h2d.Bitmap;
import h2d.Sprite;
import h2d.Text;
import h2d.Tile;
import h2d.Scene;
import h2d.Graphics;
import hxd.Res;
import hxd.Event;
import hxd.res.Font;

import hxd.App;

import Connection;
import Socket;
import Context;


class Node extends h2d.Object {
  var header_title:h2d.Text;
  public var body:h2d.Interactive;
  var width:Float;
  var height:Float;
  var offset:{x:Float, y:Float};
  var outline:h2d.filter.Outline;
  var g:h2d.Graphics;
  var socket001:Socket;
  var socket002:Socket;

  public function new(scene:h2d.Scene,
                      context:Context,
                      connectionsContainer:ConsContainer,
                      title:String,
                      font:h2d.Font,
                      _x:Float, _y:Float) {
    super(scene);
    width = 220; height = 120;
    x = _x; y = _y;

    body = new h2d.Interactive(width, height, this);
    body.backgroundColor = 0xFF444444;
    outline = new h2d.filter.Outline(2.0, 0xFFAAAAAA);

    g = new h2d.Graphics(this);
    g.beginFill(0xffdd0b35);
    g.drawRect(0, 12, width, 20);
    g.endFill();

    header_title = new h2d.Text(font, this);
    header_title.text = title;
    header_title.x = 10; header_title.y = 12;
    header_title.textColor = 0xFF444444;

    body.onClick = clbk_onClick;
    body.onRelease = clbk_onRelease;
    body.onPush = clbk_onPush;

    socket001 = new Socket(scene, context, connectionsContainer, this, 0, 60, In);
    socket002 = new Socket(scene, context, connectionsContainer, this, width, 60, Out);
    socket001.setGlobalPosition(x, y + 60);
    socket002.setGlobalPosition(x + width, y + 60);
  }

  function clbk_onClick(e:hxd.Event):Void {
    trace("click....");
  }

  function clbk_onPush(e:hxd.Event):Void {
    offset = {x:e.relX, y:e.relY};
    body.startDrag(clbk_startDrag);
    body.filter = outline;
  }

  // startDrag is used to lock focus on specific Interactive and specific callbacks
  function clbk_startDrag(e:hxd.Event):Void {
    x += e.relX - offset.x;
    y += e.relY - offset.y;
  }

  function clbk_onRelease(e:hxd.Event):Void {
    body.stopDrag();
    body.filter = null;
    socket001.setGlobalPosition(x, y + 60);
    socket002.setGlobalPosition(x + width, y + 60);
  }
}

class Main extends hxd.App
{
  var node001:Node;
  var node002:Node;
  var connections:ConsContainer;
  var ctx:Context;

  override function init() {
    Res.initEmbed();
    var font12 = Res.instruction.build(12);
    var font18 = Res.instruction.build(18);
    var font28 = Res.instruction.build(28);
    var font42 = Res.instruction.build(42);
    var font56 = Res.instruction.build(56);

    engine.backgroundColor = 0xFF111111;

    ctx = new Context(s2d, connections);

    node001 = new Node(s2d, ctx, connections, "Node - 01", font12, 300, 200);
    node002 = new Node(s2d, ctx, connections, "Node - 02", font12, 800, 200);
  }

  // if we the window has been resized
  override function onResize() {
    // center our object
    //obj.x = Std.int(s2d.width / 2);
    //obj.y = Std.int(s2d.height / 2);

    // move our text up/down accordingly
    //if( tf != null ) tf.y = s2d.height - 80;
  }

  override function update(dt:Float) {

  }

  static function main() {
    new Main();
  }
}
