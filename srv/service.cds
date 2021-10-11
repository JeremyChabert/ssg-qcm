using int.ssg as model from '../db/schema';

service API {
  entity Questions as projection on model.Questions;
  entity Answers as projection on model.Answers;
}
