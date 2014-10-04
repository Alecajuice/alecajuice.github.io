/*
 * Code written by Maxwell Bernstein and originally used for
 * bernsteinbear.com. This work is licensed under a
 * Creative Commons Attribution-NonCommercial 3.0 Unported License.
 * For attribution, please clearly mention my name and my website, Bernstein Bear.
 * License: http://creativecommons.org/licenses/by-nc/3.0/deed.en_US
 * Bernstein Bear: http://bernsteinbear.com
 */

window.posts = [];

var PostList = function PostListF () {
    var postList = $("#post-list");
    var postSingle = $("#post-single");
    postSingle.hide();
    postList.show();
};

var SinglePost = function SinglePostF (link) {
    var postList = $("#post-list");
    var postSingle = $("#post-single");
    postList.hide();
    postSingle.show();

    link = '/news/#/' + link;

    var found = false;
    $.each(window.posts, function (ind, post) {
	if (post.link == link) {
	    postSingle.find("#post-title").html(post.title);
	    postSingle.find("#post-body").html(post.body);
	    found = true;
	}
    });

    if (!found) {
	postSingle.find("#post-title").html("Not found");
    }
};

var appendPost = function appendPostF (post, postList, listUl) {
    var listEl = $("<li/>");

    post.link = '/news/#/' + post.link;

    $("<a/>", {
	href: post.link,
	html: post.title
    }).appendTo(listEl);

    listEl.appendTo(listUl);
};

var appendPosts = function appendPostsF (postList) {
    var postList = $("#post-list");
    var listUl = postList.find("ul");
    $.each(window.posts, function (ind, post) {
	appendPost(post, postList, listUl);
    });
};

$(document).ready(function () {
    var spinner = $('.preloader');
    $(document).ajaxStart(function () {
	spinner.show();
    }).ajaxStop(function () {
	spinner.hide();
    });

    $.getJSON("http://news.palyrobotics.com/feed").success(function (data) {
	window.posts = data;
	appendPosts(window.posts);

	routie({
	    "": PostList,
	    "/:id": SinglePost
	});
    }).fail(function (err) {
	console.log(err);
    });
});
