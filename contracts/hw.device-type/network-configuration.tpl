{{#if (or hw.device-type.data.connectivity.wifi hw.device-type.data.usb)}}
{
  "isGroup": true,
  "name": "network",
  "message": "Network",
  "options": [
    {
      "message": "Network Connection",
      "name": "network",
      "type": "list",
      "choices": [
        "ethernet",
        "wifi"
      ]
    },
    {
      "message": "Wifi SSID",
      "name": "wifiSsid",
      "type": "text",
      "when": {
        "network": "wifi"
      }
    },
    {
      "message": "Wifi Passphrase",
      "name": "wifiKey",
      "type": "password",
      "when": {
        "network": "wifi"
      }
    }
  ]
},
{{/if}}
