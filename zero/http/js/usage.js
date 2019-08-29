export default usage;
function usage({ disk }) {
    const percent = disk.percent;
    const fith = (percent / 20) >> 0;
    const colors = ['green', 'green', 'orange', 'red', 'black'];
    const color = colors[fith];

    const html = `
        <div class="widget">
            <span class="icon usage" 
                style="--bgcolor:${color}; --width:${(fith + 1) * 20}%">
            </span>
            <span class="text">${percent}%</span>
        </div>
    `;
    return html;
}


