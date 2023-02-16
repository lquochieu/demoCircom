pragma circom 2.0.0;

include "ageCalculation.circom";
include "../../node_modules/circomlib/circuits/comparators.circom";

template VerifyAge() {
    signal input DoB;
    signal input currentDay;
    signal input currentMonth;
    signal input currentYear;

    signal input minAge;
    signal input maxAge;

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
    isGreater.out === 1;
}

component main{public [
    currentDay, 
    currentMonth, 
    currentYear, 
    minAge, 
    maxAge
    ]} = VerifyAge();