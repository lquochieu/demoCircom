pragma circom 2.0.0;
include "ageCalculation.circom";
include "../../node_modules/circomlib/circuits/comparators.circom";
include "../../node_modules/circomlib/circuits/eddsaposeidon.circom";

template VerifyAge() {
    signal input DoB;
    signal input currentDay;
    signal input currentMonth;
    signal input currentYear;

    signal input minAge;
    signal input maxAge;

    signal input pubKey[2];
    signal input S;
    signal input R8x;
    signal input R8y;

    component verifier = EdDSAPoseidonVerifier();
    verifier.enabled <== 1;
    verifier.Ax <== pubKey[0];
    verifier.Ay <== pubKey[1];
    verifier.S <== S;
    verifier.R8x <== R8x;
    verifier.R8y <== R8y;
    verifier.M <== DoB;

    component date = calculateAgeFromYYYYMMDD();
    date.yyyymmdd <== DoB;
    date.currentDay <== currentDay;
    date.currentMonth <== currentMonth;
    date.currentYear <== currentYear;
    
    component isGreater = GreaterEqThan(32);
    isGreater.in[0] <== date.age;
    isGreater.in[1] <== minAge;
    isGreater.out === 1;

    component isLess = LessEqThan(32);
    isLess.in[0] <== date.age;
    isLess.in[1] <== maxAge;
}

component main{public [currentDay, currentMonth, currentYear, minAge, maxAge]} = VerifyAge();