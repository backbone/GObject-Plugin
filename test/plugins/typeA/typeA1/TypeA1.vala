using GObject.Plugins;

/**
 * Plugin of type A1.
 */
public class TypeA1 : PluginTypeA {

	/**
	 * Constructs a new ``TypeA1``.
	 */
	construct {
		stdout.puts ("TypeA1 init () called\n");
	}

	/**
	 * Destroys the ``TypeA1``.
	 */
	~TypeA1 () {
		stdout.puts ("TypeA1 deinit () called\n");
	}

	/**
	 * Any abstract method realization for PluginTypeA.
	 */
	public override void method_a () {
		stdout.puts ("TypeA1.method_a () called\n");
		stdout.puts ("Call IHostLoaderTest.method_host () from TypeA1:\n  ");
		(host as IHostLoaderTest).method_host ();
	}
}

[ModuleInit]
Type plugin_init (GLib.TypeModule type_module) {
	return typeof (TypeA1);
}
