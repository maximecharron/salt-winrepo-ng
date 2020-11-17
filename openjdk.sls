# Installs the WMI Exporter used by prometheus to scrape metrics from windows based systems
# WMI Exporter: https://github.com/martinlindhe/wmi_exporter
# Prometheus Monitoring: https://prometheus.io/

{% set versions = [
                   ('1.8.0_275', '8u275-b01', '8u275b01'),
                   ('1.8.0_272', '8u272-b10', '8u272b10'),
                   ('1.8.0_265', '8u265-b01', '8u275b01'),
                   ('1.8.0_262', '8u262-b10', '8u262b10'),
                   ('1.8.0_252', '8u252-b09', '8u252b09'),
                   ('1.8.0_242', '8u242-b08', '8u242b08'),
                   ('1.8.0_232', '8u232-b09', '8u232b09'),
                   ('1.8.0_222', '8u222-b10', '8u222b10'),
                   ('1.8.0_212', '8u212-b04', '8u212b04')
] %}


openjdk:
{% for version, version_tag, raw_version in versions %}
  '{{ version }}':
    full_name: 'Adopt Open JDK {{ version }}'
    {% set package_arch = 'x86-32' %}
    {% if grains['cpuarch'] == 'AMD64' %}
      {% set package_arch = 'x64' %}
    {% endif %}
    installer:   'https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk{{version_tag}}/OpenJDK8U-jdk_{{package_arch}}_windows_hotspot_{{raw_version}}.msi'
    uninstaller: 'https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk{{version_tag}}/OpenJDK8U-jdk_{{package_arch}}_windows_hotspot_{{raw_version}}.msi'
    install_flags: 'INSTALLLEVEL=3 /quiet'
    uninstall_flags: ''
    msiexec: True
    locale: en_US
    reboot: False
{% endfor %}
