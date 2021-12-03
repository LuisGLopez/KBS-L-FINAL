package test;

import net.sf.clipsrules.jni.*;

public class BasicDemo {
    
    public static void main(String args[]) throws Exception {
        Environment clips;

        clips = new Environment();

        clips.eval("(clear)");
        clips.load("C:\\Users\\destr\\Documents\\7mo Semestre\\KBS\\CLIPS actividades\\CLIPSJNI\\work\\resources\\books.clp");

        clips.eval("(reset)");
        clips.eval("(facts)");
        clips.run();

    }
}