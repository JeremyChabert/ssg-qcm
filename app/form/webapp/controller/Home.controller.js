sap.ui.define(
  ['sap/ui/core/mvc/Controller',
  'int/ssg/form/model/Formatter'],
  /**
   * @param {typeof sap.ui.core.mvc.Controller} Controller
   */
  function (Controller,Formatter) {
    'use strict';
    
    return Controller.extend('int.ssg.form.controller.Home', {
      formatter:Formatter,
      onInit: function () {},
      //
      //
      addAnswer(event) {
        const answerInput = this.getView().byId('idAnswerText');
        const answerCheckBox = this.getView().byId('idAnswerCorrect');
        const answer = answerInput.getValue();
        const correct = answerCheckBox.getSelected();
        const answersModel = this.getView().getModel('localAnswer');
        const answers = answersModel.getProperty('/answers') || [];
        answers.push({ answer, correct, ID: answers.length + 1 });
        answersModel.setProperty('/answers', answers);
        answerInput.setValue('');
        answerCheckBox.setSelected(false);
      },
      //
      //
      onSave() {
        const questionInput = this.getView().byId('idQuestionText');
        const questionText = questionInput.getValue();
        const oQuestionBinding = this.getView().getModel().bindList('/Questions');
        const answersModel = this.getView().getModel('localAnswer');
        const answers = answersModel.getProperty('/answers') || [];
        oQuestionBinding.create({ question: questionText, possibilities: answers.length }, true);
        this.clearForm();
      },
      //
      //
      clearForm() {
        const questionInput = this.getView().byId('idQuestionText');
        questionInput.setValue('');
        const answersModel = this.getView().getModel('localAnswer');
        answersModel.setProperty('/answers', []);
      },
      //
      //
      onDeleteAnswer(event) {
        const row = event.getSource().getParent().getBindingContext('localAnswer').getObject();
        const answersModel = this.getView().getModel('localAnswer');
        const answers = answersModel.getProperty('/answers');
        answersModel.setProperty(
          '/answers',
          answers.filter(({ ID }) => ID !== row.ID)
        );
      },
    });
  }
);
