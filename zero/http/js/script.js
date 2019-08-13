
// http://192.168.1.51:8000/images/image-0901.jpg
//

let state = {
    current: null, 
    ms: (60 * 1000), 
    timer: null,
    monitor: null,
    attempts: 0,
    chksum: null,
    limit: 10,
    grid: false
};

const body = document.querySelector("body");
const ts = document.querySelector("#ts");
const imagelist = document.querySelector("#images");
const main = document.querySelector("#main");
const api = { stats: "/data/stats.txt"}

stats();

function stats(url = null) {
    url = url || `${api.stats}`;
    // console.log("url", url);
    fetch(url)
        .then(r => r.text())
        .then(parse)
        .then(render)
        .catch(err => {
            console.warn(err);
        });
}



function parse(string) {
    // flat text file
    const array = string.trim().split("\n");

    // check for the EOF char "."
    if(!/^\.$/.test(array.slice(-1)[0])) {
        return retry(400, "Payload not ready. No EOF character found.");
    }

    let [ts, df, dt] = array;

    // console.log("chk", state.chksum,  ts)
    if(state.chksum === ts){
        return retry(500, "Timestamp has not updated.")
    }


    const [year, month, day, hour, minute, second, z] = ts
        .match(/([^\s]+)/g)
        .map(v => Number(v));

    // Last modified date/time
    const chksum = ts;
    const date = {year, month: month - 1, day, hour, minute, second};

    // Disk usage
    let [dev, size, used, avail, percent] = df
        .match(/([^\s]+)/g)
        .map(v => /^\d+$/.test(v) ? Number(v) : v);
    size = avail + used; // bytes

    // Current day light
    const daytime = {}
    dt.match(/(\w+\s\d+)/g).forEach(t => {
        // converts "named value" into dictionary key/value
        let [key, value] = t.split(" ");
        daytime[key] = Number(value);
    })

    // Image collection (last 20ish)
    let images = array
        .filter(row => /-\d+\.jpg$/.test(row))
        .map(r => {
            const [_, no]= r.match(/(\d{8})/);
            return [Number(no), r]
        });

    // The time when the page should reload the data
    let severPrepTime = 18 * 1000;
    let cameraInterval = Number(z) * 1000;
    let expire = Date.UTC(year, month -1, day, hour, minute, second);
    expire = new Date(expire + severPrepTime + cameraInterval);


    const usage = {dev, used, size, 
        percent: (used/size * 10000 >> 0) / 100
    };

    const current = images.slice(-1)[0][1];


    // sync the progress to the sleep time
    state = {...state, chksum, expire, date, daytime, z, usage, images, current};
    state.ms = Number(state.z || 60) * 1000;
    state.attempts = 0;

    retry(null);
    repeat();

    return state;
}

function render() {
    image();
    title();
    list();

    return true;
}

function repeat(n = 0) {
    //state.ms = n || state.ms;
    let [_, ms] = remainder();

    if(!state.monitor){
        console.log("Repeating in ...%ssec ", (ms / 1000));
        clearTimeout(state.timer);
        state.timer = setTimeout(stats, ms);
    }
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
    const {ms} = state;
    const wait = 240;
    const buffer = wait + 0;
    let width = 100;

    let [percent, msec] = remainder();

    
    msec = ((msec - buffer) / ms) * ms >> 0;
    width = Math.max(0, width - ((percent * 100) >> 0));

    console.log("ready to render", percent)
    // Halt the redraw while data loads
    percent < 1.2 && setTimeout(() => {
        console.log("adding go class")
        document
            .querySelector("#progress")
            .classList.add("go");
    }, wait);

    console.log("return span", width, msec)
    // calcutate the remaining time to next refesh
    return `<span id="progress" style="--width:${width}%;--ms-delay: ${msec}ms"></span>`;
}

function remainder() {
    // calculate the remaining time before reload
    const {expire, ms} = state;
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
            const path =  `${a || ""}${c}${slash}`.replace(/^\.+/, "");
            paths.push(`<a href="${path}" target="${c}">${c}</a>`);
            return path;
        });
    return `<span class="path">${paths.join("/")}</span>`;
}

function retry(err, desc) {
    let {monitor, attempts, limit} = state;
    if(err === null) {
        console.log("Reset retry monitor", attempts);
        clearTimeout(monitor)
        monitor = null;
        state.attempts = 0
        return;
    }

    if(monitor) {
        console.log("monitor in progress", attempts);
        return;
    }

    state.attempts += 1
    if(attempts > limit) {
        throw(err, `Too many attempts. ${desc} ${attempts}`);
    }

    const inc = (state.attempts * 5) * 1000;
    console.log("inc", state.attempts, inc);
    monitor = monitor || setTimeout(() => {
        clearTimeout(monitor)
        state.monitor = null;
        stats();
    }, inc);

}
