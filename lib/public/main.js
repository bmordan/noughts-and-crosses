const baseUrl = "http://172.17.0.1:4567"

function newGame () {
    $("#board").html("")
    $.ajax({
        url: `${baseUrl}/board`,
        success: getBoard
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
        url: `${baseUrl}/play/${position}`,
        success: onPlay
    })
}
