function newGame () {
    $("#board").html("")
    $.ajax({
        url: '/board',
        success: getBoard,
        beforeSend: function(request) {
            request.setRequestHeader("Access-Control-Allow-Origin", "*")
        },
    })
}

function getBoard (response) {
    $("#welcome").hide()
    onPlay(response)
}

function onPlay (response) {
    $('#board').html(response)
}

function play (position) {
    $.ajax({
        url: `/play/${position}`,
        success: onPlay,
        beforeSend: function(request) {
            request.setRequestHeader("Access-Control-Allow-Origin", "*")
        },
    })
}
