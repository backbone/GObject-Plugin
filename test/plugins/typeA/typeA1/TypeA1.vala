using GObject.Plugins;

/**
 * Plugin of type A1.
 */
public class TypeA1 : PluginTypeA {

	/**
	 * Constructs a new ``TypeA1``.
	 */
	construct {
		stdout.puts ("TypeA1 init\n");
	}

	/**
	 * Destroys the ``TypeA1``.
	 */
	~Test () {
		stdout.puts ("TypeA1 deinit\n");
	}

	/**
	 * Any virtual method for PluginTypeA.
	 */
	public override void method_a () {
		stdout.puts ("TypeA1.method_a () called\n");
	}
}

[ModuleInit]
Type plugin_init (GLib.TypeModule type_module) {
	return typeof (TypeA1);
}
