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

  $(".slider-sum").slider({
    range: "min",
    min: 0,
    max: 1000000,
    value: 150000,
    slide: function(event, ui) {
      $(".calc-sum-amount").html(ui.value);
    }
  });

  $(".calc-sum-amount").html($(".slider-sum").slider("value"));

  $(".slider-term").slider({
    range: "min",
    min: 0,
    max: 12,
    value: 9,
    slide: function(event, ui) {
      $(".calc-term-amount").html(ui.value);
    }
  });

  $(".calc-term-amount").html($(".slider-term").slider("value"));

  $(".mark-sum").slider({
    range: "min",
    min: 5000,
    max: 452840,
    value: 452840,
    slide: function(event, ui) {
      $(".mark-sum-amount").html(ui.value);
    }
  });

  $(".mark-sum-amount").html($(".mark-sum").slider("value"));

  $(".mark-term").slider({
    range: "min",
    min: 1,
    max: 24,
    value: 12,
    slide: function(event, ui) {
      $(".mark-term-amount").html(ui.value);
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

  $(".consent-carousel").slick({
    arrows: false,
    fade: true,
    infinite: false,
    swipe: false,
    touchMove: false,
    accessibility: false
  });

  $(".consent-nav li").click(function() {
    var current = $(this).index();

    $(".consent-nav li").removeClass("active");
    $(this).addClass("active");

    consent_completed(current);

    $(".consent-carousel").slick("slickGoTo", current);

    return false;
  });

  function consent_completed(current) {
    $(".consent-nav li").each(function() {
      if ($(this).index() < current) {
        $(this).addClass("completed");
      } else {
        $(this).removeClass("completed");
      }
    });
  }

  $(".consent-back").click(function(e) {
    e.preventDefault();
    $(".consent-carousel").slick("slickPrev");
    var current = $(".consent-carousel").slick("slickCurrentSlide");
    $(".consent-nav li").removeClass("active");
    $(".consent-nav li")
      .eq(current)
      .addClass("active");
    consent_completed(current);
  });

  $(".consent-next").click(function(e) {
    e.preventDefault();
    $(".consent-carousel").slick("slickNext");
    var current = $(".consent-carousel").slick("slickCurrentSlide");
    $(".consent-nav li").removeClass("active");
    $(".consent-nav li")
      .eq(current)
      .addClass("active");
    consent_completed(current);
  });
});
