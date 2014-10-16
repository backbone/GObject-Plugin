using GObject.Plugins;

/**
 * Loader Host Interface.
 */
public interface IHostLoaderTest : IHost {

	/**
	 * Any Host Method.
	 */
	public abstract void method_host ();
}

/**
 * Abstract plugin of type A.
 */
public abstract class PluginTypeA: Plugin {

	/**
	 * Any abstract method for PluginTypeA.
	 */
	public abstract void method_a ();
}

/**
 * Abstract plugin of type B.
 */
public abstract class PluginTypeB : Plugin {

	/**
	 * Any abstract method for PluginTypeB.
	 */
	public abstract string method_b ();
}
