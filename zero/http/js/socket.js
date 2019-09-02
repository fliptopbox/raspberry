import parse from './parse.js';

let socket;

class Socket {
    constructor(server) {
        socket = new WebSocket(server);
        this.triggers = {};
        socket.onmessage = this.socketOnMessage.bind(this);
        this.on.bind(this);
        //this.emit.bind(this);
        this.log = true;
        window.ws = socket;
    }

    emit(string) {
        console.log("emit", string);
        socket.send(string);
    }

    on(key, callback) {
        this.triggers[key] = callback;
    }

    socketOnMessage(e) {
        const data = e.data;
        const array = data.split(/&/g);
        const [cmd, string] = array[0].split('=');
        const {triggers} = this;

        switch (cmd || 'unknown') {
            case 'hello world':
            case 'log':
                if (this.log) {
                    console.log("<<< [%s]", cmd, data);
                }
                break;

            case 'cmd':
                const next = parse(array);
                triggers[string](next);

                break;
            default:
                console.warn(cmd, array);
                break;
        }
    }
}

export default Socket;
