# EcH2O-iso Tree Water Isotopic Composition
This repository contains two post-processing tools for EcH2O-iso (Kuppel et al. 2018) model output to compute the isotopic composition of above ground tree water storage.

## Inputs
* Tree_V - the volume of tree-water storage (expressed as a depth)
* Site - the EcH2O-iso output file site index
* Spinup - the size of the model spinup period

## Well Mixed (WM)
* Assumes trees are static reservoirs with volume TreeV
* Assumes the volume of transpiration = RWU
* All stored water is well mixed.
* Water inputs have the isotopic composition of root water uptake (RWU)
* Water losses (transpiration) has the same isotopic composition of the tree (dTree)
* dTree(t) = dTree(t-1)*TreeV + dRWU(t)*T(t) - dTree(t-1)*T(t)

## Piston Flow (PF)
* Assumes trees are static reservoirs with volume TreeV
* Assumes the volume of transpiration = RWU
* Water inputs have the isotopic composition of root water uptake (RWU)
* Transpired water is the oldest tree-stored water
* Tree isotopic composition is computed as 1) average of all tree stored water, and 2) the midpoint by volume of all tree-stored water

## References
Kuppel, S., Tetzlaff, D., Maneta, M., & Soulsby, C. (2018). EcH2O-iso 1.0: water isotopes and age tracking in a process-based, distributed ecohydrological model. Geoscientific Model Development.
