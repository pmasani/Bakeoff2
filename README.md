# DOF Target Alignment (Processing)

Interactive sketches exploring multi-degree-of-freedom manipulation (translate, rotate, scale) for aligning a “logo” square to a randomly placed/rotated/scaled destination square. Implemented in **Processing**. ([GitHub][1])

## ✨ What’s inside

* **`Bakeoff4DOF_FP.pde`** – main 4-DOF bakeoff sketch (final pass). ([GitHub][1])
* **`Bakeoff4DOF/processing/bakeoff4DOF`** – supporting folder for the 4-DOF sketch. ([GitHub][2])
* **`GOOD DRAG PROTOTYPE`** – early interaction prototype focused on robust dragging. ([GitHub][1])
* **`prototype 1`** – first experimental prototype. ([GitHub][1])
* **`color_change_basic.pde`** – minimal color-change interaction demo. ([GitHub][1])
* **`mode_switch.pde`** – demo of mode switching patterns for interaction. ([GitHub][1])

> Repo is 100% **Processing** source. ([GitHub][1])

## 🧠 Goal

Given a destination square with random position, rotation, and scale, quickly and accurately transform the logo square until it matches the destination (within a tolerance). The sketches explore input mappings, feedback, and interaction modes to minimize time and errors.

## 📦 Requirements

* **Processing 4.x** (or 3.x should also work for these PDEs)
  Download from processing.org and open the `.pde` files directly.

## 🚀 Getting started

1. **Clone** the repo:

   ```bash
   git clone https://github.com/pmasani/Bakeoff2.git
   cd Bakeoff2
   ```
2. **Open** a sketch in Processing:

   * For the final bakeoff: open `Bakeoff4DOF_FP.pde`.
   * You can also open the prototypes (`GOOD DRAG PROTOTYPE`, `prototype 1`) and the small demos (`color_change_basic.pde`, `mode_switch.pde`) to compare interaction ideas.
3. **Run** the sketch (▶ in Processing).

## 🎮 How to use (general)

* The app spawns a **destination** square and a **logo** square.
* Interact to **translate**, **rotate**, and **scale** the logo until it visually matches the destination.
* Most sketches display **on-screen hints or mode labels**. If you’re tweaking behavior, read the top of each `.pde` for key bindings and parameters.

> Tip: The prototypes and demos isolate specific mechanics (drag quality, mode switching, color feedback) so you can evaluate each concept before the full 4-DOF task.

## 🧪 Measuring performance

The “bakeoff” framing emphasizes **speed** with **accuracy thresholds**. To adapt evaluation:

* Add timing with `millis()` around trial start/end.
* Track success when pose error (position/rotation/scale) falls under a tolerance.
* Log per-trial metrics (time, error, attempts) to a CSV for analysis.

## 🗂️ Project structure (high level)

```
Bakeoff2/
├── Bakeoff4DOF/processing/bakeoff4DOF/   # 4-DOF sketch support
├── Bakeoff4DOF_FP.pde                     # 4-DOF (final pass)
├── GOOD DRAG PROTOTYPE/                   # drag-only prototype
├── prototype 1/                           # early prototype
├── color_change_basic.pde                 # minimal color feedback demo
└── mode_switch.pde                        # mode switching demo
```

## ⚙️ Customization ideas

* **Tolerance & scoring:** expose constants for position/angle/scale thresholds.
* **Visual feedback:** add ghosting, snap lines, or match “glow” when within tolerance.
* **Input mapping:** experiment with mouse vs. key-modified modes, scroll-to-scale, etc.
* **Data logging:** write CSV lines per trial for downstream analysis in Python/R.

## 🐛 Troubleshooting

* **Sketch won’t open?** Ensure the main `.pde` file is opened from the folder that contains any referenced assets (Processing expects a matching folder structure).
* **Rendering glitches?** Try switching the renderer to `P2D` or `JAVA2D` in `size()`.

## 📄 License

Add your preferred license (e.g., MIT) here.
