SetDirectory["/Users/louis/Library/Mobile Documents/com~apple~CloudDocs/McGill/HONG/Projects/SYM-GF/mathematica/SymGFplus_codex"];
<<SymGF.m;

Clear[H, Hlr, Hdot, Hcouple, k,
  cl, cldag, cr, crdag, a, adag,
  tl, tlstar, tr, trstar, el, er, ea];

Hlr = el[k] OverHat[cldag[k]]**OverHat[cl[k]] +
   er[k] OverHat[crdag[k]]**OverHat[cr[k]];

Hdot = ea OverHat[adag]**OverHat[a];

Hcouple = tl[k] OverHat[cldag[k]]**OverHat[a] +
   tlstar[k] OverHat[adag]**OverHat[cl[k]] +
   tr[k] OverHat[crdag[k]]**OverHat[a] +
   trstar[k] OverHat[adag]**OverHat[cr[k]];

H = Hlr + Hdot + Hcouple;

SetRules[{
  {cl[k_], cldag[kp_], cl[k_] cldag[kp_] :> DiracDelta[k - kp], 1},
  {cr[k_], crdag[kp_], cr[k_] crdag[kp_] :> DiracDelta[k - kp], 1},
  {a, adag, 1, 1}
}];

SetSumSub[{k}];

SetPreserve[{OverHat[a], OverHat[adag]}];

TargetGF[OverHat[a]**OverHat[adag]];
DeriveGF[H];
ResDisp[];

SetCoupling[{{{tl[k], tr[k]}, {tlstar[k], trstar[k]}}}];
CondIter[];

CreateMat[];
res = GaussElim[];
Print["Gaussian elimination block summary:"];
Print[res[[All, All, 1]]];
