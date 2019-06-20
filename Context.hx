import Connection;

enum Action {
  IDLE;
  DRAGGING_CONNECTION_IN_TO_OUT;
  DRAGGING_CONNECTION_OUT_TO_IN;
}

class Context {
  var scene:h2d.Scene;
  var action:Action = IDLE;
  var conBeingMade:Connection;
  var cons:ConsContainer;

  public function new(inScene:h2d.Scene, connectionsContainer:ConsContainer) {
    conBeingMade = new Connection(inScene);
    cons = connectionsContainer;
  }

  public function setAction(inAction:Action):Void {
    action = inAction;
  }

  public function getAction():Action {
    return action;
  }


  /**
    Functions below are used to manipulate the connection being made.
  **/

  /**
    Set the origin of the connection in the parent coordinate system (s2d).
  **/
  public function setHotConnectionOrigin(x:Float, y:Float):Void {
    conBeingMade.setOrigin(x, y);
  }

  /**
  **/
  public function setHotConnectionDestination(x:Float, y:Float):Void {
    conBeingMade.setDestination(x, y);
  }

  /**
  **/
  public function drawHotConnection():Void {
    conBeingMade.redraw();
  }

  /**
  **/
  public function resetHotConnection():Void {
    conBeingMade.reset();
  }

  /**
  **/
  public function saveConnection():Void {
    cons.addConnection(conBeingMade);
  }
}
