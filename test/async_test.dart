import 'package:flutter_test/flutter_test.dart';

// Simula uma operação assíncrona que retorna uma mensagem.
Future<String> buscarMensagem() async {
  await Future.delayed(Duration(milliseconds: 100));
  return 'Operação concluída';
}

void main() {
  test('Testar operação assíncrona', () async {
    final mensagem = await buscarMensagem();

    // Verifica se a operação retornou a mensagem esperada.
    expect(mensagem, 'Operação concluída');
  });
}
