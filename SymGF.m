(* ::Package:: *)

(* this is a version for manual writing *)
BeginPackage["NEGF`"]; 
SetRules::usage = "SetRules[rules_List] registers (anti-)commutation relations for operators.";
SetPreserve::usage = "SetPreserve[ops_List] marks operators that must be preserved during derivation.";
SetSumSub::usage = "SetSumSub[sums_List] declares dummy summation indices used in equations of motion.";
SetIGF::usage = "SetIGF[list_] seeds the isolated Green's function pool.";
SetSelfEnergy::usage = "SetSelfEnergy[rules_] registers explicit self-energy replacement rules.";
InitializeGFs::usage = "InitializeGFs[expr_] resets internal state and loads the requested target Green's functions.";
TargetGF::usage = "TargetGF[expr_] is the public wrapper that delegates to InitializeGFs.";
DeriveGF::usage = "DeriveGF[hamiltonian_] derives the equations of motion for the active Green's functions.";
com::usage = "com[a_, b_] evaluates the commutator [a, b].";
anticom::usage = "anticom[a_, b_] evaluates the anti-commutator {a, b}.";
ResDisp::usage = "ResDisp[] prints the derived equations of motion and isolated Green's functions.";
sneak::usage = "sneak[] exposes internal solver state for debugging.";
subs::usage = "subs[expr_] extracts subscript symbols appearing in expr.";
IterateGFExpression::usage = "IterateGFExpression[idx_] performs one step of the iterative solution process (internal).";
GuardExpression::usage = "GuardExpression[expr_] enforces guard conditions on expressions (internal).";
CanonicalGFSymbol::usage = "CanonicalGFSymbol[idx_] returns the canonical representation of a stored Green's function.";
purepattern::usage = "purepattern[expr_] replaces explicit indices with blanks for pattern matching.";
SetDelta::usage = "SetDelta[value_] configures the delta-symbol used inside SymGF.";
clearup::usage = "clearup[expr_] simplifies expressions by removing redundant delta functions.";
grab2::usage = "grab2[expr_] rearranges NonCommutativeMultiply factors into canonical order.";
grab3::usage = "grab3[expr_] integrates over declared summation indices when possible.";
Commutator::usage = "Commutator[a_, b_] is the public commutator wrapper (kept for compatibility).";
commutator::usage = "commutator[a_, b_] implements the commutator recursively on various expression types.";
ClassifyGFType::usage = "ClassifyGFType[expr_] computes key characteristics of an expression (internal).";
acLesser::usage = "acLesser[expr_, tag_] builds the lesser component of a Green's function.";
acGreater::usage = "acGreater[expr_, tag_] builds the greater component of a Green's function.";
acRetarded::usage = "acRetarded[expr_, tag_] builds the retarded Green's function component.";
acAdvanced::usage = "acAdvanced[expr_, tag_] builds the advanced Green's function component.";
prep::usage = "prep[] prints self-energy replacement rules (internal helper).";
SetExact::usage = "SetExact[gf_] records exact Green's functions that must remain untouched.";
ApplyExact::usage = "ApplyExact[expr_] enforces exact-GF substitutions inside expr.";
SortOperatorProducts::usage = "SortOperatorProducts[expr_] sorts operator products into canonical order.";
Grab::usage = "Grab[expr_] expands non-commutative products into sums with explicit deltas.";
com2::usage = "com2[a_, b_] is a lightweight commutator wrapper returning an unsimplified expression.";
SetTrunc::usage = "SetTrunc[rules_] defines truncation rules for higher-order operator strings.";
FindTruncationRule::usage = "FindTruncationRule[expr_] identifies which truncation rule applies to expr.";
truncsol::usage = "truncsol[expr_, dt_] applies the truncation solution for a given direction.";
ReorderForTruncation::usage = "ReorderForTruncation[expr_, dt_] reorders operators into the slots required by truncation rules.";
SplitOperatorCoefficient::usage = "SplitOperatorCoefficient[expr_] splits expressions into operator/coefficient pairs.";
SwapFermions::usage = "SwapFermions[expr_, pos_, dt_] permutes fermionic operators with the correct sign.";
NormalizeGFExpression::usage = "NormalizeGFExpression[expr_] prepares expressions for the solver by calling SplitOperatorCoefficient.";
LocateTruncationSlots::usage = "LocateTruncationSlots[expr_, id_] returns positioning data for a truncation rule application.";
inpos1::usage = "inpos1[len_, list_, dt_] tests whether the first operator is in the desired position.";
inpos2::usage = "inpos2[len_, list_, dt_] tests whether the last operator is in the desired position.";
annihilation::usage = "annihilation[op_] returns True if op is an annihilation operator.";
creation::usage = "creation[op_] returns True if op is a creation operator.";
existself::usage = "existself[rhs_, dt_, idx_] locates self terms in an equation of motion.";
IterateTimeOrderedGF::usage = "IterateTimeOrderedGF[idx_] iteratively solves time-ordered Green's functions (internal).";
IterateTOBranch::usage = "IterateTOBranch[idx_] is a helper branch of the iterative solver.";
SolveFinalPass::usage = "SolveFinalPass[idx_] performs the third pass of the Conditioned Iteration solver (internal).";
SolveSecondPass::usage = "SolveSecondPass[idx_] performs the second pass of the Conditioned Iteration solver (internal).";
del0::usage = "del0[] clears temporary delta-function bookkeeping.";
cut0::usage = "cut0[expr_] removes zero-valued Green's functions from expr.";
purepattern::usage = "purepattern[expr_] replaces explicit indices with blanks for pattern matching.";
containedGF::usage = "containedGF[expr_] lists GF symbols contained in expr.";
NoneMatrixSol::usage = "NoneMatrixSol[expr_] handles matrix blocks without explicit inverses.";
exceed::usage = "exceed[list_, idx_] tests whether indices exceed the supplied bound.";
repexceed::usage = "repexceed[expr_, idx_] replaces excessive indices with placeholders.";
summable::usage = "summable[expr_, var_] returns True if expr contains DiracDelta tying var.";
NRcontainedGF::usage = "NRcontainedGF[expr_] counts non-repeated Green's functions inside expr.";
SolveFirstPass::usage = "SolveFirstPass[idx_] runs the first Conditioned Iteration pass.";
RunSolverPasses::usage = "RunSolverPasses[idx_] solves equations that involve only a single Green's function.";
BuildCategoryGrid::usage = "BuildCategoryGrid[{lhs_, rhs_}] splits numerator and denominator factors (internal).";
CategorySelector::usage = "CategorySelector[expr_] enforces solver constraints before final substitution.";
RunConditionedSweep::usage = "RunConditionedSweep[idx_] decomposes coupled equations into independent groups.";
SolveConditionedEquation::usage = "SolveConditionedEquation[idx_] performs symbolic decomposition during iteration.";
RunInlineConditionedSweep::usage = "RunInlineConditionedSweep[idx_] handles branch splitting in recursive solutions.";
IterateConditionedEquation::usage = "IterateConditionedEquation[idx_] stores the results of RunInlineConditionedSweep (internal).";
MakeSE::usage = "MakeSE[] constructs self-energy symbols from stored rules.";
SetETPreserve::usage = "SetETPreserve[list_] marks operators to keep during energy-time manipulations.";
ETjudge::usage = "ETjudge[expr_] extracts the preserved pieces from delta contributions.";
BuildCouplingGraph::usage = "BuildCouplingGraph[idx_] draws the coupling graph for debugging purposes.";
ShowCouplingGraph::usage = "ShowCouplingGraph[idx_] prints the coupling relation list.";
ResolveGraphSolutions::usage = "ResolveGraphSolutions[idx_] dumps intermediate solver steps for inspection.";
SetInterParam::usage = "SetInterParam[list_] records interaction parameters used by truncation rules.";
RunSunIteration::usage = "RunSunIteration[] implements Dr. Sun Qing-Feng's conditioned iteration algorithm.";
CondIter::usage = "CondIter[] runs the conditioned iteration solver.";
ExpandCouplingChains::usage = "ExpandCouplingChains[idx_] caches coupling information (internal).";
MiT::usage = "MiT[idx_] builds matrix blocks for Gaussian elimination.";
type::usage = "type[expr_] classifies expressions by operator content.";
CCinTerm::usage = "CCinTerm[term_] lists coupling constants appearing in a given term.";
GFIiT::usage = "GFIiT[idx_] fetches isolated GF information for iteration step idx.";
grasp::usage = "grasp[idx_] assembles coupled equations for a specific Green's function.";
pairedCC::usage = "pairedCC[cc_] groups coupling constants with their conjugates.";
SetCoupling::usage = "SetCoupling[list_] declares grouped coupling constants for Conditioned Iteration.";
SetSingleCorr::usage = "SetSingleCorr[list_] records single-correlation functions for later substitutions.";
SelfEnergySymbol::usage = "SelfEnergySymbol[] creates a unique self-energy symbol placeholder.";
subs::usage = "subs[expr_] extracts subscript symbols appearing in expr.";
selfconsistent::usage = "selfconsistent[list_] solves specified equations self-consistently (internal).";
listify::usage = "listify[expr_] converts solver output into list form (internal).";
CCprofile::usage = "CCprofile[] summarizes coupling-constant usage (internal).";
solveself::usage = "solveself[idx_] solves a GF that only contains itself on the right-hand side.";
GFiT::usage = "GFiT[idx_] retrieves the ith Green's function definition.";
GFIiT::usage = "GFIiT[idx_] fetches isolated GF information for iteration step idx.";
ISOsubsub::usage = "ISOsubsub[expr_, gi_] substitutes explicit indices into isolated GFs.";
PhysicalArgument::usage = "PhysicalArgument[param_] enforces additional physical constraints (internal).";
stealthsub::usage = "stealthsub[expr_] returns subscript information embedded in self-energies.";
(*numGEwbl::usage="";*)
SErep::usage = "SErep[] lists currently known self-energy replacements.";
ISOrep::usage = "ISOrep[] lists isolated Green's function replacements.";
sneaksumlist::usage = "sneaksumlist[] exposes the current summation-index list.";
ISOidx::usage = "ISOidx[expr_] locates the index of an isolated GF symbol.";
BuildEquationMatrix::usage = "BuildEquationMatrix[list_, idx_] merges matrix rows with identical structure.";
CreateMat::usage = "CreateMat[] builds the block matrix representing the derived equations.";
GaussElim::usage = "GaussElim[] performs block Gaussian elimination on the equation matrix.";
teom::usage = "teom[] returns the filtered set of equations of motion.";
tm::usage = "tm[] returns the current matrix M used for Gaussian elimination.";


Begin["`Private`"]; 
Unprotect[Commutator];
Clear[Commutator];
IGFs = {}; 
rulelist = {}; 
gfs = {}; solgf = {}; eom={};StoredEOM={};
preservelist = {}; 
sumlist = {};   (* sub scripts for summation (dummy ones) *)
GFnames={};
selfenergyrep={};
SelfEnergy={};  
GammaEnergy={};
acGFnames={};
acGFsol={};
closedsol={};
connectionlist={};  (* stores indices of each time-ordered gf *)
final={};  (* indices for "final" (exact) gf's *)
trunclist={};  (* { { {op1,op2,op3,...},total # of them},  {{ ol1,ol2,...}, # } , ... }  *)
category={};
oriNRIGF=0;
ETP={};
graph={};
interparam={};
CC={};  
plainCC={};
TBS={};  (* to be solved *)
TS={};   (* to be solved self-consistently *)
SC={};   (* single corr *)
ZeroEncodedBlock={"_",0,0,0};   
IdentityEncodedBlock={"I",0,0,0};    
M={};
L={};
EnergySymbol=0;

$SymGFVerbose=True;
$SymGFForceTextOutput=False;
SetSymGFVerbose[flag_:True]:=($SymGFVerbose=TrueQ[flag]);
symGFPrint[args___]:=If[TrueQ[$SymGFVerbose],
  Module[{pieces={args},useText},
    useText=TrueQ[$SymGFForceTextOutput]||$FrontEnd===Null;
    Which[
      pieces==={},
        System`Print[],
      useText,
        Block[{$PageWidth=Infinity},
          System`Print@@pieces
        ],
      True,
        System`Print@@(Style[#,FormatType->TraditionalForm]&/@pieces)
    ]
  ]
];

symGFPrint["SymGFplus - Symbolic Green's Function"];
symGFPrint["Feng Zimin, Louis Rossignol and Guo Hong\nPhysics, McGill"];
symGFPrint["2026-April-08"];
symGFPrint["Please make sure that this is a new Mathematica session !!!"]
symGFPrint["Report bugs or comments to ziminf@physics.mcgill.ca, louis.rossignol@mail.mcgill.ca or guo@physics.mcgill.ca"]

symGFPrint["\nThis code is adapted from:"]
symGFPrint["SymGF - Symbolic Green's Function"];
symGFPrint["Feng Zimin and Guo Hong\nPhysics, McGill"];
symGFPrint["2012-April-15"];


teom[]:=StoredEOM
tm[]:=M

poletype={};  (* this list should have the same length as IGFs, for now this branch is paused. *)
Needs["NumericalCalculus`"];

tempo=0; (* to be deleted when debug finishes. *)

Clear[symGFUniqueCounters, symGFUnique, symGFResetUniqueCounters];
symGFUniqueCounters=<||>;
symGFResetUniqueCounters[]:=(symGFUniqueCounters=<||>;);
(*
   Function: symGFUnique[tag_String]
   Purpose: Generate deterministic yet unique symbols so different modules can
     introduce temporary variables without colliding.
   Algorithm:
     1. Look up the current counter stored for tag inside the
        symGFUniqueCounters association (defaults to zero).
     2. Increment and store the counter so the next call for the same tag
        continues the numbering sequence.
     3. Return a symbol that lives in Global` and whose name is tag<>
        counter, mirroring Mathematica's Unique[] behaviour.
   Inputs: tag_String - namespace key that keeps independent counters.
   Output: A new symbol whose name encodes tag and a monotonically increasing
     integer.
*)
symGFUnique[tag_String]:=Module[{n},
  n=Lookup[symGFUniqueCounters,tag,0]+1;
  symGFUniqueCounters[tag]=n;
  Symbol["Global`"<>tag<>ToString[n]]
];

SetSingleCorr[a_List]:=(SC=a;)

ResInto[cont_,sl_,w_]:=(
  symGFPrint[cont];
  symGFPrint[sl];
  symGFPrint[w];
  Abort[]
)
ResInto[___]:=symGFPrint["Error: invalid arguments supplied to ResInto."];

(*
   Function: PhysicalArgument[u_]
   Purpose: Remove contributions from the solved equations that contradict a
     user-supplied physical constraint, e.g. discard isolated Green's
     functions that contain a Hubbard interaction parameter.
   Algorithm:
     1. Collect the isolated GF labels (IGFs) whose frequency expressions
        contain u so that we know which cores need to be eliminated.
     2. Walk through every stored solution in solgf; each right-hand side may
        be a single term or a sum of terms that contain UnderBar patterns.
     3. If a term references an IGF marked in step 1, replace the term by
        zero; otherwise keep the term intact and rebuild the original Plus
        structure.
   Inputs: u - the parameter that should not survive inside IGFs.
   Output: solgf is updated in place so that forbidden IGFs vanish.
*)
PhysicalArgument[u_]:=Module[{ss,isoincore},   (* this physical argument doesn't work as it totally cuts off the U-effect *)
  ss=Select[IGFs,!FreeQ[#[[1]],u] & ] [[All,2]];
  symGFPrint["elim ",ss];
  Do[
    symGFPrint[" ** ",i];
    If[Head[solgf[[i,3]] ] === Plus,
      solgf[[i,3]]=List@@solgf[[i,3]];
      Do[
        isoincore=Cases[solgf[[i,3,j]],_UnderBar];
        If[isoincore=!={},
          If[!FreeQ[ss,purepattern[ isoincore[[1]]  ]   ],
            solgf[[i,3,j]]=0;
            symGFPrint[j," set to 0 for ",isoincore];
          ];
        ];
        ,{j,Length[solgf[[i,3]] ]}];
      solgf[[i,3]]=Plus@@solgf[[i,3]];
      ,
      (* just one term *)
      isoincore=Cases[solgf[[i,3]],_UnderBar];
      If[isoincore=!={},
        If[!FreeQ[ss,purepattern[ isoincore[[1]] ]  ],
          solgf[[i,3]]=0;
          symGFPrint["set to 0 for ",isoincore];
        ];
      ];
    ];
    ,
    {i,Length[solgf]}
  ];
]

(*
   Function: SErep[]
   Purpose: Produce pattern-based substitution rules for every stored
     self-energy so later passes can match them even when concrete indices
     differ.
   Algorithm:
     1. For each self-energy entry, gather both the explicit subscript symbols
        (subs) and the stealth subscripts (underbars embedded in operators).
     2. Replace every such symbol by Blank[] patterns with the right head so
        that the resulting expression matches any instance of that structure.
     3. Return a rule where the patternised expression on the left points to
        the symbolic self-energy placeholder stored in the first column of the
        SelfEnergy table.
   Inputs: None; the function reads the global SelfEnergy list.
   Output: List of replacement rules of the form pattern -> SelfEnergySymbol.
*)
SErep[]:=Module[{kkkkk,ss,sub,replacements},
  (* this module is only for single level, if not, there could be real subs instead of stealth subs only. *)
  replacements[ss_List,sub_List]:=
  Join[
    Table[ ss[[j]] -> (Pattern[kkkkk,Blank[] ] /. kkkkk->ss[[j]] ),{j,Length[ss]}],
    Table[ sub[[j]] -> (Pattern[kkkkk,Blank[] ] /. kkkkk->sub[[j]] ),{j,Length[sub]}]
  ];
  Table[
    ss=stealthsub[SelfEnergy[[i,2]] ];
    sub=subs[SelfEnergy[[i,2]] ];
    (SelfEnergy[[i,2]]/.replacements[ss,sub])->SelfEnergy[[i,1]]
    ,{i,Length[SelfEnergy]}]
]

(*
   Function: ISOrep[w_]
   Purpose: Build the canonical 1/(w - E) expressions for all isolated
     Green's functions so they can be substituted into equations of motion.
   Algorithm:
     1. Iterate over IGFs and collect the subscript variables appearing inside
        each stored expression.
     2. Replace every explicit subscript by Blank[] patterns, mirroring the
        structure of SErep so that the rules are pattern agnostic.
     3. Emit rules that map each pattern to 1/(w - IGFs[[i,1]]), which is the
        isolated propagator associated with that branch.
   Inputs: w - the complex frequency variable used when instantiating the
     isolated solution.
   Output: List of rules pattern -> 1/(w - energy).
*)
ISOrep[w_]:=Module[{kkkkk,sub},
  (* this module is only for single level, if not, there could be real subs instead of stealth subs only. *)
  Table[
    sub=subs[IGFs[[i,2]] ];
    (
      IGFs[[i,2]]/.Table[sub[[j]] -> (Pattern[kkkkk,Blank[] ] /. kkkkk->sub[[j]] ),{j,Length[sub]}]
    )->1/(w-IGFs[[i,1]])
    ,{i,Length[IGFs]}]
]

(*
   Function: ISOidx[gi_UnderBar]
   Purpose: Locate the position of an isolated GF inside IGFs so that other
     routines can quickly fetch its metadata.
   Algorithm:
     1. Search IGFs for an entry whose pattern matches gi after removing
        explicit indices with purepattern.
     2. Validate that exactly one entry is found, otherwise abort because the
        bookkeeping broke down.
     3. Return the row index, which is later used to access energy data or
        coefficients.
   Inputs: gi - an UnderBar object pointing to an isolated GF symbol.
   Output: Integer index into IGFs.
*)
ISOidx[gi_UnderBar]:=Module[{ret},
  ret=Position[IGFs,purepattern[gi] ];
  If[ret==={},
    symGFPrint["Error: ISO unrecognizable: ",gi];
    Abort[];
  ];
  ret[[1,1]]
]
(*
   Function: GFIiL[gf_OverBar]
   Purpose: Determine which equation of motion contains the requested Green's
     function so BuildEquationMatrix/EncodeEquationTerm know where to place the coefficients in the
     big matrix.
   Algorithm:
     1. Look for gf (after stripping explicit indices) in the first column of
        StoredEOM, which stores the left-hand sides of the derived equations.
     2. Abort when zero or multiple matches are found because that indicates a
        corrupted data structure.
     3. Return the row index so EncodeEquationTerm can write into column indices
        corresponding to that GF.
   Inputs: gf - OverBar form of a GF appearing on the left-hand side.
   Output: Integer position in StoredEOM.
*)
GFIiL[gf_OverBar]:=Module[{ret},
  ret=Position[StoredEOM[[All,1]] ,purepattern[gf] ] ;
  If[Length[ret]!=1,
    symGFPrint["Error: zero or multiple gf's in list"];
    Abort[]
  ];
  ret[[1,1]]
]
EncodeCoefficientStructure[expr_Times,i_,j_]:=

Module[{cont=expr,ret={{{},{}},{{},{}},{}},ii,rem,t,ddx},
  (* ddx means diracdelta's for x, there should be no ddy *)
  ddx= Cases[cont, _DiracDelta]; (* we don't consider more complicated situations (e-ph interaction) for now *)
  cont=expr/.Table[ddx[[k]]->1,{k,Length[ddx]}];
  rem=cont;
  Do[
    t=Select[cont,!FreeQ[#,x[ii]]&];
    If[ Length[Union [  Cases[t,_x,\[Infinity]]]]>1,
      symGFPrint["non-factorizable:",cont," in ",t];
      Abort[];
    ];
    rem/=t;
    AppendTo[ret[[1,1]],t]
    ,{ii,1,i}];
  If[ddx=!={},
    ret[[1,2]]=(Level[#,{-2}]&/@ddx)/.x[a_]:>a;
  ];
  Do[
    t=Select[cont,!FreeQ[#,y[ii]]&];
    If[ Length[Union [  Cases[t,_y,\[Infinity]]]]>1,
      symGFPrint["non-factorizable:",cont," in ",t];
      Abort[];
    ];
    rem/=t;
    AppendTo[ret[[2,1]],t]
    ,{ii,1,j}];
  ret[[2,2]]={};
  AppendTo[ret[[3]] ,rem];   (* ret[[3]]={X, { {}, {}, {}, ... }  }  *)
  ret
]
EncodeCoefficientStructure[expr_,0,0]:={"_",0,0,{ {{},{},{expr,{}}}   }   }
EncodeEquationTerm[expr_Plus,subl_List,hang_Integer]:=(
  Do[EncodeEquationTerm[expr[[i]],subl,hang],{i,Length[expr]}];
)
(*
   Function: EncodeEquationTerm[expr_,subl_List,hang_Integer]
   Purpose: Decompose every term appearing on the right-hand side of equation
     hang into the canonical matrix format used by the Gaussian elimination
     backend.
   Algorithm:
     1. If expr is a sum, dispatch EncodeEquationTerm to each summand so the rows collect
        all contributions.
     2. When the term contains a Green's function, isolate it with GFiT,
        rename the left-hand subscripts into x[i], rename the GF subscripts
        into y[i], call EncodeCoefficientStructure on the remaining coefficient, and record any
        artificially inserted DiracDelta information.
     3. Store the resulting {"c",h,l,{...}} entry either into the column that
        corresponds to the referenced GF (GFIiL) or, for pure source terms
        without GFs, into the constant column at index -1.
   Inputs: expr - term to encode; subl - subscript symbols of the row GF;
     hang - row index inside M.
   Output: Writes into the global matrix M.
*)
EncodeEquationTerm[expr_,subl_List,hang_Integer]:=Module[{j,g,h,l,subr,sr,dd,cont,subll,dest},
  
  If[!FreeQ[expr,_OverBar],
    subll=Table[subl[[i]]->x[i],{i,Length[subl]} ];
    (* symGFPrint[subll]; *)
    g=  GFiT[  expr ];
    cont=expr/.g->1;
    subr=subs[g]/.subll;
    h=Length[subl];
    l=Length[subr];
    sr=Table[subr[[i]]->y[i],{i,Length[subr] } ];
    dd=(Select[sr,#[[1,0]]===x&]/.Rule->List)/.{x[a_]:>a,y[a_]:>a};
    (* only responsible for artificially added diracdelta functions. *)
    cont=(cont/.subll)/.sr;
    (*symGFPrint["con ",cont," ",h," ",l];
    symGFPrint[sr];*)
    dest={"c",h,l,{EncodeCoefficientStructure[cont,h,l]} };
    AppendTo[dest[[4,1,3]]  ,dd];
    (*symGFPrint[" res: ",dest]*)
    M[[hang,GFIiL[g] ]]=dest
    ,
    
    (*symGFPrint["jian li:",expr];*)
    subll=Table[subl[[i]]->x[i],{i,Length[subl]} ];
    (* symGFPrint[subll]; *)
    subr={};
    h=Length[subl];
    l=Length[subr];
    (* only responsible for artificially added diracdelta functions. *)
    cont=(expr/.subll);
    (*symGFPrint["con ",cont," ",h," ",l];
    symGFPrint[sr];*)
    dest={"c",h,l,{EncodeCoefficientStructure[cont,h,l]} };
    (*symGFPrint[" res: ",dest];*)
    AppendTo[dest[[4,1,3]]  ,{}];
    (*symGFPrint[" res: ",dest]*)
    M[[hang,-1 ]]=dest
    
  ]
]
CreateMat[w_:w]:=BuildEquationMatrix[w]
(*
   Function: BuildEquationMatrix[w_:w]
   Purpose: Assemble the master matrix M from the symbolic equations of motion
     so that later modules can run block Gaussian elimination.
   Algorithm:
     1. Remember the driving frequency in EnergySymbol and allocate an
        (n x (n+1)) matrix filled with ZeroEncodedBlock placeholders.
     2. For each equation StoredEOM[[i]], extract the subscript structure of the
        left-hand GF and call EncodeEquationTerm on the negated right-hand side to fill
        the off-diagonal entries.
     3. Set the diagonal entry M[[i,i]] to the pre-encoded identity block IdentityEncodedBlock,
        signalling that the left-hand GF coefficients form the pivot block.
   Inputs: w - symbolic energy that labels the block structure.
   Output: Populated matrix M.
*)
BuildEquationMatrix[w_:w]:=Module[{subl},
  EnergySymbol=w;
  M=Table[ZeroEncodedBlock,{Length[StoredEOM]},{Length[StoredEOM]+1 }  ];
  Do[
    subl=subs[StoredEOM [[i,1]]];
    EncodeEquationTerm[-StoredEOM[[i,2]],subl,i];
    M[[i,i]]=IdentityEncodedBlock;
    ,{i,Length[StoredEOM]}];
  symGFPrint["Matrix established."];
  M
]
(*
   Function: MultiplyEncodedBlocks[m1_List,m2_List]
   Purpose: Multiply two encoded matrix blocks while respecting the symbolic
     bookkeeping that tracks Dirac deltas, x/y placeholders, and cached
     contractions.
   Algorithm:
     1. Inspect the matrix tags: "I" means the second operand is the identity,
        "c" denotes an explicit coefficient block, and "Ic" is an identity
        block that still carries correction lists inside entry 4.
     2. Dispatch to MultiplyCoefficientBlocks for ordinary block multiplication (and to
        MultiplySingleEntries via MultiplyCoefficientBlocks) after checking that the inner dimensions match;
        when one operand is "Ic" extend the resulting entry list with the
        stored corrections from the other operand.
     3. Post-process the raw entry list with SimplifyEntryList so that identical rows
        and columns are merged and redundant DiracDelta decorations are
        removed.
   Inputs: m1, m2 - encoded matrices with heads "c", "Ic", or "I".
   Output: Encoded matrix representing the product m1.m2.
*)
MultiplyEncodedBlocks[m1_List,m2_List]:= Module[{tmp},
  Which[
    m2[[1]]==="I",
    tmp=m1
    ,
    m1[[1]]==="c"&&m2[[1]]==="c",
    If[m1[[3]]=!=m2[[2]],
      symGFPrint["dimensions don't match: ",m1, " and ",m2];
      Abort[];
      ,
      tmp=MultiplyCoefficientBlocks[m1,m2]
    ]
    ,
    m1[[1]]==="c"&&m2[[1]]==="Ic",
    If[ m2[[2]]=!=m2[[3]],
      symGFPrint["non-square matrix with Ic symbol:",m2];
      Abort[];
      ,
      (* m1+MultiplyCoefficientBlocks[m1,m2] *)
      tmp=MultiplyCoefficientBlocks[m1,m2];
      tmp[[4]]=Join[tmp[[4]],m1[[4]] ];
    ]
    ,
    m1[[1]]==="Ic"&&m2[[1]]==="c",
    If[ m1[[2]]=!=m1[[3]],
      symGFPrint["non-square matrix with Ic symbol:",m1];
      Abort[];
      ,
      (* m1+MultiplyCoefficientBlocks[m1,m2] *)
      tmp=MultiplyCoefficientBlocks[m1,m2];
      tmp[[4]]=Join[tmp[[4]],m2[[4]] ];
    ]
    ,
    True,
    (* above listed should be the only cases we should meet in gaussian elimination *)
    symGFPrint["error: can't identify matrices:",m1," or ",m2]
  ];
  tmp[[4]]=SimplifyEntryList[tmp[[4]] ,m1[[2]],m2[[3]] ];
  tmp
]
MultiplyCoefficientBlocks[m1_List,m2_List]:=
{"c",m1[[2]],m2[[3]],Flatten[Table[MultiplySingleEntries[m1[[4,i]],m2[[4,j]]],{i,Length[m1[[4]]]},{j,Length[m2[[4]] ] }],1]   }


(*
   Function: PropagateYBackward[y_List,s_List]
   Purpose: Propagate substitution chains from the y-side of a matrix entry
     into the s list; logically this mirrors PropagateYForward but walks the dependencies in
     the opposite direction.
   Algorithm:
     1. Iterate over the yet-unified x/y groups stored in y.
     2. Whenever a group shares an index with the first column of s, replace
        the matching entry in s by expanding that group so each element
        inherits the stored multiplier in the second column.
     3. Remove the processed row from y and keep iterating until no matches
        remain, returning the updated pair of lists.
   Inputs: y - groups of indices tied to y placeholders; s - substitution grid
     whose first column stores the indices to be matched.
   Output: {updated y list, updated s list}.
*)
PropagateYBackward[y_List,s_List]:=Module[{xy=y,xs=s,t,i=1}, (* same logic as PropagateYForward but mirrored *)
  While[i<=Length[xy],
    If[(t=Intersection[xy[[i]],xs[[All,1]] ])=!={},
      t=Position[xs[[All,1]],t[[1]]][[1,1]];
      xs=xs~Join~Table[{xy[[i,j]],xs[[t,2]]},{j,Length[xy[[i]]]}];
      xs=Delete[xs,t];
      xy=Delete[xy,i];
      ,
      i++
    ]
  ];
  {xy,xs}
]
(*
   Function: PropagateYForward[y_List,e_List]
   Purpose: Expand the y-side indices using the substitution information that
     sits in the second column of e; this is the forward direction complement
     of PropagateYBackward.
   Algorithm:
     1. Iterate over the pending groups stored in y.
     2. If a group shares an index with the second column of e, split that
        row so that every element of the group inherits the first-column label
        of the matching entry inside e.
     3. Delete the processed y block as well as the original row in e and
        continue until every match has been propagated.
   Inputs: y - index groups bound to y placeholders; e - substitution table
     whose second column contains the indices to be replaced.
   Output: {updated y list, updated e list}.
*)
PropagateYForward[y_List,e_List]:=Module[{xy=y,xe=e,t,i=1}, (* see manuscript for the original derivation *)
  While[i<=Length[xy],
    If[(t=Intersection[xy[[i]],xe[[All,2]] ])=!={},
      t=Position[xe[[All,2]],t[[1]]][[1,1]];
      xe=xe~Join~Table[{xe[[t,1]],xy[[i,j]]},{j,Length[xy[[i]]]}];
      xe=Delete[xe,t];
      xy=Delete[xy,i];
      ,
      i++
    ]
  ];
  {xy,xe}
]
(*
   Function: LinkAssignments[e_List,s_List]
   Purpose: Link entries from list e to list s so that matched indices can be
     treated as the same physical leg when multiplying matrix elements.
   Algorithm:
     1. Scan each element of e and look for a matching index in the first
        column of s.
     2. When a match exists, create a triple {e[[i,1]], e[[i,2]], s[[t,2]]}
        telling later code that these two structures must be merged with the
        specified Dirac-delta symbol.
     3. Remove the consumed rows from e and s and return the leftovers
        alongside the list of connections.
   Inputs: e, s - substitution tables that arose from PropagateYForward/PropagateYBackward.
   Output: {remaining e rows, remaining s rows, list of connection triples}.
*)
LinkAssignments[e_List,s_List]:=Module[ {t,xe=e,xs=s,k={},i=1},
  While[i<=Length[xe],
    If[(t=Position[xs[[All,1]],xe[[i,2]] ])=!={},
      t=t[[1,1]];
      AppendTo[k,{xe[[i,1]],xe[[i,2]],xs[[t,2]]}];
      xe=Delete[xe,i];
      xs=Delete[xs,t];
      ,
      i++
    ]
  ];
  {xe,xs,k}
]
(*
   Function: MultiplySingleEntries[l1_List,l2_List]
   Purpose: Multiply two single matrix entries expressed in the symbolic
     layout {row data, column data, coefficient data} while honoring all
     x/y placeholders and contraction rules.
   Algorithm:
     1. Build a skeleton entry that multiplies the scalar coefficients and
        concatenates the lists that describe how each placeholder should be
        transformed.
     2. Use PropagateYForward, PropagateYBackward, and LinkAssignments to propagate dependencies between the x-side of
        the left entry and the y-side of the right entry, thereby exposing the
        placeholder indices that must be identified.
     3. Traverse every placeholder index and decide whether it belongs to the
        b, c, k, or a sets; multiply the appropriate coefficient piece, carry
        out Dirac-delta contractions through CacheContractionFactor when two placeholders are
        tied, and finally record the delta bookkeeping into tmp[[3,2]].
   Inputs: l1, l2 - single-entry descriptors extracted from two blocks.
   Output: New entry descriptor that represents their product.
*)
MultiplySingleEntries[l1_List,l2_List]:=Module[{a=Join[l1[[2,2]],l2[[1,2]] ],b=l1[[3,2]],c=l2[[3,2]],tmp,i,j,j2,m,k},
  tmp={l1[[1]],l2[[2]],{l1[[3,1]]l2[[3,1]] ,{} }  };
  {a,b}=PropagateYForward[a,b];
  {a,c}=PropagateYBackward[a,c];
  {b,c,k}=LinkAssignments[b,c];
  Do[
    Which[
      MemberQ[b[[All,2]],i],
      j=b[[Position[b[[All,2]],i][[1,1]],1]];
      tmp[[1,1,j]]*=(l1[[2,1,i]]/.y[i]->x[j])(l2[[1,1,i]]/.x[i]:>x[j]/;i!=j)
      ,
      MemberQ[c[[All,1]],i],
      j=c[[Position[c[[All,1]],i][[1,1]],2]];
      tmp[[2,1,j]]*=(l1[[2,1,i]]/.y[i]:>y[j]/;j!=i)(l2[[1,1,i]]/.x[i]->y[j])
      ,
      MemberQ[k[[All,2]],i],
      j=k[[Position[k[[All,2]],i][[1,1]],1]];
      tmp[[1,1,j]]*=(l2[[1,1,i]]/.x[i]:>x[j]/;j!=i)(l1[[2,1,i]]/.y[i]->x[j]);
      j2=k[[Position[k[[All,2]],i][[1,1]],3]];
      tmp[[1,1,j2]]*=tmp[[2,1,j2]]/.y[i]->x[j];
      tmp[[2,1,j2]]=1;
      ,
      MemberQ[Flatten[a],i],
      If[MemberQ[a[[All,1]],i],
        m=Position[a,i][[1,1]];
        tmp[[3,1]]*=CacheContractionFactor[Times@@(l1[[2,1,a[[m]]]]),Times@@(l2[[1,1,a[[m]]]])]
      ]
      ,
      True,
      tmp[[3,1]]*=l1[[2,1,i]]
    ]
    ,{i,Length[l1[[2,1]]]}];
  tmp[[3,2]]=k[[All,{1,3}]];
  tmp
]
(*
   Function: SubtractEncodedBlocks[m1_List,m2_List]
   Purpose: Subtract one encoded block matrix from another and merge the
     resulting entry list.
   Algorithm:
     1. Confirm that m1 and m2 share identical shapes because subtraction is
        defined only for conformable matrices.
     2. Flip the sign of every scalar coefficient inside m2 (entry[[4,*,3,1]])
        so it can be appended to the entry list of m1.
     3. Concatenate both entry lists and call SimplifyEntryList to merge equivalent rows
        and columns, yielding a cleaned-up block.
   Inputs: m1, m2 - encoded matrices.
   Output: Encoded matrix representing m1 - m2.
*)
SubtractEncodedBlocks[m1_List,m2_List]:=Module[{ret=m1,tmp=m2},
  If[m1[[2]]!=m2[[2]]||m1[[3]]!=m2[[3]],
    symGFPrint["non-matching dimension of matrices:",m1 ," and ",m2];
    Abort[]
  ];
  tmp[[4,All,3,1]]*=-1;
  ret[[4]]=ret[[4]]~Join~tmp[[4]] ;
  ret[[4]]=SimplifyEntryList[ret[[4]] ,m1[[2]],m1[[3]]   ];
  (*If[Length[ret[[4]]  ]>1,symGFPrint["jian cheng: ",ret]; ];*)
  ret
]
(*
   Function: SubtractEncodedBlocks[ZeroEncodedBlock,m2_List]
   Purpose: Negate an encoded matrix, i.e. compute 0 - m2, which is used when
     building the constant column of M.
   Algorithm:
     1. Copy m2.
     2. Multiply every scalar coefficient inside entry[[4,*,3,1]] by -1.
   Inputs: ZeroEncodedBlock - sentinel representing the zero matrix; m2 - encoded block.
   Output: Encoded matrix equal to -m2.
*)
SubtractEncodedBlocks[ZeroEncodedBlock,m2_List]:=Module[ {tmp=m2},
  tmp[[4,All,3,1]]*=-1;
  tmp
]
(*
   Function: SubtractEncodedBlocks[IdentityEncodedBlock,m2_List]
   Purpose: Subtract m2 from the identity block, producing the symbolic
     structure needed when pivot rows are updated.
   Algorithm:
     1. Copy m2 and negate all scalar coefficients.
     2. Tag the copy as "Ic" to indicate that it now behaves like an identity
        block with corrections.
   Inputs: IdentityEncodedBlock - encoded identity block; m2 - encoded matrix to subtract.
   Output: Encoded matrix representing IdentityEncodedBlock - m2.
*)
SubtractEncodedBlocks[IdentityEncodedBlock,m2_List]:=Module[ {tmp=m2},
  tmp[[4,All,3,1]]*=-1;
  tmp[[1]]="Ic";
  tmp
]
(*
   Function: DetectRowMerges[l_List]
   Purpose: Find sets of entries inside l that share the same row label and
     delta bookkeeping so they can be merged along the x-direction.
   Algorithm:
     1. Traverse consecutive entries of the sorted list l, looking for pairs
        with identical first elements and identical third-column delta tags.
     2. When a match is found, record the row label and the list of positions
        that need to be merged.
     3. Return the unique list of such merge instructions.
   Inputs: l - list of entry descriptors sorted by rows.
   Output: {{rowLabel, {idx1,idx2,...}}, ...}.
*)
DetectRowMerges[l_List]:=Module[{ret={} ,p},
  
  Do[
    If[l[[i,1]]===l[[i+1,1]] && l[[i,3,2]]===l[[i+1,3,2]],
      p=Position[l[[All,1]],l[[i,1]]][[All,1]];
      AppendTo[ret,{l[[i,1]],p}]
    ]
    ,{i,Length[l]-1}];
  Union[ret]
]
(*
   Function: DetectColumnMerges[l_List]
   Purpose: Identify duplicate column entries so that SimplifyEntryList can merge them
     along the y-direction.
   Algorithm:
     1. Iterate through consecutive entries in the sorted list looking for
        identical column labels and identical delta metadata.
     2. Record each column label together with the indices of the entries that
        need to be merged.
     3. Return the union of all recorded merge instructions.
   Inputs: l - list of entry descriptors sorted by columns.
   Output: {{columnLabel, {idx1,idx2,...}}, ...}.
*)
DetectColumnMerges[l_List]:=Module[{ret={} ,p},
  
  Do[
    If[l[[i,2]]===l[[i+1,2]] && l[[i,3,2]]===l[[i+1,3,2]],
      p=Position[l[[All,2]],l[[i,2]]][[All,1]];
      AppendTo[ret,{l[[i,2]],p}]
    ]
    ,{i,Length[l]-1}];
  Union[ret]
]
(*
   Function: MergeRowEntries[l_List,yy_List,dimen_]
   Purpose: Merge the rows listed in yy by summing their coefficients and
     consolidating their delta bookkeeping; used after DetectRowMerges reports
     duplicates.
   Algorithm:
     1. Keep all entries not referenced by yy untouched.
     2. For every merge instruction {label, positions}, accumulate the
        corresponding coefficients along the x-side or, when dimen==0, move
        the scalars to the third slot while keeping placeholder structure.
     3. After merging, run NormalizePlaceholderFactors to separate factors independent of y so that
        the remaining coefficients continue to expose the right placeholders.
   Inputs: l - full list of entries; yy - merge plan from DetectRowMerges; dimen - 0
     or 1 describing whether we operate on x or y slots.
   Output: New list with merged rows.
*)
MergeRowEntries[l_List,yy_List,dimen_]:=Module[{ret={},s},
  
  s=Complement[Range[Length[l] ], Flatten[  yy[[All,2]]  ]   ];
  ret=Join[ret,l[[s]]];
  Scan[
    Function[i,
      Switch[dimen,
        1,
        AppendTo[ret,{
            yy[[i,1]],
            {{Plus@@(Apply[Times,l[[yy[[i,2]],2,1]],{1}]l[[yy[[i,2]],3,1]])},l[[yy[[i,2,1]],2,2]]},
            {1,l[[yy[[i,2,1]],3,2]]}
        }],
        0,
        AppendTo[ret,{
            yy[[i,1]],
            {{},{}},
            {Plus@@(Apply[Times,l[[yy[[i,2]],2,1]],{1}]l[[yy[[i,2]],3,1]]),l[[yy[[i,2,1]],3,2]]}
        }]
      ]
    ],
    Range[Length[yy]]
  ];
  {ret[[-1,2,1]],ret[[-1,3,1]]}= NormalizePlaceholderFactors[ ret[[-1,2,1]] ,ret[[-1,3,1]],y  ];
  ret
]
(*
   Function: MergeColumnEntries[l_List,yy_List,dimen_]
   Purpose: Merge duplicate columns the same way MergeRowEntries merges rows, i.e.
     consolidate coefficients and delta bookkeeping on the y-side.
   Algorithm:
     1. Copy untouched entries and then, for each merge instruction, sum the
        affected column coefficients or move the resulting scalars into the
        third slot when operating in scalar mode (dimen==0).
     2. Apply NormalizePlaceholderFactors so that factors independent of x are pulled into the scalar
        prefactor, keeping the placeholder structure normalized.
   Inputs: l - full list; yy - merge instructions from DetectColumnMerges; dimen - 0 or 1
     describing the context.
   Output: New list with merged columns.
*)
MergeColumnEntries[l_List,yy_List,dimen_]:=Module[{ret={},s},
  
  s=Complement[Range[Length[l] ], Flatten[  yy[[All,2]]  ]   ];
  ret=Join[ret,l[[s]]];
  Scan[
    Function[i,
      Switch[dimen,
        1,
        AppendTo[ret,{
            {{Plus@@(Apply[Times,l[[yy[[i,2]],1,1]],{1}]l[[yy[[i,2]],3,1]])},l[[yy[[i,2,1]],1,2]]},
            yy[[i,1]],
            {1,l[[yy[[i,2,1]],3,2]]}
        }],
        0,
        AppendTo[ret,{
            {{},{}},
            yy[[i,1]],
            {Plus@@(Apply[Times,l[[yy[[i,2]],1,1]],{1}]l[[yy[[i,2]],3,1]]),l[[yy[[i,2,1]],3,2]]}
        }]
      ]
    ],
    Range[Length[yy]]
  ];
  {ret[[-1,1,1]],ret[[-1,3,1]]}= NormalizePlaceholderFactors[ ret[[-1,1,1]],ret[[-1,3,1]] ,x  ];
  ret
]
(*
   Function: NormalizePlaceholderFactors[lb_List,onum_,v_]
   Purpose: Split each entry in lb into a piece that still depends on the
     placeholder v[i] and a scalar prefactor that can be accumulated in onum.
   Algorithm:
     1. Map over the list while keeping track of the element index so the
        placeholder subscript v[i] is known.
     2. When a factor inside value does not depend on v[i], multiply it into
        num and divide it out from the entry; otherwise keep the factor inside
        the list element.
     3. Return the normalized list together with the updated overall numeric
        multiplier.
   Inputs: lb - list of expressions; onum - scalar prefactor;
     v - placeholder head (x or y).
   Output: {normalized list, updated scalar prefactor}.
*)
NormalizePlaceholderFactors[lb_List,onum_,v_]:=Module[{l=lb,num=onum,t},
  l=MapIndexed[Function[{expr,idx},
      Module[{i=First[idx],value=Simplify[expr]},
        Which[
          Head[value]===Times,
          t=Select[value,FreeQ[#,v[i]]&];
          num*=t;
          value/=t,
          FreeQ[value,v[i]],
          num*=value;
          value=1
        ];
        value
      ]
    ],l];
  {l,num}
]
(*
   Function: SimplifyEntryList[l_List,dx_,dy_]
   Purpose: Clean up the entry list of an encoded block by merging rows and
     columns that carry identical placeholders, thereby reducing redundant
     bookkeeping.
   Algorithm:
     1. Sort the list and use DetectColumnMerges/MergeColumnEntries to merge equivalent columns,
        optionally operating in scalar mode depending on dx.
     2. Sort again, detect duplicated rows with DetectRowMerges, and merge them via
        MergeRowEntries, supplying dy so the caller controls whether placeholders or
        pure scalars are retained.
   Inputs: l - entry list; dx, dy - dimensions (0 or 1) describing the
     placeholder structure on each side.
   Output: Simplified entry list with unique rows and columns.
*)
SimplifyEntryList[l_List,dx_,dy_]:=Module[ {t,ret=l},
  ret=Sort[l,OrderedQ[  {#1[[2]],#2[[2]] }] & ];
  t=DetectColumnMerges[ret];
  If[t=!={},
    ret=MergeColumnEntries[ret,t,dx]
  ];
  ret=Sort[ret ];
  t=DetectRowMerges[ret];
  If[t=!={},
    ret=MergeRowEntries[ret,t,dy]
  ];
  ret
]
xm[gi_UnderBar,ss_]:=(* when one of the subs of a gi or the sub of gi is summed, it can be replaced with a delta function *)
Module[{ret,idx,fm,rep},
  idx=ISOidx[gi];
  fm=IGFs[[idx,1]] /.ISOsubsub[IGFs[[idx,2]],gi];
  rep=Select[fm,!FreeQ[#,ss] &];  (* rep is the energy symbol that takes ss as its subs *)
  If[rep===0,
    symGFPrint["no subscript ",ss," found in ",gi," => ",fm];
    Abort[];
  ];
  If[MatchQ[rep,Times[-1,_] ],
    ret=- I  \[Pi] DiracDelta[EnergySymbol-fm+rep+ss   ]  (*diracd*)
    ,
    ret=- I \[Pi] DiracDelta[EnergySymbol-fm+rep-ss   ]
  ];
  ret
]
(*
   Function: CacheContractionFactor[t1_,t2_]
   Purpose: Cache the result of contracting two strings that differ only by
     the dummy summation symbol so that repeated contractions reuse the same
     Dirac-delta prefactor.
   Algorithm:
     1. Replace x/y placeholders by a generic GlobalSummationScript so the
        two arguments can be compared independent of their dummy index name.
     2. Look up the product inside GammaEnergy; if present, reuse the stored
        symbolic contraction coefficient, otherwise create a new \[CapitalGamma]
        symbol via symGFUnique and append it to the cache.
     3. Return the cached symbol so the caller can keep track of the new
        energy-dependent factor.
   Inputs: t1, t2 - scalar pieces extracted from two matrix entries.
   Output: A unique symbol encoding the contraction.
*)
CacheContractionFactor[t1_,t2_]:=Module[{cont,ret,p},
  cont=(t1 t2)/.{x->GlobalSummationScript,y->GlobalSummationScript};
  p=Position[ GammaEnergy[[All,1]] , cont ];
  If[ p=!={},
    ret=GammaEnergy[[ p[[1,1]], 2]]
    ,
    AppendTo[GammaEnergy,{cont,symGFUnique["\[CapitalGamma]"]} ];
    ret=GammaEnergy[[-1,2]]
  ];
  ret
]

(*CacheContractionFactor[t1_,t2_]:=Module[{sl,j,gi,cont,deltaPool,sol,i,S},
cont=(t1 t2)/.{x->S,y->S};
If[Head[cont]=!=Times && Head[cont]=!=Symbol,
symGFPrint["in function CacheContractionFactor, the cont may be illegal.",cont];
];
sl=Union[ Cases[cont,_S,\[Infinity]]  ];
(*symGFPrint["in function contraction:",sl];*)
symGFPrint[cont];
symGFPrint[cont/.S[_]->_];
Abort[];
For[j=1,j<=Length[sl],j++,
gi=Cases[cont,UnderBar [a_[___,sl[[j]] ,___    ] ]      ,\[Infinity]      ];
If[Length[gi]!=1 || (Length[gi]==1&&! FreeQ[Cases[cont   ,Power[___,_],\[Infinity]],gi[[1]]  ]),

If[(Length[gi]==1&&! FreeQ[Cases[cont   ,Power[___,_],\[Infinity]],gi[[1]]  ]),
symGFPrint["pay attention to this new pattern:",cont];
];
cont=ResInto[cont,sl[[j]],EnergySymbol] ;
,  (* only one gi, can use direct replace *)
gi=gi[[1]];
cont=cont/gi*xm[gi,sl[[j]]];
deltaPool=Select[Cases[cont,_DiracDelta,\[Infinity]],!FreeQ[#,sl[[j]]  ]&];  (*dirad *)
sol=Solve[ deltaPool[[1,1]]==0,sl[[j]]  ] [[1,1]];
If[ !FreeQ[sol,Root],symGFPrint["WTH !!",deltaPool]; Abort[]  ];
cont=Simplify[(cont/.deltaPool[[1]]->1)  ]/.sol;
];

];
If[!FreeQ[cont,DiracDelta[0]  ],symGFPrint[cont," now screwed!! "];
symGFPrint[cont," \n",deltaPool];
Abort[]   
];
cont
]
*)
(*
   Function: BlockIsInvertible[m_List]
   Purpose: Quick structural test that tells InvertEncodedBlock whether a block matrix can be
     inverted using the simplified routines intended for identity-like blocks.
   Algorithm:
     1. The matrix must be square and tagged "Ic", otherwise BlockIsInvertible immediately
        returns False.
     2. Inspect every entry stored in m[[4]] and ensure both placeholder lists
        (the second elements of entry[[1]] and entry[[2]]) are empty, meaning
        the block behaves like a scalar multiple of the identity.
   Inputs: m - encoded matrix to test.
   Output: True when m is a candidate for the lightweight inverse, False
     otherwise.
*)
BlockIsInvertible[m_List]:=Module[{ret=True,i},
  If[m[[2]]=!=m[[3]] || m[[1]]=!="Ic",
    ret=False
    ,
    Do[
      If[m[[4,i,1,2]]=!={} || m[[4,i,2,2]]=!={},
        ret=False
      ]
      ,{i,Length[m[[4]]]}]
  ];
  
  ret
]
(*
   Function: ClassifyBlockStructure[m_]
   Purpose: Classify the structure of an encoded matrix so InvertEncodedBlock can select the
     proper inversion recipe.
   Algorithm:
     1. Degenerate matrices with zero width fall into class 1.
     2. Otherwise iterate over every stored entry and count how many carry
        non-empty delta bookkeeping (d) and how many are plain scalars (f).
     3. Map the (d,f) combination into one of the cases 2-6, which represent
        e.g. a pure scalar correction (case 2), a purely delta block (case 3),
        mixed scalar/delta contributions (case 4), or more pathological
        structures (cases 5-6) that currently abort.
   Inputs: m - encoded matrix.
   Output: Integer code from 1 to 6.
*)
ClassifyBlockStructure[m_]:=Module[{d=0,f=0},
  If[m[[2]]==0,
    1,
    Scan[
      If[m[[4,#,3,2]]==={},f++,d++]&,
      Range[Length[m[[4]]]]
    ];
    Which[
      d==0&&f==1,2,
      d>0&&f==0,3,
      d>0&&f==1,4,
      d==0&&f>1,5,
      d>0&&f>1,6
    ]
  ]
]
InvertEncodedBlock[IdentityEncodedBlock]:=IdentityEncodedBlock
(*
   Function: InvertEncodedBlock[m_List]
   Purpose: Compute the inverse of an encoded matrix block using symbolic
     manipulations that track Dirac deltas and contraction history.
   Algorithm:
     1. Reject the request unless BlockIsInvertible confirms the block is invertible in the
        sense expected by this routine (square, tagged "Ic", no exotic
        placeholders).
     2. Classify the block via ClassifyBlockStructure; each case corresponds to a tailored
        formula: cases 1-3 invert purely scalar contributions, case 4 handles
        one-delta-one-scalar situations by splitting the block, and other
        cases abort because the current solver cannot handle them.
     3. Assemble the inverse by composing contributions with MultiplyEncodedBlocks, optionally
        recursing by calling InvertEncodedBlock on intermediate matrices that still have the
        "Ic" tag.
   Inputs: m - encoded matrix.
   Output: Encoded matrix representing the inverse of m.
*)
InvertEncodedBlock[m_List]:=Module[{ret,t1,t2},
  (* symGFPrint["inverting:",m]; *)
  If[!BlockIsInvertible[m],
    symGFPrint["not a invertible matrix:",m];
    Abort[];
  ];
  
  Switch[ClassifyBlockStructure[m],
    1,
    
    (* wrong format!!! *)
    ret={"c",0,0,{{{{},{}},{{},{}},{1/(1+m[[4,1,3,1]]),{}}}} }  (* change!!!!! *)
    ,
    2,
    
    ret=m;
    ret[[4,1,3,1]]*=-1/(1+ret[[4,1,3,1]]CacheContractionFactor[Times@@ret[[4,1,1,1]],Times@@ret[[4,1,2,1]] ])
    ,
    3,
    
    
    If[m[[2]]>1||Length[m[[4]]]>1,symGFPrint["zao le"];
      symGFPrint[m];
      
      
      Abort[]];
    ret={"c",m[[2]],m[[3]],{{{1/(1+m[[4,1,3,1]]m[[4,1,1,1]](m[[4,1,2,1]]/.y[a_]:>x[a]) ),{}},{Table[1,{m[[3]]}],{}},{1,m[[4,1,3,2]]}     }      }   }
    ,
    4,
    
    
    t1=InvertEncodedBlock[{m[[1]],m[[2]],m[[3]],Select[m[[4]],#[[3,2]]=!={}&]   }];
    (* symGFPrint["yi ni:",t1]; *)
    (* symGFPrint["multi:",{"c",m[[2]],m[[3]],Select[m[[4]],#[[3,2]]==={}&]   }]; *)
    t2=MultiplyEncodedBlocks[t1,{"c",m[[2]],m[[3]],Select[m[[4]],#[[3,2]]==={}&]   }];
    t2[[1]]="Ic";  
    (* symGFPrint["t2:",t2]; *)
    ret=MultiplyEncodedBlocks[ InvertEncodedBlock[t2]  ,t1];
    ,
    5,
    
    symGFPrint[5];
    symGFPrint[m];Abort[]
    ,
    6,
    
    symGFPrint[6];symGFPrint[m];
    Abort[]
  ];
  ret
]
(*
   Function: GaussElim[]
   Purpose: Perform block Gaussian elimination on M, treating each entry as an
     encoded matrix block instead of a scalar.
   Algorithm:
     1. Walk pivot rows from the bottom to the top; for each pivot use InvertEncodedBlock to
        invert the diagonal block M[[p,p]].
     2. For every row above the pivot, build the elimination multiplier by
        multiplying M[[h,p]] with the inverse and then update each block in
        that row via MultiplyEncodedBlocks/SubtractEncodedBlocks so the pivot column turns into ZeroEncodedBlock (zero).
     3. Apply the same transformation to the augmented column (Length[M]+1) to
        keep the right-hand side synchronized.
   Inputs: None; operates on global M.
   Output: Mutated matrix M in upper-triangular form.
*)
GaussElim[]:=Module[{p,h,l,t,temp},
  symGFPrint["Gaussian Elimination of ",Length[M],"x",Length[M]+1," matrix.\nDoing row:"];
  t=TimeUsed[];
  Do[
    L[[1]]=InvertEncodedBlock[ M[[p,p]] ];  (* InvertEncodedBlock=Inverse *)
    Do[
      If[M[[h,p]]===ZeroEncodedBlock,Continue[] ];
      L[[2]]=MultiplyEncodedBlocks[M[[h,p]],L[[1]]   ];
      Do[
        If[M[[p,l]]===ZeroEncodedBlock,Continue[] ];
        L[[3]]=MultiplyEncodedBlocks[ L[[2]], M[[p,l]]  ];
        M[[h,l]]=SubtractEncodedBlocks[ M[[h,l]] , L[[3]]   ];
        ,{l,p-1,1,-1}];(* l *)
      If[M[[p,Length[M]+1]]=!=ZeroEncodedBlock,
        L[[3]]=MultiplyEncodedBlocks[ L[[2]], M[[p,Length[M]+1]]  ];
        M[[h,Length[M]+1]]=SubtractEncodedBlocks[ M[[h,Length[M]+1]] , L[[3]]   ]; 
      ];
      M[[h,p]]=ZeroEncodedBlock; (* not using it is equivalent to setting it to zero *)
      ,{h,p-1,1,-1}]; (* h *)
    ,{p,Length[M],1,-1}];  (* p *)
  symGFPrint["Finished in ",TimeUsed[]-t," seconds."];
  M
]
(*
   Function: GaussElimVerbose[]
   Purpose: Diagnostic variant of GaussElim that prints progress information
     while performing the same block elimination steps.
   Algorithm:
     1. Iterate over pivots identically to GaussElim but print the pivot index
        and intermediate multipliers to help debug pathological systems.
     2. Propagate the multipliers through each row and the augmented column,
        turning pivot columns into ZeroEncodedBlock blocks.
   Inputs: None; uses global M.
   Output: Updated M identical to GaussElim but with verbose output.
*)
GaussElimVerbose[]:=Module[{p,h,l},
  Do[
    symGFPrint[p];
    L[[1]]=InvertEncodedBlock[ M[[p,p]] ];  (* InvertEncodedBlock=Inverse *)
    symGFPrint[p];
    Do[
      If[M[[h,p]]===ZeroEncodedBlock,Continue[] ];
      If[p==70,symGFPrint[ "h: ",h];];
      If[p==70&&h==67,symGFPrint["L1:",L[[1]]];symGFPrint["M:",M[[h,p]] ]; ];
      L[[2]]=MultiplyEncodedBlocks[M[[h,p]],L[[1]]   ];
      If[p==70&&h==67,symGFPrint["tic"]; ];
      Do[
        If[M[[p,l]]===ZeroEncodedBlock,Continue[] ];
        If[p==70&&h==67,symGFPrint["tic2 ",l]; ];
        L[[3]]=MultiplyEncodedBlocks[ L[[2]], M[[p,l]]  ];
        If[p==70&&h==67,symGFPrint["tic3 ",l]; ];
        M[[h,l]]=SubtractEncodedBlocks[ M[[h,l]] , L[[3]]   ];
        If[p==70&&h==67,symGFPrint["tic4 ",l]; ];
        ,{l,p-1,1,-1}];(* l *)
      If[M[[p,Length[M]+1]]=!=ZeroEncodedBlock,
        L[[3]]=MultiplyEncodedBlocks[ L[[2]], M[[p,Length[M]+1]]  ];
        M[[h,Length[M]+1]]=SubtractEncodedBlocks[ M[[h,Length[M]+1]] , L[[3]]   ]; 
      ];
      M[[h,p]]=ZeroEncodedBlock; (* not using it is equivalent to setting it to zero *)
      ,{h,p-1,1,-1}] (* h *)
    ,{p,Length[M],1,-1}]; (* p *)
  M
]



CondIter[]:=RunSunIteration[]
(*
   Function: RunSunIteration[]
   Purpose: Run Dr. Sun Qing-Feng's conditioned iteration algorithm on the
     derived equations of motion.
   Algorithm:
     1. Initialize the to-be-solved queue (TBS) with the user-requested Green's
        functions.
     2. Pop each entry, inspect its equation of motion, and hand every term to
        ExpandCouplingChains so that coupling-constant paths and nested GF dependencies are
        explored.
     3. Accumulate solved expressions in fe, mark terms that have to be solved
        self-consistently by pushing their indices into TBS and TS, and keep
        running until no unresolved GF remains.
   Inputs: None; consumes global eom/GFnames state.
   Output: Side effects on TBS, TS, SelfEnergy, etc.; returns Null.
*)
RunSunIteration[]:=Module[{tim,i,fe={}},
  (* start with eom[[1]] *)
  
  (* find a term with coulping constant multiplied with a GF, a lot things, only U and -1 are exception (?)  *)
  
  (* for each of the terms, (in which there should be only one GF), find the corresponding eom, 
  use that eom to generate (subs) the right eom with multiplier. *)
  
  (* check the rhs of that new eom. if there is a pair of CC, then all the related iso-gf and that pair forms a SE. could judge by subs and ??
  but should be ok. later can be judged by type ? i think subs will be enough. *)
  
  (* keep that new eom and do....... *)
  tim=TimeUsed[];
  TBS={1};
  i=1;
  While[i<=Length[TBS],
    symGFPrint["Doing ",i," from ",TBS];
    TS={};
    AppendTo[fe,GFnames[[ TBS[[i]] ]] ==ExpandCouplingChains[TBS[[i]],{},1,{}]  ];
    i++;
  ];
  symGFPrint["finally ",fe," with ",GFnames[[ TBS ]] ];
  (*	symGFPrint["SE: ",SelfEnergy];*)
  symGFPrint["Finished in ",TimeUsed[]-tim," seconds."];
]

(*
   Function: listify[expr_Times]
   Purpose: Expand a product into an explicit list of factors by turning every
     power into repeated entries; used for counting coupling constants.
   Algorithm:
     1. Convert the Times expression into a list.
     2. While powers remain, replace each Power[h,n] by a list containing n
        copies of h.
     3. Flatten the resulting list to obtain a simple multiset representation.
   Inputs: expr - Times expression.
   Output: Flat list of multiplicative factors.
*)
listify[expr_Times]:=Module[{tmp,pos},
  tmp=List@@expr;
  While[(pos=Position[tmp,_Power])=!={},
    tmp[[pos[[1,1]]]]=Table[tmp[[pos[[1,1]],1]],{tmp[[pos[[1,1]],2]]}];
  ];
  tmp//Flatten
]
listify[expr_]:=(symGFPrint["na lai de??? "];Abort[];)


(*
   Function: ExpandCouplingChains[gFind_Integer,pathway_List,multiplier_,replist_]
   Purpose: Explore the equation of motion indexed by gFind, collect coupling
     chains, and recursively substitute dependent Green's functions so that
     self-energy structures emerge.
   Algorithm:
     1. Substitute replist into the current equation and expand it so each
        term can be analysed independently; lhs tracks the Green's function
        whose equation is being processed.
     2. For every term, isolate DiracDelta factors (grab3), compute the
        multiplicative prefactor MiT, and call grasp to classify the
        remaining pieces as coupling constants, isolated GFs, or other terms.
     3. When another GF is encountered, recurse unless the pathway would form
        a cycle; record self-consistent indices in TS/TBS and cache the final
        substituted expression.
   Inputs: gFind - GF index; pathway - recursion stack; multiplier - scalar
     prefactor; replist - subscript replacement rules.
   Output: Expanded right-hand-side expression for GF gFind.
*)
ExpandCouplingChains[gFind_Integer,pathway_List,multiplier_,replist_]:=Module[{i,j,curreom,gfidx,gfform,recent,lhs,baksum},
  
  curreom=( (eom[[gFind]]*multiplier)   /.  replist       )//ExpandAll;
  lhs=(GFnames[[gFind]]/.replist)*multiplier;
  (*	symGFPrint["   ExpandCouplingChains : ",gFind,"  ",lhs," == ",curreom,"  ",pathway,"    "]; *)
  Switch[curreom,
    _Plus,
    curreom=List@@curreom;
    Do[
      (* there should be no subs in diracdelta that is also in lhs *)
      If[!FreeQ[curreom[[i]],DiracDelta],
        backsum=sumlist;
        sumlist=Complement[sumlist,subs[lhs] ];
        curreom[[i]]=grab3[curreom[[i]] ];
        sumlist=backsum;
      ];  (* may change grab3, or just here; may cause trouble *)
      (* symGFPrint["----- term ",i, " of ",gFind,"  ",curreom[[i]]];*)
      
      
      recent=MiT[curreom[[i]]]/multiplier;
      curreom[[i]]=grasp[lhs,recent,curreom[[i]] ];   
      (*				symGFPrint["grasped into: ",curreom[[i]]," lhs: ", lhs];*)
      gfidx=GFIiT[curreom[[i]] ];
      gfform=GFiT[curreom[[i]] ];
      If[Length[gfform]>1,symGFPrint["Error: multiple of GF's found in term ",curreom[[i]]  ];Abort[]; ];
      If[gfidx>0,
        If[CCinTerm[curreom[[i]]],
          If[!MemberQ[pathway,gfidx],
            (*						symGFPrint["passing ",i," of ",gFind,"  ",MiT[curreom[[i]] ],"   ",multiplier];*)
            curreom[[i]]=curreom[[i]]/MiT[curreom[[i]] ]/gfform *
            ExpandCouplingChains[gfidx,pathway~Join~{gFind},MiT[curreom[[i]] ] , 
              GFTOsubsub[GFnames[[gfidx]],gfform ]  ];
            (*						symGFPrint["now ",i,"'th term of GF ",gFind," = ",curreom[[i]]  ];
            symGFPrint["and totally GF",gFind," = ",curreom ];*)
            ,
            TS=Union[TS,{gfidx}];
            (*symGFPrint["TS: ",TS];
            symGFPrint["path: ",pathway,"  idx: ",gfidx]; *)
          ]
          ,
          If[FreeQ[TBS,gfidx],
            AppendTo[TBS,gfidx]
          ];
          
        ];
        ,
        symGFPrint["Temp: ",curreom[[i]]," has no GF."];
      ];
      If[!FreeQ[curreom[[i]],DiracDelta],(* have to do it again, as the lhs' could be annoying *)
        backsum=sumlist;
        sumlist=Complement[sumlist,subs[lhs] ];
        curreom[[i]]=grab3[curreom[[i]] ];
        sumlist=backsum;
      ];  (* may change grab3, or just here; may cause trouble *)
      If[Head[curreom[[i]]]===Plus,
        curreom[[i]]=List@@curreom[[i]];
        Do[
          recent=MiT[curreom[[i,j]]]/multiplier;
          curreom[[i,j]]=grasp[lhs,recent,curreom[[i,j]] ];
          ,{j,Length[curreom[[i]]]}];
        curreom[[i]]=Plus@@curreom[[i]];
        ,
        (* i assume curreom[[i]] is still one term *)
        recent=MiT[curreom[[i]]]/multiplier;
        curreom[[i]]=grasp[lhs,recent,curreom[[i]] ];   
      ];	
      ,{i,Length[curreom]}];
    curreom=Plus@@curreom,
    _Times,
    If[!FreeQ[curreom,DiracDelta],  
      backsum=sumlist;
      sumlist=Complement[sumlist,subs[lhs] ];
      curreom=grab3[curreom ];
      sumlist=backsum;
    ];  (* may change grab3, or just here; may cause trouble *)
    (*symGFPrint["the only term of ",gFind,"  ",curreom];*)
    
    recent=MiT[curreom]/multiplier;
    curreom=grasp[lhs,recent,curreom ];   
    (*symGFPrint["grasped into ",curreom];*)
    gfidx=GFIiT[curreom ];
    gfform=GFiT[curreom ];
    If[Length[gfform]>1,symGFPrint["Error: multiple of GF's found in term ",curreom  ];Abort[]; ];
    If[gfidx>0,
      If[CCinTerm[curreom],
        If[!MemberQ[pathway,gfidx],
          curreom=curreom/MiT[curreom ]/GFiT[curreom ]*ExpandCouplingChains[gfidx,pathway~Join~{gFind},MiT[curreom ] ,
            GFTOsubsub[GFnames[[gfidx]],gfform]  ];
          ,
          TS=Union[TS,{gfidx}];
        ]
        ,
        If[FreeQ[TBS,gfidx],
          AppendTo[TBS,gfidx]
        ];
        
      ];
      ,
      symGFPrint["Temp: ",curreom," has no GF."];
    ];
    If[!FreeQ[curreom,DiracDelta],
      backsum=sumlist;
      sumlist=Complement[sumlist,subs[lhs] ];
      curreom=grab3[curreom ];
      sumlist=backsum;
    ];  (* may change grab3, or just here; may cause trouble *)
    
    If[Head[curreom]===Plus,
      curreom=List@@curreom;
      Do[
        recent=MiT[curreom[[j]]]/multiplier;
        curreom[[j]]=grasp[lhs,recent,curreom[[j]] ];
        ,{j,Length[curreom]}];
      curreom=Plus@@curreom;
      ,
      (* i assume curreom is still one term *)
      recent=MiT[curreom]/multiplier;
      curreom=grasp[lhs,recent,curreom ]   
    ],
    _,
    symGFPrint["Error: Unknown expression type: ",curreom];
    Abort[];
  ];
  If[MemberQ[TS,gFind],
    
    (*	symGFPrint["**",gFind," ",multiplier," ",GFnames[[gFind]]/.replist," \n  ",curreom,"  ",pathway,"  ",TS];*)
    curreom=solveself[lhs,curreom];
  ];
  (*	symGFPrint["   ExpandCouplingChains : ",gFind," ends with: ",lhs," == ",curreom//ExpandAll,"  ",pathway,"    "]; *)
  curreom//ExpandAll
]
(*
   Function: solveself[lhs_,rhs_Plus]
   Purpose: Solve equations where the requested Green's function only couples
     to itself, i.e. compute lhs == rhs / (1 - \Sigma).
   Algorithm:
     1. Split rhs into a list, remove all terms proportional to the left-hand
        GF, and accumulate their coefficient into oneminus so the denominator
        (1 - oneminus) can be built.
     2. Expand any occurrences of the dummy pattern purepattern[fm] by calling
        IterateTOBranch, simplify DiracDelta contributions via grab3, and repeat
        until no further replacements are needed.
     3. After isolating the left-only denominator, factor common coupling
        constants and isolated Green's functions, convert them into
        GammaEnergySymbol / SelfEnergySymbol objects, and finally call grasp
        so that the entire expression conforms to the solver's bookkeeping.
   Inputs: lhs - GF on the left-hand side; rhs - sum of terms containing lhs.
   Output: Canonical rhs expression where lhs has been solved self-consistently.
*)
solveself[lhs_,rhs_Plus]:=Module[{redo=1,i,fm,trhs=rhs,oneminus=0,rec={},u,poly,cd,left,ret=0,ab=0,fm2},
  While[redo==1,
    redo=0;
    trhs=List@@trhs;
    fm=GFiT[lhs];
    Do[
      If[!FreeQ[trhs[[i]],fm],
        oneminus+=trhs[[i]]/lhs;
        trhs[[i]]=0
        ,
        If[!FreeQ[trhs[[i]],purepattern[fm]],
          symGFPrint[" dummy vars "];
          trhs[[i]]=ExpandAll[IterateTOBranch[trhs[[i]],{GFIiT[trhs[[i]]]}]];
          If[!FreeQ[trhs[[i]],DiracDelta],
            backsum=sumlist;
            sumlist=Complement[sumlist,subs[lhs]];
            trhs[[i]]=grab3[trhs[[i]]];
            sumlist=backsum;
          ];
          redo=1
        ]
      ]
      ,{i,Length[trhs]}];
    If[!FreeQ[trhs,Power[_,-1] ], symGFPrint["internal error: shouldn't have division ",trhs]; ];
    trhs=Plus@@trhs;
  ];
  
  
  (* here we can grasp them again, as we fucking need it! *)
  (* ideally, or i think, the relationship between a GF and another GF should be not random at all. if GF1= tl[k] GF2,
  then there should be no other equations like GF1 = t1d GF2. when dealing with devrim's thesis, we met the case where
  multipliers of self-energies differ. *)
  If[Head[trhs]=!=Plus,
    poly=trhs;
    cd=Times@@Cases[poly,_OverTilde];
    left=poly/cd;
    fm2=GammaEnergySymbol[lhs,cd,1-oneminus]*left;
    If[Length[GammaEnergy]==62, symGFPrint["ge 1 ",lhs,"  ",cd,"  ",oneminus]; ];
    ret=grasp[1,fm2,fm2];
    ,
    equaltime=Select[trhs,GFIiT[#]==0&];
    rec=Table[{GFIiT[trhs[[i]]],CCprofile[trhs[[i]]],GFiT[trhs[[i]]]}, {i,Length[trhs]}];
    u=Union[  rec[[All,1]]  ];
    
    Scan[
      Function[val,
        If[val!=0 && Length[Union[Select[rec,#[[1]]==val& ][[All,2]]]]!=1,
          symGFPrint["internal error: uneven CC in self-consistent solution of eq. ",lhs," == ",trhs," == ",rhs];
          symGFPrint[rec];
          symGFPrint[u];
          symGFPrint[val];
          ab=1;
          (*				Abort[];*)
        ]
      ],
      u
    ];  (* the above makes sure the assumption of equaty of CC's *)
    
    
    (* CC's may still have different subs, this should be avoided; run it for now. if that's necessary we'll
    add it in the future. *)
    
    (*symGFPrint[" ~~~~~~~~~~~~rec~~~~~~~~~~~~~ "];
    symGFPrint[TableForm[rec] ];
    *)
    
    (* take it for granted that all the non-self GF's have the same iso-gf's for now. when needed, blow~~ *)
    
    u=Cases[Union[rec[[All,3]]],_OverBar];
    Scan[
      Function[g,
        poly=Select[rhs,!FreeQ[#,g]&];
        If[Head[poly]===Plus,
          poly=List@@poly;
          cd=PolynomialGCD@@poly;
          left=cd;
          cd=Plus@@(poly/cd);
          ,
          cd=Times@@Cases[poly,_OverTilde];
          left=poly/cd;
        ];
        fm2=GammaEnergySymbol[lhs,cd,1-oneminus]*left;
        ret+=grasp[1,fm2,fm2];
      ],
      u
    ];
    
    If[equaltime=!=0,
      If[Head[equaltime]===Plus,
        Scan[
          Function[eq,
            cd=Times@@Cases[eq,_OverTilde];
            left=eq/cd;
            fm2=GammaEnergySymbol[lhs,cd,1-oneminus]*left;
            ret+=grasp[1,fm2,fm2];
          ],
          List@@equaltime
        ]
        ,
        cd=Times@@Cases[equaltime,_OverTilde];
        left=equaltime/cd;
        fm2=GammaEnergySymbol[lhs,cd,1-oneminus]*left;
        ret+=grasp[1,fm2,fm2];
      ];
    ];
    tempo++;
    
    If[ab==1,symGFPrint[tempo,"  ",ab];Abort[] ];
  ];
  If[!FreeQ[ret,purepattern[fm] ],
    symGFPrint["internal error: ",fm," not solved but should have...."];
    Abort[];
  ];
  ret
]
solveself[lhs_,rhs_]:=rhs



(*Block[{},symGFPrint["Error: incomprehensible equation ",lhs," == ",rhs];Abort[];]  *)

(*
   Function: CCprofile[term_Times]
   Purpose: Count how many times each coupling constant stored in plainCC
     appears inside term; used to detect whether different branches share the
     same set of constants.
   Algorithm:
     1. Expand powers by calling listify so that repeated factors appear
        explicitly.
     2. For every known coupling constant in plainCC, count how many times its
        pure pattern shows up and collect the counts into a vector.
   Inputs: term - Times expression composed of couplings, GFs, and numbers.
   Output: List of integer counts, one per plain coupling constant.
*)
CCprofile[term_Times]:=Module[{tt=listify[term]},
  Table[Count[tt,purepattern[plainCC[[i]]]],{i,Length[plainCC]}]
]

selfconsistent[gfidx_,rhs_Plus]:=AnyTrue[rhs,GFIiT[#]==gfidx&]
selfconsistent[gfidx_,rhs_Times]:=If[GFIiT[rhs]==gfidx,True,False]



MiT[term_]:=Times@@Select[List@@term,MemberQ[{0,1,2,3},type[#]]&]


GFiT[term_OverBar]:=term
(*
   Function: GFiT[term_Times]
   Purpose: Extract the Green's function factor from a product; required when
     isolating coefficients from equations of motion.
   Algorithm:
     1. Inspect each factor, using type[#]==4 to detect OverBar objects.
     2. Return the first such factor; if no GF is present, default to 1 so the
        caller knows that the term did not carry an explicit GF.
   Inputs: term - product of scalars, GFs, and other tensors.
   Output: The OverBar object embedded in term (or 1).
*)
GFiT[term_Times]:=Module[{gf=SelectFirst[List@@term,type[#]==4&,1]},
  gf
]
(*GFiT[term_]:=Block[{},symGFPrint["Warning: unrecognizable term: ",term]; ]*)

type[expr_OverTilde]:=3 (* expr is a self-energy *)
type[expr_UnderBar]:=2 (* expr is a iso-gf *)
type[expr_OverBar]:=4 (* GF *)
(*
   Function: type[expr_]
   Purpose: Classify expr by the role it plays in the solver: coupling
     constant, isolated GF, self-energy, or ordinary GF.
   Algorithm:
     1. Return 4 for OverBar (propagators), 3 for OverTilde (self-energies),
        and 2 for UnderBar (isolated GFs) via the direct definitions above.
     2. For any other expression, check whether it matches an entry in CC; if
        so return 1 to denote a coupling constant, otherwise 0.
   Inputs: expr - expression being analysed.
   Output: Integer tag {0,1,2,3,4}.
*)
type[expr_]:=Module[{ret=0},
  If[!FreeQ[CC,purepattern[expr]],   
    ret=1; (* expr is a CC *)
  ];
  ret (* if ret==0 then expr is a passer-by *)
]


(*
   Function: CCinTerm[term_]
   Purpose: Test whether a term contains any coupling constants registered via
     SetCoupling/SetInterParam.
   Algorithm:
     1. Strip away GFs and self-energies so only scalar factors remain.
     2. Search through those factors for symbols that match either member of
        every CC pair in the global CC list.
     3. Return True if such a match exists, False otherwise.
   Inputs: term - symbolic expression (may be Plus, Times, etc.).
   Output: Boolean.
*)
CCinTerm[term_]:=Module[{tmp},
  tmp=Level[Cases[Cases[Cases[term,Except[_OverBar]],Except[_UnderBar]],Except[_OverTilde]],-1];
  AnyTrue[tmp,
    Function[var,
      AnyTrue[CC,
        Function[cc,
          MemberQ[cc[[1]],purepattern[var]]||MemberQ[cc[[2]],purepattern[var]]
        ]
      ]
    ]
  ]
]


(*
   Function: GFIiT[term_OverBar]
   Purpose: Translate a GF (OverBar) into its index inside GFnames so other
     routines can reference the matching equation of motion.
   Algorithm:
     1. Search GFnames for a pattern match against term (after stripping
        explicit subscripts).
     2. If the search fails or yields multiple hits, abort because the solver
        requires unique identifiers.
   Inputs: term - OverBar expression.
   Output: Integer index into GFnames.
*)
GFIiT[term_OverBar]:=Module[{j=0},
  j=Position[GFnames,purepattern[term] ];
  If[Length[j]>0,
    j=j[[1,1]];
    ,
    symGFPrint["Error: what is this then??? ",term,"  ",term ];
    Abort[];
  ];
  j
]
(*
   Function: GFIiT[term_Times]
   Purpose: Locate the GF index inside a product that may contain many other
     factors; used when parsing terms generated by ExpandCouplingChains/grasp.
   Algorithm:
     1. Look for an OverBar inside term; if more than one exists, abort
        because such terms are not expected at this stage.
     2. When a single OverBar is found, map it to its index using GFnames; if
        no GF is present return 0 to signal "none".
   Inputs: term - product expression.
   Output: GF index or 0.
*)
GFIiT[term_Times]:=Module[{pos,j=0},
  pos=Position[term,_OverBar];
  If[Length[pos]>1,
    symGFPrint["Error: Multiple GF's found in term ",term];
    Abort[];
  ];
  If[Length[pos]==1,
    j=Position[GFnames,purepattern[ Extract[term,pos[[1]] ]   ]   ];
    If[Length[j]>0,
      j=j[[1,1]];
      ,
      symGFPrint["Error: what is this?? ",term,"  ",pos[[1]]   ];
      Abort[];
    ];
  ];
  j   (* if pos returned no result, then j=0 *)
]
GFIiT[term_]:=0   (* meaning there is not a gf *)

(* { {ed,{t1d,t2d,....t1dstar...} }, {e[k],{tl[k],....} , ... } *)



(*
   Function: grasp[lhs_,recent_,term_Times]
   Purpose: Convert a raw term from an equation of motion into a canonical
     expression where coupling constants and isolated Green's functions are
     bundled into self-energy objects when possible.
   Algorithm:
     1. Use pairedCC to see whether the term contains a conjugate pair of
        coupling constants; if so, attempt to identify the isolated GF core
        carried by recent and map the pair to a SelfEnergySymbol.
     2. For single-level problems (no subscripts) the function looks up the
        preserved eigen-operators (SC) to determine which isolated GF should
        act as the core; for multi-level cases it ensures that none of the
        contraction parameters clash with sums currently in scope.
     3. Multiply the remaining scalar factors back, recursing until no more
        pairings are possible and returning the product of self-energy symbols
        and leftover scalars.
   Inputs: lhs - GF on the left-hand side; recent - list of isolated GFs that
     were present when the term was generated; term - expression to normalize.
   Output: Canonical term ready for further processing.
*)
grasp[lhs_,recent_,term_Times]:=Module[{cc,params,poscore,dupterm=term,ret=term,eige,tmpmulti=1},
  
  
  
  
  
  
  cc=pairedCC[term];
  While[cc=!=0,
    (* there are paried CC, and therefore a self-energy *)
    
    
    
    If[Depth[cc[[1]]]==1, 
      (* when the CC are non-subed, e.g., when dealing with single level problem, we must take extra care of the grasping. *)
      
      (* only one iso-gf is allowed...., if there **should** be any other SE's, they must be numbers so that we can treat them
      as another group of passers-by *)
      eige=Select[SC,!FreeQ[#,cc[[1]] ] & ];
      If[Length[eige]==0,symGFPrint["Error: Single Level eigen energies must be reset by SetSingleCorr. "];Abort[]; ];
      eige=eige[[All,1]];
      poscore=Table[Select[IGFs,!FreeQ[#[[1]],purepattern[eige[[i]] ] ] & ] [[All,2]],  {i,Length[eige] } ] //Flatten;
      poscore=Select[recent,MemberQ[poscore,purepattern[#] ] & ];
      If[Length[poscore]>1,poscore=poscore[[1]]; symGFPrint["Warning: multiple possible cores found."];Abort[]; ];
      If[Length[poscore]==0,
        symGFPrint["Warning: Single level self energy found no core. lhs=",lhs," term=",dupterm," recent=",recent];
        symGFPrint["cc=",cc];
        ret=dupterm;
        ret=dupterm/cc[[1]]/cc[[2]]*SelfEnergySymbol[cc[[1]],1,cc[[2]],{} ];
        ,
        ret=dupterm/poscore/cc[[1]]/cc[[2]]*SelfEnergySymbol[cc[[1]],poscore,cc[[2]],{} ];
      ];
      ,
      
      If[!(Depth[cc[[1]]]==2 && Depth[cc[[2]]]==2),
        symGFPrint["Error: subs ",cc[[1]] ];
        Abort[];
      ];
      params=Intersection[Complement[Union[subs[cc[[1]]],subs[cc[[2]]]],subs[GFiT[dupterm] ]  ],   sumlist];
      (* i can just add one that the param should not be contained in G *)
      (*symGFPrint[params,"  ",cc];*)
      poscore=Select[dupterm/cc[[1]]/cc[[2]], paracont[params,#] & ];  
      (*				symGFPrint[poscore];*)
      
      If[(!FreeQ[poscore,_OverBar]) || poscore===1 ,
        (* poscore should not contain GF's or subs that is also contained in lhs *)
        (*					symGFPrint[lhs, "  ren zai le."];*)
        ret=dupterm/cc[[1]]/cc[[2]];
        tmpmulti*=cc[[1]] cc[[2]];
        ,
        ret=dupterm/poscore/cc[[1]]/cc[[2]]*SelfEnergySymbol[cc[[1]],poscore,cc[[2]] , params ];
      ];
      cc=pairedCC[dupterm]
    ];
    dupterm=ret;		
  ];
  ret*tmpmulti
]
grasp[lhs_,recent_,term_Plus]:=(symGFPrint["internal error: grasping a multiple of terms: ",term]; Abort[] )
grasp[lhs_,recent_,term_]:=term  (* not know i need this one as well, sometimes we'll grasp a constant like "0"  *)

paracont[params_List,expr_]:=AnyTrue[params,!FreeQ[expr,#]&]

nonzero[l_List]:=If[l=!={},True,False]

(*
   Function: pairedCC[termo_]
   Purpose: Scan a term for two coupling constants that form a conjugate pair
     (one from CC[[i,1]], the other from CC[[i,2]]) so that the term can be
     interpreted as a self-energy contribution.
   Algorithm:
     1. Inspect every atom of termo and collect those that match any coupling
        constant stored in CC, recording both the symbol and the index of the
        CC entry it belongs to.
     2. Look for two collected items that originate from the same CC entry
        while occupying complementary positions (1 vs 2).
     3. Return the pair of coupling constants if such a match exists,
        otherwise return 0 to signal that the term does not contain a
        conjugate pair.
   Inputs: termo - expression to scan.
   Output: {c1,c2} when a pair is found, or 0.
*)
pairedCC[termo_]:=Module[{term=Level[termo,-1],rec,pos,pair=0},
  rec=DeleteCases[
    Table[
      If[type[val]==1,
        pos=Position[CC,purepattern[val]];
        If[pos==={},symGFPrint["Error: coupling constant ",val," not found."];Abort[]];
        {val,pos[[1]]},
        Nothing
      ],
      {val,term}
    ],
    Nothing
  ];
  pair=SelectFirst[
    Subsets[Range[Length[rec]],{2}],
    With[{i=#[[1]],j=#[[2]]},
      rec[[i,2,1]]==rec[[j,2,1]] &&
      ((rec[[i,2,2]]==1 && rec[[j,2,2]]==2) || (rec[[i,2,2]]==2 && rec[[j,2,2]]==1))
    ]&,
    {}
  ];
  If[pair=== {},
    0,
    {rec[[pair[[1]],1]],rec[[pair[[2]],1]]}
  ]
]		



SetInterParam[a_List]:=(interparam=a)
SetInterParam[a__]:=SetInterParam[{a}]
(*
   Function: DependsOnInteractionParam[coef_]
   Purpose: Detect whether coef depends on any interaction parameter recorded
     via SetInterParam; determines if a branch of the graph needs to be
     expanded further.
   Algorithm:
     1. Scan interparam and test whether coef contains one of those symbols.
     2. Return True as soon as a match is found.
   Inputs: coef - scalar prefactor associated with a graph edge.
   Output: Boolean.
*)
DependsOnInteractionParam[coef_]:=Module[{ret=False},
  Scan[
    If[!FreeQ[coef,#],ret=True;Return[]]&,
    interparam
  ];
  ret
]
(*
   Function: GammaEnergySymbol[lhs_,numeritor_,denominator_]
   Purpose: Produce (and cache) a symbolic representation of the ratio
     numeritor/denominator that appears inside conditioned-iteration graphs.
   Algorithm:
     1. Check whether the pair {numeritor,denominator} is already stored in
        GammaEnergy; if so, reuse the existing OverTilde symbol.
     2. Otherwise collect the subscripts present in lhs, numeritor, and
        denominator, ensure that the ratio introduces no new indices, and
        register a new unique \[CapitalGamma] symbol parameterized by the
        leftover subscripts.
   Inputs: lhs - equation head used to validate subscripts; numeritor,
     denominator - scalar expressions.
   Output: Either a cached OverTilde symbol or numeritor when denominator==1.
*)
GammaEnergySymbol[lhs_,numeritor_,denominator_]:=Module[{sl,sr,ret=0},
  If[MemberQ[GammaEnergy[[All,1;;2]],{numeritor,denominator} ],
    ret=GammaEnergy[[Position[GammaEnergy[[All,1;;2]],purepattern /@ {numeritor,denominator} ] [[1,1]],3]]
  ];
  (*un'comment this if not dealing with original 'devrim' setup	*)
  (*If[MemberQ[GammaEnergy[[All,1;;2]],purepattern /@ {-numeritor,denominator} ],
  ret=-GammaEnergy[[Position[GammaEnergy[[All,1;;2]],purepattern /@ {numeritor,denominator} ] [[1,1]],3]]
];*)
  If[ret===0,
    If[denominator=!=1,
      sl=subs[lhs];
      sr=Union[subs[numeritor] ,subs[denominator] ];
      AppendTo[GammaEnergy,{numeritor,denominator,OverTilde[symGFUnique["\[CapitalGamma]"] @@ 
            Sequence[Complement[sl,sr]]  ] }  ];
      If[nonzero[Complement[sr,sl] ],
        symGFPrint["internal error: extra subscripts in equation: ",lhs,"  ~~  ",numeritor/denominator];
        Abort[];
      ];
      GammaEnergy[[-1,3]]
      ,
      numeritor
    ]
    ,
    ret
  ]
]
(*
   Function: makereplist[l1_List,l2_List]
   Purpose: Build a substitution list that maps each element of l1 to the
     corresponding element of l2; used when instantiating stored patterns.
   Algorithm:
     1. Validate that l1 and l2 have the same length.
     2. Create Rule objects l1[[i]] -> l2[[i]].
   Inputs: l1, l2 - lists of symbols.
   Output: Replacement list.
*)
makereplist[l1_List,l2_List]:=Module[{i},
  If[Length[l1]!=Length[l2],
    symGFPrint["Error: makereplist encountered lists with unequal length."];
    Abort[];
  ];
  Table[l1[[i]]->l2[[i]],{i,Length[l1]}]
]
(*
   Function: SelfEnergySymbol[c1_,core_,c2_,stealth_]
   Purpose: Return the symbolic self-energy associated with the pair of
     couplings c1 and c2 linked through the core Green's function; if such a
     symbol does not yet exist it is created on the fly.
   Algorithm:
     1. Search the SelfEnergy table for an entry whose left-hand pattern
        matches c1 * core * c2; if one exists, adapt its subscripts using
        makereplist so the stored symbol can be reused.
     2. When no record exists, build the subscript list from the explicit
        indices of c1 core c2 minus stealth indices, append the stealth
        placeholders as OverVector objects, and create a new \[CapitalSigma]
        symbol via symGFUnique.
   Inputs: c1, core, c2 - factors forming the self-energy; stealth - list of
     summed indices that should remain hidden.
   Output: OverTilde symbol representing the self-energy.
*)
SelfEnergySymbol[c1_,core_,c2_,stealth_]:=Module[{ret=0,sub,expr},
  (* this is a special version of treating U=0, extra vars: ss,isoincore *)
  
  (* if there's def for c1 core c2 typed self energy, return its symbol,
  if not, create that SE and return the new symbol *)
  
  
  (* must add params *)
  
  
  expr=c1 core c2;
  If[MatchQ[expr,_OverTilde],
    Return[expr]
  ];
  
  Do[
    If[MatchQ[SelfEnergy[[i,1]],purepattern[expr] ],
      ret=SelfEnergy[[i,2]]/.makereplist[ subs[SelfEnergy[[i,1]] ] ,  subs[expr] ] ;  
      (* whether this SE has a sub or not does not matter here. if it has a stealh-sub, then it should word 
      as well. *)
      Break[];
    ]
    ,{i,Length[SelfEnergy]}];
  If[ret==0,
    (*		subcc=subs[c1 core c2];
    sub=Complement[subs[core],subcc ]; 
    *)
    sub=Complement[subs[expr], stealth];
    sub=sub~Join~Table[OverVector[stealth[[i]]],{i,Length[stealth]}];
    AppendTo[SelfEnergy,{expr,OverTilde[symGFUnique["\[CapitalSigma]"] [ Sequence@@sub    ] ]  } ];
    ret=SelfEnergy[[-1,2]];
  ];
  ret
]
gas[]:=ResolveGraphSolutions[]
(*
   Function: ResolveGraphSolutions[]
   Purpose: Traverse the coupling graph built from solgf and express every
     Green's function in terms of symbolic placeholders, making the chain of
     substitutions explicit for debugging.
   Algorithm:
     1. Assign a fresh symbol to each GF and keep track of which nodes have
        already been resolved; start with the first one marked as unknown.
     2. While unresolved nodes remain, pull the next index, expand its outgoing
        edges recorded in graph, and either accumulate pure coefficients or
        multiply unresolved children by their placeholder symbols.
     3. Whenever the traversal encounters a solvable branch (DependsOnInteractionParam tests
        whether the coefficient contains interaction parameters), create
        SelfEnergySymbol entries and continue until all nodes are expressed.
   Inputs: None; consumes global graph/solgf state.
   Output: Prints the symbolic solution map and updates SelfEnergy.
*)
ResolveGraphSolutions[]:=Module[{sym,symbol,out,left,coef,coef2,dest,dest2,currsol,unknown={1},done={},solgraph={},idx,i,j}, 
  (* see if we are going to make "graph" an input *)
  sym=Table[symGFUnique["X"],{Length[gfs]}];
  left=Complement[unknown,done];
  symGFPrint["left: ",left];
  While[left=!={},
    idx=left[[1]];
    symGFPrint["************************ ",idx];
    currsol=0;
    
    Do[
      coef=graph[[idx,2,out,2]];
      symGFPrint["coef: ",coef];
      dest=graph[[idx,2,out,1]];
      If[dest==0,
        currsol+=coef;
        ,
        symGFPrint["dest: ",dest];
        symbol=sym[[dest]];
        symGFPrint["symbol: ",symbol];
        If[DependsOnInteractionParam[coef],
          symGFPrint["DependsOnInteractionParam"];
          currsol+=coef*symbol;
          symGFPrint[currsol];
          unknown=Union[unknown,{dest}];
          symGFPrint["unk: ",unknown];
          ,
          symGFPrint["pingbian"];
          (* pingbian! need self energies *)
          
          Do[
            dest2=graph[[dest,2,i,1]];
            symGFPrint["dest2: ",dest2];
            If[dest2==0,symGFPrint["this shouldn't happen...."];Abort[];];
            coef2=graph[[dest,2,i,2]];
            symGFPrint["coef2: ",coef2];
            If[graph[[dest2,1]]=!=1,
              symGFPrint[dest2," is not trunc."];
              currsol+=SelfEnergySymbol[coef,graph[[dest,1]],coef2]*
              sym[[ dest2 ]];
              symGFPrint[currsol];
              unknown=Union[unknown,{dest2}];
              symGFPrint["unk: ",unknown];
              ,
              symGFPrint[dest2," is trunc."];
              Do[
                currsol+=SelfEnergySymbol[coef,graph[[dest,1]],coef2*graph[[dest2,2,j,2]] ]*
                sym[[ graph[[dest2,2,j,1]] ]];
                symGFPrint[currsol];
                unknown=Union[unknown,{graph[[dest2,2,j,1]]}];
                symGFPrint["unk: ",unknown];
                ,{j,Length[graph[[dest2,2]]]}];
              ,{i,Length[graph[[dest,2]]]}];
          ];
        ];
        ,{out,Length[graph[[idx,2]]]}];
    ];
    AppendTo[solgraph,sym[[idx]]/graph[[idx,1]]==currsol]; (* if we meet a divide by 0 error here then we are screwed *)
    done=Union[done,{idx}];
    left=Complement[unknown,done];
    symGFPrint["solgraph: ",solgraph];
  ];
  symGFPrint["SE: ",SelfEnergy];
]

ShowCouplingGraph[]:=TableForm[Table[{i,graph[[i]]},{i,Length[graph]}]]

(*
   Function: BuildCouplingGraph[]
   Purpose: Build the directed graph that records which Green's functions
     couple to which others together with the accompanying coefficients.
   Algorithm:
     1. Iterate over every solved GF stored in solgf; isolate the leading
        UnderBar term (the prefactor on the left-hand side) and divide it out
        so each remaining term represents an outgoing edge.
     2. For every term, locate the embedded GF (if any) and record both its
        index and the simplified coefficient; when no GF is present the edge
        points to 0 to denote an inhomogeneous contribution.
     3. Store the result inside the global graph variable as {prefactor,
        {{destIndex, coef}, ...}}.
   Inputs: None; operates on solgf/GFnames.
   Output: Populates graph and returns it.
*)
BuildCouplingGraph[]:=Module[{idx,pos,i,j,expr,gf,coef,outgo,val},  (* by default start with 1st gf *)
  (* build the graph in the "graph-aided solution" by means of solgf data *)
  (* i doubt its necessity, but in this way one can think more easily *)
  graph={};
  
  Do[
    If[solgf[[i,3]]=!=0,
      pos=Position[solgf[[i,3]],_UnderBar];
      If[Length[pos]>0,
        pos=pos[[1]];
        val=Extract[solgf[[i,3]],pos];
        expr=ExpandAll[Simplify[solgf[[i,3]]/val]];
        ,
        val=1;
        expr=solgf[[i,3]];
      ];
      outgo={};
      If[Head[expr]=== Plus,
        Do[
          pos=Position[expr[[j]],_OverBar];
          If[Length[pos]>0,
            pos=pos[[1]];
            If[pos=!={},
              gf=Extract[expr[[j]],pos];
              ,
              gf=expr[[j]];
            ];
            idx=Position[GFnames,purepattern[gf]];
            coef=Simplify[expr[[j]]/gf];
            ,
            gf=1;
            idx={{0}};
            coef=expr[[j]];
          ];
          AppendTo[outgo,{idx[[1,1]],coef}]
          ,{j,Length[expr]}]
        ,
        pos=Position[expr,_OverBar];
        If[Length[pos]>0,
          pos=pos[[1]];
          gf=Extract[expr,pos];
          idx=Position[GFnames,purepattern[gf]];
          coef=Simplify[expr/gf];
          ,
          gf=1;
          idx={{0}};
          coef=expr;
        ];
        AppendTo[outgo,{idx[[1,1]],coef}];
      ];
      AppendTo[graph,{val,outgo}]
      ,
      AppendTo[graph,{0,{}}]
    ];
    ,{i,Length[gfs]}];
  graph
]


(*
   Function: del0[]
   Purpose: Remove temporary delta-function placeholders from every saved
     solution so subsequent manipulations work with the simplified forms.
   Algorithm:
     1. Collect the indices of all equations whose solution vanished.
     2. For each remaining equation, call IterateTOBranch with that list so any
        references to the vanished ones are replaced by zero.
     3. Refresh eom so it contains the cleaned expressions.
   Inputs: None.
   Output: Updated solgf and eom.
*)
del0[]:=Module[{i,tmp={}},
  Do[
    If[solgf[[i,3]]==0,AppendTo[tmp,i]],
    {i,Length[gfs]}];
  Do[
    solgf[[i,3]]=IterateTOBranch[solgf[[i,3]],tmp],
    {i,Length[gfs]}];
  eom=solgf[[All,3]];
]
cut0[expr_Plus]:=Sum[cut0[expr[[i]]],{i,Length[expr]}]
cut0[expr_Times]:=Product[cut0[expr[[i]]],{i,Length[expr]}]
cut0[expr_OverBar]:=If[IterateTimeOrderedGF[expr,0]==0,0,expr,expr]
cut0[expr_]:=expr


toa[gf_OverBar]:=OverBar[SuperPlus[gf[[1]]]]
toa[gf_]:=SuperPlus[gf]
tor[gf_OverBar]:=OverBar[SuperMinus[gf[[1]]]]
tor[gf_]:=SuperMinus[gf]
tol[gf_OverBar]:=OverBar[SubMinus[gf[[1]]]]
tol[gf_]:=SubMinus[gf]
tog[gf_OverBar]:=OverBar[SubPlus[gf[[1]]]]
tog[gf_]:=SubPlus[gf]

SetTrunc[a_List]:=( trunclist=a; )
SetTrunc[a__]:=SetTrunc[{a}]

(*
   Function: SetExact[idx_Integer,max_Integer:6]
   Purpose: Helper to inspect the connection graph around a candidate exact
     Green's function; currently prints the stored connection list so the user
     can decide which entries to protect.
   Algorithm:
     1. Dump connectionlist and a formatted table showing each entry.
     2. No automatic marking is performed yet; this stub only exposes the data
        needed for manual inspection.
   Inputs: idx - GF index; max - unused legacy parameter.
   Output: Printed diagnostic table.
*)
SetExact[idx_Integer,max_Integer:6]:=Module[{i=1,orig,curr,rhs,tok=acGFnames[[idx]],zhibiao}, 
  symGFPrint[connectionlist];
  TableForm[Table[Flatten[{i,connectionlist[[i]]}],{i,Length[connectionlist]}]]
]
(*
   Function: SetExact[expr_]
   Purpose: Resolve a pattern expr to its index in acGFnames and forward the
     request to SetExact[idx].
   Algorithm:
     1. Find all positions where acGFnames matches expr.
     2. If a single match exists, call SetExact with that index; otherwise
        print a warning and return expr unchanged.
   Inputs: expr - pattern identifying the GF to preserve.
   Output: None; side effect is printing diagnostics or recursing into SetExact.
*)
SetExact[expr_]:=Module[{pos},
  pos=Position[acGFnames,expr]//Flatten; (* the expr is assumed to be pattern *)
  If[Length[pos]==1,
    SetExact[pos[[1]]]
    ,
    symGFPrint["destined GF not found"];
    expr
  ]
]
ApplyExact[expr_List]:=( (* here we assume output format of SetExact *)
  acGFsol[[expr[[1]]]]=expr[[2]];
)
acAdvanced[expr_Plus,dt_Integer]:=Sum[acAdvanced[expr[[i]],dt],{i,Length[expr]}]
(*
   Function: acAdvanced[expr_,dt_]
   Purpose: Convert a symbolic GF expression into its advanced component by
     wrapping every correlation function with SuperPlus.
   Algorithm:
     1. Count how many OverBar objects appear; record their positions.
     2. Replace each OverBar[...] by toa[...] (which applies Sub/SuperPlus)
        while leaving other factors untouched.
   Inputs: expr - GF expression; dt - unused legacy flag.
   Output: Expression for the advanced component.
*)
acAdvanced[expr_,dt_]:=Module[{c,pos,tmp,h},
  h=Head[expr];
  tmp=List@@expr;
  c=Count[expr,_OverBar];
  pos=Position[expr,_OverBar,1]//Flatten;
  Switch[c,
    1,
    tmp[[pos[[1]] ]] = toa[tmp[[pos[[1]] ]] ],
    2,
    tmp[[pos[[1]] ]] = toa[tmp[[pos[[1]] ]] ];
    tmp[[pos[[2]] ]] = toa[tmp[[pos[[2]] ]] ]
  ];
  h@@tmp
]
acRetarded[expr_Plus,dt_Integer]:=Sum[acRetarded[expr[[i]],dt],{i,Length[expr]}]
(*
   Function: acRetarded[expr_,dt_]
   Purpose: Build the retarded component by turning every GF into its SuperMinus
     version.
   Algorithm: Same as acAdvanced but replacing OverBar[...] with tor[...].
*)
acRetarded[expr_,dt_]:=Module[{c,pos,tmp,h},
  h=Head[expr];
  tmp=List@@expr;
  c=Count[expr,_OverBar];
  pos=Position[expr,_OverBar,1]//Flatten;
  Switch[c,
    1,
    tmp[[pos[[1]] ]] = tor[tmp[[pos[[1]] ]] ],
    2,
    tmp[[pos[[1]] ]] = tor[tmp[[pos[[1]] ]] ];
    tmp[[pos[[2]] ]] = tor[tmp[[pos[[2]] ]] ]
  ];
  h@@tmp
]
acLesser[expr_Plus,dt_Integer]:=Sum[acLesser[expr[[i]],dt],{i,Length[expr]}]
(*
   Function: acLesser[expr_,dt_Integer]
   Purpose: Generate the lesser component by switching each GF to SubPlus or
     SubMinus depending on dt.
   Algorithm:
     1. For dt==1 use tol (SubMinus) whereas dt==2 uses tog (SubPlus).
     2. Apply the substitution to every OverBar occurrence in expr.
*)
acLesser[expr_,dt_Integer]:=Module[{c,pos,tmp,t2=0,h},
  h=Head[expr];
  tmp=List@@expr;
  c=Count[expr,_OverBar];
  pos=Position[expr,_OverBar,1]//Flatten;
  Switch[c,
    1,	(* just one gf *)
    tmp[[pos[[1]] ]]=tol[tmp[[pos[[1]] ]]  ],
    2,
    t2=tmp;
    If[!ClassifyGFType[tmp[[pos[[1]] ]] ]==dt, (* qian *)
      c=pos[[1]];
      pos[[1]]=pos[[2]];
      pos[[2]]=c
    ];
    tmp[[pos[[1]] ]]=tor[tmp[[pos[[1]] ]] ];
    t2[[pos[[1]]  ]]=tol[t2[[pos[[1]] ]] ];
    tmp[[pos[[2]] ]]=tol[tmp[[pos[[2]] ]] ];
    t2[[pos[[2]]  ]]=toa[t2[[pos[[2]] ]] ]
  ];
  h@@tmp+h@@t2
]
acGreater[expr_Plus,dt_Integer]:=Sum[acGreater[expr[[i]],dt],{i,Length[expr]}]
(*
   Function: acGreater[expr_,dt_Integer]
   Purpose: Generate the greater component; mirrors acLesser but swaps the
     SubPlus/SubMinus choice.
*)
acGreater[expr_,dt_Integer]:=Module[{c,pos,tmp=expr,t2=0,h},
  h=Head[expr];
  tmp=List@@expr;
  c=Count[expr,_OverBar];
  pos=Position[expr,_OverBar,1]//Flatten;
  Switch[c,
    1,	(* just one gf *)
    tmp[[pos[[1]] ]]=tog[tmp[[pos[[1]] ]]  ],
    2,
    t2=tmp;
    If[!ClassifyGFType[tmp[[pos[[1]] ]] ]==dt, (* qian *)
      c=pos[[1]];
      pos[[1]]=pos[[2]];
      pos[[2]]=c
    ];
    tmp[[pos[[1]] ]]=tor[tmp[[pos[[1]] ]] ];
    t2[[pos[[1]]  ]]=tog[t2[[pos[[1]] ]] ];
    tmp[[pos[[2]] ]]=tog[tmp[[pos[[2]] ]] ];
    t2[[pos[[2]]  ]]=toa[t2[[pos[[2]] ]] ]
  ];
  h@@tmp+h@@t2
]

(*
   Function: ClassifyGFType[expr_]
   Purpose: Classify the type of Green's function appearing in expr so the
     iterative solver knows whether it is a generic GF, an isolated GF, or a
     self-energy.
   Algorithm:
     1. Start with 3 (plain coefficient); return 2 when expr is an OverBar
        corresponding to an ordinary GF.
     2. Return 1 when the OverBar head matches either an IGF entry or a
        self-energy symbol stored in SelfEnergy, signalling that the GF sits
        before/after the interaction region.
   Inputs: expr - expression to classify.
   Output: Integer tag {1,2,3}.
*)
ClassifyGFType[expr_]:=Module[{ret=3},  (* xi shu *)
  If[Head[expr]==OverBar,ret=2]; (* normal GF *)
  If[Head[expr]==OverBar && !FreeQ[IGFs,Head[expr[[1]]]], ret=1];  (* qian/hou GF *)
  If[Head[expr]==OverBar && !FreeQ[SelfEnergy,Head[expr[[1]]]], ret=1];  (* qian/hou GF *)
  ret
]

(*SetDelta[a_]:=Block[{}, deltasymbol=a;]*)

CanonicalGFSymbol[expr_Plus]:=Sum[CanonicalGFSymbol[expr[[i]]],{i,Length[expr]}]
CanonicalGFSymbol[expr_Times]:=Product[CanonicalGFSymbol[expr[[i]]],{i,Length[expr]}]
(*
   Function: CanonicalGFSymbol[expr_NonCommutativeMultiply]
   Purpose: Rewrite a pair of creation/annihilation operators into the stored
     canonical GF symbol so later passes can identify it easily.
   Algorithm:
     1. Only handle two-operator strings; determine whether the first entry is
        a creation or annihilation operator.
     2. Look up the corresponding entry in gfs; if the order is swapped,
        insert the appropriate minus sign and flip the order before replacing
        the pair by tol[GFnames[[pos]]].
   Inputs: expr - non-commutative product of two operators.
   Output: Canonical GF symbol (possibly with a minus sign).
*)
CanonicalGFSymbol[expr_NonCommutativeMultiply]:=Module[{ret=expr,pos},
  If[Length[expr]==2,
    If[creation[expr[[1]]] && annihilation[expr[[2]]],
      pos=Position[gfs,{purepattern[expr[[2]]],purepattern[expr[[1]]]}][[1,1]];
      ret=-NonCommutativeMultiply[expr[[2]],expr[[1]]];
      (* pay attention to the minus sign here, inevitable *)
      ret=-tol[GFnames[[pos]]] /. corr[NonCommutativeMultiply[gfs[[pos,1]],gfs[[pos,2]]],NonCommutativeMultiply[expr[[2]],expr[[1]]]] 
    ];
    If[creation[expr[[2]]] && annihilation[expr[[1]]],
      pos=Position[gfs,{purepattern[expr[[1]]],purepattern[expr[[2]]]}][[1,1]];
      ret=tol[GFnames[[pos]]] /. corr[NonCommutativeMultiply[gfs[[pos,1]],gfs[[pos,2]]],NonCommutativeMultiply[expr[[1]],expr[[2]]]] 
    ]
    ,
    symGFPrint["Error: only two-operator products can be converted to GF symbols."]
  ];
  ret
]
CanonicalGFSymbol[expr_]:=expr

sneak[]:={gfs,solgf,GFnames,acGFnames,acGFsol,trunclist,IGFs,SelfEnergy,GammaEnergy}

stealthsub[expr_Plus]:=Union[Flatten[Table[stealthsub[ expr[[i]] ],{i,Length[expr] } ] ] ]
stealthsub[expr_Times]:=Union[Flatten[Table[stealthsub[ expr[[i]] ],{i,Length[expr] } ] ] ]
stealthsub[expr_Power]:=stealthsub[expr[[1]] ]
stealthsub[expr_OverTilde]:=Cases[expr[[1]],_OverVector] //. OverVector[unigue_]:>unigue
stealthsub[expr_]:={}  (* has to be self energy for now *)

subs[expr_NonCommutativeMultiply]:=Union[Flatten[Table[subs[expr[[i]]], {i,Length[expr]}]]] (* union could be put off *)
subs[expr_OverHat]:=subs[expr[[1]] ]  (*If[Depth[expr]==3,Level[expr,{-1}],{}]*)
subs[expr_OverBar]:=subs[expr[[1]] ]
subs[expr_UnderBar]:=subs[expr[[1]] ]
subs[expr_OverTilde]:=subs[expr[[1]] ]
subs[expr_Times]:=Flatten[Table[subs[expr[[i]]],{i,Length[expr]} ]]   (* it used to be union'ed *)
subs[expr_Plus]:=Union[Flatten[Table[subs[expr[[i]]],{i,Length[expr]}]]]
subs[expr_Power]:=subs[expr[[1]] ]
(* take off stealth-subs *)

subs[expr_]:=Module[{ret},
  ret=Select[If[Depth[expr]>=2,Level[expr,{1}],{}],Head[#]=!=OverVector&];
  ret=ret/.x_?AtomQ:>x;
  ret//Flatten
]

(* this union'ed version of subs may not be used in multiple dots, in which case orders must be taken. *)

(* solve. since the total number of GF's is limited, every single GF can have a closed-form solution. go
from back to front, in this order we can guanrantee no "bubbles" in iteration *)

ResetClosedSolutions[]:=(closedsol=Table[0,{Length[gfs]}])

exceed[ct_List,idx_Integer]:=AnyTrue[ct,#>idx&]
repexceed[sol_,ct_List,idx_Integer]:=Fold[
  Function[acc,i,
    If[i>idx,
      acc/.GFnames[[i]]->solgf[[i,3]],
      acc
    ]
  ],
  sol,
  ct
]
(*
   Function: SolveFinalPass[idx_Integer]
   Purpose: Final pass of the conditioned-iteration solver. It eliminates any
     reference to higher-index Green's functions inside equation idx and then
     solves the resulting single-variable equation explicitly.
   Algorithm:
     1. Work only on non-subscripted GFnames; fetch the stored solution and
        repeatedly call IterateTOBranch to replace occurrences of higher-index
        GFs (tracked via exceed/thre) until none remain.
     2. Solve for GFnames[[idx]] using Mathematica's Solve when the variable
        still appears on both sides, then simplify the expression and strip
        any self-energy placeholders via selfenergyrep.
     3. Abort if the final expression still references itself or a later GF,
        otherwise store the simplified solution back in solgf.
   Inputs: idx - GF index.
   Output: {idx, solved expression}.
*)
SolveFinalPass[idx_Integer]:=Module[{sol,s2,ct},
  If[nonSubed[GFnames[[idx]]],
    sol=solgf[[idx,3]];
    symGFPrint[idx, " ge shu: ",NRcontainedGF[sol] ];
    ct=containedGF[sol];
    While[exceed[ct,idx],   
      symGFPrint[idx," die le :",ct," aim: ",thre[ct,idx] ];
      sol=IterateTOBranch[sol,thre[ct,idx]];
      If[idx>8,
        sol= Simplify[sol, TimeConstraint->10, ComplexityFunction->NRcontainedGF ]//.selfenergyrep;
      ];
      symGFPrint[idx," ge shu: ",NRcontainedGF[sol] ];
      ct=containedGF[sol];
    ];
    symGFPrint[idx, " eq. ",ct];
    If[!FreeQ[sol,GFnames[[idx]] ],
      sol= (Solve[GFnames[[idx]]==sol,GFnames[[idx]] ] [[1,1,2]] );  
    ]; 
    symGFPrint[idx," solved"];
    If[idx>6,
      sol= Simplify[sol, TimeConstraint->10, ComplexityFunction->NRcontainedGF ]//.selfenergyrep;
    ];
    symGFPrint[idx," simplified"];
    ct=containedGF[sol];
    symGFPrint["finally ", idx," contains ",ct  ];
    If[MemberQ[ct ,idx] || exceed[ct,idx],
      symGFPrint["Sorry: solution of GF #",idx," contained itself or later GF's. SolveFinalPass[",idx,"] failed."];
      Abort[]
      ,
      solgf[[idx,3]]=sol
    ];
    symGFPrint[idx," zui zhong ge shu: ",NRcontainedGF[sol] ];
    {idx,solgf[[idx,3]]}
  ]
]
thre[ct_List,idx_Integer]:=Select[ct,#>idx &]
(*
   Function: SolveFirstPass[idx_Integer]
   Purpose: First pass of the conditioned-iteration solver. It aggressively
     substitutes Green's functions with index greater than idx so the equation
     gradually depends on fewer unknowns.
   Algorithm:
     1. Extract the current solution and count how many GFs it contains; use
        thre to identify those with indices larger than idx.
     2. Apply IterateTOBranch to substitute those terms, simplify the
        intermediate expression, and repeat until only GFs with indices less than equal to idx
        remain.
     3. Solve for GFnames[[idx]] if it still appears, simplify the result, and
        store it back into solgf.
   Inputs: idx - GF index.
   Output: {idx, simplified expression}.
*)
SolveFirstPass[idx_Integer]:=Module[{sol,ct,cta},
  sol=solgf[[idx,3]];
  ct=subbed[containedGF[sol]];
  symGFPrint[idx, "   ",ct];
  While[Length[thre[ct,idx] ]>0,
    sol=IterateTOBranch[sol,thre[ct,idx]]; (* here we change it into larger than idx'ed ct *)
    sol=Simplify[sol,ComplexityFunction->NRcontainedGF,TimeConstraint->10];
    cta=containedGF[sol];
    ct=subbed[cta];
    symGFPrint[idx, "  die le  ",cta, " ge shu: ",NRcontainedGF[sol]," zhong shu: ",Length[cta] ];
  ];
  symGFPrint[idx," eq. ",containedGF[sol] ];
  If[!FreeQ[sol,GFnames[[idx]] ],
    sol= (Solve[GFnames[[idx]]==sol,GFnames[[idx]] ] [[1,1,2]] );  
  ]; 
  symGFPrint[idx," solved"];
  sol= Simplify[sol, TimeConstraint->10, ComplexityFunction->NRcontainedGF ];
  symGFPrint[idx,"  Simplified"];
  symGFPrint["finally ", idx," contains ",containedGF[sol]  ];
  If[MemberQ[containedGF[sol ] ,idx],
    symGFPrint["Sorry: solution of GF #",idx," contained itself. SolveFirstPass[",idx,"] failed."];
    Abort[]
    ,
    solgf[[idx,3]]=sol
  ];
  symGFPrint["ge shu: ",NRcontainedGF[sol] ];
  {idx,solgf[[idx,3]]}
]

(*
   Function: BuildCategoryGrid[]
   Purpose: Classify Green's functions according to how many times each
     truncation pattern appears in their operator strings. The resulting
     category table guides RunConditionedSweep/RunInlineConditionedSweep.
   Algorithm:
     1. Initialize category as a ladder of empty lists indexed by truncation
        rule and occurrence count.
     2. For every GF in gfs (up to cap), count how often each truncation
        pattern occurs in its operator pair and place its index in the
        corresponding bucket.
     3. Propagate membership upward so that higher buckets also contain the
        indices of all more restrictive buckets.
   Inputs: None; uses global trunclist and gfs.
   Output: Populates category.
*)
BuildCategoryGrid[]:=Module[{k,i,s},
  category=Table[{},{it,Length[trunclist]},{2+trunclist[[it,2]] }];
  symGFPrint[category];
  Do[
    Do[
      s=Total[Count[NonCommutativeMultiply[gfs[[k,1]],gfs[[k,2]]],trunclist[[i,1,j]],Infinity]& /@ Range[Length[trunclist[[i,1]]]]];
      If[s>0,category[[i,s]]=Union[category[[i,s]],{k}]];
      ,{i,Length[trunclist]}],
    {k,Min[cap,Length[gfs]]}];
  symGFPrint[category];
  i=Length[category];
  Do[
    category[[i,s]]=Union[category[[i,s]],category[[i,s+1]]],
    {i,Length[category]},{s,Length[category[[i]]]-1,1,-1}];
  Do[
    category[[i,-1]]=Union[category[[i,-1]],category[[i+1,1]]];
    Do[
      category[[i,s]]=Union[category[[i,s]],category[[i,s+1]]],
      {s,Length[category[[i]]]-1,1,-1}],
    {i,Length[category]-1,1,-1}];
  symGFPrint[category];
]

SelectCategoryMembers[ct_List,cat_Integer,geshu_Integer,idx_Integer]:=Intersection[ct,category[[cat,geshu]] ]
SelectCategoryMembersQuick[ct_List,cat_Integer,geshu_Integer,idx_Integer]:=Intersection[ct,category[[cat,geshu]] ]
SelectHigherMembers[ct_List,cat_Integer,geshu_Integer,idx_Integer]:=Select[Intersection[ct,category[[cat,geshu]] ],#>idx&]

(*
   Function: RunConditionedSweep[verbo_:0]
   Purpose: Run the full multi-pass conditioned iteration across all
     categories produced by BuildCategoryGrid[], invoking SolveConditionedEquation to process each GF.
   Algorithm:
     1. Call BuildCategoryGrid[] to populate category.
     2. Loop over every category/occupancy combination; for each non-empty
        bucket, iterate over GF indices in descending order and run SolveConditionedEquation
        with the appropriate selection function (SelectHigherMembers).
     3. After the forward sweep, re-run SolveConditionedEquation in verification mode (SelectCategoryMembers)
        to double-check convergence.
   Inputs: verbo - verbosity flag.
   Output: Prints timing diagnostics; solgf is updated in place.
*)
RunConditionedSweep[verbo_:0]:=Module[{cat,geshu,iter,uu,tt},
  BuildCategoryGrid[];
  tt=TimeUsed[];
  Do[
    Do[
      If[Length[category[[cat,geshu]]]>0,
        symGFPrint["cat: ",cat,"  geshu: ",geshu];
        uu=TimeUsed[];
        Do[
          If[iter!=14,
            SolveConditionedEquation[verbo,SelectHigherMembers,iter,cat,geshu],
            SolveConditionedEquation[1,SelectHigherMembers,iter,cat,geshu]
          ],
          {iter,Length[gfs],1,-1}];
        Do[
          If[SolveConditionedEquation[verbo,SelectCategoryMembers,iter,cat,geshu]==False,
            symGFPrint["Error: SolveConditionedEquation[",iter,"] failed."]
          ],
          {iter,Length[gfs],1,-1}];
        symGFPrint["Pass cat: ",cat,"  geshu: ",geshu," done in ",TimeUsed[]-uu," seconds."];
      ],
      {geshu,Length[category[[cat]]],1,-1}],
    {cat,Length[category],1,-1}];
  symGFPrint["everything done in ",TimeUsed[]-tt," seconds."];
]

(*
   Function: RunInlineConditionedSweep[verbo_:0]
   Purpose: Variant of RunConditionedSweep that keeps all iteration directions (both
     SelectHigherMembers and SelectCategoryMembers) active in a single sweep by delegating to IterateConditionedEquation.
   Algorithm:
     1. Call BuildCategoryGrid[] to ensure category data is current.
     2. Traverse the category grid; for each populated bucket and every GF
        index, invoke IterateConditionedEquation which alternates between substitution and
        simplification until convergence.
   Inputs: verbo - verbosity flag controlling logging.
   Output: Updates solgf and prints timing data.
*)
RunInlineConditionedSweep[verbo_:0]:=Module[{cat,geshu,iter,uu,tt},
  BuildCategoryGrid[];
  tt=TimeUsed[];
  Do[
    Do[
      If[Length[category[[cat,geshu]]]>0,
        symGFPrint["cat: ",cat,"  geshu: ",geshu];
        uu=TimeUsed[];
        Do[
          IterateConditionedEquation[0,SelectHigherMembers,iter,cat,geshu],
          {iter,Length[gfs],1,-1}];
        symGFPrint["Pass cat: ",cat,"  geshu: ",geshu," done in ",TimeUsed[]-uu," seconds."];
      ],
      {geshu,Length[category[[cat]]],1,-1}],
    {cat,Length[category],1,-1}];
  symGFPrint["everything done in ",TimeUsed[]-tt," seconds."];
]


(*
   Function: IterateConditionedEquation[verbo_:0,selector_,idx_Integer,cat_Integer,geshu_Integer]
   Purpose: Iteratively substitute and simplify the solution of GF idx while a
     given selection function selector reports unresolved Green's functions.
   Algorithm:
     1. Extract the current solution, compute containedGF and NRcontainedGF to
        estimate complexity, and pick the list of GFs that must still be
        resolved using CategorySelector.
     2. While unresolved indices exist, substitute them via IterateTOBranch,
        simplify the expression (with TimeConstraint), and recompute the
        outstanding list.
     3. Once convergence is reached, rewrite solgf[[idx,3]] with the updated
        expression.
   Inputs: verbo - verbosity flag; selector - selector function; idx,cat,geshu -
     identifiers used for logging.
   Output: None (updates solgf).
*)
IterateConditionedEquation[verbo_:0,selector_,idx_Integer,cat_Integer,geshu_Integer]:=Module[{sol,ct,cta,ret=True,s2,nr},
  symGFPrint[" num: ",idx," cat: ",cat," geshu: ",geshu];
  sol=solgf[[idx,3]];
  If[sol=!=0,
    If[verbo>0,symGFPrint["getting GF index ..."];];
    ct=containedGF[sol];
    nr=NRcontainedGF[sol];
    cta=selector[ct,cat,geshu,idx];
    If[verbo>0,symGFPrint["indexing done."];];
    If[verbo>0,symGFPrint["initial: ",Length[ct]," GF's and ",Length[cta]," GF's to be iterated. ",cta," ge shu :",nr];];
    While[Length[cta]>0,
      If[verbo>0,symGFPrint[idx," IterateGFExpression-ing ...",ct];];
      sol=grab3[ExpandAll[IterateTOBranch[sol,cta]]]//.selfenergyrep;
      nr=NRcontainedGF[sol];
      If[verbo>0,symGFPrint["IterateGFExpression done. ge shu: ",nr,"\n simplifying..."];];
      sol=Simplify[sol,ComplexityFunction->NRcontainedGF,TimeConstraint->10]//.selfenergyrep;
      If[verbo>0,symGFPrint["simplify done.\n getting index..."];];
      ct=containedGF[sol];
      cta=selector[ct,cat,geshu,idx];
      If[verbo>0,symGFPrint["iteration: ",Length[ct]," GF's and ",Length[cta]," GF's to be iterated. ",cta];];
    ];
    If[verbo>0,symGFPrint[idx," eq. ",ct ];];
    ct=containedGF[sol];
    If[verbo>0,symGFPrint["finally ", idx," contains ",ct," ge shu: ",NRcontainedGF[s2]  ];];
    solgf[[idx,3]]=sol;  (* this is true, it only contains itself, eliminate it next time. *)
    If[verbo>1,
      symGFPrint[sol]
    ];
  ];
]
(*
   Function: SolveConditionedEquation[verbo_:0,selector_,idx_Integer,cat_Integer,geshu_Integer]
   Purpose: Solve GF idx within a given category by iteratively substituting
     other GFs (selected by selector) and finally isolating GFnames[[idx]].
   Algorithm:
     1. Repeat the substitution/simplification loop described in IterateConditionedEquation until
        CategorySelector reports no more GFs to eliminate.
     2. If GFnames[[idx]] still appears, solve the linear equation for it and
        simplify the resulting expression; otherwise keep the simplified
        expression as is.
     3. Ensure the solution no longer contains idx itself; if it does, leave
        the unsolved expression for later processing.
   Inputs: verbo - verbosity flag; selector - selector; idx,cat,geshu - IDs.
   Output: Boolean success flag recorded via ret; solgf is updated on success.
*)
SolveConditionedEquation[verbo_:0,selector_,idx_Integer,cat_Integer,geshu_Integer]:=Module[{sol,ct,cta,ret=True,s2,nr},
  symGFPrint[" num: ",idx," cat: ",cat," geshu: ",geshu];
  sol=solgf[[idx,3]];
  If[verbo>0,symGFPrint["getting GF index ..."];];
  ct=containedGF[sol];
  nr=NRcontainedGF[sol];
  cta=selector[ct,cat,geshu,idx];
  If[verbo>0,symGFPrint["indexing done."];];
  If[verbo>0,symGFPrint["initial: ",Length[ct]," GF's and ",Length[cta]," GF's to be iterated. ",cta," ge shu :",nr];];
  While[Length[cta]>0,
    If[verbo>0,symGFPrint[idx," IterateGFExpression-ing ...",ct];];
    sol=IterateTOBranch[sol,cta]//.selfenergyrep;
    nr=NRcontainedGF[sol];
    If[verbo>0,symGFPrint["IterateGFExpression done. ge shu: ",nr,"\n simplifying..."];];
    sol=Simplify[sol,ComplexityFunction->NRcontainedGF,TimeConstraint->10]//.selfenergyrep;
    If[verbo>0,symGFPrint["simplify done.\n getting index..."];];
    ct=containedGF[sol];
    cta=selector[ct,cat,geshu,idx];
    If[verbo>0,symGFPrint["iteration: ",Length[ct]," GF's and ",Length[cta]," GF's to be iterated. ",cta];];
  ];
  If[verbo>0,symGFPrint[idx," eq. ",ct ];];
  If[!FreeQ[sol,GFnames[[idx]] ],
    s2= (Solve[GFnames[[idx]]==sol,GFnames[[idx]] ] [[1,1,2]] )//.selfenergyrep;  
    If[verbo>0,symGFPrint[idx," solved."];];
    s2= Simplify[s2, TimeConstraint->10,ComplexityFunction->NRcontainedGF ]//.selfenergyrep;
    If[verbo>0,symGFPrint[idx," simplified."];];
    ,
    s2=sol;
    If[verbo>0,symGFPrint[idx," solved & simplified."];];
  ]; 
  ct=containedGF[s2];
  If[verbo>0,symGFPrint["finally ", idx," contains ",ct," ge shu: ",NRcontainedGF[s2]  ];];
  If[MemberQ[ct ,idx],
    symGFPrint["Sorry: solution of GF #",idx," contained itself. SolveConditionedEquation[",idx,",",cat,",",geshu,"] failed."];
    solgf[[idx,3]]=sol;  (* this is true, it only contains itself, eliminate it next time. *)
    ret=False;
    ,
    solgf[[idx,3]]=s2;
  ];
  If[verbo>1,
    symGFPrint[s2]
  ];
  ret
]

(*
   Function: SolveSecondPass[idx_Integer]
   Purpose: Second pass of the conditioned-iteration solver. Similar to
     SolveFirstPass but allows substitution of any GF selected by subbed[
     containedGF[sol]] rather than only those with larger indices.
   Algorithm:
     1. Replace every GF whose pattern appears in the current solution by
        calling IterateTOBranch and simplify the expression afterwards.
     2. Continue until no GFs remain except possibly the one being solved;
        then solve for GFnames[[idx]] and simplify the result.
   Inputs: idx - GF index.
   Output: {idx, simplified solution} on success; aborts if recursion remains.
*)
SolveSecondPass[idx_Integer]:=Module[{sol,ct,cta},
  sol=solgf[[idx,3]];
  ct=subbed[containedGF[sol]];
  symGFPrint[idx, "   ",ct];
  While[Length[ct]>0,
    sol=grab3[ExpandAll[IterateTOBranch[sol,ct]]]//.selfenergyrep;
    sol=Simplify[sol,ComplexityFunction->NRcontainedGF,TimeConstraint->10];
    cta=containedGF[sol];
    ct=subbed[cta];
    symGFPrint[idx, "  die le  ",cta, " ge shu: ",NRcontainedGF[sol]," zhong shu: ",Length[cta] ];
  ];
  symGFPrint[idx," eq. ",containedGF[sol] ];
  If[!FreeQ[sol,GFnames[[idx]] ],
    sol= (Solve[GFnames[[idx]]==sol,GFnames[[idx]] ] [[1,1,2]] );  
  ]; 
  symGFPrint[idx," solved"];
  sol= Simplify[sol, TimeConstraint->10,ComplexityFunction->NRcontainedGF ];
  ct=containedGF[sol];
  symGFPrint["finally ", idx," contains ",ct  ];
  If[MemberQ[ct ,idx],
    symGFPrint["Sorry: solution of GF #",idx," contained itself. SolveSecondPass[",idx,"] failed."];
    Abort[]
    ,
    solgf[[idx,3]]=sol
  ];
  symGFPrint["ge shu: ",NRcontainedGF[sol] ];
  {idx,solgf[[idx,3]]}
]

(*
   Function: RunSolverPasses[lv_Integer:3,res_:False]
   Purpose: Run one, two, or three passes (SolveFirstPass, SolveSecondPass, SolveFinalPass) over all
     Green's functions in descending index order.
   Algorithm:
     1. Depending on lv, execute SolveFirstPass (pass 1), SolveSecondPass (pass 2), and/or
        SolveFinalPass (pass 3); each pass iterates over all indices and updates solgf.
     2. When res==True, echo each intermediate result for monitoring.
     3. Print timing information for every pass.
   Inputs: lv - number of passes (1..3); res - whether to print results.
   Output: None; solgf updated.
*)
RunSolverPasses[lv_Integer:3,res_:False]:=Module[{i,uu,tt}, (* lv: 3-SolveFirstPass+SolveSecondPass+SolveFinalPass, 2-SolveSecondPass+SolveFinalPass, 1-SolveFinalPass *)
  uu=TimeUsed[];
  tt=uu;
  If[lv>2,
    symGFPrint["Pass 1:"];
    Do[
      If[res===True,symGFPrint[SolveFirstPass[i]],SolveFirstPass[i]],
      {i,Length[gfs],1,-1}];
    symGFPrint["Pass 1 done in ",TimeUsed[]-uu," seconds."];
  ];
  uu=TimeUsed[];
  If[lv>1,
    symGFPrint["Pass 2:"];
    Do[
      If[res===True,symGFPrint[SolveSecondPass[i]],SolveSecondPass[i]],
      {i,Length[gfs],1,-1}];
    symGFPrint["Pass 2 done in ",TimeUsed[]-uu," seconds."];
  ];
  uu=TimeUsed[];
  symGFPrint["Final Pass...."];
  Do[
    If[res===True,symGFPrint[SolveFinalPass[i]],SolveFinalPass[i]],
    {i,Length[gfs],1,-1}];
  symGFPrint["Pass 3 done in ",TimeUsed[]-uu," seconds."];
  symGFPrint["everything done in ",TimeUsed[]-tt," seconds."];
]

(*
   Function: IterateTOBranch[expr_OverBar,curr_List]
   Purpose: Replace a specific GF (expr) by its current solution whenever its
     index appears in the substitution list curr; used by the conditioned
     iteration passes to remove recently solved GFs.
   Algorithm:
     1. Determine the index of expr inside GFnames.
     2. If idx belongs to curr, substitute the stored solution solgf[[idx,3]] while
        converting subscripts with GFTOsubsub so the operands match expr.
     3. Otherwise return expr unchanged.
   Inputs: expr - OverBar GF; curr - list of indices to substitute.
   Output: Expression where expr may have been replaced.
*)
IterateTOBranch[expr_OverBar,curr_List]:=Module[{pos,i,ret=expr,tok,idx},
  tok=expr;
  symGFPrint["tick"];
  idx=Flatten[Position[GFnames,purepattern[tok]]];
  symGFPrint[idx];
  If[Length[idx]!=1,
    symGFPrint["Error: Multiple or no GF's found for ",tok];
    Abort[];
  ];
  idx=idx[[1]];
  
  symGFPrint[idx];
  If[MemberQ[curr,idx],
    ret=solgf[[idx,3]]/.GFTOsubsub[GFnames[[idx]],tok];
  ];
  ret
]

(*
   Function: IterateTOBranch[expr_,curr_List]
   Purpose: Generalized version that scans the whole expression and replaces
     every GF whose index belongs to curr.
   Algorithm:
     1. Locate all OverBar subexpressions within expr.
     2. For each one, find its GFnames index; if the index is in curr,
        replace the occurrence in-place by the stored solution adapted via
        GFTOsubsub.
   Inputs: expr - arbitrary expression possibly containing GFs; curr - indices
     to replace.
   Output: Expression with selected GFs substituted.
*)
IterateTOBranch[expr_,curr_List]:=Module[{pos,ret=expr,tok,idx},
  pos=Position[expr,_OverBar];
  Do[
    tok=Extract[expr,pos[[i]]];
    idx=Flatten[Position[GFnames,purepattern[tok]]];
    If[Length[idx]!=1,
      symGFPrint["Error: Multiple or no GF's found for ",tok];
      Abort[];
    ];
    idx=idx[[1]];
    
    If[MemberQ[curr,idx],
      Part[ret,pos[[i]]/.List->Sequence]=solgf[[idx,3]]/.GFTOsubsub[GFnames[[idx]],tok];
    ],
    {i,Length[pos]}];
  ret
]

subbed[cgf_List]:=Select[cgf,!nonSubed[GFnames[[#]]]&]
NRcontainedGF[expr_]:=Count[expr,_OverBar,Infinity]
(*
   Function: containedGF[expr_]
   Purpose: Return the set of GF indices (within GFnames) that appear inside
     expr; used to decide which equations need further iteration.
   Algorithm:
     1. Search expr for OverBar occurrences.
     2. For each match, locate the index in GFnames and add it to a running
        list.
     3. Return the sorted unique list of indices.
   Inputs: expr - expression to analyse.
   Output: List of GF indices.
*)
containedGF[expr_]:=Module[{pos,collected},
  pos=Position[expr,_OverBar];
  collected=Reap[
    Do[
      With[{tmp=Extract[expr,pos[[i]]]},
        pos2=Flatten[Position[GFnames,purepattern[tmp],1]];
        If[pos2=!={},Sow[pos2[[1]]]];
      ],
      {i,Length[pos]}
    ]
  ];
  If[collected[[2]]==={}, {}, Union[collected[[2,1]]]]
]
nonSubed[var_OverBar]:=If[Length[var[[1]] ]==0,True,False,False]


(* ==== IterateTimeOrderedGF is for time ordered GF, more "raw" than AC'ed GF's *)
IterateTimeOrderedGF[expr_Plus,curr_Integer]:=Sum[IterateTimeOrderedGF[expr[[i]],curr],{i,Length[expr]}] (*/.selfenergyrep*)
IterateTimeOrderedGF[expr_Times,curr_Integer]:=Expand[ (Product[IterateTimeOrderedGF[expr[[i]],curr],{i,Length[expr]}] ) ]
(*
   Function: IterateTimeOrderedGF[expr_OverBar,curr_Integer]
   Purpose: Substitute time-ordered Green's functions whose indices are larger
     than curr, mirroring the logic used for advanced/retarded branches.
   Algorithm:
     1. Find the GF index corresponding to expr.
     2. When pos > curr, replace expr by the stored solution solgf[[pos,3]]
        adjusted by GFTOsubsub; otherwise leave expr unchanged.
*)
IterateTimeOrderedGF[expr_OverBar,curr_Integer]:=Module[{pos},
  (* this is a GF *)
  pos=Flatten[Position[GFnames,purepattern[expr],1]];
  If[Length[pos]!=0,
    If[Length[pos]>1,
      symGFPrint["Error: Multiple of Green's Function ",expr," found in list."];
      Abort[];
    ];
    pos=pos[[1]];
    If[curr<pos,
      solgf[[pos,3]]/.GFTOsubsub[GFnames[[pos]],expr]
      ,
      expr
    ]
    ,
    expr
  ]
]
IterateTimeOrderedGF[expr_,curr_Integer]:=expr   (* no change for non-gf exp's *)


IterateGFExpression[expr_Plus]:=Sum[IterateGFExpression[expr[[i]]],{i,Length[expr]}]
(*
   Function: IterateGFExpression[expr_OverBar]
   Purpose: Fetch the currently known solution for an acGF (advanced/retarded
     GF) and substitute it unless the GF has been marked as final.
   Algorithm:
     1. Identify the index of expr inside acGFnames by pattern matching.
     2. If the index is not in final, substitute the stored value
        acGFsol[[pos]] after adapting subscripts; otherwise leave expr
        untouched.
*)
IterateGFExpression[expr_OverBar]:=Module[{pos},
  pos=Position[acGFnames,expr/.
    Table[Level[expr,{3}][[i]]->Blank[],{i,Length[Level[expr,{3}]]}]] ;  (* position in gf list *)
  If[Length[pos]==1,
    pos=pos[[1,1]];
    If[FreeQ[final,pos],
      ExpandAll[(acGFsol[[pos]])/.GFsubsub[acGFnames[[pos]],expr]]/.selfenergyrep
      ,
      expr
    ]
    ,
    expr
  ]
]
IterateGFExpression[expr_]:=expr
(*
   Function: IterateGFExpression[expr_Times]
   Purpose: IterateGFExpression[idx_] performs one step of the iterative solution process (internal).
   Inputs: follows the pattern shown in IterateGFExpression[expr_Times].
   Output: See Purpose for how the result is used.
*)
IterateGFExpression[expr_Times]:=Module[{pl,tmp,h,gf,subl,pos},
  h=Head[expr];
  tmp=List@@expr;
  pl=Position[expr,_OverBar,1]//Flatten;
  Do[
    gf=tmp[[pl[[i]]]];
    subl=Level[gf,{3}];
    pos=Position[acGFnames,gf/.Table[subl[[i]]->Blank[],{i,Length[subl]}] ]//Flatten;
    If[Length[pos]==0,Continue[] ];
    pos=pos[[1]];
    tmp[[pl[[i]] ]]=acGFsol[[pos]]/.GFsubsub[acGFnames[[pos]],tmp[[pl[[i]]]] ]
    ,{i,Length[pl]}];
  Grab[ExpandAll[h@@tmp]/.selfenergyrep]
]

GFsubsub[a_OverBar,b_OverBar]:= Table[a[[1,1,i]]->b[[1,1,i]],{i,Length[a[[1,1]]]}]
GFTOsubsub[a_OverBar,b_OverBar]:= Table[a[[1,i]]->b[[1,i]],{i,Length[a[[1]]]}]  (* all GF's have depth 2 *)
ISOsubsub[a_UnderBar,b_UnderBar]:= Table[a[[1,i]]->b[[1,i]],{i,Length[a[[1]]]}]  (* all GF's have depth 2 *)

ResetGFlist[] := (
  symGFResetUniqueCounters[];
  gfs = {};
  solgf = {};
  GFnames={};
  IGFs={};
  SelfEnergy={};
  selfenergyrep={};
  GammaEnergy={};
  acGFnames={};
  acGFsol={};
  closedsol={};
  connectionlist={};
  final={};
  graph={};
  TBS={};
  TS={}
)
ResDisp[]:=(
  symGFPrint["************* Equation(s) of motion: *************"];
  symGFPrint[TableForm[Table[{i,":  <<",Sequence@@gfs[[i]],">> =",solgf[[i,3]]},{i,Length[gfs] }]]];
  symGFPrint[];
  symGFPrint["************* Isolated Green's Function(s): *************"];
  symGFPrint[TableForm[Table[{IGFs[[i,2]]," \[Congruent] ",IGFs[[i,1]]},{i,Length[IGFs]}] ]];
  If[SelfEnergy=!={}, 
    symGFPrint["************ Self-Energy(ies): ************ "]; 
    symGFPrint[TableForm[Table[{SelfEnergy[[i,2]]," \[Congruent] ",SelfEnergy[[i,1]]},{i,Length[SelfEnergy]}]]];
  ];
  If[GammaEnergy=!={},
    symGFPrint[
      TableForm[
        Table[{GammaEnergy[[i,2]]," \[Congruent] ",GammaEnergy[[i,1]]},{i,Length[GammaEnergy]}] /. 
        (GlobalSummationScript-> symGFUnique["s"])
      ]
    ];
  ];
)

SetCoupling[a_List]:=( CC=a;plainCC=Flatten[CC]; 
  symGFPrint["Grouped coupling constants:"];
  symGFPrint[ TableForm[CC] ];
  symGFPrint[]
)
SetCoupling[a__]:=SetCoupling[{a}]
prep[]:=(symGFPrint[selfenergyrep];)
(*SetSelfEnergy[a_List]:=Module[{i,l=Length[a],tmp}, selfenergyrep = a; SelfEnergy=a[[All,2]]; 
]
SetSelfEnergy[a__]:=SetSelfEnergy[{a}]
*)
(*
   Function: SetRules[a_List]
   Purpose: Register the (anti-)commutation relations supplied by the user and
     pretty-print them for verification.
   Algorithm:
     1. Store the rules in rulelist so privatecomm and friends can use them.
     2. Iterate over the rules and format each one, taking into account
        whether the replacement was given via RuleDelayed.
     3. Print the formatted table.
   Inputs: a - list of rules of the form {op1, op2, replacement}.
   Output: None; updates rulelist and prints diagnostics.
*)
SetRules[a_List] := Module[{formatted},
  rulelist = a;
  symGFPrint["(Anti-)Commutation relation(s): "];
  formatted = Table[
    If[Head[a[[i,3]] ]===RuleDelayed,
      {i,":  {",a[[i,3,1,1]],",",a[[i,3,1,2]],"} =",a[[i,3,2]]}
      ,
      {i,":  {",a[[i,1]],",",a[[i,2]],"} =",a[[i,3]] }
    ]
    ,{i,Length[a]}];
  symGFPrint[TableForm[formatted]];
  symGFPrint[]
]
SetRules[a__] := SetRules[{a}]
SetPreserve[a_List] := ( preservelist = a; 
  symGFPrint["Operators to preserve: ",a];
  symGFPrint[]
)
SetPreserve[a__] := SetPreserve[{a}]
SetETPreserve[a_List]:=(ETP=a;)
ETjudge[dt_Plus]:=Sum[ETjudge[dt[[i]]],{i,Length[dt]}]
ETjudge[dt_Times]:=Product[ETjudge[dt[[i]]],{i,Length[dt]}]
ETjudge[dt_OverHat]:=dt
(*
   Function: ETjudge[dt_NonCommutativeMultiply]
   Purpose: ETjudge[expr_] extracts the preserved pieces from delta contributions.
   Inputs: follows the pattern shown in ETjudge[dt_NonCommutativeMultiply].
   Output: See Purpose for how the result is used.
*)
ETjudge[dt_NonCommutativeMultiply]:=Module[{i,pos,ret=dt},
  pos=Position[ETP,purepattern[dt[[1]]]];
  If[Length[pos]>1,
    symGFPrint["Warning: multiple slots found for operator ",dt[[1]]  ];
  ];
  If[Length[pos]>0,
    pos=Flatten[pos][[1]];
    If[!And@@(MemberQ[ETP[[pos]],purepattern[#]]& /@ dt[[2;;]]),ret=0]
    ,
    ret=0;
  ];
  ret
  (* dt  (* keep everything *) *)
]
ETjudge[dt_]:=dt

SetSumSub[a_List] := ( sumlist = a; 
  symGFPrint["List of summation subscript: ",a];
  symGFPrint[]
)
SetSumSub[a__] := SetSumSub[{a}]
sneaksumlist[]:=sumlist
SetIGF[a_List] := ( IGFs = a; oriNRIGF=Length[a]; )
SetIGF[a__] := SetIGF[{a}]
(*
   Function: MakeSE[]
   Purpose: Build self-energy replacement rules by pairing isolated GFs whose
     frequency parts share common structure.
   Algorithm:
     1. Compare every IGF pair; when the energy expression of IGFs[[i]] uses
        the same operator structure as IGFs[[j]], create a replacement that
        maps the underbar form of IGFs[[i,2]] multiplied by the coefficients
        of IGFs[[j]] to a new \[CapitalSigma] symbol.
     2. Append each new rule to selfenergyrep so later simplifications can
        identify self-energy terms.
   Inputs: None; uses global IGFs.
   Output: Populates selfenergyrep.
*)
MakeSE[]:=Module[{i,j},
  Do[
    Do[
      If[!FreeQ[IGFs[[i,1]],IGFs[[j,1]]],
        If[Depth[IGFs[[i,2]]]==2,
          AppendTo[selfenergyrep,
            UnderBar[(IGFs[[i,2]]/.IGFs[[i,2,1]]->IGFs[[j,2,1]])]*
            Product[IGFs[[j,3,m]],{m,Length[IGFs[[j,3]]]}] -> symGFUnique["\[CapitalSigma]"]];
          ,
          AppendTo[selfenergyrep,
            UnderBar[IGFs[[i,2]]]*Product[IGFs[[j,3,m]],{m,Length[IGFs[[j,3]]]}]->symGFUnique["\[CapitalSigma]"]];
        ];
        Break[];
      ],
      {j,1,oriNRIGF-1}],
    {i,1,Length[IGFs]}];
  symGFPrint[selfenergyrep];
]

annihilation[op_OverHat] := AnyTrue[rulelist,MatchQ[op[[1]],#[[1]]]&]
creation[op_OverHat] := AnyTrue[rulelist,MatchQ[op[[1]],#[[2]]]&]
InitializeGFs[expr_] := ( ResetGFlist[]; RegisterGF[expr]; 
  symGFPrint["Target Green's function set as: ",gfs[[1]] ]; 
)
TargetGF[expr_]:=InitializeGFs[expr]
RegisterGF[expr_Plus] := Sum[RegisterGF[expr[[i]]], {i, Length[expr]}]
RegisterGF[expr_Times] := Sum[RegisterGF[expr[[i]]], {i, Length[expr]}]
(*
   Function: RegisterGF[expr_NonCommutativeMultiply]
   Purpose: Record the user-specified target GF(s) by extracting the
     annihilation/creation operators, ensuring they obey the registered
     commutation rules, and seeding the solver state.
   Algorithm:
     1. Accept only two-operator non-commutative products where the first
        operator annihilates and the second creates (or vice versa).
     2. Append the operator pair to gfs together with placeholder solutions
        in solgf and GFnames.
     3. Handle linear combinations by recursing on sums/products so multiple
        target GFs can be registered at once.
   Inputs: expr - operator product defining the GF.
   Output: Updates gfs, solgf, GFnames; returns Null.
*)
RegisterGF[expr_NonCommutativeMultiply] := Module[{k = 0}, 
  If[Length[expr] == 2 && annihilation[expr[[1]]] && creation[expr[[2]]], 
    AppendTo[gfs, {uniquesub[expr[[1]]], uniquesub[expr[[2]]]}]; 
    AppendTo[solgf, {0, 0, 0}]; 
    AppendTo[GFnames, OverBar[symGFUnique["GF"]@@subs[NonCommutativeMultiply[gfs[[-1,1]],gfs[[-1,2]] ] ] ] ];
    k = 1
  ]; 
  If[Length[expr] == 2 && annihilation[expr[[2]]] && creation[expr[[1]]], 
    AppendTo[gfs, {uniquesub[expr[[2]]], uniquesub[expr[[1]]]}]; 
    AppendTo[solgf, {0, 0, 0}]; 
    AppendTo[GFnames, OverBar[symGFUnique["GF"]@@subs[NonCommutativeMultiply[gfs[[-1,1]],gfs[[-1,2]] ] ] ] ];
    k = 1
  ]; 
  k
]
RegisterGF[expr_] := 0
preserveQ[op_OverHat] := AnyTrue[preservelist,MatchQ[op,#]&]
preserveQ[e_]:=False
(*
   Function: NormalizeGFExpression[expr_]
   Purpose: Normalize a commutator result into a list of {operator string,
     coefficient} pairs understood by the linear solver.
   Algorithm:
     1. Reject zero expressions (they signal earlier logic bugs).
     2. Call SplitOperatorCoefficient to split the term into {NonCommutativeMultiply, scalar}
        structures.
     3. Wrap the result in a list when SplitOperatorCoefficient returns a single pair.
   Inputs: expr - commutator result.
   Output: List of {operatorString, coefficient} pairs.
*)
NormalizeGFExpression[expr_]:=Module[{ret},
  If[expr===0, symGFPrint["Error: fengzhuang called with zero argument."]; Abort[] ];
  ret=SplitOperatorCoefficient[expr];
  If[Head[ret[[1]]] =!= List, ret={ret}];
  ret
]
SplitOperatorCoefficient[expr_Plus]:=Table[SplitOperatorCoefficient[expr[[i]]],{i,Length[expr]}]
(*
   Function: SplitOperatorCoefficient[expr_Times]
   Purpose: Split a product into its operator part and scalar coefficient so
     later modules can treat them separately.
   Algorithm:
     1. If expr contains NonCommutativeMultiply, pull that factor out,
        replacing it by 1 inside the coefficient part, and record the pair.
     2. Otherwise look for bare OverHat operators, treat them similarly, and
        fall back to an error message if no operator can be found.
   Inputs: expr - multiplicative term.
   Output: {operator, coefficient}.
*)
SplitOperatorCoefficient[expr_Times]:=Module[{kk=expr,re={}},
  If[FreeQ[expr,NonCommutativeMultiply]==False,
    Do[
      If[expr[[i,0]]==NonCommutativeMultiply,
        AppendTo[re,expr[[i]]];
        kk[[i]]=1;
        AppendTo[re,kk]
      ],
      {i,Length[expr]}]
    ,
    If[FreeQ[expr,OverHat]==False,
      Do[
        If[expr[[i,0]]==OverHat,
          AppendTo[re,expr[[i]]];
          kk[[i]]=1;
          AppendTo[re,kk]
        ],
        {i,Length[expr]}]
      ,
      symGFPrint["Error: expression does not contain an operator factor."]
    ]
  ];
  re
]
SplitOperatorCoefficient[expr_NonCommutativeMultiply]:={expr,1}
SplitOperatorCoefficient[expr_OverHat]:={expr,1}
(*
   Function: AC[gi_]
   Purpose: Build the advanced, retarded, lesser, and greater variants of the
     first gi Green's functions by applying the appropriate ac* constructors.
   Algorithm:
     1. For every GF up to index gi, produce the four variants (toa, tor, tol,
        tog) and store them in acGFnames.
     2. Apply acAdvanced/acRetarded/acLesser/acGreater to the stored rhs
        expressions and keep the results inside acGFsol.
   Inputs: gi - number of target Green's functions to expand.
   Output: Populated acGFnames/acGFsol.
*)
AC[gi_]:=Module[{i},
  acGFnames=Table[{toa[GFnames[[i]]],tor[GFnames[[i]]],tol[GFnames[[i]]],tog[GFnames[[i]]]},
    {i,gi}]//Flatten;
  acGFsol=Table[{acAdvanced[solgf[[i,3]],solgf[[i,1]]],acRetarded[solgf[[i,3]],solgf[[i,1]]],
      acLesser[solgf[[i,3]],solgf[[i,1]]],acGreater[solgf[[i,3]],solgf[[i,1]]]},
    {i,gi}]//Flatten;
]
(*
   Function: DeriveGF[hamiltonian_]
   Purpose: Derive the equations of motion for every registered GF using the
     equation-of-motion technique, truncation rules, and optional operator
     preservation constraints.
   Algorithm:
     1. Iterate over gfs; decide whether each GF should be treated as type 1
        or 2 based on preserveQ and check the fermionic antisymmetry rule
        (twoidentical) to skip trivial zeros.
     2. Compute the commutator [operator, hamiltonian], normalize it via Grab
        and NormalizeGFExpression, and either direct-substitute truncation rules (when
        FindTruncationRule indicates so) or build the linear system by splitting coefficients
        with SplitOperatorCoefficient/NormalizeGFExpression.
     3. Accumulate connectionlist metadata so later passes (Conditioned
        Iteration) know which GFs couple together, and print timing
        information when finished.
   Inputs: hamiltonian - full operator Hamiltonian supplied by the user.
   Output: Populates solgf, connectionlist, and derived RHS entries.
*)
DeriveGF[hamiltonian_] := Module[{tim,kk,gfListIndex = 1, rhs, dt, deltatimes,trid},
  symGFPrint["Deriving..."];
  tim=TimeUsed[];
  While[gfListIndex <= Length[gfs],
    (* symGFPrint[gfListIndex,":  ",gfs[[gfListIndex]] ]; *)
    If[preserveQ[gfs[[gfListIndex,2]]], 
      dt = 1
      , 
      dt = 2
    ]; 
    
    If[ twoidentical[ gfs[[gfListIndex,dt]] ],
      solgf[[gfListIndex,1]] = dt;
      solgf[[gfListIndex,2]] = 0;
      solgf[[gfListIndex,3]] = 0;
      AppendTo[connectionlist,{}];  (* if set to zero, no more commands will be executed from here on *)
      gfListIndex++;
      (* symGFPrint["set to zero by fermi rule."]; *)
      Continue[]    (* i'm hoping this one will go on with the next "while" *)
    ];
    
    
    trid=FindTruncationRule[gfs[[gfListIndex,dt]]];  (* the part been done is longer *)
    If[trid==0,
      If[dt==1,
        rhs = NormalizeGFExpression[Grab[ExpandAll[com[gfs[[gfListIndex,1]], hamiltonian]] //. 
            {NonCommutativeMultiply[a_, b_ + c_] :> NonCommutativeMultiply[a, b] + NonCommutativeMultiply[a, c],
              NonCommutativeMultiply[a_ + b_, c_] :> NonCommutativeMultiply[a, c] + NonCommutativeMultiply[b, c],
              NonCommutativeMultiply[Times[a_, b_], c_] :> NonCommutativeMultiply[a, b, c],
              NonCommutativeMultiply[a_, Times[b_, c_]] :> NonCommutativeMultiply[a, b, c]}     ]]
        ,
        rhs = NormalizeGFExpression[Grab[-ExpandAll[com[gfs[[gfListIndex,2]], hamiltonian]] //.  
            {NonCommutativeMultiply[a_, b_ + c_] :> NonCommutativeMultiply[a, b] + NonCommutativeMultiply[a, c],
              NonCommutativeMultiply[a_ + b_, c_] :> NonCommutativeMultiply[a, c] + NonCommutativeMultiply[b, c],
              NonCommutativeMultiply[Times[a_, b_], c_] :> NonCommutativeMultiply[a, b, c],
              NonCommutativeMultiply[a_, Times[b_, c_]] :> NonCommutativeMultiply[a, b, c]}	]]
      ]; 
      deltatimes = anticom[gfs[[gfListIndex,1]], gfs[[gfListIndex,2]]];
      deltatimes = ETjudge[deltatimes];
      (*clearup[deltatimes];*)  (* make this optional later *)
      (*deltatimes = deltasymbol*deltatimes;*)
      ,
      (* cut, truncate ! *)
      rhs=truncsol[ReorderForTruncation[gfs[[gfListIndex,dt]],dt  ],dt   ];	
      (* symGFPrint["max length reached, truncate ",trid]; *)
      If[rhs =!= 0,	rhs=NormalizeGFExpression[SortOperatorProducts[rhs] ]  ];
      
    ];
    solgf[[gfListIndex,1]] = dt; 
    solgf[[gfListIndex,2]] = rhs; 
    AppendTo[connectionlist,loadNewGF[rhs, dt, gfListIndex]]; 
    
    If[trid==0,solgf[[gfListIndex,3]] = solution[rhs, dt, deltatimes, gfListIndex,0] ];
    If[trid!=0,solgf[[gfListIndex,3]] = solution[rhs, dt, deltatimes, gfListIndex,1] ];
    gfListIndex++
  ];
  eom=solgf[[All,3]];
  (* AC[gfListIndex-1]; *)
  del0[];
  kk=Table[{GFnames[[i]],solgf[[i,3]]},{i,Length[GFnames] }] ;
  (StoredEOM=Select[ kk, #[[2]]=!=0&&#[[1]]=!=0&]  );
  M=Table[ZeroEncodedBlock,{Length[StoredEOM]},{Length[StoredEOM]+1 }  ];
  L=Range[3];
  symGFPrint[Length[gfs]," equation(s) finished in ",TimeUsed[]-tim," second(s)."];
]
twoidentical[expr_NonCommutativeMultiply]:=AnyTrue[Partition[List@@expr,2,1],#[[1]]===#[[2]]&]
(* truncsol means truncation solution *)
truncsol[expr_Plus,dt_]:=Sum[truncsol[expr[[i]],dt],{i,Length[expr]}]
truncsol[expr_Times,dt_]:=Product[truncsol[expr[[i]],dt],{i,Length[expr]}]
(*
   Function: truncsol[expr_NonCommutativeMultiply,dt_]
   Purpose: Apply a truncation rule stored in trunclist to the front (dt==1)
     or back (dt==2) of an operator string.
   Algorithm:
     1. Use FindTruncationRule to determine which truncation rule matches expr; if none
        applies simply return expr.
     2. Fetch the matching subexpression via LocateTruncationSlots, compute the prefactor
        ratio using trunclist[[yid,3,nage]], and replace the targeted pair of
        operators with the rule's third entry.
     3. Strip the removed operators from the head or tail depending on dt and
        multiply the coefficient into the remaining operators.
   Inputs: expr - operator string; dt - 1 (front) or 2 (back).
   Output: Truncated expression.
*)
truncsol[expr_NonCommutativeMultiply,dt_]:=Module[{ret=expr,yid,coef,nage},
  yid=FindTruncationRule[expr];
  If[yid>0,
    If[Length[ret]<3,
      symGFPrint["Error: truncating on a too short expression: ",ret];
      Abort[];
    ];
    If[dt==1, (* do the front ones *)
      nage=LocateTruncationSlots[expr,yid][[1]];
      coef=(ret[[1]]*ret[[2]])/.
      (trunclist[[yid,3,nage,1]]*trunclist[[yid,3,nage,2]])->trunclist[[yid,3,nage,3]];
      If[Length[ret]>3,
        ret=coef*ret[[3;;-1]]
        ,
        ret=coef*ret[[3]]
      ]
    ];
    If[dt==2,  (* end ones *)
      nage=LocateTruncationSlots[expr,yid][[1]];
      coef=(ret[[-2]]*ret[[-1]])/.
      (trunclist[[yid,3,nage,1]]*trunclist[[yid,3,nage,2]])->trunclist[[yid,3,nage,3]];
      If[Length[ret]>3,
        ret=coef*ret[[1;;-3]]
        ,
        ret=coef*ret[[1]]
      ]
    ];
    ret
    ,
    ret
  ]
]
truncsol[expr_,dt_]:=expr
ReorderForTruncation[expr_Plus,dt_]:=Sum[ReorderForTruncation[expr[[i]],dt ],{i,Length[expr]}]
ReorderForTruncation[expr_Times,dt_]:=Product[ReorderForTruncation[expr[[i]],dt],{i,Length[expr]}]
(*
   Function: ReorderForTruncation[expr_NonCommutativeMultiply,1]
   Purpose: Reorder a fermionic operator string so the creation operators
     referenced by a truncation rule occupy the first slots (dt==1).
   Algorithm:
     1. Identify the truncation rule with FindTruncationRule and retrieve the desired
        positions via LocateTruncationSlots.
     2. If the first slot (l1) is already in position, check the second slot
        (l2); otherwise call SwapFermions to anticommute the operator into place
        and recurse.
     3. Stop when both slots are in the correct positions or no rule applies.
*)
ReorderForTruncation[expr_NonCommutativeMultiply,1]:=Module[{yid,nage,ret,l1,l2,pos},
  ret="Undefined";
  yid=FindTruncationRule[expr];
  If[yid!=0,
    {nage,l1,l2}=LocateTruncationSlots[expr,yid];
    If[nage==0,
      ret=0
      ,
      (* nage!=0, ReorderForTruncation! *)
      If[inpos1[Length[expr],l1,1],
        (* l1 in position, go on with l2 *)
        If[inpos2[Length[expr],l2,1],
          (* l2 in position too, done *)
          ret=expr
          ,
          (* l2 not in position, do it *)
          ret=SwapFermions[expr,l2[[1]],1];
          ret=ReorderForTruncation[ret,1]
        ]
        ,
        (* l1 not in position, do l1 *)
        ret=SwapFermions[expr,l1[[1]],1];
        ret=ReorderForTruncation[ret,1]
      ]
    ]
    ,
    (* yid==0, no need to ReorderForTruncation *)
    ret=expr
  ];
  If[ret==="Undefined",symGFPrint["Error: returning value of ReorderForTruncation not defined."];Abort[]];
  ret
]
(*
   Function: ReorderForTruncation[expr_NonCommutativeMultiply,2]
   Purpose: Same as the dt==1 branch but acting on the tail of the operator
     string so annihilation operators land in the final slots.
   Algorithm:
     1. Use FindTruncationRule/LocateTruncationSlots to determine which operators should be moved.
     2. Check whether l2 (tail positions) and l1 (preceding positions) are in
        place; when not, use SwapFermions to commute the operator toward the end
        and recurse until the rule is satisfied.
*)
ReorderForTruncation[expr_NonCommutativeMultiply,2]:=Module[{yid,nage,ret,l1,l2,pos},
  ret="Undefined";
  yid=FindTruncationRule[expr];
  If[yid!=0,
    {nage,l1,l2}=LocateTruncationSlots[expr,yid];
    If[nage==0,
      ret=0
      ,
      (* nage!=0, ReorderForTruncation! *)
      If[inpos2[Length[expr],l2,2],
        (* l2 in position, go on with l1 *)
        If[inpos1[Length[expr],l1,2],
          (* l1 in position too, done *)
          ret=expr
          ,
          (* l1 not in position, do it *)
          ret=SwapFermions[expr,l1[[-1]],2];
          ret=ReorderForTruncation[ret,2]
        ]
        ,
        (* l2 not in position, do l2 *)
        ret=SwapFermions[expr,l2[[-1]],2];
        ret=ReorderForTruncation[ret,2]
      ]
    ]
    ,
    (* yid==0, no need to ReorderForTruncation *)
    ret=expr
  ];
  If[ret==="Undefined",symGFPrint["Error: returning value of ReorderForTruncation not defined."];Abort[]];
  ret
]
ReorderForTruncation[expr_,dt_]:=expr
(*
   Function: inpos1[len_Integer,l_List,dt_Integer]
   Purpose: Test whether the first slot targeted by a truncation rule is
     already in place (position 1 for dt==1, position len-1 for dt==2).
   Algorithm: Compare the first (dt==1) or last (dt==2) entry of l against the
     expected position.
*)
inpos1[len_Integer,l_List,dt_Integer]:=Module[{ret=False},
  If[Length[l]==0, symGFPrint["Error: inpos1 called with zero length position list."]; Abort[] ];
  If[dt==1 && l[[1]] == 1, ret= True];
  If[dt==2 && l[[-1]]== len-1, ret=True];
  ret
]
(*
   Function: inpos2[len_Integer,l_List,dt_Integer]
   Purpose: Check whether the second slot of a truncation rule sits at the
     required position (2 for dt==1, len for dt==2).
   Algorithm: Compare the first (dt==1) or last (dt==2) entry of l to the
     desired index.
*)
inpos2[len_Integer,l_List,dt_Integer]:=Module[{ret=False},
  If[Length[l]==0, symGFPrint["Error: inpos2 called with zero length position list."]; Abort[] ];
  If[dt==1 && l[[1]] == 2, ret= True];
  If[dt==2 && l[[-1]]== len, ret=True];
  ret
]
(*
   Function: SwapFermions[expr_NonCommutativeMultiply,pos_Integer,dt_Integer]
   Purpose: Move the operator at position pos one slot to the left (dt==1) or
     right (dt==2) using fermionic commutation relations while preserving the
     correct sign and accumulating commutators.
   Algorithm:
     1. Replace the adjacent pair by the difference of commutators according
        to the desired direction.
     2. Expand the resulting expression, drop explicit identity factors, and
        call Grab to normalize the non-commutative products.
*)
SwapFermions[expr_NonCommutativeMultiply,pos_Integer,dt_Integer]:=Module[{tmp=expr},
  If[dt==1, (* move pos left *)
    If[pos<2, symGFPrint["Error: illegal value in SwapFermions[",expr,",",pos,",",dt,"]"];Abort[] ];
    tmp[[pos-1]]=com[tmp[[pos-1]],tmp[[pos]]]-NonCommutativeMultiply[tmp[[pos]],tmp[[pos-1]]];
    tmp[[pos]]=1
  ];
  If[dt==2, (* move pos right *)
    If[pos>Length[expr]-1,symGFPrint["Error: illegal value in SwapFermions[",expr,",",pos,",",dt,"]"];Abort[] ];
    tmp[[pos]]=com[tmp[[pos]],tmp[[pos+1]]]-NonCommutativeMultiply[tmp[[pos+1]],tmp[[pos]]];
    tmp[[pos+1]]=1
  ];
  tmp = tmp //. {NonCommutativeMultiply[a_, b_ + c_] :> NonCommutativeMultiply[a, b] + NonCommutativeMultiply[a, c],
    NonCommutativeMultiply[a_ + b_, c_] :> NonCommutativeMultiply[a, c] + NonCommutativeMultiply[b, c]};
  tmp = tmp //. {NonCommutativeMultiply[a__, 1, b___] :> NonCommutativeMultiply[a, b],
    NonCommutativeMultiply[a___, 1, b__] :> NonCommutativeMultiply[a, b]};
  tmp=ExpandAll[tmp];
  Grab[tmp]
]


(*
   Function: clearup[expr_NonCommutativeMultiply]
   Purpose: Re-express a pair of creation/annihilation operators as one of
     the stored GF symbols, adjusting the overall sign according to fermionic
     ordering.
   Algorithm:
     1. Remove the last annihilation operator from the string and append it to
        the end, tracking the sign change.
     2. Look up the resulting pair in gfs; if it exists, map it to the
        corresponding GFnames entry via corr, otherwise create a new GF entry
        and return its symbol.
*)
clearup[expr_NonCommutativeMultiply]:=Module[{i,tmp,mtpl=1,ret=expr,pos,p2,p1},
  (* need to find if there's new gf's, or replace with existing ones *)
  i=Length[expr];
  While[annihilation[expr[[i]]],i--];  (* there has to be at least one annihilation op, o.w. we r screwed *)
  ret=Delete[ret,i];
  ret=AppendTo[ret,expr[[i]]];	
  mtpl*=(-1)^(Length[expr]-i);
  
  p2=ret[[-1]];
  If[Length[ret]>2, p1=ret[[1;;-2]] ];
  If[Length[ret]==2,p1=ret[[1]] ];
  If[Length[ret]<2, symGFPrint["Error: can't clearup a too short expression:",ret]; Abort[] ];
  pos=Position[gfs,{purepattern[p1],purepattern[p2]}] ;
  If[Length[pos]>0,
    i=pos[[1,1]];
    mtpl*GFnames[[i]]/.corr[NonCommutativeMultiply[gfs[[i,1]],gfs[[i,2]]],ret]
    ,
    AppendTo[gfs, {uniquesub[p1], uniquesub[p2]}]; 
    AppendTo[solgf,{0,0,0}];
    AppendTo[GFnames, OverBar[symGFUnique["GF"]@@subs[NonCommutativeMultiply[gfs[[-1,1]],gfs[[-1,2]] ] ] ] ];
    mtpl*GFnames[[-1]]/.corr[NonCommutativeMultiply[gfs[[-1,1]],gfs[[-1,2]]],ret]
  ]
]

clearup[expr_Plus]:=Sum[clearup[expr[[i]]],{i,Length[expr]}]
clearup[expr_Times]:=Product[clearup[expr[[i]]],{i,Length[expr]}]
clearup[expr_]:=expr

(*
   Function: corr[a_OverHat,b_OverHat]
   Purpose: Build a list of replacement rules that align the subscripts of
     two operator expressions.
   Algorithm:
     1. Ensure both operators share the same structure; otherwise abort.
     2. When the head carries explicit subscripts, pair them one by one so the
        resulting rule set can map between the two forms.
   Inputs: a, b - operator expressions.
   Output: Replacement list.
*)
corr[a_OverHat,b_OverHat]:=Module[{i},
  If[Length[a[[1]]]!=Length[b[[1]]] || !MatchQ[a,purepattern[b]],
    symGFPrint["Error: parameters ",a," and ",b," in corr should be identical in form."];
    Abort[]
  ];
  If[Depth[a]==3,
    Table[a[[1,i]] -> b[[1,i]],{i,Length[a[[1]]]}]
    ,
    {}
  ]
]
corr[a_NonCommutativeMultiply,b_NonCommutativeMultiply]:=Union[Flatten[Table[corr[a[[i]],b[[i]]],{i,Length[a]}]]]

(*
   Function: FindTruncationRule[expr_]
   Purpose: Determine which truncation rule from trunclist matches the
     operator string expr.
   Algorithm:
     1. For each rule, count how many times each template operator from
        trunclist[[i,1]] occurs in expr.
     2. If the total count exceeds the threshold trunclist[[i,2]], return i.
     3. If no rule matches, return 0.
*)
FindTruncationRule[expr_]:=Module[{ret=0},
  Do[
    If[Total[Count[expr,trunclist[[i,1,j]]]& /@ Range[Length[trunclist[[i,1]]]]] > trunclist[[i,2]],
      ret=i;
      Return[ret]
    ],
    {i,Length[trunclist]}];
  ret
]
(*
   Function: LocateTruncationSlots[expr_,yid_]
   Purpose: For a given truncation rule (identified by yid), report which
     positions inside expr match the operator slots specified by the rule.
   Algorithm:
     1. Iterate over the rule's slot definitions stored in trunclist[[yid,3]].
     2. For each candidate pair {op1, op2}, record the positions where op1 and
        op2 occur in expr.
     3. Return {indexOfRuleEntry, positionsOfOp1, positionsOfOp2} for the
        first pair that simultaneously matches.
*)
LocateTruncationSlots[expr_,yid_]:=Module[{l1={},l2={},ret=0},
  Do[
    l1=Flatten[Position[expr,trunclist[[yid,3,i,1]] ] ];
    l2=Flatten[Position[expr,trunclist[[yid,3,i,2]] ] ];
    If[Length[l1]>0 && Length[l2]>0,
      ret=i;
      Return[{ret,l1,l2}]
    ],
    {i,Length[trunclist[[yid,3]]]}];
  {ret,l1,l2}
]

(*
   Function: solution[rhs_, dt_Integer, deltatimes_, gfListIndex_,1]
   Purpose: Evaluate the right-hand side when no isolated GF needs to be
     inserted (idxIGF==0). It rewrites each term as a previously known GF
     multiplied by the appropriate coefficient.
   Algorithm:
     1. Depending on dt (1 for annihilation-first, 2 for creation-first),
        locate the corresponding GF index via Position.
     2. For each term {operator, coef}, multiply coef by the mapped GF symbol,
        using corr to align subscripts between the stored gfs entry and the
        operator in rhs.
     3. Send the combined expression through dummy to ensure summation
        variables are tracked.
   Inputs: rhs - list of {operator, coefficient}; dt - slot indicator;
     deltatimes - unused in this branch; gfListIndex - current GF index.
   Output: Expression built from existing GFnames.
*)
solution[rhs_, dt_Integer, deltatimes_, gfListIndex_,1] := Module[{idxIGF, ret = 0,params={},pos,ee}, 
  If[rhs =!= 0,
    If[dt == 1, 
      pos[i_]:=Position[gfs,{purepattern[rhs[[i,1]]],purepattern[gfs[[gfListIndex,2]]]}][[1,1]];
      ret = Sum[rhs[[i,2]]*
        GFnames[[pos[i]]]/.
        corr[NonCommutativeMultiply[gfs[[pos[i],1]],gfs[[pos[i],2]]],NonCommutativeMultiply[rhs[[i,1]],gfs[[gfListIndex,2]]]]
        ,{i,Length[rhs]}] 
    ]; 
    If[dt == 2, 
      pos[i_]:=Position[gfs,{purepattern[gfs[[gfListIndex,1]]],purepattern[rhs[[i,1]]]}][[1,1]];
      ret = Sum[rhs[[i,2]]*
        GFnames[[pos[i]]]/.
        corr[NonCommutativeMultiply[gfs[[pos[i],1]],gfs[[pos[i],2]]],NonCommutativeMultiply[gfs[[gfListIndex,1]],rhs[[i,1]]]]
        ,{i,Length[rhs]}]
    ]; 
    dummy[ret]
    ,
    0
  ]
]
(*
   Function: solution[rhs_, dt_Integer, deltatimes_, gfListIndex_,0]
   Purpose: Handle equations where one of the terms is proportional to the
     GF being solved. The isolated GF (IGF) is separated out and its closed
     form is inserted explicitly.
   Algorithm:
     1. Call existself to identify which terms correspond to the self term and
        to retrieve the matching IGF index/parameters.
     2. Remove those terms from rhs and multiply the remaining ones by the IGF
        prefactor ee, mapping each operator to an existing GF as in the dt==1
        branch.
     3. If deltatimes is non-zero, add the direct contribution ee*deltatimes
        (simplified via Grab); finally call dummy.
   Inputs: rhs - list of terms; dt - slot indicator; deltatimes - inhomogeneous
     contribution; gfListIndex - current GF index.
   Output: Expression containing IGF factors and existing GFnames.
*)
solution[rhs_, dt_Integer, deltatimes_, gfListIndex_,0] := Module[{lstRHS, idxIGF, ret = 0,params={},pos,ee,newrhs}, 
  {lstRHS, idxIGF,params} = existself[rhs, dt, gfListIndex]; 
  (* symGFPrint["lstRHS=",lstRHS,"   idxIGF=",idxIGF,"  dt=",dt,"  params=",params]; *)
  If[lstRHS=={} || idxIGF==0, 
    ret = rhs
    ,
    If[params==={},
      ee=IGFs[[idxIGF,2]] ;
      ,
      ee=UnderBar[Apply[Head[IGFs[[idxIGF,2,1]]],params]];  (* to be replaced by "replace" *)
      (* ok when there's only one param *)
    ];
    lstRHS=Table[{lstRHS[[i]]},{i,Length[lstRHS]}];
    newrhs=Delete[rhs,lstRHS];
    If[dt == 1, 
      pos[i_]:=Position[gfs,{purepattern[newrhs[[i,1]]],purepattern[gfs[[gfListIndex,2]]]}][[1,1]];
      ret = Sum[newrhs[[i,2]]*ee*
        GFnames[[pos[i]]]/.
        corr[NonCommutativeMultiply[gfs[[pos[i],1]],gfs[[pos[i],2]]],NonCommutativeMultiply[newrhs[[i,1]],gfs[[gfListIndex,2]]]]
        ,{i,Length[newrhs]}]
    ]; 
    If[dt == 2, 
      pos[i_]:=Position[gfs,{purepattern[gfs[[gfListIndex,1]]],purepattern[newrhs[[i,1]]]}][[1,1]];
      ret = Sum[newrhs[[i,2]]*ee*
        GFnames[[pos[i]]]/.
        corr[NonCommutativeMultiply[gfs[[pos[i],1]],gfs[[pos[i],2]]],NonCommutativeMultiply[gfs[[gfListIndex,1]],newrhs[[i,1]]]]
        ,{i,Length[newrhs]}]
    ]; 
    If[deltatimes =!= 0, 
      ret += Grab[ExpandAll[ee*deltatimes]]
    ];
  ];
  dummy[ret]
]
dummy[0]:=0
dummy[expr_Plus]:=Sum[dummy[expr[[i]]],{i,Length[expr]}]
(*
   Function: dummy[expr_]
   Purpose: Ensure that every summation index appearing in expr is registered
     inside sumlist so later integrations know which variables can be summed.
   Algorithm:
     1. Traverse sumlist and check whether expr depends on each entry.
     2. When a dependence exists, rename the index to a fresh symbol and push
        it into sumlist so the substitution does not clash with existing
        integrals.
   Inputs: expr - expression to sanitize.
   Output: Updated expression with fresh dummy indices.
*)
dummy[expr_]:=Module[{ret=expr},
  Scan[
    Function[var,
      If[!FreeQ[ret,var],
        tok=symGFUnique["j"];
        ret=ret/.var->tok;
        AppendTo[sumlist,tok];
      ]
    ],
    sumlist
  ];
  ret
]
getparam[expr_Plus]:=Union[Flatten[Table[getparam[expr[[i]]],{i,Length[expr]}]]]
getparam[expr_Times]:=Union[Flatten[Table[getparam[expr[[i]]],{i,Length[expr]}]]]
getparam[expr_]:=If[Depth[expr]==2,Level[expr,1],{}]

(*
   Function: existself[rhs_, dt_, gfListIndex_]
   Purpose: Detect whether the RHS contains the same GF as on the LHS and, if
     so, determine which isolated GF should be associated with its
     coefficient.
   Algorithm:
     1. Locate entries whose operator part matches gfs[[gfListIndex,dt]].
     2. Sum their coefficients and attempt to match the result against the
        list of previously registered IGFs; if not found, create a new IGF
        entry using the parameters extracted from the coefficient.
     3. Return the positions of the self terms, the IGF index, and the list of
        parameters so solution can insert the IGF explicitly.
   Inputs: rhs - list of {operator, coefficient}; dt - slot selector;
     gfListIndex - index of the GF currently being solved.
   Output: {indicesOfSelfTerms, IGFindex, parameterList}.
*)
existself[rhs_, dt_, gfListIndex_] := Module[{lstRHS, lstIGF = 0, i,j,params={},coef }, 
  (* tmp = Flatten[Position[rhs, purepattern[gfs[[gfListIndex,dt]]]]]; *)
  
  lstRHS=Flatten[  Position[rhs[[All,1]],purepattern[gfs[[gfListIndex,dt]] ], 1 ]  ];
  If[Length[lstRHS]==0, 
    symGFPrint["Warning: this GF cannot derive itself. solution temporarily set to zero."]
    ,
    (* go on with the sum of coeff's *)
    coef=ExpandAll[ Total[  rhs[[lstRHS,2]] ] ];
    lstIGF=Flatten[ Position[ IGFs[[All,1]] , purepattern[coef] ,1 ] ];
    If[Length[lstIGF]>1,
      symGFPrint["Error: multiple (seudo)IGF's correspond to the same coefficient: ",IGFs[[lstIGF]]," have ",coef];
      Abort[]
    ];
    params=getparam[coef];
    If[Length[lstIGF]==1,
      (* IGF found *)
      lstIGF=lstIGF[[1]]
      ,
      (* not found, add it *)
      AppendTo[IGFs,{coef,UnderBar[symGFUnique["gi"]@@params  ]  }];
      lstIGF=Length[IGFs]
    ]			
  ];
  
  (*	If[Length[params]>1,
  symGFPrint["Temporary Error: more than one parameters not supported for isolated GF now. ",params];
];  *)
  {lstRHS,lstIGF,params}
]
loadNewGF[0,a__]:={}
(*
   Function: loadNewGF[rhs_List, dt_Integer, gfListIndex_]
   Purpose: Inspect the RHS of an equation and register any new Green's
     functions that appear so their equations will be derived later.
   Algorithm:
     1. For each term, construct the operator pair expected for dt==1 or
        dt==2 and check whether it already exists in gfs.
     2. When a new pair is found, append it to gfs, allocate a placeholder in
        solgf, and create a corresponding GFnames entry with symGFUnique.
   Inputs: rhs - list of {operator, coefficient}; dt - slot selector;
     gfListIndex - current GF index (used to know which partner operator to
     pair with).
   Output: Number of newly added GFs (stored in c) and, indirectly, updated
     gfs/solgf/GFnames.
*)
loadNewGF[rhs_List, dt_Integer, gfListIndex_] := Module[{c = 0,op}, 
  If[dt != 1 && dt != 2, symGFPrint["wth?? dt=", dt]]; 
  Do[
    If[dt == 1 && FreeQ[gfs, {purepattern[rhs[[i,1]]], purepattern[gfs[[gfListIndex,2]]]}], 
      op={uniquesub[rhs[[i,1]]], uniquesub[gfs[[gfListIndex,2]]]};
      AppendTo[gfs,op]; 
      AppendTo[solgf, {0, 0, 0}]; 
      AppendTo[GFnames, OverBar[symGFUnique["GF"]@@subs[NonCommutativeMultiply[gfs[[-1,1]],gfs[[-1,2]] ] ] ] ];
      c++
    ]; 
    If[dt == 2 && FreeQ[gfs, {purepattern[gfs[[gfListIndex,1]]], purepattern[rhs[[i,1]]]}], 
      op={uniquesub[gfs[[gfListIndex,1]]], uniquesub[rhs[[i,1]]]};
      AppendTo[gfs,op];
      AppendTo[solgf, {0, 0, 0}];
      AppendTo[GFnames, OverBar[symGFUnique["GF"]@@subs[NonCommutativeMultiply[gfs[[-1,1]],gfs[[-1,2]] ] ] ] ];
      c++
    ],
    {i,Length[rhs]}
  ]; 
  
  If[Length[gfs]!=Length[solgf],symGFPrint["Error: Length of gfs and solgf not equal. ",Length[gfs]," and ",Length[solgf]];
    Abort[] ];
  (*symGFPrint["tick3"];*)
  If[dt==1,
    Cases[ Table[Flatten[Position[gfs,{purepattern[rhs[[i,1]]],purepattern[gfs[[gfListIndex,2]]]}]] [[1]],{i,Length[rhs]}], Except[gfListIndex]    ]
    ,
    Cases[ Table[Flatten[Position[gfs,{purepattern[gfs[[gfListIndex,1]]],purepattern[rhs[[i,1]]]}]] [[1]],{i,Length[rhs]}], Except[gfListIndex]    ]
  ]
]
subscriptedQ[op_OverHat] := If[Depth[op] == 2, False, True]
subscriptedQ[op_] := If[Depth[op] == 1, False, True]
script2blank[op_OverHat] := If[subscriptedQ[op], OverHat[op[[1,0]] @@ Table[_, {Length[op[[1]]]}]], op]
script2unique[op_OverHat] := If[subscriptedQ[op], OverHat[op[[1,0]] @@ Table[symGFUnique["i"], {Length[op[[1]]]}]], op]

purepattern[expr_OverHat] := script2blank[expr]; 
purepattern[expr_NonCommutativeMultiply] := NonCommutativeMultiply @@ Table[script2blank[expr[[i]]], {i, Length[expr]}]
purepattern[expr_Plus]:=Sum[purepattern[expr[[i]]],{i,Length[expr]}]
purepattern[expr_Times]:=Product[purepattern[expr[[i]]],{i,Length[expr]}]
purepattern[expr_UnderBar]:=UnderBar[purepattern[expr[[1]]]]
(*purepattern[expr_OverBar]:=If[Depth[expr]==3,OverBar[Apply[expr[[1,0]],Table[Blank[],{Length[expr[[1]]]}]]],expr]*)
purepattern[expr_OverBar]:=OverBar[purepattern[expr[[1]] ]  ]
purepattern[expr_OverTilde]:=OverTilde[purepattern[expr[[1]] ]  ]
purepattern[expr_] := If[Depth[expr] >= 2, expr[[0]] @@ Table[_, {Length[expr]}], expr]

uniquesub[expr_OverHat] := script2unique[expr]; 
uniquesub[expr_NonCommutativeMultiply] := NonCommutativeMultiply @@ Table[script2unique[expr[[i]]], {i, Length[expr]}]

DropRepeatedOperators[expr_Plus]:=Sum[ DropRepeatedOperators[expr[[i]] ],{i,Length[expr]} ]
DropRepeatedOperators[expr_Times]:=Product[ DropRepeatedOperators[expr[[i]] ],{i,Length[expr] } ]
DropRepeatedOperators[expr_NonCommutativeMultiply]:=If[twoidentical[expr],0,expr]
DropRepeatedOperators[expr_]:=expr
(*
   Function: anticom[a_, b_]
   Purpose: anticom[a_, b_] evaluates the anti-commutator {a, b}.
   Inputs: follows the pattern shown in anticom[a_, b_].
   Output: See Purpose for how the result is used.
*)
anticom[a_, b_] := Module[{kk}, 
  kk = anticommutator[a, b]//ExpandAll;
  kk=Grab[kk];
  kk=SortOperatorProducts[kk];
  DropRepeatedOperators[kk]
]
(*
   Function: com[a_, b_]
   Purpose: com[a_, b_] evaluates the commutator [a, b].
   Inputs: follows the pattern shown in com[a_, b_].
   Output: See Purpose for how the result is used.
*)
com[a_, b_] := Module[{kk}, 
  kk = commutator[a, b]//ExpandAll;
  kk=Grab[kk];
  kk=SortOperatorProducts[kk];
  DropRepeatedOperators[kk]
]
(*
   Function: com2[a_,b_]
   Purpose: com2[a_, b_] is a lightweight commutator wrapper returning an unsimplified expression.
   Inputs: follows the pattern shown in com2[a_,b_].
   Output: See Purpose for how the result is used.
*)
com2[a_,b_]:=Module[{kk},kk=commutator[a,b]//ExpandAll;Grab[kk] ]
(*
   Function: Grab[expr_]
   Purpose: Grab[expr_] expands non-commutative products into sums with explicit deltas.
   Inputs: follows the pattern shown in Grab[expr_].
   Output: See Purpose for how the result is used.
*)
Grab[expr_]:=Module[{tt},
  tt=grab[expr];   (* grab for getting **'s out and sum up delta's; there should be no Plus within parenthases *)
  grab3[tt]	(* grab3 for adding out kroneckerdelta's  ??? why ????  *)
]
(*
   Function: grab[kk_]
   Purpose: Expand a non-commutative expression into sums/products where the
     fermionic operators have been separated from the scalar coefficients.
   Algorithm:
     1. If kk is a sum, process each term individually; otherwise treat the
        entire expression.
     2. Locate all OverHat operators, collect them into a NonCommutativeMultiply
        block, and multiply the remaining scalars together.
     3. Return the list (or product) of reconstructed terms that now have the
        operator part factored out.
*)
grab[kk_] := Module[{terms, s, pos, t, lst, token, i, j, th}, 
  terms = {}; 
  If[kk[[0]] == Plus, 
    Do[
      t = kk[[i]];
      pos = Position[t, OverHat]; 
      lst = Table[pos[[ti,1 ;; -2]], {ti, Length[pos]}]; 
      s = {}; 
      Do[AppendTo[s, Extract[t, lst[[j]]]],{j,Length[lst]}]; 
      If[Length[s] > 1, s[[0]] = NonCommutativeMultiply]; 
      If[Length[s] == 1, s[[0]] = Times]; 
      t = Delete[t, lst]; 
      t = t //. NonCommutativeMultiply -> Times; 
      t = t*s; 
      (*			For[j = 1, j <= Length[sumlist], j++, 
      token = sumlist[[j]]; 
      If[summable[t, token] == True, 
      t=Integrate[t,{token,-Infinity,Infinity},Assumptions->Element[Level[t,{-1}],Reals]];
    ]
    ]; *)
      AppendTo[terms, t];
      ,{i,Length[kk]}]; 
    terms[[0]] = Plus
  ]; 
  
  If[kk[[0]] == Times || kk[[0]] == NonCommutativeMultiply, 
    th = kk[[0]]; 
    t = kk; 
    pos = Position[t, OverHat]; 
    lst = Table[pos[[ti,1 ;; -2]], {ti, Length[pos]}];
    s = {}; 
    Do[AppendTo[s, Extract[t, lst[[j]]]],{j,Length[lst]}]; 
    If[Length[s] > 1, s[[0]] = NonCommutativeMultiply]; 
    If[Length[s] == 1, s[[0]] = Times]; 
    t = Delete[t, lst]; 
    t = t //. NonCommutativeMultiply -> Times; 
    t = t*s; 
    (*		For[j = 1, j <= Length[sumlist], j++, 
    token = sumlist[[j]]; 
    If[summable[t, token] == True, 
    t=Integrate[t,{token,-Infinity,Infinity},Assumptions->Element[Level[t,{-1}],Reals]];
  ]
  ]; *)
    AppendTo[terms, t]; 
    If[Length[terms] > 1, terms[[0]] = th, terms[[0]] = Times]; 
  ]; 
  If[terms == {}, terms = kk]; 
  terms
]
grab2[expr_Plus]:=Sum[grab2[expr[[i]]],{i,Length[expr]}]
grab2[expr_Times]:=Product[grab2[expr[[i]]],{i,Length[expr]}]
(*
   Function: grab2[expr_NonCommutativeMultiply]
   Purpose: grab2[expr_] rearranges NonCommutativeMultiply factors into canonical order.
   Inputs: follows the pattern shown in grab2[expr_NonCommutativeMultiply].
   Output: See Purpose for how the result is used.
*)
grab2[expr_NonCommutativeMultiply]:=Module[{times={},nt={},i},
  Do[
    If[Head[expr[[i]]]===OverHat,
      AppendTo[nt,expr[[i]]],
      AppendTo[times,expr[[i]]]
    ],
    {i,Length[expr]}
  ];
  If[Length[nt]>1,
    Times@@times * NonCommutativeMultiply@@nt
    ,
    If[Length[nt]==1,
      Times@@times * nt[[1]]
      ,
      Times@@times
    ]
  ]
]
grab2[expr_]:=expr
grab3[expr_Plus]:=Sum[grab3[expr[[i]]],{i,Length[expr]}]
(*
   Function: grab3[expr_Times]
   Purpose: grab3[expr_] integrates over declared summation indices when possible.
   Inputs: follows the pattern shown in grab3[expr_Times].
   Output: See Purpose for how the result is used.
*)
grab3[expr_Times]:=Module[{i,te=expr,j,pospow},
  (*	If[FreeQ[expr,Power],
  For[i=1,i<=Length[sumlist],i++,
  If[summable[te,sumlist[[i]] ],
  te=Integrate[te,{sumlist[[i]],-Infinity,Infinity},Assumptions->Element[Level[te,{-1}],Reals]];
]
];
  te
  ,
  pospow=Flatten[Position[expr,_Power,1]];  
  If[Length[pospow]==0,
  symGFPrint["Error: this must be a mathematica bug :("];
  Abort[]
];
  grab3[Delete[expr,Table[{pospow[[j]]},{j,Length[pospow]}] ]]*
  Product[Power[grab3[ expr[[pospow[[j]],1]]],expr[[ pospow[[j]],2]]  ],{j,Length[pospow]} ]
] *)
  Do[
    If[summable[te,sumlist[[i]] ],
      te=Integrate[te,{sumlist[[i]],-Infinity,Infinity},Assumptions->Element[Level[te,{-1}],Reals]];
    ],
    {i,Length[sumlist]}
  ];
  te
]
(*grab3[expr_Power]:=Power[grab3[ expr[[1]] ], expr[[2]] ]*)
grab3[e_]:=e
(*
   Function: summable[t_, token_]
   Purpose: summable[expr_, var_] returns True if expr contains DiracDelta tying var.
   Inputs: follows the pattern shown in summable[t_, token_].
   Output: See Purpose for how the result is used.
*)
summable[t_, token_] := Module[{k1, k2},
  If[FreeQ[sumlist, token],
    False,
    k1 = Position[t, token];
    k2 = Position[t, DiracDelta];
    AnyTrue[k1, Function[p1, AnyTrue[k2, (p1[[1 ;; Length[#] - 1]] == #[[1 ;; Length[#] - 1]]) &]]]
  ]
]
(*
   Function: privatecomm[a_, b_]
   Purpose: Evaluate the commutator or anti-commutator between two single
     operators using the custom rulelist supplied via SetRules.
   Algorithm:
     1. Scan rulelist until a pattern matches {a,b} or {b,a}.
     2. When a match is found, apply the stored replacement (Rule or
        RuleDelayed) and respect the sign stored in rule[[4]] (0 for
        anti-commutator, 1 for commutator).
   Inputs: a, b - OverHat operators.
   Output: Replacement expression or 0 when no rule matches.
*)
privatecomm[a_, b_] := Module[{t = 0},
  Scan[
    Function[rule,
      If[t =!= 0, Return[]];
      Module[{rep = rule[[3]], lhs = rule[[1]]*rule[[2]], apply},
        apply[expr_] := Which[
          Head[rep] === Rule || Head[rep] === RuleDelayed, expr /. rep,
          True, expr /. (lhs :> rep)
        ];
        Which[
          MatchQ[a, rule[[1]]] && MatchQ[b, rule[[2]]], t = apply[a*b],
          MatchQ[a, rule[[2]]] && MatchQ[b, rule[[1]]],
          t = If[TrueQ[rule[[4]] == 0], -apply[b*a], apply[b*a]]
        ]
      ]
    ],
    rulelist
  ];
  t
]
commutator[a_Plus,b_Plus]:=Sum[commutator[a[[i]],b[[j]] ],{i,Length[a]},{j,Length[b]}]
commutator[a_Plus,b_]:=Sum[commutator[a[[i]],b],{i,Length[a]}]
commutator[a_,b_Plus]:=Sum[commutator[a,b[[i]]],{i,Length[b]}]
commutator[a_OverHat,b_OverHat]:=privatecomm[a[[1]],b[[1]]]
commutator[a_OverHat,b_NonCommutativeMultiply]:=SortOperatorProducts[NonCommutativeMultiply[a,b]-NonCommutativeMultiply[b,a]]
commutator[a_NonCommutativeMultiply,b_OverHat]:=SortOperatorProducts[NonCommutativeMultiply[a,b]-NonCommutativeMultiply[b,a]]
commutator[a_NonCommutativeMultiply,b_NonCommutativeMultiply]:=SortOperatorProducts[NonCommutativeMultiply[a,b]-NonCommutativeMultiply[b,a]]
(*
   Function: commutator[a_Times,b_]
   Purpose: commutator[a_, b_] implements the commutator recursively on various expression types.
   Inputs: follows the pattern shown in commutator[a_Times,b_].
   Output: See Purpose for how the result is used.
*)
commutator[a_Times,b_]:=Module[{pos},
  If[!FreeQ[a,OverHat],pos=Position[a,_OverHat]];
  If[!FreeQ[a,NonCommutativeMultiply],pos=Position[a,_NonCommutativeMultiply]];
  If[Length[pos]>1,
    symGFPrint["Error: operators must be non-commutatively arranged in ",a];
    Abort[];
  ];
  Delete[a,pos]*commutator[Extract[a,pos][[1]],b]
]
(*
   Function: commutator[a_,b_Times]
   Purpose: commutator[a_, b_] implements the commutator recursively on various expression types.
   Inputs: follows the pattern shown in commutator[a_,b_Times].
   Output: See Purpose for how the result is used.
*)
commutator[a_,b_Times]:=Module[{pos},
  If[!FreeQ[b,OverHat],pos=Position[b,_OverHat]];
  If[!FreeQ[b,NonCommutativeMultiply],pos=Position[b,_NonCommutativeMultiply]];
  If[Length[pos]>1,
    symGFPrint["Error: operators must be non-commutatively arranged in ",b];
    Abort[];
  ];
  Delete[b,pos]*commutator[a,Extract[b,pos][[1]]]
]
anticommutator[a_Plus,b_Plus]:=Sum[commutator[a[[i]],b[[j]] ],{i,Length[a]},{j,Length[b]}]
anticommutator[a_Plus,b_]:=Sum[commutator[a[[i]],b],{i,Length[a]}]
anticommutator[a_,b_Plus]:=Sum[commutator[a,b[[i]]],{i,Length[b]}]
anticommutator[a_OverHat,b_OverHat]:=privatecomm[a[[1]],b[[1]]]
anticommutator[a_OverHat,b_NonCommutativeMultiply]:=SortOperatorProducts[NonCommutativeMultiply[a,b]+NonCommutativeMultiply[b,a]]
anticommutator[a_NonCommutativeMultiply,b_OverHat]:=SortOperatorProducts[NonCommutativeMultiply[a,b]+NonCommutativeMultiply[b,a]]
anticommutator[a_NonCommutativeMultiply,b_NonCommutativeMultiply]:=SortOperatorProducts[NonCommutativeMultiply[a,b]-NonCommutativeMultiply[b,a]]
(*
   Function: anticommutator[a_Times,b_]
   Purpose: Recursively expand an anti-commutator when the left argument is a
     product, extracting the operator that participates in the non-commutative
     part.
   Algorithm: Find the first OverHat/NonCommutativeMultiply factor inside a,
     remove it, and call anticommutator on that factor and b while multiplying
     by the remaining scalars.
*)
anticommutator[a_Times,b_]:=Module[{pos},
  If[!FreeQ[a,OverHat],pos=Position[a,_OverHat]];
  If[!FreeQ[a,NonCommutativeMultiply],pos=Position[a,_NonCommutativeMultiply]];
  If[Length[pos]>1,
    symGFPrint["Error: operators must be non-commutatively arranged in ",a];
    Abort[];
  ];
  Delete[a,pos]*commutator[Extract[a,pos][[1]],b]
]
(*
   Function: anticommutator[a_,b_Times]
   Purpose: Symmetric to the previous definition but extracting the operator
     from the right-hand product.
   Algorithm: Identify the operator factor inside b, remove it, and multiply
     the result by the remaining scalars while recursing.
*)
anticommutator[a_,b_Times]:=Module[{pos},
  If[!FreeQ[b,OverHat],pos=Position[b,_OverHat]];
  If[!FreeQ[b,NonCommutativeMultiply],pos=Position[b,_NonCommutativeMultiply]];
  If[Length[pos]>1,
    symGFPrint["Error: operators must be non-commutatively arranged in ",b];
    Abort[];
  ];
  Delete[b,pos]*commutator[a,Extract[b,pos][[1]]]
]

(*
   Function: Commutator[a_, b_]
   Purpose: Commutator[a_, b_] is the public commutator wrapper (kept for compatibility).
   Inputs: follows the pattern shown in Commutator[a_, b_].
   Output: See Purpose for how the result is used.
*)
Commutator[a_, b_] := Module[{tmp = 0, tn, did, biaochengfa, pos, branch, i, j, coe}, 
  If[Head[a] == Plus, tmp = Sum[Commutator[a[[i]], b], {i, Length[a]}]  ]; 
  If[Head[a] == Times, 
    tmp = NonCommutativeMultiply[a[[1]],Commutator[Times[a[[2 ;; Length[a]]]], b]] - 
    NonCommutativeMultiply[Commutator[b, a[[1]]],Times[a[[2 ;; Length[a]]]]]
  ]; 
  If[Head[a] == NonCommutativeMultiply, 
    tn = NonCommutativeMultiply[a[[2 ;; Length[a]]]]; 
    If[Length[tn] == 1, tn = tn[[1]]]; 
    tmp = NonCommutativeMultiply[a[[1]],Commutator[tn, b]] - NonCommutativeMultiply[Commutator[b, a[[1]]],tn]
  ]; 
  If[Head[b] == Plus, tmp = Sum[Commutator[a, b[[i]]], {i, Length[b]}]  ]; 
  If[Head[b] == Times, 
    tmp = NonCommutativeMultiply[Commutator[a, b[[1]]],Times[b[[2 ;; Length[b]]]]] - 
    NonCommutativeMultiply[b[[1]],Commutator[Times[b[[2 ;; Length[b]]]], a]]
  ]; 
  If[Head[b] == NonCommutativeMultiply, 
    tn = NonCommutativeMultiply[b[[2 ;; Length[b]]]]; 
    If[Length[tn] == 1, tn = tn[[1]]]; 
    tmp = NonCommutativeMultiply[Commutator[a, b[[1]]],tn] - NonCommutativeMultiply[b[[1]],Commutator[tn, a]]
  ]; 
  If[Head[b] == Plus, tmp = Sum[Commutator[a, b[[i]]], {i, Length[b]}]  ]; 
  If[Head[a] == OverHat && Head[b] == OverHat, tmp = privatecomm[a[[1]], b[[1]] ]  ]; 
  tmp = Expand[tmp]; 
  symGFPrint["ceng jing: ", a,"  ",b,"   ",tmp];
  tmp //. {NonCommutativeMultiply[aa_, bb_ + cc_] :> NonCommutativeMultiply[aa, bb] + NonCommutativeMultiply[aa, cc],
    NonCommutativeMultiply[aa_ + bb_, cc_] :> NonCommutativeMultiply[aa, cc] + NonCommutativeMultiply[bb, cc],
    NonCommutativeMultiply[Times[aa_, bb_], cc_] :> NonCommutativeMultiply[aa, bb, cc],
    NonCommutativeMultiply[aa_, Times[bb_, cc_]] :> NonCommutativeMultiply[aa, bb, cc],
    NonCommutativeMultiply[bb___, 0, cc___] :> 0 }
]
(*
   Function: SortOperatorProducts[expr_NonCommutativeMultiply]
   Purpose: SortOperatorProducts[expr_] sorts operator products into canonical order.
   Inputs: follows the pattern shown in SortOperatorProducts[expr_NonCommutativeMultiply].
   Output: See Purpose for how the result is used.
*)
SortOperatorProducts[expr_NonCommutativeMultiply] := Module[{i = 1, tmp = expr, ret = expr}, 
  While[i < Length[expr] && OrderedQ[{expr[[i]], expr[[i + 1]]}], i++]; 
  If[i < Length[expr], 
    (* for safety, here we can replace tmp's head with list and then put it back *)
    tmp[[i]] = privatecomm[expr[[i,1]], expr[[i + 1,1]]] - NonCommutativeMultiply[expr[[i + 1]],expr[[i]]];  (* this applies only to fermions *)
    tmp[[i + 1]] = 1; 
    tmp = tmp //. {NonCommutativeMultiply[a__,1,b___] :> NonCommutativeMultiply[a,b],
      NonCommutativeMultiply[a___,1,b__] :> NonCommutativeMultiply[a,b]}; 
    If[Length[tmp]==1, tmp=tmp[[1]] ];
    tmp = tmp //. {NonCommutativeMultiply[b___,0,a___] :> 0}; 
    tmp = tmp //. {NonCommutativeMultiply[a_, b_ + c_] :> NonCommutativeMultiply[a, b] + NonCommutativeMultiply[a, c],
      NonCommutativeMultiply[a_ + b_, c_] :> NonCommutativeMultiply[a, c] + NonCommutativeMultiply[b, c]}; 
    tmp = grab[tmp]; 
    ret = SortOperatorProducts[tmp]
  ]; 
  ret
]
SortOperatorProducts[expr_Plus] := Sum[SortOperatorProducts[expr[[i]]], {i, Length[expr]}]
SortOperatorProducts[expr_Times] := Product[SortOperatorProducts[expr[[i]]], {i, Length[expr]}]
SortOperatorProducts[expr_] := expr

Protect[Commutator];
End[]; 
EndPackage[]; 
