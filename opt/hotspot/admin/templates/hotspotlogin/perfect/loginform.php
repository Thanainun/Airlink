
<script>
	 $(function() {
    $( "#dialog" ).dialog({
	  height: 800,
	  width: 800,
	   top:80,
      autoOpen: false,
      show: {
        effect: "blind",
        duration: 500,
		
      },
      hide: {
        effect: "blind",
        duration: 500
      }
    });
 
    $( "#help" ).click(function() {
      $( "#dialog" ).dialog( "open" );
	  
    });
  });
</script>

	<!-- BEGIN HEADER -->
		<header>
			<h1>DuyDui</h1>
			<h3>WiFi Hotspot</h3>
		</header>
		<!-- // END HEADER -->
		<header class="login">
                    <form action="/hotspot/index.php/gologin" id="" name="form1" method="post" class="validate default-form various-content">
							<p>
							 <input class="input field primary" id="username" name="UserName" type="text" placeholder="<?=$this->lang->line('username_login'); ?>"></p><br />
                             
                              <input class="input field primary" id="password" name="Password" type="password" placeholder="<?=$this->lang->line('password_login'); ?>">
                               <p>
                                 <input name="is_remember" checked="checked" type="checkbox" ><label for="is_remember">Remember Me</label>
                                            </p>   <br />
								<button title="Login" class="btn btn-small btn-primary " value='' type="submit"><?=$this->lang->line('button_login'); ?></button>
					
                                                    <div style="color:red;" rel="reply" class="total_members">{message}</div>
                        </form>
                        
        
        
        
        </header>
		<!-- BEGIN BODY -->
		<section id="bottom">
		
			<!-- BEGIN SOCIAL -->
			<div id="social"> 
				<div>
					<span>ติดตามเราได้ที่</span>
					<ul>
						<li class="twitter"><a href="<?= $twitter ?>" target="_blank"></a></li>
						<li class="facebook"><a href="<?= $facebook ?>" target="_blank"></a></li>
					</ul>
					<span>อ่าน <a href="#" id="help">ประกาศและข่าวสาร</a>&nbsp; :  <?=anchor("gologin/languser/thai","<span>ภาษาไทย</span>");?> &nbsp; <?=anchor("gologin/languser/english","<span>English</span>");?></span>
				</div>
			</div>
			<!-- // END SOCIAL -->
			
			
		</section>
		<!-- // END BODY -->
		
		<div id="pattern"></div>
		<div id="ct" style="display:none"></div>
        
         <div id="dialog" title="Announcements">
         {login_content}
        
        </div>
        
        
        
        
        
        
        
        
