//= require jquery
//= require jquery_ujs
//= require nprogress
//= require wiselinks
//= require admin/nprogress-wiselinks.js
//= require bootstrap
//= require losyear/blog


NProgress.configure({ showSpinner: false });
$(document).ready(function () {
    window.wiselinks = new Wiselinks($('div.wiselinks-container'));
})
// Scroll Animation
$.scrollTo = function(target, time){
    scrollTop = $(target).offset().top - 50
    $('html,body').animate({ scrollTop: scrollTop }, time || 700)
}