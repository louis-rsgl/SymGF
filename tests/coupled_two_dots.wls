SetDirectory["/Users/louis/Library/Mobile Documents/com~apple~CloudDocs/McGill/HONG/Projects/SYM-GF/mathematica/SymGFplus_codex"];
<<SymGF.m;

Clear[H, Hleads, Hdots, HcoupleL, HcoupleR, Hdotdot, k,
  cl, cldag, cr, crdag, d1, d1dag, d2, d2dag,
  tl1, tl1star, tr1, tr1star, tl2, tl2star, tr2, tr2star,
  edl, edr, ea1, ea2, t12, t12star];

Hleads = edl[k] OverHat[cldag[k]]**OverHat[cl[k]] +
   edr[k] OverHat[crdag[k]]**OverHat[cr[k]];

Hdots = ea1 OverHat[d1dag]**OverHat[d1] +
   ea2 OverHat[d2dag]**OverHat[d2];

Hdotdot = t12 OverHat[d1dag]**OverHat[d2] +
   t12star OverHat[d2dag]**OverHat[d1];

HcoupleL = tl1[k] OverHat[cldag[k]]**OverHat[d1] +
   tl1star[k] OverHat[d1dag]**OverHat[cl[k]] +
   tl2[k] OverHat[cldag[k]]**OverHat[d2] +
   tl2star[k] OverHat[d2dag]**OverHat[cl[k]];

HcoupleR = tr1[k] OverHat[crdag[k]]**OverHat[d1] +
   tr1star[k] OverHat[d1dag]**OverHat[cr[k]] +
   tr2[k] OverHat[crdag[k]]**OverHat[d2] +
   tr2star[k] OverHat[d2dag]**OverHat[cr[k]];

H = Hleads + Hdots + Hdotdot + HcoupleL + HcoupleR;

SetRules[{
  {cl[k_], cldag[kp_], cl[k_] cldag[kp_] :> DiracDelta[k - kp], 1},
  {cr[k_], crdag[kp_], cr[k_] crdag[kp_] :> DiracDelta[k - kp], 1},
  {d1, d1dag, 1, 1},
  {d2, d2dag, 1, 1}
}];

SetSumSub[{k}];

SetPreserve[{OverHat[d1], OverHat[d1dag], OverHat[d2], OverHat[d2dag]}];

ResetGFlist[];
TargetGF[OverHat[d1]**OverHat[d1dag]];
DeriveGF[H];
ResDisp[];

ResetGFlist[];
TargetGF[OverHat[d2]**OverHat[d2dag]];
DeriveGF[H];
ResDisp[];
