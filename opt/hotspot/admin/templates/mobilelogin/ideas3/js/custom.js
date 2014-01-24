/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/
/*//////////////////// Variables Start                                                                                    */
/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/
var $ = jQuery.noConflict();
/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/
/*//////////////////// Variables End                                                                                      */
/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/



/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/
/*//////////////////// Document Ready Function Starts                                                                     */
/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/
jQuery(document).ready(function($){
			
	
	
	// initial settings start
	var mainMenuStatus = 'closed';
	var mainMenuAnimation = 'complete';
	var mainMenuHeight = $('.mainMenuWrapper').outerHeight();
	
	var slideTo = '';
	var slideValue = 0;
	var currentSection = '';	
	var windowWidth = $(window).width() - 48;
		
	var lightboxInitialWidth = windowWidth;
	var lightboxInitialHeight = 220;
	// initial settings end
	
	
	
	// main menu functions start
	$('.mainMenuButton').click(function(){
		
		mainMenuHeight = $('.mainMenuWrapper').outerHeight();
		
		if(mainMenuStatus == 'closed' && mainMenuAnimation == 'complete'){
			
			mainMenuAnimation = 'incomplete';
			
			adaptMainMenu();
			
			$('.mainMenuOuterWrapper').css({'top' : 0, 'display' : 'none'});
			
			$('.mainMenuOuterWrapper').stop(true, true).fadeIn(300, 'easeOutQuart', function(){mainMenuStatus = 'open'; mainMenuAnimation = 'complete';});
			
		}else if(mainMenuStatus == 'open' && mainMenuAnimation == 'complete'){
			
			mainMenuAnimation = 'incomplete';
			
			$('.mainMenuOuterWrapper').stop(true, true).fadeOut(300, 'easeOutCubic', function(){mainMenuStatus = 'closed'; mainMenuAnimation = 'complete'; $('.mainMenuOuterWrapper').css({'top' : '-100%', 'display' : 'block'});
				
			});
		
		};
		
		return false;
	});	
	
	$('.mainMenuWrapper > li > a').click(function(){
		
		if($(this).attr('data-type') == 'slide'){
			
			mainMenuAnimation = 'incomplete';
			
			$('.mainMenuOuterWrapper').stop(true, true).fadeOut(300, 'easeOutCubic', function(){mainMenuStatus = 'closed'; mainMenuAnimation = 'complete';});
			
			$('.currentPage').removeClass('currentPage');
			
			$(this).parent().addClass('currentPage');
			
			slideTo = $(this).attr('href');
	    			
			slideValue = $(slideTo).offset().top;
			
			$('html, body').stop(true, true).animate({scrollTop: slideValue}, 1200, 'easeOutCubic');
			
			return false;
		
		};
		
	});
	// main menu functions end	
	
	
	
	// adapt pages function starts
	function adaptPages(){
		
		$('.pageWrapper').css('min-height', $(window).height());
		
	};
	
	adaptPages();
	// adapt pages function ends
	
	
	
	// adapt portfolio function starts
	function adaptPortfolio(){
		
		$('.portfolioTwoFilterableWrapper .portfolioFilterableItemsWrapper').css('width', $('.portfolioTwoFilterableWrapper').width() + 36);
		
		var portfolioTwoFilterableItemWidth = ($('.portfolioTwoFilterableWrapper').width()  - 36)/2;
		
		$('.portfolioTwoFilterableWrapper .portfolioFilterableItemWrapper').css('width', portfolioTwoFilterableItemWidth);
		
	};
	
	adaptPortfolio();
	// adapt portfolio function ends
	
	
	
	// adapt main menu function starts
	function adaptMainMenu(){
		
		mainMenuHeight = $('.mainMenuWrapper').outerHeight();
		
		if($('.websiteWrapper').height() < mainMenuHeight){
			
			$('.websiteWrapper').css('min-height', mainMenuHeight);
			
		};
		
		if( $('.mainMenuOuterWrapper').height() - $('.headerOuterWrapper').offset().top >= mainMenuHeight){
				
				$('.mainMenuWrapper').css('top', $('.headerOuterWrapper').offset().top);
			
		}else{
				
			$('.mainMenuWrapper').css('top',   $('.websiteWrapper').height() - mainMenuHeight);
				
		};
		
	};
	
	adaptMainMenu();
	// adapt main menu function ends
	
	
	
	// next page button functions start
	$('.nextPageButton').click(function(){
		
		slideTo = $(this).attr('href');
	    		
	    slideValue = $(slideTo).offset().top;
		
		$('html, body').stop(true, true).animate({scrollTop: slideValue}, 1200, 'easeOutCubic', function(){
			
			$('.currentPage').removeClass('currentPage');
			
			$('.mainMenuWrapper').find('> li > a[href="' + slideTo + '"]').parent().addClass('currentPage');
		
		});
		
		return false;
		
	});
	// next page button functions end
	
	
	
	// filterable portfolio functions start
	$('#portfolioMenuWrapper > li > a').click(function(){
		
		var filterVal = $(this).attr('data-type');
		
		if(filterVal != 'all'){
			
			$('.currentPortfolioFilter').removeClass('currentPortfolioFilter');
			
			$(this).addClass('currentPortfolioFilter');
			
			$('.portfolioFilterableItemWrapper').each(function(){
	            
				var itemCategories = $(this).attr("data-type").split(",");
				  
				if($.inArray(filterVal, itemCategories) > -1){
					
					$(this).addClass('filteredPortfolioItem');
					
					$('.filteredPortfolioItem').stop(true, true).animate({opacity:1}, 300, 'easeOutCubic');
					
				}else{
						
					$(this).removeClass('filteredPortfolioItem');
					
					if(!$(this).hasClass('filteredPortfolioItem')){
						
						$(this).stop(true, true).animate({opacity:0.3}, 300, 'easeOutCubic');
					
					};
					
				};
					
			});
		
		}else{
			
			$('.currentPortfolioFilter').removeClass('currentPortfolioFilter');
			
			$(this).addClass('currentPortfolioFilter');
			
			$('.filteredPortfolioItem').removeClass('filteredPortfolioItem');
			
			$('.portfolioFilterableItemWrapper').stop(true, true).animate({opacity:1}, 300, 'easeOutCubic');
			
		}
			
		return false;
	
	});
	// filterable portfolio functions end
	
	
	
	// alert box widget function starts
	$('.alertBoxButton').click(function(){
		
		$(this).parent().fadeOut(300, function(){$(this).remove();});
		
		return false;
		
	});
	// alert box widget function ends
	
	
	
	// accordion widget function starts
	$('.accordionButton').click(function(e){
		 
		if($(this).hasClass('currentAccordion')){
			
			 $(this).parent().find('.accordionContentWrapper').stop(true, true).animate({height:'hide'}, 300, 'easeOutCubic', function(){$(this).parent().find('.accordionButton').removeClass('currentAccordion');});
			 
		}else{
			 
			$(this).parent().find('.accordionContentWrapper').stop(true, true).animate({height:'show'}, 300, 'easeOutCubic', function(){$(this).parent().find('.accordionButton').addClass('currentAccordion');});
		 
        };
		 
		return false;
		
	});
	// accordion widget function ends

	
	
	// back to top functions starts
	function backToTop(){
		
		if($('.homePageWrapper').length >= 1){
			
			$('.currentPage').removeClass('currentPage');
				
			$('.mainMenuWrapper > li:first-child').addClass('currentPage');
		
		};
		
		$('body, html').stop(true, true).animate({scrollTop: 0}, 1200, 'easeOutCubic'); 
		
	};
	
	$('.backToTopButton').click(function(){
								   
	    backToTop();
		
		return false;
	
    });
	// back to top functions ends 
	
	
	
	// window scroll function starts
	$(window).scroll(function(){
		
		if($('.headerOuterWrapper').offset().top < $('.mainMenuWrapper').offset().top){
			
			$('.mainMenuWrapper').css('top', $('.headerOuterWrapper').offset().top);
			
		};
		
	});
	// window scroll function ends
	
	
	
	// window resize functions start
	$(window).resize(function(){
		
		windowWidth = $(window).width() - 48;
		
		lightboxInitialWidth = windowWidth;
		
		lightbox();
		
		adaptPages();
		
		adaptPortfolio();
							
		adaptMainMenu();
									
	});
	// window resize functions end
	
	
	
	// nivo slider functions start
	$('#mainSlider').nivoSlider({
		
		controlNav: false,
		prevText: '',
        nextText: '' 
		
	});
	// nivo slider functions end
	
	
	
	// lightbox functions start
	function lightbox(){
		
		$('.portfolioFilterableItemImageWrapper').colorbox({
		
			maxWidth: windowWidth,
			initialWidth: lightboxInitialWidth,
			initialHeight: lightboxInitialHeight
			
		});
		
	};
	
	lightbox();
	// lightbox functions end



});
/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/
/*//////////////////// Document Ready Function Ends                                                                       */
/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/