import image from './image.js';
import progress from './progress.js';
import footer from './footer.js';
import Socket from './socket.js';

let state = {
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

window.PI = {
    grid: (color = null) => {
        const main = document.querySelector("#main");
        let overlay = main.querySelector(".overlay");
        if(!overlay) {
            overlay = document.createElement("div");
            overlay.classList.add("overlay");
            overlay.classList.add("grid");
            main.prepend(overlay);
        }

        let toggle = !(state.overlay || false);

        if(color) {
            toggle = true;
            overlay.style.setProperty("--ui-grid", color);
        }

        overlay.style.display = toggle ? "block" : "none";
        state = {...state, overlay: toggle};
    }

}
