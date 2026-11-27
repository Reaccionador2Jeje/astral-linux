#!/usr/bin/env python3
"""Generate original, tiny ASTRAL desktop sound cues (no sampled OS sounds)."""
import math
import os
import struct
import wave

ROOT = os.environ.get("ASTRAL_SOUND_ROOT", "/usr/share/sounds")
RATE = 22050
PROFILES = {
    "PIXEL": {"notes": (660, 880, 990), "wave": "sine", "length": 0.16},
    "DOSERA": {"notes": (440, 660, 550), "wave": "square", "length": 0.12},
    "MOSAIC": {"notes": (523, 659, 784), "wave": "sine", "length": 0.20},
    "FORGE": {"notes": (392, 494, 587), "wave": "triangle", "length": 0.14},
    "NOVA": {"notes": (784, 988, 1175), "wave": "sine", "length": 0.22},
}
EVENTS = {
    "desktop-login": (0, 1, 2),
    "desktop-logout": (2, 1, 0),
    "message-new-instant": (1, 2),
    "dialog-warning": (2, 0),
    "dialog-error": (0, 0, 0),
    "device-added": (0, 2),
    "device-removed": (2, 0),
}

def sample(kind, phase):
    if kind == "square":
        return 1.0 if math.sin(phase) >= 0 else -1.0
    if kind == "triangle":
        return (2.0 / math.pi) * math.asin(math.sin(phase))
    return math.sin(phase)

def write_tone(path, notes, profile, duration):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    frames = bytearray()
    count = int(RATE * duration)
    segments = len(notes)
    for i in range(count):
        t = i / RATE
        segment = min(int(t / (duration / segments)), segments - 1)
        local = (t - segment * duration / segments) / (duration / segments)
        fade = min(1.0, local * 12.0, (1.0 - local) * 8.0)
        freq = notes[segment]
        value = sample(profile["wave"], 2 * math.pi * freq * t) * fade * 0.22
        frames.extend(struct.pack("<h", int(max(-1, min(1, value)) * 32767)))
    with wave.open(path, "wb") as out:
        out.setnchannels(1)
        out.setsampwidth(2)
        out.setframerate(RATE)
        out.writeframes(frames)

def main():
    for name, profile in PROFILES.items():
        theme = f"ASTRAL-{name}"
        directory = os.path.join(ROOT, theme, "stereo")
        os.makedirs(directory, exist_ok=True)
        with open(os.path.join(ROOT, theme, "index.theme"), "w", encoding="utf-8") as index:
            index.write("[Sound Theme]\nName=" + theme + "\nInherits=freedesktop\nDirectories=stereo\n\n[stereo]\nOutputProfile=stereo\n")
        for event, sequence in EVENTS.items():
            notes = [profile["notes"][n] for n in sequence]
            duration = profile["length"] * len(notes)
            write_tone(os.path.join(directory, event + ".wav"), notes, profile, duration)
    print("Generated five original ASTRAL sound themes.")

if __name__ == "__main__":
    main()
