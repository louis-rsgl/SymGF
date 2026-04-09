SetDirectory["/Users/louis/Library/Mobile Documents/com~apple~CloudDocs/McGill/HONG/Projects/SYM-GF/mathematica/SymGFplus_codex"];
<<SymGF.m;

Clear[a, adag, b, bdag, e, phi, k];

H = e[k] OverHat[adag[k]]**OverHat[a[k]] +
    phi[k] OverHat[bdag[k]]**OverHat[b[k]];

SetSumSub[{k}];

SetRules[{
  {a[k_], adag[kp_], a[k_] adag[kp_] :> DiracDelta[k - kp], 1},
  {b[k_], bdag[kp_], b[k_] bdag[kp_] :> DiracDelta[k - kp], 1}
}];

TargetGF[OverHat[a[k]]**OverHat[bdag[k]]];
DeriveGF[H];
ResDisp[];
