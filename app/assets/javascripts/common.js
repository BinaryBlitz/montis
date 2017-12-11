$(document).ready(function() {
  // Burger

  $(
    (function() {
      $(".burger-wrap").click(function(e) {
        $(this)
          .children()
          .toggleClass("active");
        $(".nav ul").toggleClass("active");
        e.preventDefault();
      });

      var over;

      $(".nav ul, .burger-wrap")
        .mouseenter(function() {
          over = true;
        })
        .mouseleave(function() {
          over = false;
        });

      $(document).click(function(e) {
        if (!over) {
          $(".nav ul").removeClass("active");
          $(".burger-wrap a").removeClass("active");
        }
      });
    })()
  );

  // Slider

  function monthlyPayment(amount, months) {
    var monthlyRate = 0.06;
    var result = (amount * monthlyRate * 6 + amount) / months;
    return parseInt(result);
  }

  $(".slider-sum").slider({
    range: "min",
    min: 0,
    max: 1500000,
    step: 1000,
    value: 150000,
    slide: function(event, ui) {
      $(".calc-sum-amount").html(ui.value);

      var months = parseInt($(".calc-term-amount").html());
      $("#calc-monthly-payment").html(monthlyPayment(parseInt(ui.value), months));
    }
  });

  $(".calc-sum-amount").html($(".slider-sum").slider("value"));

  $(".slider-term").slider({
    range: "min",
    min: 2,
    max: 12,
    value: 9,
    slide: function(event, ui) {
      $(".calc-term-amount").html(ui.value);

      var amount = parseInt($(".calc-sum-amount").html());
      $("#calc-monthly-payment").html(monthlyPayment(amount, parseInt(ui.value)));
    }
  });

  $(".calc-term-amount").html($(".slider-term").slider("value"));

  $(".mark-sum").slider({
    range: "min",
    min: 5000,
    max: 500000,
    value: 50000,
    step: 1000,
    slide: function(event, ui) {
      $(".mark-sum-amount").html(ui.value);
      $("#decision-content-amount").html(ui.value);

      var months = parseInt($(".mark-term-amount").html());

      var payment = monthlyPayment(parseInt(ui.value), months);
      $("#mark-info-monthly-payment").html(payment);
      $("#decision-content-monthly-payment").html(payment);
    }
  });

  $(".mark-sum-amount").html($(".mark-sum").slider("value"));

  $(".mark-term").slider({
    range: "min",
    min: 2,
    max: 24,
    value: 12,
    slide: function(event, ui) {
      $(".mark-term-amount").html(ui.value);
      $("#mark-info-term").html(ui.value);
      $("#decision-content-term").html(ui.value);

      var amount = parseInt($(".mark-sum-amount").html());

      var payment = monthlyPayment(amount, parseInt(ui.value));
      $("#mark-info-monthly-payment").html(payment);
      $("#decision-content-monthly-payment").html(payment);
    }
  });

  $(".mark-term-amount").html($(".mark-term").slider("value"));

  // Header callback

  $(
    (function() {
      $(".header-info-nav li").click(function() {
        var current = $(this).index();

        if ($(this).hasClass("active")) {
          $(".header-info-item")
            .eq(current)
            .hide();
          $(this).removeClass("active");
        } else {
          $(".header-info-item").hide();
          $(".header-info-item")
            .eq(current)
            .fadeIn();
          $(".header-info-nav li").removeClass("active");
          $(this).addClass("active");
        }
      });

      var over;

      $(".header-info")
        .mouseenter(function() {
          over = true;
        })
        .mouseleave(function() {
          over = false;
        });

      $(document).click(function(e) {
        if (!over) {
          if ($(".header-info-nav li").hasClass("active")) {
            $(".header-info-item").hide();
            $(".header-info-nav li").removeClass("active");
          }
        }
      });
    })()
  );

  // Select2 init

  $(".select2").select2({ width: "100%" });

  // Scroll to next block

  function scroll_to() {
    $(".showcase-arrow").click(function() {
      $("html, body").animate(
        {
          scrollTop: $($(this).attr("href")).offset().top + "px"
        },
        {
          duration: 1000
        }
      );

      return false;
    });
  }

  scroll_to();

  // Slider showcase inner

  $(".showcase-inner-wrap").slick({
    dots: true,
    arrows: false,
    infinite: false,
    slidesToShow: 1,
    slidesToScroll: 1
  });

  // Fancybox

  $("[data-fancybox]").fancybox({
    touch: false
  });

  // Online approval carousel

  $(".estimation-carousel").slick({
    accessibility: false,
    arrows: false,
    draggable: false,
    fade: true,
    infinite: false,
    swipe: false,
    touchMove: false
  });

  $(".estimation-nav li").click(function() {
    var current = $(this).index();

    $(".estimation-nav li").removeClass("active");
    $(this).addClass("active");

    estimation_completed(current);

    $(".estimation-carousel").slick("slickGoTo", current);

    return false;
  });

  function estimation_completed(current) {
    $(".estimation-nav li").each(function() {
      if ($(this).index() < current) {
        $(this).addClass("completed");
      } else {
        $(this).removeClass("completed");
      }
    });
  }

  $(".estimation-back").click(function(e) {
    e.preventDefault();
    $(".estimation-carousel").slick("slickPrev");
    var current = $(".estimation-carousel").slick("slickCurrentSlide");
    $(".estimation-nav li").removeClass("active");
    $(".estimation-nav li")
      .eq(current)
      .addClass("active");
    estimation_completed(current);
  });

  function nextSlide() {
    $(".estimation-carousel").slick("slickNext");
    var current = $(".estimation-carousel").slick("slickCurrentSlide");
    $(".estimation-nav li").removeClass("active");
    $(".estimation-nav li")
      .eq(current)
      .addClass("active");
    estimation_completed(current);
  }

  $(".estimation-next").click(function(e) {
    // e.preventDefault();
    // nextSlide();
  });

  function checkAuto() {
    var username = 'avtocashunicom@gmail.com';
    var password = 'avtocashunicom24';

    var vin = $('#vin').val();

    $.ajax({
      method: 'POST',
      url: 'https://unicom24.ru/api/avto_check/v1/',
      dataType: 'json',
      headers: {
        'Authorization': 'Basic ' + btoa(username + ':' + password)
      },
      data: {
        vin: vin
      },
      success: function(data) {
        var carPriceResponse = data.response.car_price;
        var amount = carPriceResponse.items[0].amount;
        console.log(amount);

        $(".mark-sum").data('amount', amount);
        $(".mark-sum").slider('option', 'max', amount);
        $(".preliminary-amount").html(amount);

        nextSlide();
        return true;
      },
      error: function() {
        console.log('Error');
        return false;
      }
    });
  }

  function checkFinancialHealth() {
    var username = 'avtocashunicom@gmail.com';
    var password = 'avtocashunicom24';

    var first_name = $("#first_name").val();
    var middle_name = $("#middle_name").val();
    var second_name = $("#second_name").val();
    var passport = $("#passport").val();
    var passport_date = $("#passport_date").val();
    var dob = $("#dob").val();

    console.log('Starting request');

    $.ajax({
      method: 'POST',
      url: 'https://unicom24.ru/api/partners/rfh/v1/request/',
      dataType: 'json',
      headers: {
        'Authorization': 'Basic ' + btoa(username + ':' + password)
      },
      data: {
        first_name: $("#first_name").val(),
        middle_name: $("#middle_name").val(),
        second_name: $("#second_name").val(),
        passport: $("#passport").val(),
        passport_date: $("#alt_passport_date").val(),
        dob: $("#alt_dob").val(),
      },
      success: function(data) {
        console.log(data);
        nextSlide();
        return true;
      },
      error: function() {
        console.log('Error');
        alert('Что-то пошло не так. Убедитесь, что все поля заполнены правильно.')
        return false;
      }
    });
  }

  $('#button-estimate-auto').click(function(e) {
    e.preventDefault();

    checkAuto();
  });

  $('#button-next-step').click(function(e) {
    e.preventDefault();

    nextSlide();
  });

  $('#button-check-financial-health').submit(function(e) {
    e.preventDefault();

    checkFinancialHealth();
  });
});
