var express = require('express');
var router = express.Router();
var bcrypt = require("bcryptjs");
var salt = bcrypt.genSaltSync(12);
var fabricaDeConexao = require("../config/connection-factory");
var conexao = fabricaDeConexao();
const { body, validationResult } = require("express-validator");

router.get('/', (req, res) => {
  res.render('pages/index',{incluir:null});
});

router.get('/Aboutus', (req, res) => {
  res.render('pages/Aboutus',{incluir:null});
});

router.get('/contato', (req, res) => {
  res.render('pages/contato',{incluir:null});
});

router.get('/cursos', (req, res) => {
  res.render('pages/cursos',{incluir:null});
});

router.get('/Esq', (req, res) => {
  res.render('pages/Esq',{incluir:null});
});

router.get('/pagcurso', (req, res) => {
  res.render('pages/pagcurso',{incluir:null});
});

router.get('/perfil', (req, res) => {
  if (req.session.autenticado) {
    autenticado = { autenticado: req.session.usu_autenticado };
  } else {
    autenticado = { autenticado: null };  
  }
  res.render('pages/perfil', autenticado);
});

router.get("/sair", function (req, res) {
  req.session.destroy();
  res.redirect("/");
});

// router.get('/configperf', (req, res) => {
//  res.render('pages/perfil',{incluir:'configperf'});
//});

router.post("/configperf", function (req, res) {
  console.log(req.body)
});

router.get('/perguntas', (req, res) => {
  res.render('pages/perguntas',{incluir:null});
});

router.get('/player', (req, res) => {
  res.render('pages/player',{incluir:null});
});

router.get('/privacidade', (req, res) => {
  res.render('pages/privacidade',{incluir:null});
});

router.get('/segurança', (req, res) => {
  res.render('pages/segurança',{incluir:null});
});

router.get('/termos', (req, res) => {
  res.render('pages/termos',{incluir:null});
});

router.get('/login', (req, res) => {
  res.render('pages/login',{incluir:null});
});

router.get('/signin', (req, res) => {
  res.render('pages/signin',{incluir:null});
});

router.post(
  "/login",

  body("email_alu")
    .isEmail()
    .withMessage('O e-mail deve ser válido!'),
  body("senha_alu")
    .isLength({ min: 3, max: 30 })
    .withMessage('A senha deve ter de 3 a 30 caracteres!'),
  body("cpf")
    .isLength({ min: 18, max: 18 }) 
    .withMessage('O CPF tem 14 caracteres!')
    .custom((value) => {
      if (!validador.validarCNPJ(value)) {
        throw new Error('CPF inválido!');
      }  
      // Indicates the success of this synchronous custom validator
      return true;
  }),
  
  function (req, res) {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      console.log(errors);
      return res.render("pages/index", { "erros": errors, "valores":req.body});
    }
    
    res.json(req.body);
  }
  );

router.post("/login",function (req, res) {
    var dadosForm = {
      email_aluno: req.body.email_alu,
      senha_aluno: req.body.senha_alu,
    };

    var result = conexao.query(
      "SELECT * FROM aluno WHERE nome_aluno = ? or email_aluno = ?",
      [dadosForm.email_aluno, dadosForm.email_aluno],
      function (error, results, fields) {
        if (error) throw error;
        var total = Object.keys(results).length;
        
        if (total == 1) {
          if (bcrypt.compareSync(dadosForm.senha_aluno,results[0].senha_aluno)) {
            req.session.autenticado = true;
            req.session.usu_autenticado = results[0].email_aluno;
            req.session.usu_tipo = results[0].id_aluno;
          }
          
        }
        res.redirect("/");
      }
    );
  }
);

router.post("/signin", function (req, res) {
  var dadosForm = {
    senha_aluno: bcrypt.hashSync(req.body.senha_alu, salt),
    nome_aluno: req.body.nome_alu,
    email_aluno: req.body.email_alu,
    nasc_aluno: req.body.nasc_alu,
    cpf_aluno: req.body.cpf_alu,
  };

  var result = conexao.query(
    "INSERT INTO aluno SET ?",
    dadosForm,
    function (error, results, fields) {
      if (error) throw error;
      res.redirect("/signin");
    }
  );
});

router.get("/perfil", function (req, res) {
  if (req.session.autenticado == true && req.session.usu_tipo == 1) {
    autenticado = { autenticado: req.session.usu_autenticado };
    res.render("pages/perfil", autenticado);
  } else {
    res.send("Área restrita");
  }
});

module.exports = router;