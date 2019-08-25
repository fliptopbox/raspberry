import TTL from "./ttl.js";

const state = {
    ms: 1000,
    timer: null,
    attempts: 0,
    max: 45,
    average: [0]
};

window.reload = reload;
export default reload;
function reload (next, callback, loop = false) {

    let {ms, timer, attempts, average} = state;

    if(!loop) {
        attempts && state.average.push(attempts);
        console.log("average", attempts, state.average);
        state.attempts = 0;
    }

    timer = setInterval(() => {
        let {remainder} = TTL(next);
        if(remainder > 0 && remainder < 10 * ms) {
            console.log("count down", remainder / 1000);
        }

        if(remainder < 0) {
            console.log("callback, clearInterval");
            clearInterval(timer);
            state.attempts += 1;
            callback();
        }
    }, ms)

}

