document.addEventListener('DOMContentLoaded', function () {
  var $dropdown = document.querySelector('.has-dropdown'); 
  $dropdown.addEventListener('click', function () {
    $dropdown.classList.toggle('is-active');
  });

  var $burger = document.querySelector('.navbar-burger'); 
  $burger.addEventListener('click', function () {
     console.log("CKIDJ")
    var $navbarMenu = document.querySelector('.navbar-menu')
    $navbarMenu.classList.toggle('is-active');
  });
});
