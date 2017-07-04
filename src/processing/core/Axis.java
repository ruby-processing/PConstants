/* -*- mode: java; c-basic-offset: 2; indent-tabs-mode: nil -*- */

/*
Use of enums is preferred for global access, however the general
recommendation is to include constants in classes that use them.
*/
package processing.core;

import java.awt.Cursor;
import java.awt.event.KeyEvent;

/**
* Numbers shared throughout processing.core.
* <P>
* An attempt is made to keep the constants as short/non-verbose as possible.
* For instance, the constant is TIFF instead of FILE_TYPE_TIFF. We'll do this
* as long as we can get away with it.
*
* @usage Web &amp; Application
*/
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
