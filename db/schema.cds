using {
  cuid,
  managed
} from '@sap/cds/common';

namespace int.ssg;

entity Questions : managed {
  key ID            : UUID;
      question      : String;
      answers       : Composition of many Answers
                        on answers.question = $self;
      possibilities : Integer default 1;
}

entity Answers : managed {
  key ID       : UUID;
      answer   : String;
      question : Association to one Questions;
      correct  : Boolean;
}
