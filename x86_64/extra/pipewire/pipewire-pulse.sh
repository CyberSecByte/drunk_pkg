if command -v pipewire-pulse > /dev/null; then
    # This is needed for applications like flatpak
    export PULSE_SERVER
    PULSE_SERVER=unix:/run/user/$(id -u)/pulse/native
fi
