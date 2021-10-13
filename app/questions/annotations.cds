annotate API.Questions with @(
  Capabilities : {
    SearchRestrictions : {Searchable : true},
    FilterRestrictions : {
      Filterable              : true,
      NonFilterableProperties : [
        'ID',
        'createdBy',
        'modifiedBy'
      ]
    }
  },
  UI           : {
    SelectionFields                 : [category.text],
    LineItem                        : [
      {
        $Type             : 'UI.DataField',
        Label             : '{i18n>Question}',
        Value             : question,
        ![@UI.Importance] : #High
      },
      {
        $Type             : 'UI.DataField',
        Label             : '{i18n>Category}',
        Value             : category_text,
        ![@UI.Importance] : #High
      },
      {
        $Type             : 'UI.DataField',
        Label             : '{i18n>Possibilities}',
        Value             : possibilities,
        ![@UI.Importance] : #High
      },
    ],
    Facets                          : [
      {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>Information}',
        ID     : 'infoquestion',
        Target : '@UI.FieldGroup#InformationQuestion'
      },
      {
        $Type  : 'UI.ReferenceFacet',
        Label  : 'Answers',
        Target : 'answers/@UI.LineItem'
      }
    ],
    HeaderInfo                      : {
      TypeName       : '{i18n>Question}',
      TypeNamePlural : '{i18n>Questions}',
      Title          : {Value : question}
    },
    FieldGroup #InformationQuestion : {Data : [
      {Value : question},
      {Value : possibilities},
      {Value : category.text},
      {Value : createdBy},
      {Value : createdAt},
      {Value : modifiedBy},
      {Value : modifiedAt}
    ]}
  }
);

annotate API.Questions with {
  ID            @(
    title : '{i18n>Question_ID}',
    UI.HiddenFilter,
    UI.Hidden
  );
  question      @title            : '{i18n>Text}';
  possibilities @title            : '{i18n>NbCorrectAnswers}';
};

annotate API.Categories with {
  text @(
    title  : '{i18n>Category}',
    Common : {
      ValueList : {
        Label          : '{i18n>Category}',
        CollectionPath : 'API.Categories',
        Parameters     : [{
          $Type             : 'Common.ValueListParameterInOut',
          ValueListProperty : 'text'
        }]
      },
      ValueListWithFixedValues
    }
  );
};

annotate API.Answers with @(
  Capabilities : {SearchRestrictions : {Searchable : true}},
  UI           : {
    LineItem                      : [
      {
        $Type             : 'UI.DataField',
        Label             : '{i18n>ID}',
        Value             : ID,
        ![@UI.Importance] : #High
      },
      {
        $Type             : 'UI.DataField',
        Label             : '{i18n>Answer}',
        Value             : answer,
        ![@UI.Importance] : #High
      },
      {
        $Type             : 'UI.DataField',
        Label             : '{i18n>Correct}',
        Value             : correct,
        ![@UI.Importance] : #High
      },
    ],
    Facets                        : [{
      $Type  : 'UI.ReferenceFacet',
      Label  : '{i18n>information}',
      ID     : 'infoanswers',
      Target : '@UI.FieldGroup#InformationAnswer'
    }],
    HeaderInfo                    : {
      TypeName       : '{i18n>Answer}',
      TypeNamePlural : '{i18n>Answers}',
      Title          : {Value : answer}
    },
    FieldGroup #InformationAnswer : {Data : [
      {Value : answer},
      {Value : correct},
      {Value : createdBy},
      {Value : createdAt},
      {Value : modifiedBy},
      {Value : modifiedAt}
    ]},
  },

);
