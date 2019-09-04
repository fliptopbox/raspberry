export default navigation;
function navigation({ api, image, settings }) {
    const url = `http://${api.host}${api.port}`;
    const fullsize = image.fullsize.replace(/^|W+/, "");
    const {bracket} = settings;
    const icon = bracket ? "bracket" : "picture";
    const no = bracket ? `<em>${(bracket * 2) + 1}</em>` : "";
    const html = `
        <span class="widget">
            <a href="${url}/${fullsize}" 
                target="image" 
                class="icon ${icon}">${no}</a>

            <a href="${url}/${fullsize.replace(/[^\/]+$/, "")}" 
                target="folder" 
                class="text">${image.count}</a>
        </span>
    `;
    return html;
}
