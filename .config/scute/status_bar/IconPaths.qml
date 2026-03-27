pragma Singleton
import Quickshell

Singleton {
    function getNetworkIcon() {
        const assets_folder = "./Assets/";
        if (NetworkService.ethernet) {
            return assets_folder + "ethernet.svg";
        }
        if (NetworkService.wifi) {
            const strength = NetworkService.networkStrength;
            if (strength >= 80) {
                return assets_folder + "wifi.svg";
            } else if (strength >= 60) {
                return assets_folder + "wifi-2.svg";
            } else {
                return assets_folder + "wifi-1.svg";
            }
        }
        return assets_folder + "wifi-off.svg";
    }
    function getBluetoothIcon() {
        const assets_folder = "./Assets/";
        const connected = "bluetooth-connected.svg";

        const available = "bluetooth.svg";

        const unavailable = "bluetooth-disabled.svg";

        if (BluetoothService.available && BluetoothService.enabled) {
            if (BluetoothService.connected) {
                return assets_folder + connected;
            } else {
                return assets_folder + available;
            }
        } else {
            return assets_folder + unavailable;
        }
    }
    function getDriveIcon(kind) {
        const assets_folder = "./Assets/";
        const hdd = "hdd.svg";

        const ssd = "ssd.svg";

        if (kind === "HDD") {
            return assets_folder + hdd;
        } else if (kind === "SSD") {
            return assets_folder + ssd;
        } else {
            return assets_folder + ssd;
        }
    }
}
