// Make sure the values are NEVER null
const Map<String, dynamic> actualApiDataStructure = {
  "end_device_ids": {
    "device_id": "pilotdevice01",
    "application_ids": {"application_id": "pilot-test"},
    "dev_eui": "A8610A3436385E17",
    "join_eui": "0000000000000000",
    "dev_addr": "260B9807",
  },
  "correlation_ids": ["gs:uplink:01JYMHW1HH8X00K2TB0ZKF03KB"],
  "received_at": "2025-06-25T22:03:26.852419179Z",
  "uplink_message": {
    "session_key_id": "AZK+fJbq91LVVe5EVA72dQ==",
    "f_port": 3,
    "f_cnt": 312590,
    "frm_payload": "fFwBuwugD1UAxgAFXMcAALcy",
    "decoded_payload": {
      "co2": 443,
      "humidity": 39.25,
      "packetCount": 351431,
      "pm25": 1.98,
      "pressure": 318.36,
      "temperature": 29.76,
    },
    "rx_metadata": [
      {
        "gateway_ids": {
          "gateway_id": "eui-a84041ffff22def8",
          "eui": "A84041FFFF22DEF8",
        },
        "timestamp": 4123877834,
        "rssi": -118,
        "channel_rssi": -118,
        "snr": -2.2,
        "frequency_offset": "-100",
        "uplink_token":
            "CiIKIAoUZXVpLWE4NDA0MWZmZmYyMmRlZjgSCKhAQf//It74EMrDta4PGgwIruTxwgYQ/IDJrwIgkPqX0oL5Uw==",
        "channel_index": 4,
        "received_at": "2025-06-25T22:03:25.752280887Z",
      },
    ],
    "settings": {
      "data_rate": {
        "lora": {
          "bandwidth": 125000,
          "spreading_factor": 10,
          "coding_rate": "4/5",
        },
      },
      "frequency": "867300000",
      "timestamp": 4123877834,
    },
    "received_at": "2025-06-25T22:03:26.644329960Z",
    "confirmed": true,
    "consumed_airtime": "0.452608s",
    "version_ids": {
      "brand_id": "arduino",
      "model_id": "mkr-wan-1310",
      "hardware_version": "1.0",
      "firmware_version": "1.2.3",
      "band_id": "EU_863_870",
    },
    "network_ids": {
      "net_id": "000013",
      "ns_id": "EC656E0000000181",
      "tenant_id": "ttn",
      "cluster_id": "eu1",
      "cluster_address": "eu1.cloud.thethings.network",
    },
  },
};
const List actualListIncomingAPI = [
  {
    "end_device_ids": {
      "device_id": "pilotdevice05",
      "application_ids": {"application_id": "pilot-test"},
      "dev_eui": "A8610A32301F8516",
      "join_eui": "0000000000000000",
      "dev_addr": "260B5157",
    },
    "correlation_ids": ["gs:uplink:01JYH2YASTK8WFM8NYSG3Z9BCM"],
    "received_at": "2025-06-24T13:44:49.932561576Z",
    "uplink_message": {
      "session_key_id": "AZK+eoyAIs5kIrjtb8vzlQ==",
      "f_port": 3,
      "f_cnt": 320093,
      "frm_payload": "fGMBsAsKDaQA0gAFVcYAALcy",
      "decoded_payload": {
        "co2": 432,
        "humidity": 34.92,
        "packetCount": 349638,
        "pm25": 2.1,
        "pressure": 318.43,
        "temperature": 28.26,
      },
      "rx_metadata": [
        {
          "gateway_ids": {
            "gateway_id": "kerlink001",
            "eui": "7276FF0039090946",
          },
          "time": "2025-06-24T13:44:49.693743Z",
          "timestamp": 4107512588,
          "rssi": -93,
          "channel_rssi": -93,
          "snr": -6.5,
          "uplink_token":
              "ChgKFgoKa2VybGluazAwMRIIcnb/ADkJCUYQjNbOpg8aDAjR1+rCBhDvv+7XAiDgzdDWxY92",
          "channel_index": 2,
          "received_at": "2025-06-24T13:44:47.444880928Z",
        },
      ],
      "settings": {
        "data_rate": {
          "lora": {
            "bandwidth": 125000,
            "spreading_factor": 9,
            "coding_rate": "4/5",
          },
        },
        "frequency": "867500000",
        "timestamp": 4107512588,
        "time": "2025-06-24T13:44:49.693743Z",
      },
      "received_at": "2025-06-24T13:44:49.725487446Z",
      "confirmed": true,
      "consumed_airtime": "0.246784s",
      "version_ids": {
        "brand_id": "arduino",
        "model_id": "mkr-wan-1310",
        "hardware_version": "1.0",
        "firmware_version": "1.2.3",
        "band_id": "EU_863_870",
      },
      "network_ids": {
        "net_id": "000013",
        "ns_id": "EC656E0000000181",
        "tenant_id": "ttn",
        "cluster_id": "eu1",
        "cluster_address": "eu1.cloud.thethings.network",
      },
    },
  },
  {
    "end_device_ids": {
      "device_id": "pilotdevice03",
      "application_ids": {"application_id": "pilot-test"},
      "dev_eui": "A8610A3230257716",
      "join_eui": "0000000000000000",
      "dev_addr": "260B7DCD",
    },
    "correlation_ids": ["gs:uplink:01JYH2Z0SZTXRVE8C4VB6FDFWN"],
    "received_at": "2025-06-24T13:45:12.466683248Z",
    "uplink_message": {
      "session_key_id": "AZRPTG/CtyIsBAAURaMeNA==",
      "f_port": 3,
      "f_cnt": 212819,
      "frm_payload": "fHkBrgqzDcwAwQADoCcAALcy",
      "decoded_payload": {
        "co2": 430,
        "humidity": 35.32,
        "packetCount": 237607,
        "pm25": 1.93,
        "pressure": 318.65,
        "temperature": 27.39,
      },
      "rx_metadata": [
        {
          "gateway_ids": {
            "gateway_id": "kerlink001",
            "eui": "7276FF0039090946",
          },
          "time": "2025-06-24T13:45:12.214480Z",
          "timestamp": 4130033316,
          "rssi": -70,
          "channel_rssi": -70,
          "snr": 10.8,
          "uplink_token":
              "ChgKFgoKa2VybGluazAwMRIIcnb/ADkJCUYQpJ2tsQ8aCwjo1+rCBhDj9OV4IKDhrMmZkHY=",
          "channel_index": 6,
          "received_at": "2025-06-24T13:45:09.977294857Z",
        },
        {
          "gateway_ids": {
            "gateway_id": "eui-a84041ffff22def8",
            "eui": "A84041FFFF22DEF8",
          },
          "timestamp": 3793675033,
          "rssi": -118,
          "channel_rssi": -118,
          "snr": -8.2,
          "frequency_offset": "102",
          "uplink_token":
              "CiIKIAoUZXVpLWE4NDA0MWZmZmYyMmRlZjgSCKhAQf//It74EJnG+5AOGgsI6NfqwgYQ5IHjeiCos5zFtMA5",
          "channel_index": 1,
          "received_at": "2025-06-24T13:45:12.240285025Z",
        },
      ],
      "settings": {
        "data_rate": {
          "lora": {
            "bandwidth": 125000,
            "spreading_factor": 11,
            "coding_rate": "4/5",
          },
        },
        "frequency": "868300000",
        "timestamp": 4130033316,
        "time": "2025-06-24T13:45:12.214480Z",
      },
      "received_at": "2025-06-24T13:45:12.255703475Z",
      "confirmed": true,
      "consumed_airtime": "0.987136s",
      "version_ids": {
        "brand_id": "arduino",
        "model_id": "mkr-wan-1310",
        "hardware_version": "1.0",
        "firmware_version": "1.2.3",
        "band_id": "EU_863_870",
      },
      "network_ids": {
        "net_id": "000013",
        "ns_id": "EC656E0000000181",
        "tenant_id": "ttn",
        "cluster_id": "eu1",
        "cluster_address": "eu1.cloud.thethings.network",
      },
    },
  },
  {
    "end_device_ids": {
      "device_id": "pilotdevice01",
      "application_ids": {"application_id": "pilot-test"},
      "dev_eui": "A8610A3436385E17",
      "join_eui": "0000000000000000",
      "dev_addr": "260B9807",
    },
    "correlation_ids": ["gs:uplink:01JYH2Z2FSMC1TE3QHCBEAHB9W"],
    "received_at": "2025-06-24T13:45:14.187275160Z",
    "uplink_message": {
      "session_key_id": "AZK+fJbq91LVVe5EVA72dQ==",
      "f_port": 3,
      "f_cnt": 311267,
      "frm_payload": "fJ8BsQuADGgAzwAFVT4AALcy",
      "decoded_payload": {
        "co2": 433,
        "humidity": 31.76,
        "packetCount": 349502,
        "pm25": 2.07,
        "pressure": 319.03,
        "temperature": 29.44,
      },
      "rx_metadata": [
        {
          "gateway_ids": {
            "gateway_id": "eui-a84041ffff22dea4",
            "eui": "A84041FFFF22DEA4",
          },
          "timestamp": 3764742950,
          "rssi": -118,
          "channel_rssi": -118,
          "snr": -18.8,
          "frequency_offset": "-198",
          "uplink_token":
              "CiIKIAoUZXVpLWE4NDA0MWZmZmYyMmRlYTQSCKhAQf//It6kEKbWlYMOGgwI6dfqwgYQgI+w0QMg8Jiq4cjPCg==",
          "received_at": "2025-06-24T13:45:13.975964032Z",
        },
        {
          "gateway_ids": {
            "gateway_id": "kerlink001",
            "eui": "7276FF0039090946",
          },
          "time": "2025-06-24T13:45:13.919160Z",
          "timestamp": 4131737996,
          "rssi": -56,
          "channel_rssi": -56,
          "snr": 8.5,
          "uplink_token":
              "ChgKFgoKa2VybGluazAwMRIIcnb/ADkJCUYQjKOVsg8aDAjp1+rCBhDytJHSAyDglZr2n5B2",
          "channel_index": 5,
          "received_at": "2025-06-24T13:45:11.701525016Z",
        },
        {
          "gateway_ids": {
            "gateway_id": "eui-a84041ffff22def8",
            "eui": "A84041FFFF22DEF8",
          },
          "timestamp": 3795379591,
          "rssi": -115,
          "channel_rssi": -115,
          "snr": 1,
          "frequency_offset": "-163",
          "uplink_token":
              "CiIKIAoUZXVpLWE4NDA0MWZmZmYyMmRlZjgSCKhAQf//It74EIfL45EOGgwI6dfqwgYQh9T5zwMg2K6C8rrAOQ==",
          "received_at": "2025-06-24T13:45:13.955784836Z",
        },
      ],
      "settings": {
        "data_rate": {
          "lora": {
            "bandwidth": 125000,
            "spreading_factor": 12,
            "coding_rate": "4/5",
          },
        },
        "frequency": "868100000",
        "timestamp": 3764742950,
      },
      "received_at": "2025-06-24T13:45:13.978268957Z",
      "confirmed": true,
      "consumed_airtime": "1.810432s",
      "version_ids": {
        "brand_id": "arduino",
        "model_id": "mkr-wan-1310",
        "hardware_version": "1.0",
        "firmware_version": "1.2.3",
        "band_id": "EU_863_870",
      },
      "network_ids": {
        "net_id": "000013",
        "ns_id": "EC656E0000000181",
        "tenant_id": "ttn",
        "cluster_id": "eu1",
        "cluster_address": "eu1.cloud.thethings.network",
      },
    },
  },
];
const Map<String, dynamic> apiFromDocumentation = {
  "name": "as.up.data.forward",
  "time": "2025-05-28T19:34:14.206425Z",
  "identifiers": [
    {
      "device_ids": {
        "device_id": "pilotdevice02",
        "application_ids": {"application_id": "pilot-test"},
        "dev_eui": "A8610A3230378316",
        "join_eui": "0000000000000000",
        "dev_addr": "260BED96",
      },
    },
  ],
  "data": {
    "@type": "type.googleapis.com/ttn.lorawan.v3.ApplicationUp",
    "end_device_ids": {
      "device_id": "pilotdevice02",
      "application_ids": {"application_id": "pilot-test"},
      "dev_eui": "A8610A3230378316",
      "join_eui": "0000000000000000",
      "dev_addr": "260BED96",
    },
    "correlation_ids": ["gs:uplink:01JWC66PQE3XY7H2H21FASJMW9"],
    "received_at": "2025-05-28T19:34:14.203818759Z",
    "uplink_message": {
      "session_key_id": "AZK+ev1SjvHPQqPySZa2Ew==",
      "f_port": 3,
      "f_cnt": 280418,
      "frm_payload": "fqUCFQlyEBgAPQAEvycAALcy",
      "decoded_payload": {
        "co2": 533,
        "humidity": 41.2,
        "packetCount": 311079,
        "pm25": 0.61,
        "pressure": 324.21,
        "temperature": 24.18,
      },
      "rx_metadata": [
        {
          "gateway_ids": {
            "gateway_id": "kerlink001",
            "eui": "7276FF0039090946",
          },
          "time": "2025-05-28T19:34:13.955830Z",
          "timestamp": 2965558316,
          "rssi": -70,
          "channel_rssi": -70,
          "snr": 8,
          "uplink_token":
              "ChgKFgoKa2VybGluazAwMRIIcnb/ADkJCUYQrKiLhgsaDAi1yt3BBhD65sHbAyDgl7PIp+qgAQ==",
          "channel_index": 2,
          "received_at": "2025-05-28T19:34:11.718601156Z",
        },
        {
          "gateway_ids": {
            "gateway_id": "eui-a84041ffff22def8",
            "eui": "A84041FFFF22DEF8",
          },
          "timestamp": 2629044847,
          "rssi": -119,
          "channel_rssi": -119,
          "snr": -7.8,
          "frequency_offset": "-105",
          "uplink_token":
              "CiIKIAoUZXVpLWE4NDA0MWZmZmYyMmRlZjgSCKhAQf//It74EO+U0OUJGgsItsrdwQYQgMWSAyCYg6P6wd2hAQ==",
          "channel_index": 5,
          "received_at": "2025-05-28T19:34:13.988488840Z",
        },
      ],
      "settings": {
        "data_rate": {
          "lora": {
            "bandwidth": 125000,
            "spreading_factor": 11,
            "coding_rate": "4/5",
          },
        },
        "frequency": "867500000",
        "timestamp": 2965558316,
        "time": "2025-05-28T19:34:13.955830Z",
      },
      "received_at": "2025-05-28T19:34:13.999572325Z",
      "confirmed": true,
      "consumed_airtime": "0.987136s",
      "version_ids": {
        "brand_id": "arduino",
        "model_id": "mkr-wan-1310",
        "hardware_version": "1.0",
        "firmware_version": "1.2.3",
        "band_id": "EU_863_870",
      },
      "network_ids": {
        "net_id": "000013",
        "ns_id": "EC656E0000000181",
        "tenant_id": "ttn",
        "cluster_id": "eu1",
        "cluster_address": "eu1.cloud.thethings.network",
      },
    },
  },
  "correlation_ids": ["gs:uplink:01JWC66PQE3XY7H2H21FASJMW9"],
  "origin": "ip-10-100-7-253.eu-west-1.compute.internal",
  "context": {"tenant-id": "CgN0dG4="},
  "visibility": {
    "rights": ["RIGHT_APPLICATION_TRAFFIC_READ"],
  },
  "unique_id": "01JWC66PXY4NCRQ68736ZBWZN0",
};
