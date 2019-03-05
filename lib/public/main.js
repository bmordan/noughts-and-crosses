let busy = false

function newGame () {
    $("#board").html("")
    $.ajax(createRequest('/new-game', onNewGame))
}

function createRequest (url, onSuccess) {
    return {
        url: url,
        success: onSuccess,
        beforeSend: function(request) {
            request.setRequestHeader("Access-Control-Allow-Origin", "*")
        },
    }
}

function onNewGame (response) {
    $("#welcome").hide()
    onPlay(response)
}

function onPlay (response) {
    $('#board').html(response)
    busy = false
}

function play (position) {
    if (busy) return
    busy = true
    $($('td')[position - 1]).text('o')
    $.ajax(createRequest(`/play/${position}/${$('td').text()}`, onPlay))
}
