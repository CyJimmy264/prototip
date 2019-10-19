// Generated Ruboto subclass with method base "none"

package ru.cj264.prototip;

import org.ruboto.JRubyAdapter;
import org.ruboto.Log;
import org.ruboto.Script;
import org.ruboto.ScriptInfo;
import org.ruboto.ScriptLoader;

import android.webkit.JavascriptInterface;

public class Jsi extends java.lang.Object implements org.ruboto.RubotoComponent {
    public Jsi() {
        super();
    }

    private final ScriptInfo scriptInfo = new ScriptInfo();
    public ScriptInfo getScriptInfo() {
        return scriptInfo;
    }

    @JavascriptInterface
    public void json_arg( String j ) {
        JRubyAdapter.runRubyMethod( scriptInfo.getRubyInstance(), "json_arg", j );
    }

    @JavascriptInterface
    public java.lang.String json_arg_return( ) {
        return (java.lang.String) JRubyAdapter.runRubyMethod( java.lang.String.class, scriptInfo.getRubyInstance(), "json_arg_return" );
    }

    @JavascriptInterface
    public java.lang.String calculate( ) {
        return (java.lang.String) JRubyAdapter.runRubyMethod( java.lang.String.class, scriptInfo.getRubyInstance(), "calculate" );
    }


    {
        scriptInfo.setRubyClassName(getClass().getSimpleName());
        ScriptLoader.loadScript(this);
    }
}
