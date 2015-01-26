using GObject.Plugins;

/**
 * Plugin of type B2.
 */
public class TypeB2 : PluginTypeB {

	/**
	 * Constructs a new ``TypeB2``.
	 */
	construct {
		stdout.puts ("TypeB2 init () called\n");
	}

	/**
	 * Destroys the ``TypeB2``.
	 */
	~TypeB2 () {
		stdout.puts ("TypeB2 deinit () called\n");
	}

	/**
	 * Any abstract method realization for PluginTypeB.
	 */
	public override string method_b () {
		stdout.puts ("TypeB2.method_b () called\n");
		return "TypeB2 returned string";
	}
}

[ModuleInit]
Type plugin_init (GLib.TypeModule type_module) {
	return typeof (TypeB2);
}
