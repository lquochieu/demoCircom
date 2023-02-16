pragma circom 2.0.0;

template linear() {
    signal input a;
    signal input b;
    signal input k;
    signal output c;
    c <== a*b + k;
 }

 component main {public [k]} = linear();