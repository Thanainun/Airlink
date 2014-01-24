<?php
$username = array(
	'name'	=> 'user',
	'id'	=> 'user',
	'value' => set_value('username'),
	'size' 	=> 10,
);
$password = array(
	'name'	=> 'pass',
	'id'	=> 'pass',
	'maxlength'	=> $this->config->item('password_max_length', 'tank_auth'),
	'size'	=> 10,
);

?>
<body>
                            
     <div class="navbar transparent navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
            <a class="brand" href="dashboard">
                <strong><?=$logo ?></strong>
            </a>
            <div class="nav-collapse collapse">
                <ul class="nav pull-right">
                 
                  <li><?=anchor("dashboard/languser/thai","<span>ภาษาไทย</span>");?></li> 
                  <li><?=anchor("dashboard/languser/english","<span>English</span>");?></li>
                </ul>
            </div>
        </div>
      </div>
    </div>
          <div class="container">    
          <div class="row contact"> 
          	<div class="span6">
            <div class="row-fluid">    
						<?=form_open('dashboard/loginuser','id="form" class="validate default-form various-content"')?>
						
							<h3><?=$this->lang->line('user_refill_header') ?></h3>
                            <div class="text">
								<?=form_input(array('name'=>'user','type'=>'text','minlength'=>'13'),'',' autocomplete="off" title="ชื่อผู้ใช้เดิมที่จะเติม" placeholder='.$this->lang->line('user_refill_u').' required="required" id="user"' )?>
						   
								<?=form_input(array('name'=>'pass','type'=>'password','minlength'=>'13'),'',' autocomplete="off" title="รหัสเดิมที่จะเติม" placeholder='.$this->lang->line('user_refill_p').' required="required" id="pass"')?>
							    
						 
						<?php echo form_submit('login', $this->lang->line('user_refill_button').'','class="button big style2"'); ?>
	
					
						<?php echo form_close(); ?>
              </div>
              </div>
              </div>
              <div class="span6">
              <div class="row-fluid">

              
                  
                        	 <h3><?=$this->lang->line('user_dashboard_head') ?></h3>
                             <ul>
                       <li><?=$this->lang->line('user_dashboard_topic1') ?></li>
                          <li><?=$this->lang->line('user_dashboard_topic2') ?></li>
                         <li><?=$this->lang->line('user_dashboard_topic3') ?></li>
                          <li><?=$this->lang->line('user_dashboard_topic4') ?></li>
                         <li><?=$this->lang->line('user_dashboard_topic5') ?></li>
                           <li><?=$this->lang->line('user_dashboard_topic6') ?></li>
                        </ul>
                         <button class="submit button style2">ลงทะเบียน</button> <button class="submit button style1">ลืมรหัสผ่าน</button> <button class="submit button style1">Go login</button>
                        </div>
                        </div>
                  
                  
        </div>

</div>
</body>
