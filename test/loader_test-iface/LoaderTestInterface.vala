using GObject.Plugins;

/**
 * Abstract plugin of type A.
 */
public abstract class PluginTypeA: Plugin {

	/**
	 * Any virtual method for PluginTypeA.
	 */
	[CCode (has_target = false)]
	public virtual void method_a () { }
}

/**
 * Abstract plugin of type B.
 */
public abstract class PluginTypeB : Plugin {

	/**
	 * Any virtual method for PluginTypeB.
	 */
	public virtual string method_b () { return ""; }
}
