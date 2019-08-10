
// http://192.168.1.51:8000/images/image-0901.jpg
//

const body = document.querySelector("body");
const cam = document.querySelector("#cam");
const ts = document.querySelector("#ts");

let delay = 3000;
let current = 0;
let sequence = `00000000`;

function src(n = 0) {
    //const src = `http://192.168.1.51:8000/images/image-${n}.jpg`;
    let digit = `${sequence}${n}`.slice(-(sequence.length));
    const href = `/images/image-${digit}.jpg`;
    return href;
}

function now() {
    const d = new Date().toString();
    const [wd, mm, dd, yyyy, time] = d.split(" ");
    return  `${dd} ${mm} ${time}`;
}

function image(n = 0) {
    const im = new Image();
    try {
        im.src = src(n || current + 1)
        im.onload = () => {
            current += 1;
            cam.src = im.src;
            ts.innerHTML = `${current} - ${now()}`;
            image();
        }
    } catch(e) {
        console.log(e);
        setTimeout(image, delay);
    }
}
