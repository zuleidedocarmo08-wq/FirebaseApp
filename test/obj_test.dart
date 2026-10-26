
import 'package:flutter_test/flutter_test.dart';

// Representa uma pessoa com nome e identificacao.
class Pessoa {
  final String nome;
  final String identificacao;

  Pessoa(this.nome, this.identificacao);
}

// Representa um aluno.
class Aluno extends Pessoa {
  final String matricula;

  Aluno(String nome, String identificacao, this.matricula)
      : super(nome, identificacao);
}

// Representa um professor.
class Professor extends Pessoa {
  final String area;

  Professor(String nome, String identificacao, this.area)
      : super(nome, identificacao);
}

// Representa uma disciplina.
class Disciplina {
  final String nome;
  final int cargaHoraria;

  Disciplina(this.nome, this.cargaHoraria);
}

// Representa uma turma com alunos e disciplina.
class Turma {
  final Disciplina disciplina;
  final List<Aluno> alunos = [];

  Turma(this.disciplina);

  void matricular(Aluno aluno) {
    if (!alunos.any((a) => a.matricula == aluno.matricula)) {
      alunos.add(aluno);
    }
  }

  bool estaMatriculado(Aluno aluno) {
    return alunos.any((a) => a.matricula == aluno.matricula);
  }
}

// Registra notas e calcula a media do aluno.
class Historico {
  final Aluno aluno;
  final Disciplina disciplina;
  final List<double> notas = [];

  Historico(this.aluno, this.disciplina);

  void adicionarNota(double nota) {
    if (nota < 0 || nota > 10) {
      throw ArgumentError('A nota deve estar entre 0 e 10.');
    }
    notas.add(nota);
  }

  double get media {
    if (notas.isEmpty) return 0;
    return notas.reduce((a, b) => a + b) / notas.length;
  }

  bool get aprovado => notas.isNotEmpty && media >= 7;
}

void main() {
  group('Testes de orientacao a objetos', () {
    final aluno = Aluno('Maria', '123', 'MAT001');
    final professor = Professor('Joao', '456', 'Programacao');
    final disciplina = Disciplina('Desenvolvimento Mobile I', 60);

    test('Criar aluno e professor', () {
      expect(aluno.nome, 'Maria');
      expect(aluno.matricula, 'MAT001');
      expect(professor.nome, 'Joao');
      expect(professor.area, 'Programacao');
    });

    test('Matricular aluno em turma', () {
      final turma = Turma(disciplina);

      turma.matricular(aluno);

      expect(turma.estaMatriculado(aluno), isTrue);
      expect(turma.alunos.length, 1);
    });

    test('Impedir matricula duplicada', () {
      final turma = Turma(disciplina);

      turma.matricular(aluno);
      turma.matricular(aluno);

      expect(turma.alunos.length, 1);
    });

    test('Calcular media e verificar aprovacao', () {
      final historico = Historico(aluno, disciplina);

      historico.adicionarNota(8);
      historico.adicionarNota(6);

      expect(historico.media, 7);
      expect(historico.aprovado, isTrue);
    });

    test('Verificar reprovacao', () {
      final historico = Historico(aluno, disciplina);

      historico.adicionarNota(5);
      historico.adicionarNota(6);

      expect(historico.media, 5.5);
      expect(historico.aprovado, isFalse);
    });

    test('Rejeitar nota invalida', () {
      final historico = Historico(aluno, disciplina);

      expect(
        () => historico.adicionarNota(11),
        throwsArgumentError,
      );
    });
  });
}
