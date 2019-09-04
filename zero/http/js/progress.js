import TTL from './ttl.js';

export default progress;
function progress(next) {
    const { remainder = null, totaltime, active } = TTL(next);

    if (!remainder) return;

    const width = 100 - (remainder / totaltime) * 100;

    return render(width, remainder, active);
}

function render(width, remainder, active) {
    const el = getElement();

    el.classList.remove('go');
    el.classList.add(active ? "online" : "offline");

    el.style.display = 'block';
    el.style.setProperty('--width', `${width}%`);
    el.style.setProperty('--ms-delay', `${remainder}ms`);

    setTimeout(() => el.classList.add('go'), 100);
    setTimeout(() => (el.style.display = 'none'), remainder + 350);

    return el;
}

function getElement() {
    let el = document.querySelector('#progress');

    if (!el) {
        const div = document.createElement('div');
        div.className = 'footer';

        el = document.createElement('div');
        el.id = 'progress';

        div.append(el);

        document.querySelector('body').prepend(div);
    }

    return el;
}
