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
//= require twitter/bootstrap
//= require jquery.ui.all
//= require_tree .


// Notice slide
$(function(){
    if($('.notice').is(':visible')){
        setTimeout(function(){
            $('.notice').slideToggle()
        }, 5000);
    };
})

// Channel form toggle
$(function(){
    $('.channel_form_toggle').click(function(){
        $('.add_channel_form').slideToggle();
    });
});

// Channel add
$(document).ready(function(){
    $('#fast_channel_add_form').on('ajax:success', function(e, data, status, xhr){
        load_channels();
        this.reset()
    });
    $('#fast_channel_add_form').on('ajax:error', function(e, data, status, xhr){
        var message = "<span>" + JSON.parse(data.responseText)['url'][0] + "</span>"
        $(message).appendTo($('#add_channel')).fadeOut(5000);
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
    load_channels();
});

function load_channels(){
    var path = $('#channel_list').attr('_data-path');
    $('#channel_list').load(path, function(){
        $('.channel_link').click(function(){
            var path = this.attributes['_data-path'].value
            load_articles(path);
        });
    });
};

// Search
$(document).ready(function(){
    $('.search_form').find('form').on('ajax:success', function(e, data, satus, xhr){
        load_articles('', data);
    });
});

$(function(){
    if($('#article_list.from_search')){
        setup_article_links();
    };
});

function load_articles(path, data){
    if(data){
        $('#article_list').html(data);
        setup_article_links();
    }
    else{
        $('#article_list').load(path, function(){
            setup_article_links();
        })
    };

};



function setup_article_links(){
    $('.article').click(article_click_events);
    $('.refresh_channel_articles').click(function(){
        var path = this.attributes['_data-path'].value;
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
    $.each($('.comment_section'), function(){
        var section = this
        var element_to_update = this.getElementsByClassName('article_comments');
        var toggle_link = $(this.children.item('toggle_comments'));
        var toggle_icon = toggle_link.find('.ui-icon');
        $(toggle_link).click(function(){
            $(toggle_icon).toggleClass('ui-icon-triangle-1-e ui-icon-triangle-1-s');
            if($(toggle_icon).hasClass('ui-icon-triangle-1-e')){
                $(element_to_update).slideUp()
            }
            else{
                var path = this.attributes['_data-path'].value
                $(element_to_update).hide();
                $(element_to_update).load(path, function(){
                    if($(section).find('.comment_form')){
                        $(section).find('.new_comment').on('ajax:success', function(e, data, status, xhr){
                            $(xhr.responseText).hide().appendTo($(section).find('.comments')).fadeIn(1000);
                            this.reset();
                        });
                    };
                });
                $(element_to_update).slideDown();
            };
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
