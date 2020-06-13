import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _numeroAleatorio = 0;
  int _numeroAleatorioModalidade = 0;
  int eu = 0, adv = 0; //para contar pontos atual
  double tamanhoEU = 15; //tamanho do texto de EU
  double tamanhoADV = 15; //tamanho do texto de ADV
  var corEU = Colors.black; //cor de EU
  var corADV = Colors.black; //cor de ADV

  var img = "imagens/logo.jpg"; //imagem inicial
  var msg = "Vamos Jogar?"; //msg inicial
  var msg2 =
      "Clique no botão Modo para selecionar uma modalidade"; //msg2 inicial
  int countRodadeAtual = 0;
  int qtdRodada =
      30; //Para definir numero de rodada maxima, quando a rodada atinge o limite, quem tiver mais pontos VENCE
  int qtdPontos =
      30; //Para definir numero de pontos, quem chegar lá primeiro VENCE

  List adversario = [
    //possiveis jogadas do adversario
    "imagens/pedra.png",
    "imagens/papel.png",
    "imagens/tesoura.png"
  ];

  List modalidade = [
    //São 2 modalidades, 0 2 4 6 8 10 modalidade Rodada, restantes modalidade pontos
    "Vamos confrontar durante 30 Rodadas",
    "Quem vai chegar a 30 primeiro?",
    "Vamos lá, 30 Rodadas",
    "Aposto que vou chegar a 30 primeiro",
    "Vai ser 30 Rodadas",
    "30 pontos é o que vou fazer",
    "Vai ser 30 Rodadas divertidas",
    "Preparado para eu te vencer por 30 pontos?",
    "30 Rodadas te amassando por completo",
    "Vc não vai escapar, vou fazer 30 pontos primeiro",
    "Vou te destruir durante 30 rodadas",
  ];

  void _jogadaAdversario() {
    //gerando numero aleatorio para definir a jogada do adversario
    setState(() {
      _numeroAleatorio = new Random().nextInt(adversario.length.toInt());
      img = adversario[_numeroAleatorio];
    });
  }

  void vencendo() {
    //para saber a pontuação atual, baseado na pontuação atribui cor e o tamanho da fonte
    setState(() {
      if (eu > adv) {
        tamanhoEU = 25;
        tamanhoADV = 15;
        corEU = Colors.green;
        corADV = Colors.red;
      } else if (eu < adv) {
        tamanhoEU = 15;
        tamanhoADV = 25;
        corEU = Colors.red;
        corADV = Colors.green;
      } else {
        tamanhoEU = 15;
        tamanhoADV = 15;
        corEU = Colors.black;
        corADV = Colors.black;
      }
    });
  }

  void reset() {
    //para reiniciar as variaveis, ou seja, jogo volta ao inicio
    setState(() {
      eu = 0;
      adv = 0;
      corEU = Colors.black;
      corADV = Colors.black;
      tamanhoEU = 15;
      tamanhoADV = 15;
      countRodadeAtual = 0;
    });
  }

  void selecionaModalidade() {
    //gerando um numero aleatorio para saber a modalidade que será jogada
    setState(() {
      _numeroAleatorioModalidade =
          new Random().nextInt(modalidade.length.toInt());

      msg2 = modalidade[_numeroAleatorioModalidade];
    });
  }

  void jogar() {
    //definindo as regras do jogo para cada 1 das 2 modalidades existente
    if (_numeroAleatorioModalidade == 0 ||
        _numeroAleatorioModalidade == 2 ||
        _numeroAleatorioModalidade == 4 ||
        _numeroAleatorioModalidade == 6 ||
        _numeroAleatorioModalidade == 8 ||
        _numeroAleatorioModalidade == 10) {
      //modalidade rodada
      countRodadeAtual++; //passndo para proxima rodada

      msg2 =
          "Rodada $countRodadeAtual de $qtdRodada"; //informando a rodada atual

      if (countRodadeAtual == qtdRodada) {
        //verificando se chegou a rodada final
        if (adv > eu) {
          //se pontos do adversario na rodada final for maior que eu, adversario vence
          msg = "O Adversário te derotou por $adv a $eu";
        } else if (adv < eu) {
          //se pontos do adversario na rodada final for menor que eu, adversario perde
          msg = "Vc venceu por $eu a $adv";
        } else {
          //se pontos do adversario na rodada final for igual a eu, final empate
          msg = "Que incrível! Um final com empate";
        }

        msg2 = "FIM DO JOGO! Rodada $countRodadeAtual de $qtdRodada";

        reset(); //reiniciando as variaveis
      }
    } else {
      //modalidade pontos
      //verificando a pontuação atual para informar quem está  vencendo
      if (adv > eu) {
        //se pontos do adversario na rodada final for maior que eu, adversario vence
        msg2 = "Adversário esta vencendo com $adv de $qtdPontos";
      } else if (adv < eu) {
        //se pontos do adversario na rodada final for menor que eu, adversario perde
        msg2 = "Vc esta vencendo com $eu de $qtdPontos";
      } else {
        //se pontos do adversario na rodada final for igual a eu, final empate
        msg2 = "Estão empatados com $eu de $qtdPontos";
      }

      if (adv == qtdPontos) {
        //verificando se adversário chegou ao ponto primeiro, adversario vence
        if ((adv - eu) > (qtdPontos / 2)) {
          //se a diferença for maior do que a metade
          msg = "O Adversário te AMASSOUUUU por $adv a $eu";
        } else {
          //se a diferença for menor do que a metade
          msg = "O Adversário te derotou por $adv a $eu";
        }

        reset(); //reiniciando as variaveis
      } else if (eu == qtdPontos) {
        //se a diferença for maior do que a metade
        if ((adv - eu) > (qtdPontos / 2)) {
          msg = "Vc AMASSOUUUU o adversário por $eu a $adv";
        } else {
          //se a diferença for menor do que a metade
          msg = "Vc venceu o adversário por $eu a $adv";
        }

        reset(); //reiniciando as variaveis
      }
    }
  }

  void _pedra() {
    //chamado ao apertar botao de pedra
    _jogadaAdversario(); //para saber qual a jogada do adversario

    //Comparando as jogadas
    if (_numeroAleatorio == 0) {
      msg = "EMPATE Pedra com Pedra";
    } else if (_numeroAleatorio == 1) {
      msg = "Vc PERDEU, Papel ganha de Pedra";
      adv++; //pontos para adversario
    } else {
      msg = "Vc VENCEU, Pedra ganha de Tesoura";
      eu++; //pontos para eu
    }

    vencendo(); //verificando a pontuação atual para atribuir cores e formataçoes
    jogar(); //para aplicar as regras da modalidade atual
  }

  void _papel() {
    //mesmos comentarios que pedra()
    _jogadaAdversario();

    if (_numeroAleatorio == 1) {
      msg = "EMAPTE Papel com Papel";
    } else if (_numeroAleatorio == 0) {
      msg = "Vc VENCEU, Papel ganha de Pedra";
      eu++;
    } else {
      msg = "Vc PERDEU, Tesoura ganha de Papel";
      adv++;
    }

    vencendo();
    jogar();
  }

  void _tesoura() {
    //mesmos comentarios que pedra()
    _jogadaAdversario();

    if (_numeroAleatorio == 2) {
      msg = "EMAPTE Tesoura com Tesoura";
    } else if (_numeroAleatorio == 1) {
      msg = "Vc VENCEU, Tesoura ganha de Papel";
      eu++;
    } else {
      msg = "Vc PERDEU, Pedra ganha de Tesoura";
      adv++;
    }

    vencendo();
    jogar();
  }

  void _reiniciar() {
    setState(() {
      msg =
          "Jogo Reiniciado! Vamos Jogar?"; //msg diferente para mostrar que o jogo foi reiniciado
      img = "imagens/logo.jpg"; //chamando o logotipo novamente

      reset(); //reiniciando as variaveis

      selecionaModalidade(); //reiniciar a seleção da modalidade
    });
  }

  void _modo() {
    //chamado ao apertar botao de modo
    setState(() {
      selecionaModalidade(); //para alternar entre as 2 modalidades

      if (adv != 0 || eu != 0) {
        //se a pontuação já tinha iniciado entao quer dizer que o jogo vai ser interrompido
        msg = "Jogo interrompido ao trocar Modo";
        img = "imagens/logo.jpg"; //chamando o logotipo inicial
        reset(); //reiniciando as variaveis
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JokenPo"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "EU: $eu",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: tamanhoEU,
                      color: corEU,
                    ),
                  ),
                  Text(
                    "VS",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Adv: $adv",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: tamanhoADV,
                      color: corADV,
                    ),
                  ),
                ],
              ),
              Text("Escolha do adversário:"),
              Image.asset(
                "$img",
                height: 200,
              ),
              Text(
                "$msg",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$msg2",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: _pedra,
                    child: Image.asset(
                      "imagens/pedra2.png",
                      height: 80,
                    ),
                  ),
                  GestureDetector(
                    onTap: _papel,
                    child: Image.asset(
                      "imagens/papel2.png",
                      height: 80,
                    ),
                  ),
                  GestureDetector(
                    onTap: _tesoura,
                    child: Image.asset(
                      "imagens/tesoura2.png",
                      height: 80,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: _modo,
                    child: Text(
                      "Modo",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: _reiniciar,
                    child: Text(
                      "Reiniciar",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
