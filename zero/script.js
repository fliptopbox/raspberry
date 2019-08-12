
// http://192.168.1.51:8000/images/image-0901.jpg
//

let state = {current: null, ms: (60 * 1000), timer: null, grid: false}
const body = document.querySelector("body");
const ts = document.querySelector("#ts");
const imagelist = document.querySelector("#images");
const main = document.querySelector("#main");

imagelist.onclick = (e) => {
    const {dataset} = e.target;
    const {src} = dataset;
    if(state.current === src) {
        console.log("Unsetting current", state.current);
        state.current = null;
        list();
        title();
        return;
    }
    image(src, true);
    state.current = src;
    list();
    title();
}

// relad every minute
repeat();

function repeat(n = 0) {

    state.ms = n || state.ms;
    clearTimeout(state.timer);

    state.timer = setTimeout(repeat, state.ms);
    console.log("State Delay", state.ms);
    stats();
}

function image(source, reload=false) {
    if(state.current && !reload) return;
    console.log(source);
    main.style.backgroundImage = `url(${source})`;
}

function parse(string) {
    // flat text file
    const array = string.split("\n");
    const [ts, df] = array;

    const [year, month, day, hour, minute, second, z] = ts
        .match(/([^\s]+)/g)
        .map(v => Number(v));

    let [dev, size, used, avail, percent] = df
        .match(/([^\s]+)/g)
        .map(v => /^\d+$/.test(v) ? Number(v) : v);

    size = avail + used; // bytes

    let images = array
        .slice(3,-2)
        .map(r => {
            const [_, no]= r.match(/(\d{8})/);
            return [Number(no), r]
        })
        .sort((a,b) => (a[0] - b[0]));

    const date = {year, month, day, hour, minute, second};
    const usage = {dev, used, size, 
        percent: (used/size * 10000 >> 0) / 100
    };

    return { date, z, usage, images };
}

function stats() {
    console.log("getting stats", new Date());
    fetch("stats.txt")
        .then(r => r.text())
        .then(parse)
        .then(meta => {
            state = {...state, ...meta};

            const src = meta.images.slice(-1)[0][1];

            image(src);
            title();
            list();
        })
}

function title () {
    const {date, usage, z, current = "", ms} = state;
    const {year, month, day, hour, minute, second} = date;
    const timestamp = new Date(year, month, day, hour, minute, second)
        .toString().split(" ").slice(0,5).join(" ");

    ts.innerHTML = `
        ${progress(ms)}
        ${timestamp} - 
        (${z}s) - 
        ${disk(usage.percent)}
        ${ current || "" }
    `;

}

function progress(ms, wait = 240) {
    setTimeout(() => {
        document.querySelector("#progress").classList.add("go");
        console.log("go!", state.ms);
    }, wait);

    return `<span id="progress" style="--ms-delay: ${ms}ms"></span>`;
}

function disk(percent) {
    const colors = ["green", "orange", "red"];
    const color = colors[(percent / 33.333 >> 0)];

    return `Disk: ${percent}% <em class="${color}"></em>`;
}

function list (index=null) {
    if(!state.grid) {
        imagelist.innerHTML = "";
        return;
    }

    const {images, current = ""} = state;
    const lis = images
        .map(s => {
            const current = state.current === s[1] ? `class="selected"` : "";
            return `<li ${current} data-id="${s[0]}" data-src="${s[1]}">${s[0]}</li>`;
        })
        .join("");

    imagelist.innerHTML = `<ul>${lis}</ul>`;
}
