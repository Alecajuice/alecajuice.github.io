###
 * Code written by Maxwell Bernstein and originally used for
 * bernsteinbear.com. This work is licensed under a
 * Creative Commons Attribution-NonCommercial 3.0 Unported License.
 * For attribution, please clearly mention my name and my website, Bernstein Bear.
 * License: http://creativecommons.org/licenses/by-nc/3.0/deed.en_US
 * Bernstein Bear: http://bernsteinbear.com
###

window.posts = [];
window.baseUrl = '/news/#/';

PostList = () ->
    window.postSingle.hide()
    window.postList.show()

SinglePost = (link) ->
    window.postList.hide()
    window.postSingle.show()

    link = window.baseUrl + link

    found = false
    for post in window.posts
        if post.link == link
            window.postSingle.find("#post-title").html post.title
            window.postSingle.find("#post-body").html post.body
            found = true

    window.postSingle.find("#post-title").html "Not found" unless found

appendPost = (post, postList, listUl) ->
    listEl = $("<li/>")

    post.link = window.baseUrl + post.link

    $("<a/>", {
        href: post.link,
        html: post.title
    }).appendTo listEl

    listEl.appendTo listUl

appendPosts = () ->
    listUl = window.postList.find "ul"
    appendPost(post, postList, listUl) for post in window.posts

replaceURLWithHTMLLinks = (text) ->
    exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig
    text.replace exp, "<a href='$1'>$1</a>"

$(document).ready ->
    window.postList = $("#post-list")
    window.postSingle = $("#post-single")

    spinner = $(".preloader")
    $(document).ajaxStart ->
        spinner.show()
    $(document).ajaxStop ->
        spinner.hide()

    $.getJSON("http://news.palyrobotics.com/feed")
        .success((data) ->
            for post in data
                post.body = replaceURLWithHTMLLinks post.body
            window.posts = data
            appendPosts()

            routie {
                "": PostList,
                "/:id": SinglePost
            }
        )
        .fail((err) ->
            console.log err
        )
