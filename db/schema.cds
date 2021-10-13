using {
      cuid,
      managed
} from '@sap/cds/common';

namespace int.ssg;

entity Category {
      key text : String;
}

entity Question : cuid, managed {
      question      : String not null;
      answers       : Composition of many Answer
                            on answers.question = $self;
      category      : Association to one Category;
      possibilities : Integer default 1;
}

entity Answer : cuid, managed {
      answer   : String not null;
      question : Association to one Question;
      correct  : Boolean;
}

// @Aggregation.CustomAggregate #category : 'Edm.Integer'
// entity QuestionsBis : cuid, managed {
//       question      : String not null;
//       answers       : Composition of many Answers
//                             on answers.question = $self;
//       @Aggregation.default : #SUM
//       category      : Categories;
//       possibilities : Integer default 1;
// }

entity Exam : cuid, managed {
      examquestion : Composition of many {
                           key ID : Association to Question
                     };
      score        : Integer default 0;
}
