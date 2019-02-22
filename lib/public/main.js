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
    $('#board').html(response)
}

function onPlay (response) {
    $('#board').html(response)
    displayNextButton()
}

function displayNextButton () {
    const message = $('#message').html()
    const msg = message.substring(message.length - 5)

    if (msg == "wins!" || msg === "draw!") {
        $('#message').append(`<button class="bg-green ml2 bn white" onclick="newGame()">Play Again</button>`)
    }
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
