import 'package:flutter_test/flutter_test.dart';

// Cria uma lista de números inteiros que será utilizada nos testes.
List<int> numeros = [1, 2, 3];

void main() {
  test('Adicionar elemento', () {
    // O método add() adiciona um novo elemento ao final da lista.
    numeros.add(4);

    // Verifica se o número 4 foi adicionado corretamente.
    expect(numeros.contains(4), isTrue);
  });

  test('Adicionar outra lista', () {
    // O método addAll() adiciona vários elementos à lista de uma só vez.
    numeros.addAll([5, 6]);

    expect(numeros.contains(5), isTrue);
    expect(numeros.contains(6), isTrue);
  });

  test('Adicionar na posição', () {
    // O método insert() adiciona um elemento em uma posição específica.
    numeros.insert(0, 0);

    // indexOf() retorna a posição em que o elemento foi encontrado.
    expect(numeros.indexOf(0), 0);
  });

  test('Remover elemento', () {
    // O método remove() remove da lista o elemento informado.
    numeros.remove(2);

    // Verifica se o elemento 2 não está mais na lista.
    expect(numeros.contains(2), isFalse);
  });

  test('Remover na posição', () {
    // O método removeAt() remove o elemento que está em uma posição específica.
    numeros.removeAt(0);

    expect(numeros.contains(0), isFalse);
  });

  test('Testar tamanho', () {
    // A propriedade length informa a quantidade de elementos da lista.
    expect(numeros.length, 5);
  });

  test('Testar vazio e não vazio', () {
    // isEmpty verifica se a lista está vazia e isNotEmpty verifica se possui elementos.
    expect(numeros.isEmpty, isFalse);
    expect(numeros.isNotEmpty, isTrue);
  });

  test('Testar ordenação', () {
    // reversed cria uma sequência com os elementos em ordem inversa.
    expect(numeros.reversed.toList(), [6, 5, 4, 3, 1]);

    // Verifica se a lista está na ordem esperada.
    expect(numeros, [1, 3, 4, 5, 6]);

    // Converte a lista para sua ordem inversa.
    numeros = numeros.reversed.toList();

    expect(numeros, [6, 5, 4, 3, 1]);

    // O método sort() organiza os elementos da lista em ordem crescente.
    numeros.sort();

    expect(numeros, [1, 3, 4, 5, 6]);
  });

  test('Testar percorrer lista', () {
    // A variável soma será utilizada para acumular os valores da lista.
    int soma = 0;

    // O for percorre cada elemento da lista e adiciona seu valor à soma.
    for (int numero in numeros) {
      soma += numero;
    }

    expect(soma, 19);

    // O método map() transforma cada elemento da lista conforme a regra definida.
    numeros = numeros.map((numero) => numero * 2).toList();

    expect(numeros, [2, 6, 8, 10, 12]);

    // O método where() filtra a lista mantendo apenas os elementos que atendem à condição.
    numeros = numeros.where((numero) => numero % 3 == 0).toList();

    expect(numeros, [6, 12]);
  });
}