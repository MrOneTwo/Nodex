enum Action {
  IDLE;
  DRAGGING_CONNECTION_IN;
  DRAGGING_CONNECTION_OUT;
}

class Context {
  var action:Action = IDLE;

  public function new() {
  }

  public function setAction(inAction:Action):Void {
    action = inAction;
  }

  public function getAction():Action {
    return action;
  }
}

