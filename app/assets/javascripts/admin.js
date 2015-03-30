//= require nprogress
//= require admin/nprogress-wiselinks.js
// require admin/global.js.coffee
//= require admin/global
//= require admin/menu_admin.js.coffee
// require ckeditor/override
//= require ckeditor/init

NProgress.configure({ showSpinner: false });
$(document).on('page:load', function () {
    $('a#tooltip').tooltip()
});

$(document).ready(function () {
    window.wiselinks = new Wiselinks($('.content'));
})