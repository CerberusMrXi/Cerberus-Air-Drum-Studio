<div align="center">

# Cerberus Air Drum Studio

**A webcam-powered virtual drum kit with real-time hand tracking, expressive strike detection, and studio-style drum playback.**

[![Version](https://img.shields.io/badge/version-5.0-2563eb?style=flat-square)](https://github.com/sudeepa-w/cerberus-air-drum-studio)[![License](https://img.shields.io/badge/license-MIT-16a34a?style=flat-square)](LICENSE)[![Hand Tracking](https://img.shields.io/badge/hand%20tracking-MediaPipe-9333ea?style=flat-square)](https://ai.google.dev/edge/mediapipe/solutions/vision/hand_landmarker)[![Web Audio](https://img.shields.io/badge/audio-Web%20Audio%20API-f97316?style=flat-square)](https://developer.mozilla.org/docs/Web/API/Web_Audio_API)

[Get Started](#getting-started) · [Controls](#controls) · [Architecture](#architecture) · [Troubleshooting](#troubleshooting)

</div>

> **Play drums in the air—no dedicated hardware required.** Cerberus Air Drum Studio uses a webcam to translate natural hand movement into responsive drum performance.

## Table of Contents

| Section | Description |
| --- | --- |
| [Overview](#overview) | What the studio does and who it is for |
| [Feature Set](#feature-set) | Performance, audio, and interface capabilities |
| [Getting Started](#getting-started) | Requirements, installation, and launch instructions |
| [Playing the Kit](#playing-the-kit) | Pad layout, gesture controls, and keyboard mapping |
| [Audio, Recording, and Playback](#audio-recording-and-playback) | Available kits, effects, and session capture |
| [Architecture](#architecture) | High-level real-time processing flow |
| [Project Reference](#project-reference) | Directory layout, compatibility, and troubleshooting |

## Overview

**Cerberus Air Drum Studio** turns a browser and webcam into an expressive, hand-controlled drum instrument. The application detects both hands, maps their positions to six virtual pads, and identifies downward strike motion to trigger velocity-sensitive drum sounds. It is designed for rapid experimentation, casual performance, musical sketching, and interactive demonstrations without requiring a physical MIDI controller or electronic drum kit.

The studio combines client-side hand landmark tracking with browser audio processing. MediaPipe provides the real-time hand-landmark capability used by the interaction layer, while the Web Audio API supplies low-latency browser audio primitives. [1] [2] A visual canvas provides immediate feedback for pad focus, successful hits, and current playback state.

## Feature Set

| Area | Capability | Practical benefit |
| --- | --- | --- |
| **Hand interaction** | Dual-hand tracking with a mirrored camera view | Play naturally as if looking into a mirror, using both hands at once. |
| **Drum performance** | Six playable pads with downward-strike detection | Trigger kick, snare, hi-hat, crash, tom, and ride sounds in the air. |
| **Expression** | Velocity-sensitive triggering | More deliberate strikes produce greater output intensity. |
| **Sound design** | Acoustic, Electronic, and Trap kits | Quickly adapt the instrument to different musical directions. |
| **Mix control** | Master volume, reverb, and dynamics processing | Shape the output for practice, demonstration, or creative experimentation. |
| **Performance capture** | Timestamped event recording and playback | Review an idea immediately after performing it. |
| **Alternative input** | Complete keyboard mapping | Test the application or play without camera interaction. |
| **Responsive interface** | Desktop and mobile-aware layout | Maintain a usable studio interface across common screen sizes. |

## How It Works

The application continuously processes the webcam stream and resolves a short real-time pipeline. First, the vision layer identifies hand landmarks. The interaction layer then converts those landmark positions into pad regions in the mirrored canvas. When it detects a qualifying downward motion inside a pad, the event processor calculates velocity, plays the corresponding sound, updates the canvas, and—in an active recording session—stores the hit with a timestamp.

```
Webcam stream
     │
     ▼
MediaPipe hand landmarks
     │
     ▼
Mirrored position mapping ──► Pad hover feedback
     │
     ▼
Downward-strike detection
     │
     ├──► Velocity calculation ──► Audio playback and effects
     │
     └──► Timestamped event recording (when enabled)
```

## Getting Started

### Prerequisites

Cerberus Air Drum Studio runs entirely in a modern browser. For the best experience, use a device with a working webcam, reliable lighting, and an active internet connection when the application is configured to load its tracking resources or samples from a CDN.

| Requirement | Recommended configuration |
| --- | --- |
| **Browser** | Current Chrome, Edge, Firefox, Safari, or Opera release |
| **Camera** | Integrated or external webcam with permission enabled |
| **Connection** | Internet access for CDN-hosted dependencies and samples |
| **Runtime context** | `localhost` or HTTPS, as required by browser camera-permission rules |
| **Environment** | A local static-file server; no build step is required for the supplied structure |

### Installation

Clone the repository and enter the project directory.

```bash
git clone https://github.com/sudeepa-w/cerberus-air-drum-studio.git
cd cerberus-air-drum-studio
```

Start the included local server appropriate to your operating system.

| Platform | Command |
| --- | --- |
| **Windows** | `start-server.bat` |
| **macOS / Linux** | `chmod +x start-server.sh && ./start-server.sh` |
| **Any platform with Python 3** | `python3 -m http.server 8080` |

Open the application in your browser.

```
http://localhost:8080/system/ads.html
```

Select **Launch Studio**, grant camera access when prompted, and wait for sample loading to finish. Keep your hands within the camera frame, move over a pad to focus it, and make a clear downward motion to trigger a sound.

> **Camera permission note:** Web browsers generally restrict camera access to secure contexts, such as HTTPS pages and `localhost`. Running the project through a local server rather than opening the HTML file directly is therefore essential. [3]

## Playing the Kit

### Pad Layout

The virtual kit uses a two-column, three-row layout. Each pad has a direct keyboard equivalent for accessible testing and alternate performance input.

| Row | Left pad | Right pad |
| --- | --- | --- |
| **Top** | Kick — `Z` | Snare — `X` |
| **Middle** | Hi-Hat — `C` | Crash — `V` |
| **Bottom** | Tom — `B` | Ride — `N` |

### Gesture Controls

Gesture controls are intended to keep core performance operations accessible without leaving the camera interface. Use clear, deliberate gestures and maintain steady lighting for more reliable recognition.

| Gesture | Action |
| --- | --- |
| **Hand over a pad** | Highlights the pad under the detected hand. |
| **Downward strike** | Triggers the selected drum sound using calculated velocity. |
| **Peace sign** | Starts or stops recording. |
| **Fist** | Resets tempo to 120 BPM. |
| **Thumbs up** | Increases tempo by 5 BPM. |
| **Thumbs down** | Decreases tempo by 5 BPM. |

### Keyboard Shortcuts

| Key | Action |
| --- | --- |
| `Z` | Kick drum |
| `X` | Snare drum |
| `C` | Hi-hat |
| `V` | Crash cymbal |
| `B` | Tom |
| `N` | Ride cymbal |
| `Space` | Start or pause the metronome |
| `R` | Start or stop recording |
| `F` | Reset tempo to 120 BPM |
| `↑` / `↓` | Increase or decrease tempo by 5 BPM |
| `P` | Play the current recording |

## Audio, Recording, and Playback

### Drum Kits

The application provides three distinct sound palettes. Selecting a kit changes the musical character while preserving the same gesture and keyboard interaction model.

| Kit | Character | Suitable use |
| --- | --- | --- |
| **Acoustic** | Warm, natural, sampled drum tone | Practice, songwriting, and conventional drum patterns |
| **Electronic** | Punchy, synthesized, contemporary tone | Electronic music, dance, and sound-design experiments |
| **Trap** | Deep kicks, crisp snares, and 808-oriented texture | Trap rhythms and modern beat sketching |

### Effects and Signal Handling

The audio path includes master volume management, adjustable reverb, and dynamics compression. Sample-based playback is used when samples are available; the application can fall back to oscillator-based browser synthesis so the interaction remains demonstrable when sample playback is unavailable.

| Control or process | Description |
| --- | --- |
| **Master volume** | Adjusts final output from 0–100%. |
| **Reverb** | Adjusts the wet/dry effect mix from 0–100%. |
| **Compression** | Controls dynamics for a more consistent and punchy output. |
| **Velocity mapping** | Maps strike intensity to sound level for more expressive performance. |
| **Fallback synthesis** | Uses Web Audio oscillators if sampled audio cannot be played. |

### Recording Workflow

A recording session captures each triggered hit with its time position, allowing the performance to be replayed through the selected audio setup.

1. Start recording with the **peace-sign gesture** or the `R` key.

1. Perform with hand gestures, keyboard input, or a combination of both.

1. Stop recording with the same gesture or key.

1. Review the recorded hit list and use playback to hear the performance again.

1. Use the clear control to discard the current recording and start a new take.

## Architecture

Cerberus Air Drum Studio is a client-side web application structured around independent real-time responsibilities. Separating vision, interaction, audio, rendering, and recording keeps the playing loop understandable and makes future features—such as MIDI output or multi-track capture—easier to add.

| Layer | Responsibility | Primary technologies |
| --- | --- | --- |
| **Capture** | Requests and renders the webcam stream | `getUserMedia`, HTML video |
| **Vision** | Detects hand landmarks for both hands | MediaPipe hand-landmark tracking [1] |
| **Interaction** | Mirrors coordinates, resolves pad bounds, and detects strikes | JavaScript motion analysis |
| **Audio** | Plays samples or synthesis and applies effects | Web Audio API; sample playback [2] |
| **Presentation** | Draws pads, hand feedback, and session state | Canvas 2D, HTML, CSS |
| **Session** | Stores trigger events and coordinates playback | In-memory timestamped event buffer |

```
┌──────────────┐     ┌───────────────────┐     ┌──────────────────┐
│ Webcam input │ ──► │ Hand-landmark     │ ──► │ Position and     │
│              │     │ detection         │     │ strike processing│
└──────────────┘     └───────────────────┘     └───────┬──────────┘
                                                       │
                 ┌─────────────────────────────────────┼─────────────────────────────────────┐
                 ▼                                     ▼                                     ▼
        ┌────────────────┐                   ┌────────────────┐                    ┌────────────────┐
        │ Canvas feedback│                   │ Audio engine   │                    │ Recording buffer│
        └────────────────┘                   └────────────────┘                    └────────────────┘
```

## Project Reference

### Repository Structure

```
cerberus-air-drum-studio/
├── system/
│   └── ads.html          # Main browser application
├── start-server.sh       # macOS/Linux local-server launcher
├── start-server.bat      # Windows local-server launcher
├── README.md             # Project documentation
└── LICENSE               # MIT License terms
```

### Browser Compatibility

| Browser | Minimum version | Expected support |
| --- | --- | --- |
| Chrome | 80+ | Full |
| Microsoft Edge | 80+ | Full |
| Firefox | 75+ | Full |
| Safari | 14+ | Full |
| Opera | 67+ | Full |

Browser support can vary with device hardware, camera availability, and the vendor’s implementation of media and audio APIs. For the most predictable performance and lowest practical latency, test on a recent desktop version of Chrome or Edge.

### Performance Guidance

| Practice | Why it helps |
| --- | --- |
| Use bright, even front lighting | Helps the vision system distinguish hands clearly. |
| Keep the background simple | Reduces visual distractions around the playing area. |
| Stay inside the frame | Ensures landmarks remain visible and stable. |
| Make clear downward strikes | Improves separation between intentional hits and incidental movement. |
| Close unnecessary browser tabs | Leaves more CPU and GPU capacity for vision and audio processing. |
| Use a recent Chromium-based browser | Typically offers the most consistent real-time browser performance. |

## Troubleshooting

| Issue | Likely cause | Recommended resolution |
| --- | --- | --- |
| Camera does not start | The browser blocked camera access or the page is not in a secure context. | Allow camera permission, run through `localhost` or HTTPS, and reload the page. |
| Hands are not detected reliably | Insufficient lighting, cluttered background, or hands outside the frame. | Improve front lighting, simplify the background, and keep hands visible. |
| No drum sound is heard | Muted system output, suspended browser audio context, or denied audio permissions. | Check system volume, interact with the page to unlock audio, then reload if needed. |
| Samples do not load | A network issue or blocked CDN resource. | Confirm the internet connection and review the browser console for failed resource requests. |
| Performance feels delayed | Resource contention or limited camera/browser performance. | Close other tabs, use a recent browser, and lower the camera resolution if the application exposes that setting. |
| Gestures trigger unexpectedly | Motion thresholds are too sensitive for the environment. | Use more deliberate gestures, stabilize lighting, and avoid moving hands rapidly between pads. |

## Roadmap

The following enhancements are proposed for future versions. They are not included in the current release unless explicitly marked as complete in the project’s issue tracker.

- [ ] 3D pad visualization using Three.js

- [ ] Custom sample upload and kit authoring

- [ ] MIDI export

- [ ] Multi-track recording

- [ ] Audio export in WAV and MP3 formats

- [ ] Session sharing

- [ ] Enhanced mobile touch support

- [ ] AI-assisted rhythm analysis

- [ ] Multi-user jam sessions

## Contributing

Contributions that improve interaction reliability, audio quality, browser compatibility, accessibility, or documentation are welcome. Please begin by opening an issue describing the proposed change or bug, then create a focused branch and submit a pull request with a concise explanation of the update and the testing performed.

When contributing, preserve the project’s client-side architecture where practical, avoid committing credentials or private samples, and test camera and keyboard flows before requesting review.

## License

This project is distributed under the **MIT License**. See the [LICENSE](LICENSE) file for the full license text.

## Author

**Sudeepa Wanigarathna**

| Resource | Link |
| --- | --- |
| GitHub | [@sudeepa-w](https://github.com/sudeepa-w) |
| Project repository | [Cerberus Air Drum Studio](https://github.com/sudeepa-w/cerberus-air-drum-studio) |

## Acknowledgments

Cerberus Air Drum Studio is built on the work of the following open web and creative technology projects.

| Project | Contribution |
| --- | --- |
| [MediaPipe](https://ai.google.dev/edge/mediapipe/solutions/vision/hand_landmarker) | Hand landmark tracking concepts and tooling [1] |
| [Tone.js](https://tonejs.github.io/) | Web-audio framework and sample-oriented music tooling [4] |
| [Web Audio API](https://developer.mozilla.org/docs/Web/API/Web_Audio_API) | Browser-native audio processing primitives [2] |
| [Three.js](https://threejs.org/) | Inspiration for planned 3D visualization work [5] |

If this project is useful, consider starring the repository and sharing it with musicians, educators, and developers exploring creative interaction on the web.

---
⭐ Support

If you find this project useful, please give it a ⭐ on GitHub and share it with fellow musicians and developers!

Built with ❤️ and 🥁 by Sudeepa Wanigarathna

> *“The future of music production is in your hands—literally.”*
