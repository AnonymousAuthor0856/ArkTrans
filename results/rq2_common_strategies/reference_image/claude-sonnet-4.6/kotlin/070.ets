// entry/src/main/ets/pages/LeaseWizardPage.ets
// Kotlin Compose -> ArkTS (ArkUI declarative) port of the single-file "LeaseWizard" UI.

const NAME: string = '160*LeaseWizard*en';
const UI_TYPE: string = 'Wizard';
const STYLE_THEME: string = 'Soft Pastel';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';
const COMPLEXITY: string = 'Stepper,Form,Summary';
const EXTRA: string = 'Soft pastel lease wizard with step chips and summary card';

/* ------------------------------ Design tokens ------------------------------ */

const COLOR_PRIMARY: string = '#A07CFF';
const COLOR_SECONDARY: string = '#F6B4D7';
const COLOR_TERTIARY: string = '#8DD3C7';
const COLOR_BACKGROUND: string = '#FDF8FF';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_SURFACE_VARIANT: string = '#EFE7FF';
const COLOR_OUTLINE: string = '#C9B4E6';
const COLOR_SUCCESS: string = '#6ED8A0';
const COLOR_WARNING: string = '#FCD277';
const COLOR_ERROR: string = '#FF8899';
const COLOR_ON_PRIMARY: string = '#1D0F33';
const COLOR_ON_SECONDARY: string = '#2B0E1C';
const COLOR_ON_TERTIARY: string = '#06231C';
const COLOR_ON_BACKGROUND: string = '#1C1126';
const COLOR_ON_SURFACE: string = '#24132C';
const COLOR_SURFACE_TONAL: string = '#F6F0FF';

const SPACE_XXS: number = 4;
const SPACE_XS: number = 8;
const SPACE_SM: number = 12;
const SPACE_MD: number = 16;
const SPACE_LG: number = 20;
const SPACE_XL: number = 28;
const SPACE_XXL: number = 36;
const SPACE_XXXL: number = 48;

const RADIUS_SMALL: number = 8;
const RADIUS_MEDIUM: number = 14;
const RADIUS_LARGE: number = 24;

// Shared sub-palette values used for shadows / tonal cards.
const COLOR_SURFACE_VARIANT_80: string = '#CCEFE7FF';
const COLOR_ON_SURFACE_70: string = '#B31C1126';

/* -------------------------------- Data models ------------------------------- */

interface WizardStep {
  title: string;
  description: string;
}

interface SummaryItem {
  label: string;
  value: string;
}

interface DocumentChecklist {
  label: string;
  status: string;
}

/* ---------------------------------- Page ----------------------------------- */

@Entry
@Component
struct LeaseWizardPage {
  @State currentStep: number = 1;
  @State name: string = 'Avery Tenant';
  @State contact: string = 'avery@example.com';
  @State income: string = '$120k annual';

  private steps: WizardStep[] = [
    { title: 'Profile', description: 'Tenant basics' },
    { title: 'Income', description: 'Proof details' },
    { title: 'References', description: 'Upload letters' },
    { title: 'Summary', description: 'Confirm submission' }
  ];

  private summaryItems: SummaryItem[] = [
    { label: 'Lease start', value: 'Aug 12' },
    { label: 'Monthly', value: '$2,450' },
    { label: 'Deposit', value: '$2,450' },
    { label: 'Pets', value: '2 approved' }
  ];

  private checklist: DocumentChecklist[] = [
    { label: 'ID verification', status: 'Uploaded' },
    { label: 'Employment letter', status: 'Pending' },
    { label: 'Credit report', status: 'Synced' }
  ];

  /* ------------------------------ Header builder ----------------------------- */

  @Builder
  TopBar() {
    Row() {
      // Leading avatar / navigation placeholder.
      Column() {
      }
      .width(30)
      .height(30)
      .borderRadius(15)
      .backgroundColor(COLOR_SURFACE_VARIANT)

      Column() {
        Text('LeaseWizard')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
        Text('Guided handoff')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE_70)
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      // Trailing action placeholder (primary @ 30% alpha).
      Column() {
      }
      .width(30)
      .height(30)
      .borderRadius(15)
      .backgroundColor('#4DA07CFF')
    }
    .width('100%')
    .height(76)
    .padding({ left: SPACE_LG, right: SPACE_LG })
    .alignItems(VerticalAlign.Center)
  }

  /* ------------------------------- Step row --------------------------------- */

  @Builder
  StepBadge(index: number, reached: boolean) {
    Column() {
      Text(`${index + 1}`)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(reached ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE)
        .textAlign(TextAlign.Center)
    }
    .width(28)
    .height(28)
    .borderRadius(14)
    .backgroundColor(reached ? COLOR_PRIMARY : COLOR_SURFACE_VARIANT)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  /* ---------------------------------- UI ------------------------------------ */

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: SPACE_MD }) {

          /* ------------------------------ Steps card ---------------------------- */
          Column({ space: SPACE_SM }) {
            Text('Steps')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(COLOR_ON_SURFACE)
              .width('100%')
              .textAlign(TextAlign.Start)

            ForEach(this.steps, (step: WizardStep, index: number) => {
              Row() {
                Column() {
                  this.StepBadge(index, index <= this.currentStep)

                  if (index !== this.steps.length - 1) {
                    Column() {
                    }
                    .width(4)
                    .height(32)
                    .backgroundColor(COLOR_SURFACE_VARIANT)
                  }
                }
                .width(28)
                .alignItems(HorizontalAlign.Center)

                Column() {
                  Text(step.title)
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(COLOR_ON_SURFACE)
                  Text(step.description)
                    .fontSize(13)
                    .fontColor(COLOR_ON_SURFACE_70)
                    .margin({ top: 2 })
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)
                .margin({ left: SPACE_MD, right: SPACE_MD })

                Button(index <= this.currentStep ? 'Edit' : 'Go')
                  .type(ButtonType.Normal)
                  .width(80)
                  .height(40)
                  .borderRadius(RADIUS_SMALL)
                  .backgroundColor(COLOR_SECONDARY)
                  .fontColor(COLOR_ON_SECONDARY)
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .onClick(() => {
                    this.currentStep = index;
                  })
              }
              .width('100%')
              .alignItems(VerticalAlign.Top)
            }, (step: WizardStep, index: number) => `${index}-${step.title}`)
          }
          .width('100%')
          .padding(SPACE_MD)
          .borderRadius(RADIUS_LARGE)
          .backgroundColor(COLOR_SURFACE_TONAL)
          .alignItems(HorizontalAlign.Start)

          /* ------------------------------- Form card ---------------------------- */
          Column({ space: SPACE_SM }) {
            Text('Form')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(COLOR_ON_SURFACE)
              .width('100%')
              .textAlign(TextAlign.Start)

            // Full name
            Column() {
              Text('Full name')
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE_70)
              TextInput({ text: this.name, placeholder: 'Full name' })
                .backgroundColor(Color.Transparent)
                .padding(0)
                .height(28)
                .fontSize(13)
                .fontColor(COLOR_ON_SURFACE)
                .placeholderColor(COLOR_OUTLINE)
                .onChange((value: string) => {
                  this.name = value;
                })
            }
            .width('100%')
            .padding({ left: SPACE_SM, right: SPACE_SM, top: SPACE_XXS, bottom: SPACE_XXS })
            .borderRadius(RADIUS_SMALL)
            .borderWidth(1)
            .borderColor(COLOR_OUTLINE)
            .alignItems(HorizontalAlign.Start)

            // Contact
            Column() {
              Text('Contact')
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE_70)
              TextInput({ text: this.contact, placeholder: 'Contact' })
                .backgroundColor(Color.Transparent)
                .padding(0)
                .height(28)
                .fontSize(13)
                .fontColor(COLOR_ON_SURFACE)
                .placeholderColor(COLOR_OUTLINE)
                .onChange((value: string) => {
                  this.contact = value;
                })
            }
            .width('100%')
            .padding({ left: SPACE_SM, right: SPACE_SM, top: SPACE_XXS, bottom: SPACE_XXS })
            .borderRadius(RADIUS_SMALL)
            .borderWidth(1)
            .borderColor(COLOR_OUTLINE)
            .alignItems(HorizontalAlign.Start)

            // Income
            Column() {
              Text('Income')
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE_70)
              TextInput({ text: this.income, placeholder: 'Income' })
                .backgroundColor(Color.Transparent)
                .padding(0)
                .height(28)
                .fontSize(13)
                .fontColor(COLOR_ON_SURFACE)
                .placeholderColor(COLOR_OUTLINE)
                .onChange((value: string) => {
                  this.income = value;
                })
            }
            .width('100%')
            .padding({ left: SPACE_SM, right: SPACE_SM, top: SPACE_XXS, bottom: SPACE_XXS })
            .borderRadius(RADIUS_SMALL)
            .borderWidth(1)
            .borderColor(COLOR_OUTLINE)
            .alignItems(HorizontalAlign.Start)

            // Back / Next-Submit
            Row({ space: SPACE_SM }) {
              Button('Back')
                .type(ButtonType.Normal)
                .layoutWeight(1)
                .height(44)
                .borderRadius(RADIUS_MEDIUM)
                .backgroundColor(COLOR_SURFACE_VARIANT)
                .fontColor(COLOR_ON_SURFACE)
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .onClick(() => {
                  if (this.currentStep > 0) {
                    this.currentStep -= 1;
                  }
                })

              Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
                .type(ButtonType.Normal)
                .layoutWeight(1)
                .height(44)
                .borderRadius(RADIUS_MEDIUM)
                .backgroundColor(COLOR_PRIMARY)
                .fontColor(COLOR_ON_PRIMARY)
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .onClick(() => {
                  if (this.currentStep < this.steps.length - 1) {
                    this.currentStep += 1;
                  }
                })
            }
            .width('100%')
          }
          .width('100%')
          .padding(SPACE_MD)
          .borderRadius(RADIUS_LARGE)
          .backgroundColor(COLOR_SURFACE_TONAL)
          .alignItems(HorizontalAlign.Start)

          /* ----------------------------- Summary card --------------------------- */
          Column({ space: SPACE_SM }) {
            Text('Summary')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(COLOR_ON_SURFACE)
              .width('100%')
              .textAlign(TextAlign.Start)

            ForEach(this.summaryItems, (item: SummaryItem) => {
              Row() {
                Text(item.label)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(COLOR_ON_SURFACE)
                Text(item.value)
                  .fontSize(13)
                  .fontColor(COLOR_ON_SURFACE)
              }
              .width('100%')
              .padding(SPACE_SM)
              .borderRadius(RADIUS_MEDIUM)
              .backgroundColor(COLOR_SURFACE_VARIANT)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }, (item: SummaryItem) => item.label)

            Column({ space: SPACE_XS }) {
              Text('Documents')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE)
                .width('100%')
                .textAlign(TextAlign.Start)

              ForEach(this.checklist, (doc: DocumentChecklist) => {
                Row() {
                  Text(doc.label)
                    .fontSize(13)
                    .fontColor(COLOR_ON_SURFACE)
                  Text(doc.status)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(COLOR_SECONDARY)
                }
                .width('100%')
                .padding({ left: SPACE_SM, right: SPACE_SM, top: SPACE_XS, bottom: SPACE_XS })
                .borderRadius(RADIUS_SMALL)
                .backgroundColor(COLOR_SURFACE_VARIANT_80)
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center)
              }, (doc: DocumentChecklist) => doc.label)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding(SPACE_MD)
          .borderRadius(RADIUS_LARGE)
          .backgroundColor(COLOR_SURFACE_TONAL)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding({ left: SPACE_LG, right: SPACE_LG, top: SPACE_MD, bottom: SPACE_MD })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}