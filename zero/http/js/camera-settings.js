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
        min:30,
        max: 360,
        value: 3 * 60, 
        step: 10,
        unit: 's'
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
    }
};
