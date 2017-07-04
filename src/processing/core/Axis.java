/* -*- mode: java; c-basic-offset: 2; indent-tabs-mode: nil -*- */

/*
Use of enums is preferred for global access, however the general
recommendation is to include constants in classes that use them.
*/
package processing.core;

public enum Axis {
  X(0),
  Y(1),
  Z(2);

  Axis(int val) {
    this.axis = val;
  }

  public int getAxis(){
    return this.axis;
  }
  private final int axis;
}
