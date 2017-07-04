/* -*- mode: java; c-basic-offset: 4; indent-tabs-mode: nil -*- */

 /*
  Use of enums is preferred for global access, however the general 
  recommendation is to include constants in classes that use them.
 */
package processing.core;

public enum RenderMode {
    JAVA2D("processing.awt.PGraphicsJava2D"),
    P2D("processing.opengl.PGraphics2D"),
    P3D("processing.opengl.PGraphics3D"),
    FX2D("processing.javafx.PGraphicsFX2D"),
    PDF("processing.pdf.PGraphicsPDF"),
    SVG("processing.svg.PGraphicsSVG"),
    DXF("processing.dxf.RawDXF");

    RenderMode(String val) {
        this.mode = val;
    } 
    
    private final String mode;

    public String renderMode(){
        return this.mode;
    }
}
