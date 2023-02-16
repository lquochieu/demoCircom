pragma circom 2.0.0;
include "../../node_modules/circomlib/circuits/comparators.circom";
template Multiplier2() {
    signal input a;
    signal input b;
    signal input c;
    
    component gt = GreaterEqThan(32);
    gt.in[0] <== a * b;
    gt.in[1] <== c;
    gt.out === 1;
 }

 component main{public[c]} = Multiplier2();