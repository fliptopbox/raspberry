import image from './image.js';
import progress from './progress.js';
import footer from './footer.js';
import Socket from './socket.js';

let state = {
    welcome: true,
    api: {
        host: '192.168.1.51',
        port: ':8080'
    }
};

const socket = new Socket(`ws://${state.api.host}${state.api.port}`);
socket.on("data", render);


function render(next) {
    state = {...state, ...next};

    console.log(state);

    if(state.welcome) {
        state.welcome = false;
        document.querySelector(".welcome")
            .style.display = "none";
    }
    footer(state);
    progress(state);
    image(state);
}


