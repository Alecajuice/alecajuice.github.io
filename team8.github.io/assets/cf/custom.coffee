###
 *
 * General
 *
###

window.onresize = () ->
    if document.getElementById('resizingIframe') != null
    	obj = document.getElementById('resizingIframe')
    	obj.style.height = (obj.parentNode.offsetWidth / 16 * 9) + "px"

###
 *
 * Off-Canvas Fix
 *
###
$(window)
    .on('resize', (e) ->
        if $(this).width() > 640
            e.preventDefault()
            $(".off-canvas-wrap").removeClass("move-left")
    )
    .on('resize', (e) ->
        if $(this).width() > 640
            e.preventDefault()
            $(".off-canvas-wrap").removeClass("move-right")
    )

# no longer need .html adding, due to permalinks! :D

###
 *
 * Accordion Fix
 *
###

addPanel = (i) -> panelNum = i

$('dd > a').on("click", (e) ->
    target = $('#' + 'panel' + panelNum)
    if target.hasClass('active2')
        target.removeClass('active')
        target.removeClass('active2')
    else
        target.addClass('active2')
    $('.active2').addClass('active')
);
