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
//= require jquery.ui.all
//= require_tree .


// Channel form toggle
$(function(){
    $('.channel_form_toggle').click(function(){
        $('.add_channel_form').slideToggle();
    });
});

// Special channel options
$(function(){
    $('.full_articles_list').click(function(){
        load_articles(this.attributes['_data-path'].value);
    });
    $('.starred_articles').click(function(){
        load_articles(this.attributes['_data-path'].value);
    });

});

// Channel list load
$(document).ready(function(){
    $('#channel_list').load('user/channels/list', function(){
        $('.channel_link').click(function(){
            var path = this.attributes['_data-path'].value
            load_articles(path);
        });
    });
});

function load_articles(path){
    $('#article_list').load(path, function(){
        $('.article').click(article_click_events);
        $('.refresh_channel_articles').click(function(){
            return load_articles(path);
        });
        $('.display_all_channel_articles').click(function(){
            var path = this.attributes['_data-path'].value;
            load_articles(path);
        });
        $('.star').click(function(){
            var element = $(this).find('.ui-icon')
            var path = element.attr('_data-path')
            $.ajax({
                url: path,
                type: 'GET',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function(data){
                    if(data=='success'){
                        element.toggleClass('ui-state-default ui-state-active')
                    }
                }
            });

        });
        $('.mark_all_articles').click(function(){
            var path = this.attributes['_data-path'].value
            $.ajax({
                url: path,
                type: 'GET',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function(data){
                    if(data=='success'){
                        $('.unread').removeClass('unread');
                        $('.unread_count').html('0');
                    }
                }
            });
        });
    })
};

function article_click_events(){
    var article = this;
    if(this.classList.contains('unread')){
        $.ajax({
            url: this.attributes['_data-path'].value,
            type: 'GET',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function(data){
                article.classList.remove('unread');
                if(data == 'success'){
                    var counter = $('.unread_count').text()
                    $('.unread_count').html(parseInt(counter) - 1);
                }
            }
        });
    };


};
