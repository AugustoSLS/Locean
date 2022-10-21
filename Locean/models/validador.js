function cpf(cpf){
    cpf = cpf.replace(/\D/g, '');
    if(cpf.toString().length != 11 || /^(\d)\1{10}$/.test(cpf)) return false;
    var result = true;
    [9,10].forEach(function(j){
        var soma = 0, r;
        cpf.split(/(?=)/).splice(0,j).forEach(function(e, i){
            soma += parseInt(e) * ((j+2)-(i+1));
        });
        r = soma % 11;
        r = (r <2)?0:11-r;
        if(r != cpf.substring(j, j+1)) result = false;
    });
    return result;
}

console.log('11111111111', cpf('11111111111'));
console.log('82312321312', cpf('82312321312'));
console.log('825.566.405-02', cpf('825.566.405-02'));
console.log('875.189.681-85', cpf('875.189.681-85'));
console.log('875.189.681-86', cpf('875.189.681-86'));
console.log('640.422.216-70', cpf('640.422.216-70'));