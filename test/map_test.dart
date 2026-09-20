import 'package:flutter_test/flutter_test.dart';

// Cria um Map em que o nome do aluno é a chave
// e a lista de notas é o valor associado.
Map<String, List<double>> alunos = {
  'Maria': [8.0, 9.0],
  'Bruna': [7.0, 7.0],
  'Carla': [10.0, 9.0],
};

void main() {
  test('Adicionar elemento', () {
    // putIfAbsent() adiciona um elemento somente se a chave ainda não existir.
    alunos.putIfAbsent('Elena', () => [9.0, 8.0]);

    expect(alunos.containsKey('Elena'), isTrue);
    expect(alunos['Elena'], [9.0, 8.0]);
  });

  test('Adicionar outro dicionário', () {
    // addAll() adiciona várias chaves e valores ao Map de uma só vez.
    alunos.addAll({
      'Elena': [9.0, 8.0],
      'Luiza': [8.0, 9.0],
    });

    expect(alunos.containsKey('Elena'), isTrue);
    expect(alunos.containsKey('Luiza'), isTrue);
  });

  test('Remover elemento', () {
    // remove() exclui do Map o elemento correspondente à chave informada.
    alunos.remove('Bruna');

    expect(alunos.containsKey('Bruna'), isFalse);
  });

  test('Atualizar elemento', () {
    // update() permite alterar o valor associado a uma chave existente.
    alunos.update('Carla', (value) => [9.0, 8.0]);

    expect(alunos['Carla'], [9.0, 8.0]);

    // Também é possível atualizar diretamente usando a chave do Map.
    alunos['Carla'] = [8.0, 9.0];

    expect(alunos['Carla'], [8.0, 9.0]);
  });

  test('Testar percorrer dicionário', () {
    // keys retorna todas as chaves existentes no Map.
    expect(alunos.keys, ['Maria', 'Carla', 'Elena', 'Luiza']);

    // values retorna todos os valores associados às chaves.
    expect(alunos.values, [
      [8.0, 9.0],
      [8.0, 9.0],
      [9.0, 8.0],
      [8.0, 9.0],
    ]);

    double soma = 0;

    // forEach() percorre cada chave e seu respectivo valor no Map.
    alunos.forEach((key, value) {
      // Percorre as notas de cada aluno para calcular a soma.
      for (double nota in value) {
        soma += nota;
      }
    });

    expect(soma, 68.0);
  });

  test('Calcular médias', () {
    // Cria um novo Map para armazenar a média de cada aluno.
    Map<String, double> medias = {};

    // Percorre os alunos e calcula a média das notas de cada um.
    alunos.forEach((nome, notas) {
      double soma = 0;

      for (double nota in notas) {
        soma += nota;
      }

      // A média é calculada dividindo a soma pela quantidade de notas.
      double media = soma / notas.length;

      medias[nome] = media;
    });

    // Verifica se as médias calculadas correspondem aos valores esperados.
    expect(medias, {
      'Maria': 8.5,
      'Carla': 8.5,
      'Elena': 8.5,
      'Luiza': 8.5,
    });
  });
}