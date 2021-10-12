sap.ui.define([], () => {
  'use strict';

  return {
    getCorrectAnswers(answers) {
      return answers.find(({ correct }) => correct).length;
    },
  };
});
