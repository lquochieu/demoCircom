const fs = require("fs");
const { buildEddsa, buildBabyjub } = require("circomlibjs");

const main = async () => {
    const input = {
        DoB: "20010825",
        currentDay: "16",
        currentMonth: "2",
        currentYear: "2023",
        minAge: "18",
        maxAge: "30"
    }

    let eddsa = await buildEddsa();
    let babyJub = await buildBabyjub();
    let F = babyJub.F;

    let msg = F.e(input.DoBdate)
    const prvKey = Buffer.from("0000000000000000000000000000000000000000000000000000000000000000", "hex");
    const pubKey = eddsa.prv2pub(prvKey);

    const signature = eddsa.signPoseidon(prvKey, msg);
    
    input.pubKey = ['0x' + F.toObject(pubKey[0]).toString("16"), '0x' + F.toObject(pubKey[1]).toString("16")];
    input.R8x = '0x' + F.toObject(signature.R8[0]).toString("16");
    input.R8y = '0x' + F.toObject(signature.R8[1]).toString('16');
    input.signature = '0x' + signature.S.toString('16');
    
    console.log(input);
    const json = JSON.stringify(input, null, 2);
    console.log(json);
    // console.log(json);
    fs.writeFile('../src/age/input1.json', json, (err) => {
        if (err) {
            console.log(err);
        } else {
            console.log("write successful");
        }
    });
};

main()
    .then(() => { })
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });