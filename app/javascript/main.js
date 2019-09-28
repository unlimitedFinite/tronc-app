$(window).bind("load", function(){

  console.log('hello from main.js');

  function focusFields(){
    const fields = document.querySelectorAll('.field');

    fields[0].classList.add('focused');

    fields.forEach((f) => {
      f.addEventListener('focusin', function(e){
        f.classList.add('focused');
      });
      f.addEventListener('focusout', function(e){
        f.classList.remove('focused');
      });
    });
  };

  setTimeout(() => {
  $('.alert').fadeOut();
  }, 6000);

  // focusFields();

});


