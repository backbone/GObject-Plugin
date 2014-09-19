using GObject.Plugins;

static Gee.ArrayList<Module> type_a_modules = null;
static Gee.ArrayList<Module> type_b_modules = null;

int main (string [] args) {

	GObject.Plugins.load_modules (
	    Path.build_path (Path.DIR_SEPARATOR_S, File.new_for_path (
	        args[0]).get_parent ().get_parent ().get_path (), "test/plugins/typeA"),
	    ref type_a_modules
	);

	GObject.Plugins.load_modules (
	    Path.build_path (Path.DIR_SEPARATOR_S, File.new_for_path (
	        args[0]).get_parent ().get_parent ().get_path (), "test/plugins/typeB"),
	    ref type_b_modules
	);

	// Show Modules List
	foreach (var m in type_a_modules) {
		stdout.printf ("Plugin Type Name = " + m.get_plugin_type ().name () + "\n");
	}
	foreach (var m in type_b_modules) {
		stdout.printf ("Plugin Type Name = " + m.get_plugin_type ().name () + "\n");
	}

	// Create a new Plugin Instance by Object.new () method
	var a = type_a_modules[0].create_instance () as PluginTypeA;
	a.method_a ();
	a = null; // free last instance, plugin unload

	// Create a new Plugin Instance by Plugin Type
	var b = GLib.Object.new (Type.from_name (type_b_modules[0].get_plugin_type ().name ())) as PluginTypeB;
	stdout.puts (b.method_b () + "\n");
	b = null; // free last instance, plugin unload

	GObject.Plugins.unload_modules (type_a_modules);
	GObject.Plugins.unload_modules (type_b_modules);

	return 0;
}
