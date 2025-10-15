# DOF Target Alignment (Processing)

Interactive sketches exploring multi-degree-of-freedom manipulation (translate, rotate, scale) for aligning a “logo” square to a randomly placed/rotated/scaled destination square. Implemented in **Processing**. 


## 🧠 Goal

Given a destination square with random position, rotation, and scale, quickly and accurately transform the logo square until it matches the destination (within a tolerance). The sketches explore input mappings, feedback, and interaction modes to minimize time and errors.


## 🎮 How to use (general)

* The app spawns a **destination** square and a **logo** square.
* Interact to **translate**, **rotate**, and **scale** the logo until it visually matches the destination.
* Most sketches display **on-screen hints or mode labels**. If you’re tweaking behavior, read the top of each `.pde` for key bindings and parameters.

> Tip: The prototypes and demos isolate specific mechanics (drag quality, mode switching, color feedback) so you can evaluate each concept before the full 4-DOF task.

## 🧪 Measuring performance

* Add timing with `millis()` around trial start/end.
* Track success when pose error (position/rotation/scale) falls under a tolerance.
* Log per-trial metrics (time, error, attempts) to a CSV for analysis.

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
