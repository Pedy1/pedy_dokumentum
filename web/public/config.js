// These are the jobs that can create documents. The ranks in templateGrades can create templates for this job.
const AVAILABLE_JOBS = [
  {
    job: 'police',
    templateGrades: [13, 14, 15],
    logo: 'https://imgur.com/oFkMqtL.png',
  },
  {
    job: 'ambulance',
    templateGrades: [3],
    logo: 'https://imgur.com/iOBAgG1.png',
  },
  {
    job: 'mechanic',
    templateGrades: [4],
    logo: '/web/build/mechaniclogo.jpg',
  },
]

// These templates are visible to all players. If you don't want
// any citizen templates, delete everything inside the [] like this:
//    const CITIZEN_TEMPLATES = []
//
// If these templates are empty, the issued documents tab will
// not be visible to players who fon't have a specified job.
const CITIZEN_TEMPLATES = [
  {
    id: 'citizen_contract',
    documentName: 'Állampolgári szerződés',
    documnetDescription:
      'Ez egy dokumentum Magyarország két polgára között. Ez a dokumentum hivatalos jogi dokumentum.',
    fields: [
      {
        name: 'Keresztnév',
        value: '',
      },
      {
        name: 'Vezetéknév',
        value: '',
      },
      {
        name: 'Ig érvényes',
        value: '',
      },
    ],
    infoName: 'INFORMÁCIÓ',
    infoTemplate: '',
  },
]

const COLORS = {
  // These are hexadecimal color codes for the main theme. You can change them as you wish.
  // Primary colors are colors of buttons, and some texts, while secondary color is used for the cancel button.
  primary: '#E37777',
  secondary: '#DCAF62',

  // These two should stay RGBA to give them a 90% opacity. Only change the first 3 numbers with any RGB code
  // i.e. rgba([red], [green], [blue], 0.9)
  menuGradientBottom: 'rgba(209, 142, 142, 0.9)',
  menuGradientTop: 'rgba(243, 243, 203, 0.9)',
}

// These are the texts that show up on the NUI. Translate them as you wish. If you'd like to change
// the client texts, go to the config.lua file.

const TEXTS = {
  myDocumentsTitle: 'Saját dokumentumaim',
  issuedDocumentsTitle: 'Kiadott dokumentumok',
  templatesTitle: 'Sablonok',
  customDocumentName: 'Egyéni dokumentumnév',
  documentType: 'Típus',
  documentName: 'Név',
  unnamed: 'Névtelen',
  actions: 'Műveletek',
  edit: 'Szerkesztés',
  cancel: 'Mégse',
  delete: 'Törlés',
  view: 'Megtekintés',
  show: 'Mutat',
  copy: 'Másolás',
  newTemplateBtn: 'Új sablone',
  deleteTemplateTitle: 'Sablon törlése',
  deleteTemplateQuestion: 'Biztosan törli ezt a sablont?:',
  date: 'Dátum',
  newDocumentBtn: 'Új dokumentum',
  newCitizenDocumentBtn: 'Új állampolgári dokumentum',
  deleteDocumentTitle: 'Dokumentum törlése',
  deleteDocumentQuestion: 'Biztosan törli ezt a dokumentumot?:',
  signHereText: 'Itt írd alá',
  selectDocumentType: 'Válasszon ki egy dokumentumtípust',
  cannotIssueDocument: 'Ezzel a munkával nem állíthat ki dokumentumot',
  issuerFirstname: 'KIADÓ KERESZTNEVE',
  issuerLastname: 'KIADÓ VEZETÉKNÉVE',
  issuerDOB: 'KIADÓ SZÜLETETT',
  issuerJob: 'KIADÓ ÁLLÁS',
  termsAndSigning: 'FELTÉTELEK ÉS ALÁÍRÁS',
  terms1: 'Ez a dokumentum aláírásakor hivatalos dokumentummá válik.',
  terms2:
    'A jelen dokumentum aláírásával Ön jogilag kötelezi magát a szövegkörnyezetre, és elfogad minden jogi következményt, amelyet az okozhat.',
  terms3:
    'Ennek a dokumentumnak minden másolata azonos értékű az eredetivel. Legyen különösen óvatos, amikor másolatot ad.',
  terms4:
    "Aláírás előtt győződjön meg arról, hogy teljesen tisztában van a dokumentum szövegkörnyezetével.",
  terms5: "Az aláírás előtt ne habozzon kérni segítséget.",
  requiredError: 'Ez a mező kötelező',
  docNameField: 'DOKUMENTUM NEVE',
  docDescField: 'DOKUMENTUM LEÍRÁS',
  docFieldField: 'MEZŐ NEVE',
  docAddField: 'Mező hozzáadása',
  docInfoNameField: 'INFORMÁCIÓ CÍME',
  docInfoValueField: 'INFORMÁCIÓS SABLON',
  docMinGradeField: 'MINIMÁLIS ÁLLÁSFOKOZÁS',
  editTemplateBtn: 'SABLON SZERKESZTÉSE',
  createTemplateBtn: 'SABLON LÉTREHOZÁSA',
  createDocumentBtn: 'DOKUMENTUM LÉTREHOZÁSA',
  documentCopy: 'MÁSOLÁS',
}
