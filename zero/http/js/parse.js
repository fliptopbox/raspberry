
const re = {
    empty: /^$/,
    boolean: /^(true|false)$/i,
    time: /^([0-2][0-9])([0-5][0-9])([0-5][0-9])?$/,
    percent: /^(\d+(\.\d+)?)(%)$/,
    seconds: /^(\d+(\.\d+)?)(\s?s(ec)?.*)$/,
    camel: /^([a-z]+)([A-Z].*)$/
};

export default parse;
function parse(payload = '') {

    if(typeof payload === "string") {
        payload = payload && payload.trim();
        if (!payload || !/\.$/.test(payload)) return null;
        payload = payload.split("\n");
    }

    const next = {};
    payload
        .filter(s => s.length - 1)
        .map(line => line.split('='))
        .forEach(row => {
            let [key, value] = row;

            key = parentChild(key);
            value = primitive(value);

            if (key.length === 1) {
                next[key[0]] = value;
                return;
            }

            const [parent, child] = key;
            next[parent] = next[parent] || {};
            next[parent][child] = value;
        });

    return next;
}

export {parentChild};
function parentChild(string) {
    if (!re.camel.test(string)) return [string];

    let array = string
        .match(re.camel)
        .slice(1, 3)
        .map((text, i) => {
            if (!i) return text.toLowerCase();

            return text.toUpperCase() === text ? text : text.toLowerCase();
        });

    return array;
}

export {primitive};
function primitive(string = '') {
    let temp;
    let value = `${string}`.trim();

    if (re.empty.test(value)) {
        return null;
    }

    if (re.boolean.test(value)) {
        return /^true$/i.test(value);
    }

    if (re.percent.test(value)) {
        value = value.replace(/%$/, '');
        value = Number(value) / 100;
        return value;
    }

    // cast as time. 
    // TODO change API to use : deliminator for times
    // WARNING! the regex will match large integers eg. 100101
    temp = value.match(re.time) || [];
    if (temp && temp.length && temp[3]) {
        temp = temp.slice(1, 4).map(v => Number(v));
        temp = Date.UTC(...[1970, 0, 1, ...temp]);
        return temp;
    }

    if (!isNaN(Number(value))) {
        return Number(value);
    }

    return value;
}
