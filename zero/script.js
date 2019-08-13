
// http://192.168.1.51:8000/images/image-0901.jpg
//

let state = {current: null, ms: (60 * 1000), timer: null, grid: false}
const body = document.querySelector("body");
const ts = document.querySelector("#ts");
const imagelist = document.querySelector("#images");
const main = document.querySelector("#main");

stats();

function stats() {
    fetch("stats.txt")
        .then(r => r.text())
        .then(parse)
        .then(render)
        .then(repeat)
        .catch(err => {
            console.warn(error);
        });
}

function parse(string) {
    // flat text file
    const array = string.trim().split("\n");

    // check for the EOF char "."
    if(!/^\.$/.test(array.slice(-1)[0])) {
        console.warn("No EOF character found");
        setTimeout(stats, 1000);
        throw(123, "Payload not ready");
    }

    let [ts, df, dt] = array;

    const [year, month, day, hour, minute, second, z] = ts
        .match(/([^\s]+)/g)
        .map(v => Number(v));

    let [dev, size, used, avail, percent] = df
        .match(/([^\s]+)/g)
        .map(v => /^\d+$/.test(v) ? Number(v) : v);

    size = avail + used; // bytes

    const daytime = {}
    // converts "named value" into dictionary key/value
    // eg "sunrise 034212 >> "sunrise": 34212
    // and convert times to EPOC timestamp
    dt.match(/(\w+\s\d+)/g).forEach(t => {
        let [key, value] = t.split(" ");

        // Cast as time as UTC integer
        if(/^[0-9]{6}$/.test(value)) {
            value = [
                1970, 1, 1, 
                ...value.match(/(\d{2})/g).map(n => Number(n))
            ];
            value = Date.UTC(...value)
        }
        daytime[key] = Number(value);
    })

    let images = array
        .slice(3,-2)
        .map(r => {
            const [_, no]= r.match(/(\d{8})/);
            return [Number(no), r]
        })
        .sort((a,b) => (a[0] - b[0]));

    // The time when the page should reload the data
    let expire = Date.UTC(year, month -1, day, hour, minute, second);
    expire = new Date(expire + (Number(z) * 1000));

    const usage = {dev, used, size, 
        percent: (used/size * 10000 >> 0) / 100
    };

    const current = images.slice(-1)[0][1];

    const date = {year, month: month - 1, day, hour, minute, second};

    // sync the progress to the sleep time
    state = {...state, expire, date, daytime, z, usage, images, current};
    state.ms = Number(state.z || 60) * 1000;

    return state;
}

function render() {
    image();
    title();
    list();
}

function repeat(n = 0) {
    //state.ms = n || state.ms;
    const [_, ms] = remainder();
    const lag = 2000;
    clearTimeout(state.timer);
    state.timer = setTimeout(stats, ms + lag);
}

function image(source = null) {
    source = source || state.current;
    main.style.backgroundImage = `url(${source})`;
}

function title () {
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

function progress() {
    const wait = 240;
    const buffer = wait + 0;
    const {ms} = state;
    let width = 100;

    let [percent, msec] = remainder();
    
    msec = ((msec - buffer) / ms) * ms >> 0;
    width = width - ((percent * 100) >> 0);

    setTimeout(() => {
        document
            .querySelector("#progress")
            .classList.add("go");
    }, wait);

    // calcutate the remaining time to next refesh

    return `<span id="progress" style="--width:${width}%;--ms-delay: ${msec}ms"></span>`;
}

function remainder() {
    // calculate the remaining time before reload
    const {expire, z, ms} = state;
    const now = Date.now();
    const percent = (expire - now) / ms;
    const msec = ms * percent;

    if (msec <= 0) return [1, 0];

    // console.log(now, expire.valueOf(), percent, msec);
    return [percent, msec];
}

function disk(percent) {
    const colors = ["green", "orange", "red"];
    const color = colors[(percent / 33.333 >> 0)];

    return `Disk: ${percent}% <em class="${color}"></em>`;
}

function rec() {
    const {daytime} = state.daytime;
    const classname = daytime ? "on" : "off";
    return `<span class="rec ${classname}">REC</span>`;
}

function navigation () {
    let {current} = state;
    let paths = [];
    current.split(/[\/]+/g)
        .reduce((a, c, i, array) => {
            const slash = i === array.length - 1 ? "" : "/";
            const path =  `${a || ""}${c}${slash}`.replace(/^\./, "");
            paths.push(`<a href="${path}" target="${c}">${c}</a>`);
            return path;
        });
    return `<span class="path">${paths.join("/")}</span>`;
}
