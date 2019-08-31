import defaults from "./camera-settings.js";

let local = {
    showOverlay: false,
    socket: null
};

export default settings;
function settings(socket = null, state = null) {
    if (!socket) return icon();

    return control(socket, state);
}

function icon() {
    const html = `
    <div class="widget" onclick="PI.settings.show()">
        <span class="icon settings"></span>
    </div>
    `;
    return html;
}

function control(socket, getState) {
    local = { ...local, socket, getState };

    return {
        show: overlay
    };
}

function overlay() {
    let { showOverlay } = local;
    let el;

    local.showOverlay = !showOverlay;

    if (!!showOverlay) {
        console.log('close');
        el = document.querySelector('overlay');
        el.parentNode.removeChild(el);
        return false;
    }

    el = document.createElement('overlay');
    el.classList.add('overlay');
    el.innerHTML = `
        <a class="icon close topright" 
            href="#close" 
            onclick="return PI.settings.show()">
        </a>
        <div class="container">
            <div class="inputs">
            </div>
        </div>
    `;

    document.querySelector('body').append(el);
    inputs(el);
}

function saveKeyValue(key, value) {
    const msg = `${key}=${value}`;
    socket.emit(msg);
}

function inputs(overlay) {
    const container = overlay.querySelector('.container');
    const parent = container.querySelector('.inputs');
    const state = local.getState();
    const options = {...defaults};

    // augment with persisted values
    Object.keys(options).forEach(id => {
        // let array = options[id];
        const { settings } = state || {};
        if (settings[id]) {
            // array[2] = settings[id];
            options[id].value = settings[id];
        }
        parent.append(slider(id, options[id]));
    });
}

function slider(id, object) {
    const el = document.createElement('div');
    let {min, max, value, step = null, unit = '', name = null} = object;
    let labels = object.enum || null;

    name = name || id.replace(/(\w)(.*)/, (g0, g1, g2) => (g1.toUpperCase() + g2));
    step = step ? `step="${step}"` : '';
    let [index, string] = getValue(id, object);

    if(labels) {
        min = 0;
        max = labels.length - 1;
        step = 1;
    }

    console.log(object);

    el.classList.add('row');
    el.innerHTML = `
        <div class="range">
          <label for="${id}">${name}</label>
          <input type="range" 
             id="${id}" name="${id}"
             min="${min}" max="${max}" ${step}
             value="${index}"
          >
          <span class="value" id="${id}_value">${string}${unit}</span>
        </div>
    `;
    const io = el.querySelector('input');
    io.oninput = (e) => inputOnInput(e, object);
    io.onchange = e => inputOnChange(e, object);
    return el;
}

function getValue(id, object) {

    let {value} = object;
    let labels = object.enum || null;
    let index = Number(value);
    let string = value;


    if(labels) {
        index = isNaN(index) ? labels.indexOf(string) : index;
        string = labels[index];
    }

    return [index, string];
}

function inputOnInput(e, object) {
    console.log(e);
    const id = e.target.id;
    object.value = e.target.value;
    const [_, value] = getValue(id, object);
    document.querySelector(`#${id}_value`).innerHTML = value;
}

function inputOnChange(e, object) {
    const id = e.target.id;
    object.value = e.target.value;
    const [_, value] = getValue(id, object);
    const msg = `${id}=${value}`;
    console.log(111, id, value);
    local.socket.emit(msg);
}
