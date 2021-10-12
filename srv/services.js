module.exports = (srv) => {
  srv.on('generateExam', async (req) => {
    const length = 5;
    const questions = await SELECT.from('Question');
    const val = Array.from({ length }, () => Math.floor(Math.random() * length + 1));

    const exam = {
      examquestion: val.map((i) => {
        return { ID_ID: questions[((1 % i) + i) % i].ID };
      }),
    };
    // await INSERT.into('Exam').entries(exam);
  });
};
