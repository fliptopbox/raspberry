export default usage;
function usage({ disk }) {
    const {percent, avail} = disk;
    const GiB = avail / (1000 ** 2);
    const color = percent > 75 ? "red" : "white";
    const deg = (360 * (percent / 100) ) >> 0;

    console.log(percent, deg);

    const html = `
        <div class="widget">
            <span class="icon disk"></span>
            <span class="text">${GiB >> 0}GB</span>
        </div>
        <div class="widget">
            <span class="icon pie" 
                style="
                    --pie-color:${color};
                    --pie-percent:${deg}deg
                ">
            </span>
            <span class="text">${percent}%</span>
        </div>
    `;
    return html;
}


