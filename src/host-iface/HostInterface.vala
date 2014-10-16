/**
 * GObject Models.
 */
namespace GObject {

	/**
	 * Modules/Plugins.
	 */
	namespace Plugins {

		/**
		 * Host interface.
		 */
		public interface IHost : Object {
		}

		/**
		 * Abstract Host.
		 */
		public abstract class Host : Object, IHost {
		}
	}
}
