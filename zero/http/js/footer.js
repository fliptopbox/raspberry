import progressbar from './progressbar.js';
import navigation from './navigation.js';
import rec from './rec.js';
import suntime from './suntime.js';
import usage from './usage.js';

export default footer;
function footer(state) {
    const el = document.querySelector('#footer');
    el.innerHTML = `
        ${progressbar(state)}
        ${suntime(state)}
        ${usage(state)}
        ${navigation(state)}
        ${rec(state)}
    `;
}

