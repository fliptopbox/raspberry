import image from './image.js';
import progress from './progress.js';
import footer from './footer.js';
import Socket from './socket.js';
import settings from './settings.js';

let state = {
    api: {
        host: '192.168.1.51',
        port: ':8080'
    }
};

const socket = new Socket(`ws://${state.api.host}${state.api.port}`);
socket.on("data", render);

window.PI = window.PI || {}
window.PI.settings = settings(socket, getState);

function render(next) {
    state = {...state, ...next};

    console.log(state);

    greeting(state);
    footer(state);
    progress(state);
    image(state);
}


function greeting(state) {

    const {stayawake, daytime} = state.time;
    const alseep = !daytime && !stayawake;
    const method = alseep ? "add" : "remove";

    document
        .querySelector("body")
        .classList[method]("greeting");
}

function getState () {
    return {...state}
}

