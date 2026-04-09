SetDirectory["/Users/louis/Library/Mobile Documents/com~apple~CloudDocs/McGill/HONG/Projects/SYM-GF/mathematica/SymGFplus_codex"];
<<SymGF.m;

Clear[H, Hlr, Hdot, Htld, Htrd, k,
  cl1, cl1dag, cl2, cl2dag, cr1, cr1dag, cr2, cr2dag,
  a1, a1dag, a2, a2dag, tl, tlstar, tr, trstar,
  el1, el2, er1, er2, ea];

Hlr = el1[k] OverHat[cl1dag[k]]**OverHat[cl1[k]] +
   el2[k] OverHat[cl2dag[k]]**OverHat[cl2[k]] +
   er1[k] OverHat[cr1dag[k]]**OverHat[cr1[k]] +
   er2[k] OverHat[cr2dag[k]]**OverHat[cr2[k]];

Hdot = ea OverHat[a1dag]**OverHat[a1] + ea OverHat[a2dag]**OverHat[a2];

Htld = tl[k] OverHat[cl1dag[k]]**OverHat[a1] +
   tlstar[k] OverHat[a1dag]**OverHat[cl1[k]] +
   tl[k] OverHat[cl2dag[k]]**OverHat[a2] +
   tlstar[k] OverHat[a2dag]**OverHat[cl2[k]];

Htrd = tr[k] OverHat[cr1dag[k]]**OverHat[a1] +
   trstar[k] OverHat[a1dag]**OverHat[cr1[k]] +
   tr[k] OverHat[cr2dag[k]]**OverHat[a2] +
   trstar[k] OverHat[a2dag]**OverHat[cr2[k]];

H = Hlr + Hdot + Htld + Htrd;

SetRules[{
  {cl1[k_], cl1dag[kp_], cl1[k_] cl1dag[kp_] :> DiracDelta[k - kp], 1},
  {cl2[k_], cl2dag[kp_], cl2[k_] cl2dag[kp_] :> DiracDelta[k - kp], 1},
  {cr1[k_], cr1dag[kp_], cr1[k_] cr1dag[kp_] :> DiracDelta[k - kp], 1},
  {cr2[k_], cr2dag[kp_], cr2[k_] cr2dag[kp_] :> DiracDelta[k - kp], 1},
  {a1, a1dag, 1, 1},
  {a2, a2dag, 1, 1}
}];

SetSumSub[{k}];

SetPreserve[{OverHat[a1], OverHat[a1dag], OverHat[a2], OverHat[a2dag]}];

TargetGF[OverHat[a1]**OverHat[a2dag]];
DeriveGF[H];
ResDisp[];
