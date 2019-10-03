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

  // function generate(){
  //   $("#employee-list").html("<%= j (render 'employee-list') %>");
  //   console.log('rendered employee-list from edit.js');
  // };

  setTimeout(() => {
  $('.alert').fadeOut();
  }, 6000);

});


