
import 'package:flutter_test/flutter_test.dart';

// Simula uma operação assíncrona que retorna um resultado após 5 segundos.
Future<int> process() async {
  await Future.delayed(const Duration(seconds: 5));
  return 0;
}

// Armazena as notas de cada aluno.
Map<String, List<double>> alunos = {
  'Maria': [8.0, 9.0],
  'Bruna': [7.0, 7.0],
  'Carla': [10.0, 9.0],
};

// Pesquisa as notas de um aluno após 2 segundos.
// Se o aluno não existir, lança um erro.
Future<List<double>?> search(String key) async {
  return Future.delayed(const Duration(seconds: 2), () {
    if (alunos.containsKey(key)) {
      return alunos[key]!;
    }
    throw ArgumentError('Aluno não encontrado.');
  });
}

// Emite os números de 1 a 3, com intervalo de 1 segundo.
Stream<int> count() async* {
  for (int i = 1; i <= 3; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
}

// Calcula e emite a média das notas de cada aluno pesquisado.
Stream<double> media(List<String> nomes) async* {
  for (String nome in nomes) {
    final notas = await search(nome);
    final soma = notas!.reduce((a, b) => a + b);
    yield soma / notas.length;
  }
}

void main() {
  group('Testes de programação assíncrona', () {
    late Future<int> result;

    // Inicializa a operação antes de cada teste.
    setUp(() {
      result = process();
    });

    test('Aguardando operação', () {
      expect(result, isNotNull);
    });

    test('Testando o resultado', () async {
      final num = await result;
      expect(num, 0);
    });

    test('Testando busca sem erros em Future', () async {
      final notas = await search('Maria');
      expect(notas, [8.0, 9.0]);
    });

    test('Testando busca com erro em Future', () async {
      expect(
        () => search('Paula'),
        throwsArgumentError,
      );
    });

    test('Testando contagem em Stream', () async {
      final resultados = await count().toList();
      expect(resultados, [1, 2, 3]);
    });

    test('Testando média em Stream', () async {
      final resultados = await media(['Maria', 'Bruna']).toList();
      expect(resultados, [8.5, 7.0]);
    });

    test('Testando erro na Stream de médias', () async {
      await expectLater(
        media(['Maria', 'Paula']).toList(),
        throwsArgumentError,
      );
    });
  });
}
