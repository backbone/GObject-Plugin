/**
 * GObject Models.
 */
namespace GObject {

	/**
	 * Modules/Plugins.
	 */
	namespace Plugins {

		/**
		 * Plugin interface.
		 */
		public interface IPlugabble : Object {
		}

		/**
		 * Abstract Plugin.
		 */
		public abstract class Plugin : Object, IPlugabble {
		}
	}
}
