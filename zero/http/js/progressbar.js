
export default progressbar;
function progressbar({ sleep }) {
    const now = new Date();
    let interval = sleep.interval;
    let hour = now.getHours();
    let minute = now.getMinutes();
    let hours = (hour / 24) * (360 * 2);
    let minutes = (minute / 60) * 360;

    hours = hours > 360 ? hours - 360 : hours;

    minute = `00${minute}`.slice(-2);
    hour = `00${hour}`.slice(-2);

    interval = interval > 60 ? 
        (((interval / 60) * 10 >> 0) / 10) + "min" : 
        (interval) + "sec";

    const html = `
        <div class="widget">
            <span 
                class="icon clock"
                style="
                    --hour: ${hours}deg;
                    --min: ${minutes}deg;
                ">
            </span>
            <span class="text">${hour}:${minute}</span>
        </div>
        <span class="widget reload">
            <span id="progress"></span>
        </span>
        <span class="widget">
            <span class="icon refresh"></span>
            <span class="text">${interval}</span>
        </span>
    `;

    return html;
}
