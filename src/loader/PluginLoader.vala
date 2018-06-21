/**
 * GObject Models.
 */
namespace GObject {

	/**
	 * Modules/Plugins.
	 */
	namespace Plugins {

		/**
		 * Module.
		 */
		public class Module : TypeModule {
			[CCode (has_target = false)]
			private delegate Type PluginInitFunc (TypeModule module);

			private GLib.Module module = null;

			private string path = null;

			private Type type;

			/**
			 * Creates a new Module by specific path.
			 *
			 * @param path path to the module.
			 */
			public Module (string path) {
				this.path = path;
			}

			/**
			 * Loads the module.
			 */
			public override bool load () {
				module = GLib.Module.open (path, GLib.ModuleFlags.BIND_LAZY);
				if (null == module) {
					stderr.printf("Cannot load module %s\n", path);
					return false;
				}

				void * plugin_init = null;
				if (! module.symbol ("plugin_init", out plugin_init)) {
					stderr.printf("No such symbol: plugin_init in %s\n", path);
					return false;
				}

				type = ((PluginInitFunc) plugin_init) (this);

				return true;
			}

			/**
			 * Unloads the module.
			 */
			public override void unload () {
				module = null;
			}

			/**
			 * Gets Plugin Type.
			 */
			public Type get_plugin_type () {
				return type;
			}

			/**
			 * Creates Plugin instance from the module.
			 */
			public Plugin create_instance (IHost ihost) {
				var p = Object.new (type) as Plugin;
				p.host = ihost;
				return p;
			}
		}

		void sort_modules (Gee.ArrayList<Module> modules) {
			modules.sort ((a, b) => {
					var a_name = a.get_plugin_type ().name ();
					var b_name = b.get_plugin_type ().name ();
					if (a_name < b_name) return -1;
					if (a_name > b_name) return 1;
					return 0;
			});
		}

		/**
		 * Loads modules in the specific directory.
		 *
		 * @param dir_path path to the directory.
		 * @param modules where to save list of modules.
		 *
		 * @return are the modules loaded correctly or not.
		 */
		public bool load_modules (string dir_path, ref Gee.ArrayList<Module>? modules) {

			modules = new Gee.ArrayList<Module> ();
			var paths = new Gee.HashSet<string> ();

			try {
				var libPath = File.new_for_path (dir_path);
				for (var i = 0; i < 32; ++i) {
					var saved_length = modules.size;
					var lib_enumerator = libPath.enumerate_children (FileAttribute.STANDARD_NAME, 0, null);
					FileInfo file_info = null;
					while ((file_info = lib_enumerator.next_file (null)) != null) {
						if (Regex.match_simple ("^.*\\.(so|dll)$", file_info.get_name ())) {
							var path = GLib.Module.build_path (dir_path, file_info.get_name ());
							if (paths.contains(path)) continue;
							var module = new Module (path);
							if (module.load ()) {
								modules.add (module);
								paths.add(path);
							}
						}
					}
					if (modules.size == saved_length) break;
				}
			} catch (Error e) {
				message (e.message);
				return false;
			}

			sort_modules (modules);

			return true;
		}


		/**
		 * Loads modules in the 2-depth directory tree path.
		 *
		 * @param dir_path path to the 2-depth directory tree.
		 * @param modules where to save list of modules.
		 *
		 * @return are the modules loaded correctly or not.
		 */
		public bool load_modules_depth2 (string dir_path, ref Gee.ArrayList<Module>? modules) {

			modules = new Gee.ArrayList<Module> ();
			var paths = new Gee.HashSet<string> ();

			try {
				var libPath = File.new_for_path (dir_path);
				for (var i = 0; i < 32; ++i) {
					var saved_length = modules.size;
					var dir_enumerator = libPath.enumerate_children ("standard::*",
					    FileQueryInfoFlags.NOFOLLOW_SYMLINKS, null);
					FileInfo dir_info = null;
					while ((dir_info = dir_enumerator.next_file (null)) != null ) {
						if (dir_info.get_file_type () == FileType.DIRECTORY) {
							File subdir = libPath.resolve_relative_path (dir_info.get_name ());
							var lib_enumerator = subdir.enumerate_children (FileAttribute.STANDARD_NAME, 0, null);
							FileInfo file_info = null;
							while ((file_info = lib_enumerator.next_file (null)) != null) {
								if (Regex.match_simple ("^.*\\.(so|dll)$", file_info.get_name ())) {
									var path = Path.build_path (Path.DIR_SEPARATOR_S, dir_path, dir_info.get_name ());
									path = GLib.Module.build_path (path, file_info.get_name ());
									if (paths.contains(path)) continue;
									var module = new Module (path);
									if (module.load ()) {
										modules.add (module);
										paths.add(path);
									}
								}
							}
						}
					}
					if (modules.size == saved_length) break;
				}
			} catch (Error e) {
				message (e.message);
				return false;
			}

			sort_modules (modules);

			return true;
		}

		/**
		 * Unloads modules.
		 *
		 * @param modules list of modules.
		 */
		public void unload_modules (Gee.ArrayList<Module> modules) {
			modules.foreach ((a) => {a.unload (); return true;});
		}
	}
}
