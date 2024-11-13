import 'tasks.dart';

// propositional logic questions based on logical equivalence
List<Tasks> offlineTasks = [
  Tasks(
    taskId: 1,
    question: '"∀x (P(x) ∧ Q(x))" is equivalent to:',
    choices: ['∀x (P(x) → Q(x))', '∃x (P(x) ∧ Q(x))', '∀x (¬P(x) ∨ Q(x))'],
    correctAns: 1,
  ),
  Tasks(
    taskId: 2,
    question: '"∀x (P(x) ∨ Q(x))" is equivalent to:',
    choices: ['∀x (P(x) ∧ Q(x))', '∀x (¬P(x) → Q(x))', '∃x (¬P(x) ∨ Q(x))'],
    correctAns: 2,
  ),
  Tasks(
    taskId: 3,
    question: '"∀x (P(x) ↔ Q(x))" is equivalent to:',
    choices: ['∀x (P(x) ∨ Q(x))', '∀x (P(x) ∧ ¬Q(x))', '∀x (¬P(x) ∨ ¬Q(x))'],
    correctAns: 2,
  ),
  Tasks(
    taskId: 4,
    question: '"∀x (P(x) ∧ ¬Q(x))" is equivalent to:',
    choices: ['∀x (P(x) ↔ Q(x))', '∀x (¬P(x) ∨ Q(x))', '∀x (¬P(x) ∧ Q(x))'],
    correctAns: 1,
  ),
  Tasks(
    taskId: 5,
    question: '"∃x (P(x) ∨ Q(x))" is equivalent to:',
    choices: ['∀x (P(x) ∧ ¬Q(x))', '∃x (P(x) → Q(x))', '∀x (¬P(x) ∧ ¬Q(x))'],
    correctAns: 2,
  ),
  Tasks(
    taskId: 6,
    question: '"∀x (P(x) → Q(x))" is equivalent to:',
    choices: ['∀x (¬P(x) ∨ Q(x))', '∃x (P(x) ∧ Q(x))', '∀x (P(x) ↔ Q(x))'],
    correctAns: 0,
  ),
  Tasks(
    taskId: 7,
    question: '"∃x (P(x) ∧ Q(x) ∧ R(x))" is equivalent to:',
    choices: [
      '∀x (P(x) ∨ Q(x) ∨ R(x))',
      '∃x (P(x) ∨ Q(x))',
      '∀x (¬P(x) ∨ ¬Q(x) ∨ ¬R(x))'
    ],
    correctAns: 0,
  ),
  Tasks(
    taskId: 8,
    question: '∀x (P(x) ∧ Q(x) → R(x))" is equivalent to:',
    choices: [
      '∃x (P(x) ∧ Q(x) ∧ R(x))',
      '∀x (¬P(x) ∨ ¬Q(x) ∨ R(x))',
      '∀x (¬P(x) ∨ ¬Q(x) → ¬R(x))'
    ],
    correctAns: 1,
  ),
  Tasks(
    taskId: 9,
    question: '"∃x (P(x) ∧ Q(x) → R(x))" is equivalent to:',
    choices: [
      '∀x (P(x) ∧ Q(x) → R(x))',
      '∀x (¬P(x) ∨ ¬Q(x) ∨ ¬R(x))',
      '∀x (P(x) ∧ ¬Q(x) ∨ R(x))'
    ],
    correctAns: 2,
  ),
  Tasks(
    taskId: 10,
    question: '"∀x (P(x) ∨ Q(x) → R(x))" is equivalent to:',
    choices: [
      '∃x (P(x) ∨ Q(x) ∨ R(x))',
      '∀x (¬P(x) ∧ ¬Q(x) → ¬R(x))',
      '∀x (¬P(x) ∧ ¬Q(x) ∧ R(x))'
    ],
    correctAns: 1,
  ),
];
