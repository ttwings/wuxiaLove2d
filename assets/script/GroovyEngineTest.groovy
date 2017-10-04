package com.mygdx.game.tools
import javax.naming.Binding
/**
 * Created by ttwings on 2017/8/7.
 */
String[] roots = { "script/" }
GroovyScriptEngine gse = new GroovyScriptEngine(roots)
Binding binding = new Binding()
while(true){
    def greeter = gse.run("Reloading.groovy",binding)
    println greeter.sayHello()
    Thread.sleep(1000)
}