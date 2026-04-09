SetDirectory["/Users/louis/Library/Mobile Documents/com~apple~CloudDocs/McGill/HONG/Projects/SYM-GF/mathematica/SymGFplus_codex"];
<<SymGF.m;

Clear[H, Hlr, Hdot, Htld, k,
  cl1, cl1dag, cl2, cl2dag, a1, a1dag, a2, a2dag,
  tl, tlstar, el1, el2, ea];

Hlr = el1[k] OverHat[cl1dag[k]]**OverHat[cl1[k]] +
   el2[k] OverHat[cl2dag[k]]**OverHat[cl2[k]];

Hdot = ea OverHat[a1dag]**OverHat[a1] + ea OverHat[a2dag]**OverHat[a2];

Htld = tl[k] OverHat[cl1dag[k]]**OverHat[a1] +
   tlstar[k] OverHat[a1dag]**OverHat[cl1[k]] +
   tl[k] OverHat[cl2dag[k]]**OverHat[a2] +
   tlstar[k] OverHat[a2dag]**OverHat[cl2[k]];

H = Hlr + Hdot + Htld;

SetRules[{
  {cl1[k_], cl1dag[kp_], cl1[k_] cl1dag[kp_] :> DiracDelta[k - kp], 1},
  {cl2[k_], cl2dag[kp_], cl2[k_] cl2dag[kp_] :> DiracDelta[k - kp], 1},
  {a1, a1dag, 1, 1},
  {a2, a2dag, 1, 1}
}];

SetSumSub[{k}];

SetPreserve[{OverHat[a1], OverHat[a1dag], OverHat[a2], OverHat[a2dag]}];

TargetGF[OverHat[a1]**OverHat[a1dag]];
DeriveGF[H];
ResDisp[];

SetCoupling[{{{tl[k]}, {tlstar[k]}}}];
CondIter[];

CreateMat[];
res = GaussElim[];
Print["Gaussian elimination block summary:"];
Print[res[[All, All, 1]]];
