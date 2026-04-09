SetDirectory["/Users/louis/Library/Mobile Documents/com~apple~CloudDocs/McGill/HONG/Projects/SYM-GF/mathematica/SymGFplus_codex"];
<<SymGF.m;
Clear[a,adag,e,k];
H = e[k] OverHat[adag[k]]**OverHat[a[k]];
SetSumSub[{k}];
SetRules[{{a[k_], adag[kp_], a[k_] adag[kp_] :> DiracDelta[k - kp], 1}}];
TargetGF[OverHat[a[k]]**OverHat[adag[k]]];
DeriveGF[H];
ResDisp[];
