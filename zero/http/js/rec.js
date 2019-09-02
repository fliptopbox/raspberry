export default rec;
function rec({ time, settings }) {
    const active = time.daytime || time.stayawake;
    const {preview} = settings;
    const classname = active ? 'on' : 'off';

    const body = document.querySelector("body");
    let warning = document.querySelector(".warning");


    if (warning) body.removeChild(warning);

    if(preview) {
        warning = document.createElement("div");
        warning.classList.add("warning");
        warning.innerHTML = "<strong>PREVIEW</strong> - your images are not being saved";
        body.prepend(warning);
    }


    const html = `
        <span class="widget">
            <span class="rec ${classname}">REC</span>
        </span>
    `;
    return html;
}
