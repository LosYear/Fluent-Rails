$(function() {
    $(document).on('page:loading ',   function() { NProgress.start();  });
    $(document).on('page:done',  function() { NProgress.done();   });
  //  $(document).on('page:restore', function() { NProgress.remove(); });
});