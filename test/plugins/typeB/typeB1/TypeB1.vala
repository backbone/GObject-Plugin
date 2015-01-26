using GObject.Plugins;

/**
 * Plugin of type B1.
 */
public class TypeB1 : PluginTypeB {

	/**
	 * Constructs a new ``TypeB1``.
	 */
	construct {
		stdout.puts ("TypeB1 init () called\n");
	}

	/**
	 * Destroys the ``TypeB1``.
	 */
	~TypeB1 () {
		stdout.puts ("TypeB1 deinit () called\n");
	}

	/**
	 * Any abstract method realization for PluginTypeB.
	 */
	public override string method_b () {
		stdout.puts ("TypeB1.method_b () called\n");
		return "TypeB1 returned string";
	}
}

[ModuleInit]
Type plugin_init (GLib.TypeModule type_module) {
	return typeof (TypeB1);
}
