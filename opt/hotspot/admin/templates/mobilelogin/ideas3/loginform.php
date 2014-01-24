<!-- websiteideas wrapper starts -->
<div class="websiteWrapper"> 
  
  <!-- main menu outer wrapper starts -->
  <div class="mainMenuOuterWrapper"> 
    <!-- main menu wrapper starts -->
    <ul class="mainMenuWrapper">
      <li class="mainMenuItemSlide currentPage"><a href="/hotspot/index.php/gologin" data-type="slide">Home</a></li>
      <li class="mainMenuItemSlide"><a href="/hotspot/index.php/signup" data-type="slide"><?=$this->lang->line('gologin_service_register') ?></a> </li>
      <li class="mainMenuItemSlide"><a href="/hotspot/index.php/dashboard" data-type="slide"><?=$this->lang->line('user_refill_header') ?></a></li>
      <li class="mainMenuItemSlide"><a href="/hotspot/index.php/topup" data-type="slide"><?=$this->lang->line('user_dashboard_topic1') ?></a></li>
      <li class="mainMenuItemSlide"><a href="/hotspot/index.php/clear" data-type="slide"><?=$this->lang->line('gologin_service_clearbutton') ?></a></li>
    </ul>
    <!-- mainideas menu wrapper ends --> 
  </div>
  <!-- mainideas menu outer wrapper ends --> 
  
  <!-- headerideas outer wrapper starts -->
  <div class="headerOuterWrapper">
    <div class="headerWrapper"> <a href="#" class="mainLogo"><img src="../templates/mobilelogin/ideas3/images/common/mainLogo.png" alt=""/></a> <a href="#" class="mainMenuButton"></a> </div>
  </div>
  <!-- headerideas outer wrapper ends --> 
  
  <!-- pageideas wrapper starts -->
  <div class="pageWrapper sectionWrapper homePageWrapper" id="homeSection"> 
    
    <!-- sliderideas wrapper starts -->
    <div class="sliderOuterWrapper">
      <div class="sliderWrapper">
        <div class="mainSlider" id="mainSlider"> <a href="#"><img src="../templates/mobilelogin/ideas3/images/content/slide-1.jpg" alt="" /></a> <a href="#"><img src="../templates/mobilelogin/ideas3/images/content/slide-2.jpg" alt="" /></a><a href="#"><img src="../templates/mobilelogin/ideas3/images/content/slide-3.jpg" alt="" /></a> <a href="#"><img src="../templates/mobilelogin/ideas3/images/content/slide-4.jpg" alt="" /></a><a href="#"><img src="../templates/mobilelogin/ideas3/images/content/slide-5.jpg" alt="" /></a></div>
      </div>
    </div>
    <!-- sliderideas wrapper ends --> 

    <!-- homeideas page content starts -->
    <div class="pageContentWrapper noBackground noPadding ">
    
    <div class="homeQuoteWrapper">
    <h2 class="homeQuote">"<strong style="font-size: 25px">Roman</strong> WiFi Hotspot Login"</h2>
	<center>
	<form action="{auth_url}" id="user_login" name="form1" method="post">
      <fieldset>
        <div class="formFieldWrap">
          <input class="contactField requiredField" id="username" name="UserName" type="text" placeholder="<?=$this->lang->line('username_login'); ?>" >
        </div>
        <div class="formFieldWrap">
          <input class="contactField" id="password" name="Password" type="password" placeholder="<?=$this->lang->line('password_login'); ?>">
        </div>
        <div class="formTextareaWrap">
          <div class="formSubmitButtonErrorsWrap">{message} </div>
            <!-- form errors end -->
            <button title="Login" class="homeQuoteButton" value='Login' type="submit"><?=$this->lang->line('button_login'); ?></button>
          </div>
          {hidden_form}
        </fieldset>
      </form>
	  </center>
	</div>


    <!-- accordionideas wrapper starts -->
      <div class="accordionWrapper"> 
        <!-- accordion item wrapper starts -->
        <div class="accordionItemWrapper"> <a href="#" class="accordionButton"><span class="accordionButtonIcon"></span><span class="accordionButtonTitle"><?=$this->lang->line('gologin_news_2') ?></span></a>
          <div class="accordionContentWrapper">
            <div class="accordionContent">
              <p>ผู้พัฒนา Thanainun Diawhathai</p>
            </div>
          </div>
		 </div>

        <!-- accordionideas item wrapper ends --> 

        <!-- accordionideas item wrapper starts -->
        <div class="accordionItemWrapper"> <a href="#" class="accordionButton"><span class="accordionButtonIcon"></span><span class="accordionButtonTitle"><?=$this->lang->line('contact_2') ?></span></a>
          <div class="accordionContentWrapper">
            <div class="accordionContent">
              <p>{login_footer}</p>

          </div>
        </div>
        <!-- accordionideas item wrapper ends --> 
      </div>
      <!-- accordionideas wrapper ends --> 
    </div>
    <!-- homeideas page content ends -->
   </div>  
  
