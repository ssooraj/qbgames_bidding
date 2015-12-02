jQuery(document).ready(function($){
    //final width --> this is the quick view image slider width
    //maxQuickWidth --> this is the max-width of the quick-view panel
    var sliderFinalWidth = 400,
        maxQuickWidth = 900;

    //open the quick view panel
    $('body').on('click','.cd-trigger1' ,function(event){
        var selectedImage = $(this).parent('.cd-item1').children('img'),
            slectedImageUrl = selectedImage.attr('src');
        data = {id: $(this).parent('.cd-item1').children('img').attr('name')};
        animateQuickView1(selectedImage, sliderFinalWidth, maxQuickWidth, 'open');
        $.ajax({
            url: '/players/get_player_details',
            crossDomain: true,
            data: data,
            async: false,
            success: function (response) {
                $('.cd-item-info').children('h2').text(response.player_name);
                $('.cd-item-info').children('#cricket').remove();
                $('.cd-item-info').children('#football').remove();
                $('.cd-item-info').children('#badminton').remove();
                if( response.sex != '' ) {
                    $('.cd-item-info').children('#sex').text(response.sex);
                }else {
                    $('.cd-item-info').children('#sex').text('');
                }
                if( response.team_name != '' ) {
                    $('.cd-item-info').children('#team').text('Team: '+ response.team_name);
                }else {
                    $('.cd-item-info').children('#team').text('');
                }
                base = response.base;
                if( response.base ) {
                    $('.cd-item-info').children('#base-price').text('Base Price: $ '+ base);
                }

                if( response.cricket ) {
                    $('.cd-item-info').append('<img src="/assets/blank.png" id="cricket" >');
                    $('.cd-item-info').children('#cricket').attr('src', '/assets/Cricket.png');
                }else {
                    $('.cd-item-info').children('#cricket').remove();
                }
                if( response.football ) {
                    console.log(response);
                    $('.cd-item-info').append('<img src="/assets/blank.png" id="football" >');
                    $('.cd-item-info').children('#football').attr('src', '/assets/Soccer.png');
                }else {
                    $('.cd-item-info').children('#football').remove();
                }
                if( response.badminton ) {
                    $('.cd-item-info').append('<img src="/assets/blank.png" id="badminton" >');
                    $('.cd-item-info').children('#badminton').attr('src', '/assets/Badminton.png');
                }else {
                    $('.cd-item-info').children('#badminton').remove();
                }
                if( response.star ) {
                    $('.cd-item-info').children('#stars').attr('src', '/assets/star.png');
                }else {
                    $('.cd-item-info').children('#stars').attr('src', '/assets/blank.png');
                }
                if( response.sold ) {
                    sold = response.sold;
                    $('.cd-item-info').children('#sold-price').text('Sold Price: $ '+ sold);
                }
                if( response.status ) {

                    $('.cd-item-info').children('#status').remove();
                    //$('.cd-item-info').children('#status').attr('class', 'sold');
                }else {
                    $('.cd-item-info').children('#status').remove();
                    //$('.cd-item-info').children('#status').attr('class', 'notsold');
                }
            },
            error: function(xhr, status, errorThrown) {
                console.log(errorThrown);
            }
        });
        $('.cd-slider').children('li').children('img').attr('src', slectedImageUrl);
        $('body').addClass('overlay-layer');
        //update the visible slider image in the quick view panel
        //you don't need to implement/use the updateQuickView if retrieving the quick view data with ajax
        updateQuickView1(slectedImageUrl);
    });

    //close the quick view panel
    $('body').on('click', function(event){
        if( $(event.target).is('.cd-close') || $(event.target).is('body.overlay-layer')) {
            closeQuickView1( sliderFinalWidth, maxQuickWidth);
        }
    });
    $(document).keyup(function(event){
        //check if user has pressed 'Esc'
        if(event.which=='27'){
            closeQuickView1( sliderFinalWidth, maxQuickWidth);
        }
    });

    //quick view slider implementation
    $('.cd-quick-view').on('click', '.cd-slider-navigation a', function(){
        updateSlider1($(this));
    });

    //center quick-view on window resize
    $(window).on('resize', function(){
        if($('.cd-quick-view').hasClass('is-visible')){
            window.requestAnimationFrame(resizeQuickView1);
        }
    });

    function updateSlider1(navigation) {
        var sliderConatiner = navigation.parents('.cd-slider-wrapper').find('.cd-slider'),
            activeSlider = sliderConatiner.children('.selected').removeClass('selected');
        if ( navigation.hasClass('cd-next') ) {
            ( !activeSlider.is(':last-child') ) ? activeSlider.next().addClass('selected') : sliderConatiner.children('li').eq(0).addClass('selected');
        } else {
            ( !activeSlider.is(':first-child') ) ? activeSlider.prev().addClass('selected') : sliderConatiner.children('li').last().addClass('selected');
        }
    }

    function updateQuickView1(url) {
        $('.cd-quick-view .cd-slider li').removeClass('selected').find('img[src="'+ url +'"]').parent('li').addClass('selected');
    }

    function resizeQuickView1() {
        var quickViewLeft = ($(window).width() - $('.cd-quick-view').width())/2,
            quickViewTop = ($(window).height() - $('.cd-quick-view').height())/2;
        $('.cd-quick-view').css({
            "top": quickViewTop,
            "left": quickViewLeft,
        });
    }

    function closeQuickView1(finalWidth, maxQuickWidth) {
        var close = $('.cd-close'),
            activeSliderUrl = close.siblings('.cd-slider-wrapper').find('.selected img').attr('src'),
            selectedImage = $('.empty-box').find('img');
        //update the image in the gallery
        if( !$('.cd-quick-view').hasClass('velocity-animating') && $('.cd-quick-view').hasClass('add-content')) {
            selectedImage.attr('src', activeSliderUrl);
            $('.cric-img').attr('src', '/assets/Cricket.png');
            $('.foot-img').attr('src', '/assets/Soccer.png');
            $('.bad-img').attr('src', '/assets/Badminton.png');
            $('.star-img').attr('src', '/assets/star.png');
            animateQuickView1(selectedImage, finalWidth, maxQuickWidth, 'close');
        } else {
            closeNoAnimation1(selectedImage, finalWidth, maxQuickWidth);
        }
    }

    function animateQuickView1(image, finalWidth, maxQuickWidth, animationType) {
        //store some image data (width, top position, ...)
        //store window data to calculate quick view panel position
        var parentListItem = image.parent('.cd-item1'),
            topSelected = image.offset().top - $(window).scrollTop(),
            leftSelected = image.offset().left,
            widthSelected = image.width(),
            heightSelected = image.height(),
            windowWidth = $(window).width(),
            windowHeight = $(window).height(),
            finalLeft = (windowWidth - finalWidth)/2,
            finalHeight = finalWidth * heightSelected/widthSelected,
            finalTop = (windowHeight - finalHeight)/2,
            quickViewWidth = ( windowWidth * .8 < maxQuickWidth ) ? windowWidth * .8 : maxQuickWidth ,
            quickViewLeft = (windowWidth - quickViewWidth)/2;

        if( animationType == 'open') {
            //hide the image in the gallery
            parentListItem.addClass('empty-box');
            //place the quick view over the image gallery and give it the dimension of the gallery image
            $('.cd-quick-view').css({
                "top": topSelected,
                "left": leftSelected,
                "width": widthSelected,
            }).velocity({
                //animate the quick view: animate its width and center it in the viewport
                //during this animation, only the slider image is visible
                'top': finalTop+ 'px',
                'left': finalLeft+'px',
                'width': finalWidth+'px',
            }, 100, [ 100, 10 ], function(){
                //animate the quick view: animate its width to the final value
                $('.cd-quick-view').addClass('animate-width').velocity({
                    'left': quickViewLeft+'px',
                    'width': quickViewWidth+'px',
                }, 200, 'ease' ,function(){
                    //show quick view content
                    $('.cd-quick-view').addClass('add-content');
                });
            }).addClass('is-visible');
        } else {
            //close the quick view reverting the animation
            $('.cd-quick-view').removeClass('add-content').velocity({
                'top': finalTop+ 'px',
                'left': finalLeft+'px',
                'width': finalWidth+'px',
            }, 50, 'ease', function(){
                $('body').removeClass('overlay-layer');
                $('.cd-quick-view').removeClass('animate-width').velocity({
                    "top": topSelected,
                    "left": leftSelected,
                    "width": widthSelected,
                }, 50, 'ease', function(){
                    $('.cd-quick-view').removeClass('is-visible');
                    parentListItem.removeClass('empty-box');
                });
            });
        }
    }
    function closeNoAnimation1(image, finalWidth, maxQuickWidth) {
        var parentListItem = image.parent('.cd-item1'),
            topSelected = image.offset().top - $(window).scrollTop(),
            leftSelected = image.offset().left,
            widthSelected = image.width();

        //close the quick view reverting the animation
        $('body').removeClass('overlay-layer');
        parentListItem.removeClass('empty-box');
        $('.cd-quick-view').velocity("stop").removeClass('add-content animate-width is-visible').css({
            "top": topSelected,
            "left": leftSelected,
            "width": widthSelected,
        });
    }
});