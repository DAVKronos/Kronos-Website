

function getLocalSettings(key) {
    let settings = localStorage.getItem('kronos-settings')

    if (settings) {
        settings = JSON.parse(settings);
        return settings[key];
    }
    return null;
}

function setLocalSettings(key, value) {
    let settings = localStorage.getItem('kronos-settings')

    if (settings) {
        settings = JSON.parse(settings);
        
    } else {
        settings = {}
    }
    settings[key] = value;
    localStorage.setItem('kronos-settings', JSON.stringify(settings))
}

export {getLocalSettings, setLocalSettings}