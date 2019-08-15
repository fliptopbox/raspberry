

export default title;
function title (state) {
    const {date, usage, z, current = "", ms} = state;
    const {year, month, day, hour, minute, second} = date;
    const timestamp = new Date(year, month, day, hour, minute, second)
        .toString().split(" ").slice(0,5).join(" ");

    ts.innerHTML = `
        ${progress()}
        ${timestamp} - 
        (${z}s) - 
        ${disk(usage.percent)}
        ${navigation()}
        ${rec()}
    `;
}
