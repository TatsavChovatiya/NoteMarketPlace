/* ==================================
            Navigation
====================================*/

/* Show & Hide White Navigation */
$(function () {

    // show/hide nav on page load
    showHideNav();

    $(window).scroll(function () {

        showHideNav();

    });

    function showHideNav() {

        if ($(window).scrollTop() > 50) {

            //Show White nav
            $(".navbar-movable").addClass("white-nav-top");

            // Show dark logo
            $(".navbar-movable .navbar-brand img").attr("src", "/Content/images/pre-login/Capture.PNG");

        } else {

            // Hide White nav
            $(".navbar-movable").removeClass("white-nav-top");

            // Show logo
            $(".navbar-movable .navbar-brand img").attr("src", "/Content/images/pre-login/top-logo.png");

        }
    }
});

/* ==================================
            Mobile Menu
====================================*/
$(function () {

    // Show Mobile nav
    $("#mobile-nav-open-btn").click(function () {
        $("#mobile-nav").css("height", "100%");
    });

    // Hide Mobile nav
    $("#mobile-nav-close-btn").click(function () {
        $("#mobile-nav").css("height", "0");
    });


});
/* ==================================
            Accodion
====================================*/
$(document).ready(function () {
    for (let i = 1; i <= 7; i++) {
        $(".showdata" + i).click(function () {
            $(".mybody" + i).show();
            $(".myhead" + i).hide();
        });
        $(".hidedata" + i).click(function () {
            $(".mybody" + i).hide();
            $(".myhead" + i).show();
        });
    }
});

/* ==================================
            Show-Hide Password
==================================== */
$(".pass-eye1").click(function () {
  
    var input = $(".pe1");
    if (input.attr("type") == "password") {
        input.attr("type", "text");
    } else {
        input.attr("type", "password");
    }
});

$(".pass-eye2").click(function () {

    var input = $(".pe2");
    if (input.attr("type") == "password") {
        input.attr("type", "text");
    } else {
        input.attr("type", "password");
    }
});

$(".pass-eye3").click(function () {

    var input = $(".pe3");
    if (input.attr("type") == "password") {
        input.attr("type", "text");
    } else {
        input.attr("type", "password");
    }
});
/* ==================================
            Drop-down Menu
====================================*/

$('#myModal').on('shown.bs.modal', function () {
    $('#myInput').trigger('focus')
});

