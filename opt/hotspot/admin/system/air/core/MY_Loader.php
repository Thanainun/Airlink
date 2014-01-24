<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class MY_Loader extends CI_Loader
{

    function __construct()
    {
        parent::__construct();
    }
	

	/**
	 * Load Plugin
	 *
	 * This function loads the specified plugin.
	 *
	 * @access	public
	 * @param	array
	 * @return	void
	 */
	function plugin($plugins = array())
	{
		if ( ! is_array($plugins))
		{
			$plugins = array($plugins);
		}
	
		foreach ($plugins as $plugin)
		{	
			$plugin = strtolower(str_replace(EXT, '', str_replace('_pi', '', $plugin)).'_pi');		

			if (isset($this->_ci_plugins[$plugin]))
			{
				continue;
			}

			if (file_exists(APPPATH.'plugins/'.$plugin.EXT))
			{
				include_once(APPPATH.'plugins/'.$plugin.EXT);	
			}
			else
			{
				if (file_exists(BASEPATH.'plugins/'.$plugin.EXT))
				{
					include_once(BASEPATH.'plugins/'.$plugin.EXT);	
				}
				else
				{
					show_error('Unable to load the requested file: plugins/'.$plugin.EXT);
				}
			}
			
			$this->_ci_plugins[$plugin] = TRUE;
			log_message('debug', 'Plugin loaded: '.$plugin);
		}		
	}

	
}
