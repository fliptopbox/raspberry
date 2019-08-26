export default rec;
function rec({ time }) {
    const active = time.daytime || time.stayawake;
    const classname = active ? 'on' : 'off';
    const html = `
        <span class="widget">
            <span class="rec ${classname}">REC</span>
        </span>
    `;
    return html;
}
