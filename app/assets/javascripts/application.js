// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


// Channel form toggle
$(function(){
    $('.channel_form_toggle').click(function(){
        $('.add_channel_form').slideToggle();
    });
});

// Channel list load
$(document).ready(function(){
    $('#channel_list').load('user/channels', function(){
        $('.channel_link').click(function(){
            $('#article_list').load('user/channels/' + this.attributes['_data-id'].value + '/articles_list', function(){
                $('.article').click(function(){
                    var article = this;
                    $.ajax({
                        url: 'user/channels/' + this.attributes['_data-channel_id'].value + '/articles/' + this.attributes['_data-id'].value + '/mark_as_read',
                        type: 'GET',
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8',
                        success: function(){
                            article.classList.remove('unread');
                        }
                    });
                });
            });
        });
    });
});
