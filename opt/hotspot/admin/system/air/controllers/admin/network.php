<?php if (!defined('BASEPATH')) exit('No direct script access allowed');
/**
 * Network
 *
 * Network Controller
 *
 * @package		network
 * @author		Nost radius
 * @version		1.0
 * @based on	Nost radius management
 * @license		GPL/GNU License Copyright (c) 2008 Nost Computer
 */

class Network extends My_Admin
{

	function __construct()
	{
		parent::__construct();
		
		$this->load->model('siteconfigmodel');
		
	}

	function index()
	{
		$coova = $this->siteconfigmodel->getConfig('coova_config');
		$data = $this->session->_unserialize($coova->value);
		$this->template ->add_js('network/network.js')
						->write_view('left-content','admin/network/network_view',$data)
						->render();
	}
	
	function saveconfig()
	{
		$rep['rep'] = TRUE;
		$rep['msg'] = $this->lang->line('network_config_start');
		
		$old = $this->siteconfigmodel->getConfig('coova_config');
		$data = $this->session->_unserialize($old->value);
		
		$_POST['lannet'] = substr_replace($_POST['ipaddress'], '0', strlen($_POST['ipaddress'])-1);
		$coova = array('value'=>$this->session->_serialize($_POST));

		$ip = explode(".", $this->input->ip_address());
		
		if($data['ipaddress']==$ip[0].'.'.$ip[1].'.'.$ip[2].'.1')
		{
			$rep['rep'] = FALSE;
			$rep['msg'] = $this->lang->line('network_config_notallow');
		}
		else 
		{
			if( ! $this->siteconfigmodel->write_config($_POST,$data))
			{
				$rep['rep'] = FALSE;
				$rep['msg'] = $this->lang->line('network_config_notwrite');
			}
		}
		
		if($rep['rep']) $this->siteconfigmodel->updateConfig('coova_config',$coova);

		print json_encode($rep);
	}
	
	function configchange()
	{
		$operate = $this->uri->segment(4);
		$service = $this->uri->segment(5);
		if($operate=='reconfig')
		{
			$data = $this->siteconfigmodel->serviceRestart($service);
		}
		
		if($operate=='stop')
		{
			$data = $this->siteconfigmodel->serviceStop($service);
		}
		
		print json_encode($data);
	}
	
}

/* End of file network.php */
/* Location: ./system/nostradius/controllers/admin/network.php */