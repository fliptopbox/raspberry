
export default ttl;
function ttl (next) {
    const {time, timestamp, sleep, server} = next;
    const { UTC, stayawake, sunrise, sunset } = time;
    const active = (UTC > sunrise && UTC < sunset) || stayawake;

    if (!active) return {};

    console.log(timestamp)

    const [yyyy, mm, dd, hh, mn, ss] = new Date(timestamp)
        .toISOString()
        .split(/[\-T\.\:Z]+/g)
        .map(v => Number(v));

    const interval = sleep.interval * 1000;
    const runtime = server.runtime * 1000;
    const totaltime = interval + runtime;

    const now = new Date().valueOf();
    const modified = Date.UTC(yyyy, mm - 1, dd, hh, mn, ss);
    const expires = new Date(modified).valueOf() + totaltime;
    const remainder = (expires - now) || 0;

    return {
        now,
        modified,
        expires,
        totaltime,
        remainder
    }
}
