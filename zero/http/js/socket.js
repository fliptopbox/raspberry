import parse from './parse.js';

class Socket {
    constructor(server) {
        this.socket = new WebSocket(server);
        this.triggers = {};
        this.socket.onmessage = this.socketOnMessage.bind(this);
        this.on.bind(this);
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
