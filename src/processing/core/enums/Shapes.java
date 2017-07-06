/* -*- mode: java; c-basic-offset: 4; indent-tabs-mode: nil -*- */

 /*
  Use of enums is preferred for global access, however the general
  recommendation is to include constants in classes that use them.
 */
package processing.core.enums;

public enum Shapes {
    VERTEX(0),
    BEZIER_VERTEX(1),
    QUADRATIC_VERTEX(2),
    CURVE_VERTEX(3),
    BREAK(4);

    Shapes(int val) {
        this.shape = val;
    }

    private final int shape;

    public int getShape() {
        return this.shape;
    }
}
