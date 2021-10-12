sap.ui.define(
  ['sap/ui/core/mvc/Controller', 'sap/m/MessageToast', 'sap/m/MessageBox'],
  /**
   * @param {typeof sap.ui.core.mvc.Controller} Controller
   */
  function (Controller, MessageToast, MessageBox) {
    'use strict';

    return Controller.extend('int.ssg.form.controller.Home', {
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
        const questionModel = this.getView().getModel('localQuestion');

        answers.push({ answer, correct, ID: answers.length + 1 });
        answersModel.setProperty('/answers', answers);
        answerInput.setValue('');
        answerCheckBox.setSelected(false);

        questionModel.setProperty('/data/nbCorrectAnswers', answers.filter(({ correct }) => correct).length);
      },
      //
      //
      onSave() {
        const questionModel = this.getView().getModel('localQuestion');
        const { question, nbCorrectAnswers: possibilities } = questionModel.getProperty('/data');
        const questionBinding = this.getView().getModel().bindList('/Questions');
        const answersModel = this.getView().getModel('localAnswer');
        const answers = answersModel.getProperty('/answers') || [];
        const context = questionBinding.create({
          question,
          possibilities,
          answers: answers.map(({ ID, ...answer }) => answer),
        });
        context.created().then(
          function () {
            MessageBox.success('Created question id ' + context.getProperty('ID') + '.', {
              icon: MessageBox.Icon.SUCCESS,
              title: 'Success',
            });
          },
          function (error) {
            MessageBox.alert('Could not create question: ' + error.message, {
              icon: MessageBox.Icon.ERROR,
              title: 'Error',
            });
          }
        );
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
