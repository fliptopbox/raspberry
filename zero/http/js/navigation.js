export default navigation;
function navigation({ api, image }) {
    const url = `http://${api.host}${api.port}`;
    const html = `
        <span class="widget">
            <span class="icon picture"></span>
            <a href="${url}/images/" class="text">
                ${image.count}
            </a>
        </span>
    `;
    return html;
}
