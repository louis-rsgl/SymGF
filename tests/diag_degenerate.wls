SetDirectory["/Users/louis/Library/Mobile Documents/com~apple~CloudDocs/McGill/HONG/Projects/SYM-GF/mathematica/SymGFplus_codex"];
<<SymGF.m;

Clear[a, adag, eps];
H = eps OverHat[adag]**OverHat[a];

SetRules[{{a, adag, 1, 1}}];

TargetGF[OverHat[a]**OverHat[adag]];
DeriveGF[H];
ResDisp[];
