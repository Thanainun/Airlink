<?php if (!defined('BASEPATH')) exit('No direct script access allowed');
/**
 * Client
 *
 * Client Controller
 *
 * @package		client
 * @author		Nost radius
 * @version		1.0
 * @based on	Nost radius management
 * @license		GPL/GNU License Copyright (c) 2008 Nost Computer
 */

class Client extends MY_Admin
{

	function __construct()
	{
		parent::__construct();
		
		$this->load->model('siteconfigmodel');
		$this->load->helper('coova');
		
	}

	function index()
	{
		$data['numdhcp'] = count(get_dhcplist());

		$this->template	->add_css('datatable/table_jui.css?'._DATETIME)
						->add_js('datatable/jquery.dataTables.min.js?'._DATETIME)
						->add_js('datatable/dhcplist.js?'._DATETIME)
						->write_view('left-content', 'admin/client/client_view',$data)
						->render();
	}

	function action()
	{
	
		$action = $this->uri->segment(5);
		$opt = $this->uri->segment(4);

		foreach(get_dhcplist() as $data)
		{
			if($data['sessionid']==$action)
			{
				$_mac = $data['mac'];
				$act_to = ($opt=='authorize') ? $action : $_mac;
			}
		}
		
		$up = NULL;
		$dn = NULL;
		$ac = NULL;
		$us = 'BP-'.strtoupper(random_string('alnum', 4));
		if($opt=='authorize')
		{
			//โหลดค่า
			$global = $this->siteconfigmodel->getConfig('chilli_query');
			$val = $this->session->_unserialize($global->value);
			$up = $val['bw_upload'];
			$dn = $val['bw_download'];
			$ac = $val['acct_status'];
		}
		
		if(operation($opt, $act_to, $us, $up, $dn, $ac))
		{
			switch($opt)
			{
				case 'block' :
					$this->siteconfigmodel->clearAlllist($_mac);
					$this->siteconfigmodel->updateBlocklist($_mac);
				break;
				case 'release' :
					$this->siteconfigmodel->clearAlllist($_mac);
				break;
				case 'authorize' :
					$this->siteconfigmodel->clearAlllist($_mac);
					$this->siteconfigmodel->updateAllowlist($_mac);
				break;
				case 'wallgarden' :
					$this->siteconfigmodel->clearAlllist($_mac);
					$this->siteconfigmodel->updateAllowlist($_mac);
				break;
				case 'disconnect' :
					$this->siteconfigmodel->clearAlllist($_mac);
				break;
			}

		}

		redirect('admin/client');

	}

	function json()
	{
		$output = array("aaData" => array());

		$count = 1;
		foreach(get_dhcplist() as $data)
		{
	
			$jdata = array();

			if($data['status']=="pass") 
			{ 
			$status = 'Online'; $color = "btn btn-small btn-primary"; 
			
			} 
			
			else if($data['status']=="dnat") {
				 
				 $status = 'Offline'; $color = "btn btn-small btn-warning"; } 
				 
				 else if($data['status']=="drop") 
				 
				 { $status = 'Block'; $color = "btn btn-small"; } 
				 
				 else { $status = 'Release..'; $color = "btn btn-small btn-success"; }
				 
			if($data['ip']=="0.0.0.0" || $data['status']=="drop") 
			
			{ $ipaddress = $data['ip']; $auth = ' '; } 
			
			else { $ipaddress = $data['ip']; $auth = anchor('admin/client/action/authorize/'.$data['sessionid'],img(ASSETS.'images/unplug.png'),'title="Bypass" class="action"'); }
			$jdata[] .= $count++;
			$jdata[] .= $data['username'];
			$jdata[] .= $ipaddress;
			$jdata[] .= $data['mac'];
			$jdata[] .= $data['bandwidth_down'];
			$jdata[] .= $data['bandwidth_up'];
			$jdata[] .= $data['idletimeout'];
			$jdata[] .= '<div id="status" class="'.$color.'">'.$status.'</div>';
			$jdata[] .= (($status=='Block') ? ' ' : anchor('admin/client/action/block/'.$data['sessionid'],img(ASSETS.'images/backlist.png'),'title="Block" class="action"')).' '
			.(($data['status']=="pass") ? anchor('admin/client/action/disconnect/'.$data['sessionid'],img(ASSETS.'images/plug.png'),'title="Disconnect" class="action"') : $auth).' '
			.anchor('admin/client/action/release/'.$data['sessionid'], img(ASSETS.'images/rotate_c.gif'), 'title="Release" class="action"');

			$output['aaData'][] = $jdata;

		}

		$this->output->enable_profiler(FALSE);
		
		print json_encode($output);

	}
	
	function getfrom()
	{

		//โหลดค่า
		$global = $this->siteconfigmodel->getConfig('chilli_query');
		$val = $this->session->_unserialize($global->value);

		if(!isset($_POST['bw_download'])) $this->load->view('admin/client/setup_from', $val);
		
		if(isset($_POST['bw_download']))
		{
			$conf_data = array('value'=>$this->session->_serialize($_POST));
			$this->siteconfigmodel->updateConfig('chilli_query', $conf_data);
			print "บันทึกการตั้งค่าแล้ว";
		}
	}
	
	function help()
	{
		$data['head'] = "วิธีการใช้งาน";
		$data['content'] = "<p>Dhcp list</p>";
		
		$this->output->enable_profiler(FALSE);
		$this->load->view('admin/help', $data);
	}

}
/* End of file client.php */
/* Location: ./system/nostradius/controllers/admin/client.php */