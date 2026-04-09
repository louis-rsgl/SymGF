# SymGF
[![DOI](https://img.shields.io/badge/DOI-10.1088%2F0953--8984%2F23%2F41%2F415301-blue.svg)](https://doi.org/10.1088/0953-8984/23/41/415301)

## 📌 Cite

This repository improves and extends the **SymGF** symbolic framework introduced in the following paper.

If you use this code in academic work, please cite:

```bibtex
@article{Feng_2011,
  doi = {10.1088/0953-8984/23/41/415301},
  url = {https://doi.org/10.1088/0953-8984/23/41/415301},
  year = {2011},
  month = {sep},
  publisher = {IOP Publishing},
  volume = {23},
  number = {41},
  pages = {415301},
  author = {Feng, Zimin and Sun, Qing-feng and Wan, Langhui and Guo, Hong},
  title = {SymGF: a symbolic tool for quantum transport analysis and its application to a double quantum dot system},
  journal = {Journal of Physics: Condensed Matter},
  abstract = {We report the development and an application of a symbolic tool, called SymGF, for analytical derivations of quantum transport properties using the Keldysh nonequilibrium Green’s function (NEGF) formalism. The inputs to SymGF are the device Hamiltonian in the second quantized form, the commutation relation of the operators and the truncation rules of the correlators. The outputs of SymGF are the desired NEGF that appear in the transport formula, in terms of the unperturbed Green’s function of the device scattering region and its coupling to the device electrodes. For complicated transport analysis involving strong interactions and correlations, SymGF provides significant assistance in analytical derivations. Using this tool, we investigate coherent quantum transport in a double quantum dot system where strong on-site interaction exists in the side-coupled quantum dot. Results obtained by the higher-order approximation and Hartree–Fock approximation are compared. The higher-order approximation reveals Kondo resonance features in the density of states and conductances. Results are compared both qualitatively and quantitatively to the experimental data reported in the literature.}
}
```

---

## 📖 About

**SymGF** is a symbolic Mathematica package for deriving nonequilibrium Green’s functions (NEGF) using the **equation-of-motion (EOM)** method in quantum transport problems.

It is designed for:

* Strongly interacting mesoscopic systems
* Anderson / quantum dot models
* Keldysh NEGF formalism
* Symbolic derivation of Green’s function hierarchies and decoupling schemes

Instead of doing long and error-prone hand derivations, SymGF:

* Takes a Hamiltonian in second-quantized operator form
* Uses operator commutation/anticommutation relations
* Applies user-defined truncation / decoupling rules
* Automatically generates and simplifies the EOM hierarchy

---

## 📂 Repository contents

* `SymGF.m` — Core Mathematica package
* `SymGF_Manual.nb` — Manual and documentation notebook
* `FengDefault.nb` — Formatting script

---

## 🧰 Requirements

* Wolfram **Mathematica**

---

## 🚀 Quick start

1. Clone your fork:

```bash
git clone https://github.com/louis-rsgl/SymGFplus.git
cd SymGF
```

2. Open Mathematica and set the working directory to this folder.

3. Load the package:

```mathematica
Get["SymGF.m"]
```

If needed:

```mathematica
Get[FileNameJoin[{NotebookDirectory[], "SymGF.m"}]]
```

4. Open and evaluate:

* `SymGF_Manual.nb` for a working example, documentation and usage patterns

---

## 🧠 Typical workflow

1. Define the Hamiltonian in second-quantized form
2. Define operator algebra (commutators / anticommutators)
3. Define correlator truncation / decoupling rules
4. Generate equation-of-motion chains
5. Solve and simplify symbolic Green’s function relations
6. Export expressions for analytical or numerical evaluation

---

## 🎯 Scope and philosophy

SymGF is focused on:

* Symbolic correctness
* Reproducibility of long EOM derivations
* Assisting human analytical work (not replacing physical modeling decisions)
* Handling complex interacting systems where manual derivation becomes intractable

---

## 🛠️ This fork: goals

This fork aims to:

* Modernize the Mathematica code style while preserving Feng & Guo’s original API
* Document the working Mathematica notebooks and package internals
* Ship a tiny yet representative suite of regression tests under `tests/`
* Capture the conditioned-iteration + block-elimination workflow that senior users rely on

---

## 🧱 SymGF.m overview

The core package (`SymGF.m`) exposes a fairly large public surface. The most commonly used entry points are grouped below (see the declarations near the top of `SymGF.m` for the authoritative list).

### Configuration primitives

* `SetRules`, `SetPreserve`, `SetSumSub` — register commutation rules, protected operators, and dummy summation indices before deriving equations of motion (EOMs).
* `SetIGF`, `SetSelfEnergy`, `SetDelta`, `SetExact`, `SetTrunc`, `SetCoupling`, `SetInterParam` — preload isolated Green’s functions, explicit self-energies, the delta-symbol, exact relations, truncation/decoupling rules, and grouped coupling constants.
* `InitializeGFs` / `TargetGF` — reset internal state and select the Green’s functions SymGF should derive.

### Derivation helpers

* `DeriveGF` — drives the EOM derivation for the selected targets using the registered Hamiltonian, commutation rules, and truncation preferences.
* `ResDisp`, `sneak`, `symGFPrint` — diagnostics/printing routines for inspecting stored equations (`StoredEOM`) and solver state.
* `SetPreserve`, `SetTrunc`, `ReorderForTruncation`, `SwapFermions` — keep specified operators untouched and slot them into the truncation templates when high-order correlators appear.
* `Grab`, `grab2`, `grab3`, `clearup`, `SortOperatorProducts` — algebraic clean-up utilities that normalize `NonCommutativeMultiply` expressions and handle delta functions.

### Solver stack

* `CondIter` (backed by `RunSunIteration`) — implements Dr. Sun Qing-Feng’s conditioned-iteration algorithm that chases down coupling-constant chains, registers self-energies, and builds the dependency graph (`TBS`, `TS`, `SelfEnergy`, etc.).
* `SetCoupling` / `SetInterParam` — describe the grouping of tunneling amplitudes so `CCprofile`, `CCinTerm`, and the iteration logic can tell which terms share the same physical channels.
* `CreateMat` (`BuildEquationMatrix`) — turns the derived EOMs into a block matrix (`M`) whose entries are encoded coefficient blocks.
* `GaussElim` / `GaussElimVerbose` — run block Gaussian elimination, using helpers such as `MultiplyEncodedBlocks`, `InvertEncodedBlock`, `SubtractEncodedBlocks`, and `SimplifyEntryList`.
* `CreateMat`, `GaussElim`, and `GaussElimVerbose` are normally used after `CondIter` has populated the necessary self-energy structure, but they can also operate directly on `StoredEOM`.

### Component builders

* `acLesser`, `acGreater`, `acRetarded`, `acAdvanced` — construct Keldysh components once the main propagators are known.
* `SetExact` / `ApplyExact` — mark Green’s functions that should be kept untouched by later manipulations (useful for embedding exact results from symmetric points).
* `SetSelfEnergy`, `FindTruncationRule`, `truncsol`, `LocateTruncationSlots` — utilities for more advanced workflows that require manual control over self-energies or bespoke truncation.

### Typical equation-of-motion workflow

1. Define your Hamiltonian in second-quantized operator form (Mathematica `NonCommutativeMultiply` with `OverHat` operators).
2. Call `SetSumSub`, `SetRules`, and `SetPreserve` to describe dummy indices, (anti-)commutation relations, and operators that must survive untouched.
3. Optionally preload isolated GFs (`SetIGF`), truncation rules (`SetTrunc`), exact relations (`SetExact`), or user-provided self-energies (`SetSelfEnergy`).
4. Choose the target propagators with `TargetGF` (or `InitializeGFs`) and derive their EOMs via `DeriveGF[H]`.
5. Inspect the resulting hierarchy with `ResDisp[]`, `sneak[]`, or exportable lists such as `StoredEOM`.
6. Register tunneling amplitudes with `SetCoupling[...]` and execute `CondIter[]` to build self-consistent chains and self-energies.
7. Build the encoded matrix (`CreateMat[]`) and eliminate it (`GaussElim[]` or `GaussElimVerbose[]`) to obtain symbolic Dyson equations ready for post-processing.
8. Use `acRetarded`, `acAdvanced`, `acLesser`, or `acGreater` to extract the desired components and feed them into your transport formulas.

### Debugging tips

* `sneak[]` dumps internal solver structures (GF lists, connection graphs, truncation records) when you need to understand why SymGF branches a certain way.
* `symGFPrint` respects `$SymGFVerbose` / `$SymGFForceTextOutput`; toggle verbosity with `SetSymGFVerbose`.
* `teom[]` and `tm[]` serve as public aliases for `StoredEOM` and `M`, respectively, so you can poke at intermediate expressions from a notebook.

---

## ✅ Regression tests

A set of `.wls` scripts under `tests/` exercises the most common workflows: diagonal Hamiltonians, multi-lead dots, and the conditioned-iteration + Gaussian-elimination pipeline.

### Test matrix

* `tests/diag.wls` — single orbital with a momentum-summed diagonal Hamiltonian. Verifies `SetSumSub`, fermionic commutators, `TargetGF`, `DeriveGF`, and `ResDisp`.
* `tests/diag_degenerate.wls` — single level without explicit momentum sums; ensures local operators (`SetRules` with unit coefficients) behave.
* `tests/diag_cross_species.wls` — two independent species and a mixed Green’s function to confirm cross-species commutators are ignored.
* `tests/coupled_dot.wls` & `tests/coupled_dot_down.wls` — two-level dot symmetrically coupled to left/right leads. Exercise `SetCoupling`, `CondIter`, `CreateMat`, and `GaussElim` plus `SetPreserve` for dot operators. The `_down` variant derives the spin-down channel.
* `tests/coupled_cross_updown.wls` — asks for off-diagonal (spin-flip) propagators to make sure mixed indices propagate through `CondIter`.
* `tests/coupled_spinless.wls` — simplest single-level dot coupled to two leads; ideal sanity check for the conditioned-iteration pipeline.
* `tests/coupled_leftonly.wls` — only left leads are present so `SetCoupling` is given a single column. Guards against asymmetric lead configurations.
* `tests/coupled_extra_lead.wls` — extends the previous setup with a third (middle) lead to confirm multi-lead coupling matrices remain consistent.
* `tests/coupled_two_dots.wls` — two interacting dots, intercoupling `t12`, and repeated `TargetGF`/`DeriveGF` calls. Stresses `ResetGFlist`, `SetPreserve`, and multiple targets.

Each script follows the same pattern:

1. Set the working directory and load `SymGF.m`.
2. Declare Hamiltonian pieces, operators, and tunneling amplitudes.
3. Configure commutation rules (`SetRules`), dummy sums (`SetSumSub`), and preserved operators (`SetPreserve`).
4. Pick target propagators (`TargetGF`), derive (`DeriveGF`), display (`ResDisp`), and (when needed) run `SetCoupling` → `CondIter` → `CreateMat` → `GaussElim`.

### Running the suite

The helper script `tests/run_all_tests.sh` sequentially invokes each `.wls` file via `wolframscript`. Before running it:

1. Ensure `WOLFRAM` inside `run_all_tests.sh` points to your local `wolframscript`.
2. Update the `SetDirectory["..."]` line at the top of each `.wls` so it matches your clone path (or replace it with `SetDirectory[NotebookDirectory[]];` if you keep the scripts beside `SymGF.m`).
3. Execute the runner from the repository root:

```bash
bash tests/run_all_tests.sh
```

The scripts print progress (e.g., `Gaussian elimination block summary`) but do not yet assert on the output — compare the printed matrices with known results to validate your environment. When the `-file` calls finish without Mathematica aborting, you have exercised the entire conditioned-iteration + block-elimination path end-to-end.

---

## 🔎 Next steps

* Convert the hard-coded paths inside the test scripts into relative paths so future contributors can run the suite without editing files.
* Automate simple pass/fail checks for the printed matrices (e.g., hash or `FullSimplify` against reference expressions) to turn the regression suite into a CI-ready test harness.
