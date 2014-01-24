<?php if (!defined('BASEPATH')) exit('No direct script access allowed');
/**
 * Server
 *
 * Server Controller
 *
 * @package		server
 * @author		Nost radius
 * @version		1.0
 * @based on	Nost radius management
 * @license		GPL/GNU License Copyright (c) 2008 Nost Computer
 */
Class Server extends CI_Controller

{
	function __construct()
	{
		parent::__construct();

		$this->load->library('cpuload');
		$this->cpuload->get_load();
		
	}

	function index()
	{
		$this->load->helper('server');
		$tr = getBandwidth();
		print_r ($tr[3]);
	}
	
	
	
	function status()
	{
		$this->load->helper('number');
		$this->load->helper('serverinfo');
		$this->load->helper('server');
		
		//Hdd info
		$perc =  round((disk_free_space("/")*100) / disk_total_space("/"),2);
		$hddperc = 100 - $perc;

		$mem_array = get_memory();

		$memperc = round(($mem_array['Inactive']*100) / $mem_array['MemTotal'],2);

		$load = sprintf("%.1f",$this->cpuload->load["cpu"]);

		$data = array(	'cpu_load'=>sprintf("ซีพียู : %.1f%%",100-$this->cpuload->load["idle"]),
						'cpu_perc'=>sprintf("%.1f",$this->cpuload->load["cpu"]),
						'memory_usage'=>byte_format($mem_array['Inactive']*1024),
						'momory_total'=>byte_format($mem_array['MemTotal']*1024),
						'memory_perc'=>$memperc,
						'hdd_total_space'=>byte_format(disk_total_space("/")),
						'hdd_free_space'=>byte_format(disk_total_space("/")-disk_free_space("/")),
						'hdd_perc'=>$hddperc
					);

		print json_encode($data);
	}

	
}
