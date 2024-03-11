(* GSL interface *)

ClearAll["GSLLink`*"];

BeginPackage["WolframExternalFunctions`GSLLink`"];

gslComplexRect::usage = "gslComplexRect[re,im] returns the complex number re + I im.";
gslComplexPolar::usage = "gslComplexPolar[r,theta] returns the complex number r Exp[I theta].";
gslComplexArg::usage = "gslComplexArg[z] returns the argument of the complex number z.";
gslComplexAbs::usage = "gslComplexAbs[z] returns the absolute value of the complex number z.";
gslComplexAbs2::usage = "gslComplexAbs2[z] returns the square of the absolute value of the complex number z.";
gslComplexLogAbs::usage = "gslComplexLogAbs[z] returns the natural logarithm of the absolute value of the complex number z.";
gslComplexAdd::usage = "gslComplexAdd[z1,z2] returns the sum of the complex numbers z1 and z2.";
gslComplexSub::usage = "gslComplexSub[z1,z2] returns the difference of the complex numbers z1 and z2.";
gslComplexMul::usage = "gslComplexMul[z1,z2] returns the product of the complex numbers z1 and z2.";
gslComplexDiv::usage = "gslComplexDiv[z1,z2] returns the quotient of the complex numbers z1 and z2.";
gslComplexAddReal::usage = "gslComplexAddReal[z,x] returns the sum of the complex number z and the real number x.";
gslComplexSubReal::usage = "gslComplexSubReal[z,x] returns the difference of the complex number z and the real number x.";
gslComplexMulReal::usage = "gslComplexMulReal[z,x] returns the product of the complex number z and the real number x.";
gslComplexDivReal::usage = "gslComplexDivReal[z,x] returns the quotient of the complex number z and the real number x.";
gslComplexAddImag::usage = "gslComplexAddImag[z,y] returns the sum of the complex number z and the imaginary number y.";
gslComplexSubImag::usage = "gslComplexSubImag[z,y] returns the difference of the complex number z and the imaginary number y.";
gslComplexMulImag::usage = "gslComplexMulImag[z,y] returns the product of the complex number z and the imaginary number y.";
gslComplexDivImag::usage = "gslComplexDivImag[z,y] returns the quotient of the complex number z and the imaginary number y.";
gslComplexConjugate::usage = "gslComplexConjugate[z] returns the complex conjugate of the complex number z.";
gslComplexInverse::usage = "gslComplexInverse[z] returns the inverse of the complex number z.";
gslComplexNegative::usage = "gslComplexNegative[z] returns the negative of the complex number z.";

gslMatrixAlloc::usage = "gslMatrixAlloc[m,n] returns a pointer to a new m x n matrix.";
gslMatrixCAlloc::usage = "gslMatrixCAlloc[m,n] returns a pointer to a new m x n matrix initialized to zero.";
gslMatrixFree::usage = "gslMatrixFree[m] frees the memory associated with the matrix m.";
gslMatrixGet::usage = "gslMatrixGet[m,i,j] returns the element at row i and column j of the matrix m.";
gslMatrixSet::usage = "gslMatrixSet[m,i,j,x] sets the element at row i and column j of the matrix m to x.";
gslMatrixPtr::usage = "gslMatrixPtr[m,i,j] returns a pointer to the element at row i and column j of the matrix m.";
gslMatrixSetAll::usage = "gslMatrixSetAll[m,x] sets all elements of the matrix m to x.";
gslMatrixSetZero::usage = "gslMatrixSetZero[m] sets all elements of the matrix m to zero.";
gslMatrixSetIdentity::usage = "gslMatrixSetIdentity[m] sets the matrix m to the identity matrix.";
gslLinalgCholeskyDecomp1::usage = "gslLinalgCholeskyDecomp[m] computes the Cholesky decomposition of the matrix m.";

Begin["`Private`"];

this = DirectoryName[ $InputFileName ];
lib = FileNameJoin[{this,"Libraries",$SystemID,"libgsl.27.dylib"}];

(* types *)
GSLCOMPLEX = {"CDouble", "CDouble"};
GSLBLOCK =  { "CSizeT", "RawPointer"::["CDouble"]};
GSLMATRIX = {"CSizeT", "CSizeT", "CSizeT", "RawPointer"::["CDouble"], "RawPointer"::[GSLBLOCK], "CInt"};

(* error handling *)
(* complex numbers *)
gslComplexRect = ForeignFunctionLoad[lib, "gsl_complex_rect", {"CDouble", "CDouble"} -> GSLCOMPLEX];
gslComplexPolar = ForeignFunctionLoad[lib, "gsl_complex_polar", {"CDouble", "CDouble"} -> GSLCOMPLEX];
gslComplexArg = ForeignFunctionLoad[lib, "gsl_complex_arg", {GSLCOMPLEX} -> "CDouble"];
gslComplexAbs = ForeignFunctionLoad[lib, "gsl_complex_abs", {GSLCOMPLEX} -> "CDouble"];
gslComplexAbs2 = ForeignFunctionLoad[lib, "gsl_complex_abs2", {GSLCOMPLEX} -> "CDouble"];
gslComplexLogAbs = ForeignFunctionLoad[lib, "gsl_complex_logabs", {GSLCOMPLEX} -> "CDouble"];
gslComplexAdd = ForeignFunctionLoad[lib, "gsl_complex_add", {GSLCOMPLEX, GSLCOMPLEX} -> GSLCOMPLEX];
gslComplexSub = ForeignFunctionLoad[lib, "gsl_complex_sub", {GSLCOMPLEX, GSLCOMPLEX} -> GSLCOMPLEX];
gslComplexMul = ForeignFunctionLoad[lib, "gsl_complex_mul", {GSLCOMPLEX, GSLCOMPLEX} -> GSLCOMPLEX];
gslComplexDiv = ForeignFunctionLoad[lib, "gsl_complex_div", {GSLCOMPLEX, GSLCOMPLEX} -> GSLCOMPLEX];
gslComplexAddReal = ForeignFunctionLoad[lib, "gsl_complex_add_real", {GSLCOMPLEX, "CDouble"} -> GSLCOMPLEX];
gslComplexSubReal = ForeignFunctionLoad[lib, "gsl_complex_sub_real", {GSLCOMPLEX, "CDouble"} -> GSLCOMPLEX];
gslComplexMulReal = ForeignFunctionLoad[lib, "gsl_complex_mul_real", {GSLCOMPLEX, "CDouble"} -> GSLCOMPLEX];
gslComplexDivReal = ForeignFunctionLoad[lib, "gsl_complex_div_real", {GSLCOMPLEX, "CDouble"} -> GSLCOMPLEX];
gslComplexAddImag = ForeignFunctionLoad[lib, "gsl_complex_add_imag", {GSLCOMPLEX, "CDouble"} -> GSLCOMPLEX];
gslComplexSubImag = ForeignFunctionLoad[lib, "gsl_complex_sub_imag", {GSLCOMPLEX, "CDouble"} -> GSLCOMPLEX];
gslComplexMulImag = ForeignFunctionLoad[lib, "gsl_complex_mul_imag", {GSLCOMPLEX, "CDouble"} -> GSLCOMPLEX];
gslComplexDivImag = ForeignFunctionLoad[lib, "gsl_complex_div_imag", {GSLCOMPLEX, "CDouble"} -> GSLCOMPLEX];
gslComplexConjugate = ForeignFunctionLoad[lib, "gsl_complex_conjugate", {GSLCOMPLEX} -> GSLCOMPLEX];
gslComplexInverse = ForeignFunctionLoad[lib, "gsl_complex_inverse", {GSLCOMPLEX} -> GSLCOMPLEX];
gslComplexNegative = ForeignFunctionLoad[lib, "gsl_complex_negative", {GSLCOMPLEX} -> GSLCOMPLEX];

(* matrices *)

gslMatrixAlloc = ForeignFunctionLoad[lib, "gsl_matrix_alloc", {"CSizeT", "CSizeT"} -> "RawPointer"::[GSLMATRIX]];
gslMatrixCAlloc = ForeignFunctionLoad[lib, "gsl_matrix_calloc", {"CSizeT", "CSizeT"} -> "RawPointer"::[GSLMATRIX]];
gslMatrixFree = ForeignFunctionLoad[lib, "gsl_matrix_free", {"RawPointer"::[GSLMATRIX]} -> "Void"];

gslMatrixGet = ForeignFunctionLoad[lib, "gsl_matrix_get", {"RawPointer"::[GSLMATRIX], "CSizeT", "CSizeT"} -> "CDouble"];
gslMatrixSet = ForeignFunctionLoad[lib, "gsl_matrix_set", {"RawPointer"::[GSLMATRIX], "CSizeT", "CSizeT", "CDouble"} -> "Void"];
gslMatrixPtr = ForeignFunctionLoad[lib, "gsl_matrix_ptr", {"RawPointer"::[GSLMATRIX], "CSizeT", "CSizeT"} -> "RawPointer"::["CDouble"]];

gslMatrixSetAll = ForeignFunctionLoad[lib, "gsl_matrix_set_all", {"RawPointer"::[GSLMATRIX], "CDouble"} -> "Void"];
gslMatrixSetZero = ForeignFunctionLoad[lib, "gsl_matrix_set_zero", {"RawPointer"::[GSLMATRIX]} -> "Void"];
gslMatrixSetIdentity = ForeignFunctionLoad[lib, "gsl_matrix_set_identity", {"RawPointer"::[GSLMATRIX]} -> "Void"];

gslLinalgCholeskyDecomp1 = ForeignFunctionLoad[lib, "gsl_linalg_cholesky_decomp1", {"RawPointer"::[GSLMATRIX]} -> "CInt"];

End[];

EndPackage[];