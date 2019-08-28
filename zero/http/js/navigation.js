export default navigation;
function navigation({ api, image }) {
    const url = `http://${api.host}${api.port}`;
    const fullsize = image.fullsize.replace(/^|W+/, "");
    const html = `
        <span class="widget">
            <span class="icon picture"></span>
            <a href="${url}/${fullsize}" class="text">
                ${image.count}
            </a>
        </span>
    `;
    return html;
}
