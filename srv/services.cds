using int.ssg as model from '../db/schema';

service API {
  entity Questions         as projection on model.Question;
  entity Answers           as projection on model.Answer;
  entity Categories @(restrict : [{grant : [
    'READ',
    'CREATE',
    'WRITE'
  ]}, ])                   as projection on model.Categorie;

  entity Exams @(restrict : [{
    grant : [
      'READ',
      'CREATE',
      'WRITE'
    ],
    where : 'createdBy = $user or createdFor = $user'
  }, ])                    as projection on model.Exam;

  @readonly
  entity QuestionsCategory as
    select from Questions {
          count(
            category.ID
          ) as questioncategory : Integer,
      key category.text
    }
    group by
      category;

  function generateExam() returns Exams;
}
