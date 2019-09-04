export default {
    // key      min, max, value, step, unit
    saturation: {
        min:-100,
        max: 100,
        value: 0
    },
    contrast: {
        min:-100,
        max: 100,
        value: 0
    },
    brightness: {
        min:0,
        max: 100,
        value: 50, 
        unit: '%'
    },
    rotation: {
        min:0,
        max: 359,
        value: 0, 
        unit: '˚'
    },
    interval: {
        name: "Camera Interval",
        min: 10,
        max: 5 * 60,
        value: 3 * 60,
        step: 10,
        unit: 's',
        format: (value, unit) => {
            value = Number(value);
            unit = "sec";

            let minutes = 0;
            let seconds = value;
            let text = `${seconds}${unit}`;

            if(value > 60) {
                unit = "min"
                value /= 60;
                minutes = value >> 0;
                seconds = Math.round((value - minutes) * (60)) >> 0
                seconds = `00${seconds}`.slice(-2);
                text = `${minutes}:${seconds}`;
            }

            return `${text}`;
        }
    },
    ISO: {
        min:50,
        max: 1600,
        value: 200,
        step: 10
    },
    awb: {
        name: "White Balance",
        min: 0,
        max: 0,
        value: 0,
        enum: [
            'off',
            'auto',
            'sun',
            'cloud',
            'shade',
            'tungsten',
            'fluorescent',
            'incandescent',
            'flash',
            'horizon'
        ]
    },
    drc: {
        name: "Dynamic Range",
        min: 0,
        max: 0,
        value: 0,
        enum: ['off', 'low', 'med', 'high']
    },
    exposure: {
        min: 0,
        max: 0,
        value: 0,
        enum: [
            'off',
            'auto',
            'night',
            'nightpreview',
            'backlight',
            'spotlight',
            'sports',
            'snow',
            'beach',
            'verylong',
            'fixedfps',
            'antishake',
            'fireworks'
        ]
    },
    encoding: {
        name: "File Encoding",
        min: 0,
        max: 0,
        value: 0,
        enum: ['jpg', 'png', 'gif', 'bmp']
    },
    metering: {
        name: "Light Metering",
        min: 0,
        max: 0,
        value: 0,
        enum: ['average', 'spot', 'backlit', 'matrix']
    },
    imxfx: {
        name: "Image Effects",
        min: 0,
        max: 0,
        value: 0,
        enum: [
            'none',
            'negative',
            'solarise',
            'sketch',
            'denoise',
            'emboss',
            'oilpaint',
            'hatch',
            'gpen',
            'pastel',
            'watercolour',
            'film',
            'blur',
            'saturation',
            'colourswap',
            'washedout',
            'posterise',
            'colourpoint',
            'colourbalance',
            'cartoon'
        ]
    },
    reduction: {
        name: "BG resize",
        min: 1,
        max: 10,
        value: 3,
        enum: [1,2,3,4,5,10],
        format(value) {
            value = Number(value);
            let perc = 1/value * 100 >> 0;
            return `${perc}%`;
        }
    },
    continuous: {
        name: "Work hours",
        min: 0,
        max: 1,
        value: 0,
        enum: ["false", "true"],
        format (value) {
            console.log(value);
            const bool = /^true/i.test(value);
            return bool ? "Day & Night" : "Dawn to Dusk";
        }
    },
    preview: {
        min: 0,
        max: 1,
        value: 0,
        enum: ["false", "true"]
    },
    bracket: {
        min: 0,
        max: 4,
        value: 0,
        format(value) {
            value = Number(value);
            const max = 24;
            const ev = max / value >> 0;
            // const count = (value * 2) + 1;
            let html = `${value} EV±${ev}`;
            html = value ? html : "None";
            return html;
        }
    }
};
