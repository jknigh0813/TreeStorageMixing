# EcH2O-iso Tree Water Isotopic Composition
This repository contains two post-processing tools for EcH2O-iso (Kuppel et al. 20183) model output. 

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

