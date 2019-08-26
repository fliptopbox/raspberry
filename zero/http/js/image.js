export default image;
function image(next) {
    const main = document.querySelector("#main");
    const { api, image } = next;
    const url = `http://${api.host}${api.port}`;
    const source = image.resize.replace(/^\.+/, '');

    main.style.backgroundImage = `url(${url}/${source})`;
}
