import progressbar from './progressbar.js';
import navigation from './navigation.js';
import rec from './rec.js';
import suntime from './suntime.js';
import usage from './usage.js';
import grid from './grid.js';
import settings from './settings.js';

export default footer;
function footer(state) {
    const el = document.querySelector('#footer');
    el.innerHTML = `
        ${settings(null, state)}
        ${grid(state)}
        ${progressbar(state)}
        ${suntime(state)}
        ${usage(state)}
        ${navigation(state)}
        ${rec(state)}
    `;
}

