export default grid;
function grid() {
    const html = `
    <div class="widget" onclick="PI.grid()">
        <span class="icon grid"></span>
    </div>
    `;
    return html;
}

let state = {
    overlay: false
}

window.PI = window.PI || {};
window.PI.grid = function(color = null) {
    const main = document.querySelector('#main');
    let overlay = main.querySelector('.overlay');
    if (!overlay) {
        overlay = document.createElement('div');
        overlay.classList.add('overlay');
        overlay.classList.add('grid');
        main.prepend(overlay);
    }

    let toggle = !(state.overlay || false);

    if (color) {
        toggle = true;
        overlay.style.setProperty('--ui-grid', color);
    }

    overlay.style.display = toggle ? 'block' : 'none';
    state = { ...state, overlay: toggle };
};
