using GObject.Plugins;

static Gee.ArrayList<Module> type_a_modules = null;
static Gee.ArrayList<Module> type_b_modules = null;

class LoaderTestHost : Object, IHost, IHostLoaderTest {
	public void method_host () {
		stdout.puts ("LoaderTestHost.method_host () called\n");
	}
}

int main (string [] args) {

	var h = new LoaderTestHost ();

	GObject.Plugins.load_modules_depth2 (
	    Path.build_path (Path.DIR_SEPARATOR_S, File.new_for_path (
	        args[0]).get_parent ().get_parent ().get_path (), "test/plugins/typeA"),
	    ref type_a_modules
	);

	GObject.Plugins.load_modules_depth2 (
	    Path.build_path (Path.DIR_SEPARATOR_S, File.new_for_path (
	        args[0]).get_parent ().get_parent ().get_path (), "test/plugins/typeB"),
	    ref type_b_modules
	);

	// Show Modules List
	stdout.puts ("List Plugins:\n");
	foreach (var m in type_a_modules) {
		stdout.printf ("  Name = " + m.get_plugin_type ().name () + "\n");
	}
	foreach (var m in type_b_modules) {
		stdout.printf ("  Name = " + m.get_plugin_type ().name () + "\n");
	}

	// Create a new Plugin Instance by Object.new () method
	stdout.puts ("Creating PluginTypeA Object:\n  ");
	var a = type_a_modules[0].create_instance (h) as PluginTypeA;
	stdout.puts ("Call a.method_a () from main app:\n  ");
	a.method_a ();
	stdout.puts ("Destroing PluginTypeA Object:\n  ");
	a = null;

	// Create a new Plugin Instance by Plugin Type
	stdout.puts ("Creating PluginTypeB Object:\n  ");
	var b = GLib.Object.new (Type.from_name (type_b_modules[0].get_plugin_type ().name ())) as PluginTypeB;
	b.host = h;
	stdout.puts ("Call b.method_b () from main app:\n  ");
	stdout.puts ("  Returned String: " + b.method_b () + "\n");
	stdout.puts ("Destroing PluginTypeB Object:\n  ");
	b = null;

	// Unload modules
	GObject.Plugins.unload_modules (type_a_modules);
	GObject.Plugins.unload_modules (type_b_modules);

	return 0;
}
