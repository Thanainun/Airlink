
  
 <br />
<div class="span12">
<div class="widget_container serverinfo">
Date :<?=$datetime ?>  <strong>Hostname</strong> : <?=$serverinfo ?>  <strong>Server Uptime</strong> : <?=$serverup ?> <strong>Interface</strong> :<? foreach ($ifinfo as $ifname) {echo "$ifname&nbsp;" ; } ?>  <strong>Kernel V. <?php $kv = shell_exec('uname -r'); echo $kv ?></strong><span class="right"> <a href="sysinfo" class="btn btn-small btn-primary">system information</a></span>
</div>
</div>
<div class="span7">  
 <div class="widget_heading">
	<h4>การใช้ทรัพยากร Server</h4></div>
    <div class="widget_container">
    <dt><ld id="cpu_load"></ld><?="/100%";?></dt>
    <dd><div id="cpu_color" class="progress"><span id="progress_bar" class="cpu_perc" style="width:0%"><b>0%</b></span></div></dd>
    <dt>แรม :<ld id="memory_usage"></ld>/<?=$momory_total?></dt>
    <dd><div id="mem_color" class="progress progress-blue"><span id="progress_bar" class="memory_perc" style="width:0%"><b>0%</b></span></div></dd>
    <dt>ฮาดร์ดิส: <ld id="hdd_free_space"></ld>/<?=$hdd_total_space?></dt>
    <dd><div id="hdd_color" class="progress progress-orange"><span id="progress_bar" class="hdd_perc" style="width:0%"><b>0%</b></span></div></dd>
</dl>
</div>
</div>
 
   <div class="span5">   
 <div class="widget_heading">
	<h4>จัดการงานบริการ</h4></div>
    <div class="widget_container">
   
  <p>
    <a href="dashboard/Shutdown" id="halt" class="confirm btn btn-large btn-danger"><i class="icon-off"></i>ShutDown</a>
    <a href="dashboard/Restart" class="confirm btn btn-large btn-danger"><i class="icon-thumbs-up"></i>Restart</a>
    <a href="dashboard/Clear" class="confirm btn btn-large btn-warning"><i class="icon-warning-sign"></i>Clear Memory</a>

  </p>
  <p>
    <a href="dashboard/Squid" class="confirm btn btn-small btn-primary"><i class="icon-exchange"></i>SQUID Restart</a>
    <a href="dashboard/Webserver" class="confirm btn btn-small btn-primary"><i class="icon-cloud"></i>HTTP Restart</a>
    <a href="dashboard/Radius" class="confirm btn btn-small btn-primary"><i class="icon-asterisk"></i>RADIUS Restart</a>
  </p>
  <p>
   	<a href="dashboard/Network" class="confirm btn btn-small btn-success"><i class="icon-linux"></i>Network Restart</a>
    <a href="dashboard/Firewall" class="confirm btn btn-small btn-success"><i class="icon-adn"></i>Firewall Restart</a>
    <a href="dashboard/Coova" class="confirm btn btn btn-small btn-success"><i class="icon-random"></i>Coova Reload</a>
 </p>

</div>
</div>  
<script>
$(".confirm").easyconfirm();
$("#alert").click(function() {
	alert("You approved the action");
});
</script>  

