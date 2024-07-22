/*  ---------------------------------------------------
    Template Name: Aler
    Description:  Aler property HTML Template
    Author: Colorlib
    Author URI: https://colorlib.com
    Version: 1.0
    Created: Colorlib
---------------------------------------------------------  */

'use strict';

(function ($) {

    /*------------------
        Preloader
    --------------------*/
    $(window).on('load', function () {
        $(".loader").fadeOut();
        $("#preloder").delay(200).fadeOut("slow");

        /*------------------
            Property filter
        --------------------*/
        $('.property-controls li').on('click', function () {
            $('.property-controls li').removeClass('active');
            $(this).addClass('active');
        });
        if ($('.property-filter').length > 0) {
            var containerEl = document.querySelector('.property-filter');
            var mixer = mixitup(containerEl);
        }
    });

    /*------------------
        Background Set
    --------------------*/
    $('.set-bg').each(function () {
        var bg = $(this).data('setbg');
        $(this).css('background-image', 'url(' + bg + ')');
    });

    //Canvas Menu
    $(".canvas-open").on('click', function () {
        $(".offcanvas-menu-wrapper").addClass("show-offcanvas-menu-wrapper");
        $(".offcanvas-menu-overlay").addClass("active");
    });

    $(".canvas-close, .offcanvas-menu-overlay").on('click', function () {
        $(".offcanvas-menu-wrapper").removeClass("show-offcanvas-menu-wrapper");
        $(".offcanvas-menu-overlay").removeClass("active");
    });

    /*------------------
		Navigation
	--------------------*/
    $(".nav-menu").slicknav({
        prependTo: '#mobile-menu-wrap',
        allowParentLinks: true
    });

    /*------------------
        Carousel Slider
    --------------------*/
    var hero_s = $(".hs-slider");
    hero_s.owlCarousel({
        loop: true,
        margin: 20,
        nav: true,
        items: 1,
        dots: false,
        navText: ['<i class="arrow_left"></i>', '<i class="arrow_right"></i>'],
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: true
    });

    /*------------------
        Team Slider
    --------------------*/
    $(".fp-slider").owlCarousel({
        loop: true,
        margin: 0,
        items: 1,
        dots: false,
        nav: true,
        animateOut: 'fadeOut',
        animateIn: 'fadeIn',
        navText: ['<i class="arrow_left"></i>', '<i class="arrow_right"></i>'],
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: true
    });

    /*------------------
        Testimonial Slider
    --------------------*/
    $(".testimonial-slider").owlCarousel({
        loop: true,
        margin: 0,
        items: 2,
        dots: false,
        nav: true,
        navText: ['<i class="arrow_left"></i>', '<i class="arrow_right"></i>'],
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: true,
        responsive: {
            0: {
                items: 1
            },
            768: {
                items: 2
            }
        }
    });

    /*------------------
        Logo Slider
    --------------------*/
    $(".lc-slider").owlCarousel({
        loop: true,
        margin: 115,
        items: 6,
        dots: false,
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: true,
        responsive: {
            0: {
                items: 2
            },
            480: {
                items: 3
            },
            768: {
                items: 4
            },
            992: {
                items: 5
            },
            1200: {
                items: 6
            }
        }
    });

    /*------------------------
        Property pic slider
    -------------------------*/
    $(".property-pic-slider").owlCarousel({
        loop: true,
        margin: 0,
        items: 1,
        dots: false,
        nav: true,
        navText: ['<i class="arrow_left"></i>', '<i class="arrow_right"></i>'],
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: true
    });

    /*------------------------
        Sidebar Feature slider
    -------------------------*/
    $(".sf-slider").owlCarousel({
        loop: true,
        margin: 0,
        items: 1,
        dots: true,
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: true
    });

    /*------------------------
        Agent slider
    -------------------------*/
    $(".as-slider").owlCarousel({
        loop: true,
        margin: 0,
        items: 1,
        dots: false,
        nav: true,
        navText: ['<i class="arrow_left"></i>', '<i class="arrow_right"></i>'],
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: true
    });

    /*------------------
        Video Popup
    --------------------*/
    $('.video-popup').magnificPopup({
        type: 'iframe'
    });

    /*------------------
        Nice Select
    --------------------*/
    $('select').niceSelect();

    /*-------------------
		Radio Btn
	--------------------- */
    $(".cb-item label").on('click', function () {
        $(".cb-item label").removeClass('active');
        $(this).addClass('active');
    });

    /*-------------------
		Range Wrap
	--------------------- */

    //room size (compra)
    $("#roomsize-range").slider({
        range: true,
        min: 0,
        max: 4000,
        step: 200,
        values: [0, 1200],
        slide: function (event, ui) {
            $("#roomsizeRange").val("[" + ui.values[0] + "-" + ui.values[1] + "]" + "");
            $("#tamanhoMenor").val(ui.values[0]);
            $("#tamanhoMaior").val(ui.values[1]);
        }
    });
    $("#roomsizeRange").val("[" + $("#roomsize-range").slider("values", 0) + "-" + $("#roomsize-range").slider("values", 1) + "]" + "");
    $("#tamanhoMenor").val($("#roomsize-range").slider("values", 0));
    $("#tamanhoMaior").val($("#roomsize-range").slider("values", 1));

    //price range
    $("#price-range-aluguel").slider({
        range: true,
        min: 0,
        max: 2500,
        step: 100,
        values: [400, 1200],
        slide: function (event, ui) {
            $("#priceRangeAluguel").val("[ " + ui.values[0] + " - " + ui.values[1] + " ]" + " R$");
            $("#valorMenorAluguel").val(ui.values[0]);
            $("#valorMaiorAluguel").val(ui.values[1]);
        }
    });
    $("#priceRangeAluguel").val("[ " + $("#price-range-aluguel").slider("values", 0) + " - " + $("#price-range-aluguel").slider("values", 1) + " ]" + " R$");
    $("#valorMenorAluguel").val($("#price-range-aluguel").slider("values", 0));
    $("#valorMaiorAluguel").val($("#price-range-aluguel").slider("values", 1));
 

    //price range (Aluguel)
    $("#price-range").slider({
        range: true,
        min: 10000,
        max: 2000000,
        step: 10000,
        values: [100000, 700000],
        slide: function (event, ui) {
            $("#priceRange").val("[ " + ui.values[0] + " - " + ui.values[1] + " ]" + " R$");
            $("#valorMenorCompra").val(ui.values[0]);
            $("#valorMaiorCompra").val(ui.values[1]);
        }
    });
    $("#priceRange").val("[ " + $("#price-range").slider("values", 0) + " - " + $("#price-range").slider("values", 1) + " ]" + " R$");
    $("#valorMenorCompra").val($("#price-range").slider("values", 0));
    $("#valorMaiorCompra").val($("#price-range").slider("values", 1));
    
    
     //Text editor
    $('.texteditor-content').richText();

    $('.texteditor-switch').on('click', function () {
        if(!$(this).hasClass('active')) {
            $(".richText-btn[data-command='toggleCode']").click();
        }
    });

     //Drag Upload
    $('.feature-image-content').imageUploader();

})(jQuery);