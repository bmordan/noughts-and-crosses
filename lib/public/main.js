function newGame () {
    $("#board").html("")
    $.ajax(createRequest('/board', onNewGame))
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
}

function play (position) {
    $.ajax(createRequest(`/play/${position}`, onPlay))
}
