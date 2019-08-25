export default suntime;
function suntime({ time }) {
    let { sunset, sunrise } = time;
    const hhmm = /(\d+:\d+)/g;
    sunset = new Date(sunset).toString().match(hhmm)[0];
    sunrise = new Date(sunrise).toString().match(hhmm)[0];
    console.log(sunset, sunrise);

    const html = `
        <div class="widget">
            <span class="icon sun"></span>
            <span class="text">${sunrise}</span>
        </div>
        <div class="widget">
            <span class="icon moon"></span>
            <span class="text">${sunset}</span>
        </div>
    `;
    return html;
}

