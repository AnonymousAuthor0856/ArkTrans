class WizardStep {
  title: string
  description: string

  constructor(title: string, description: string) {
    this.title = title
    this.description = description
  }
}

class SummaryItem {
  label: string
  value: string

  constructor(label: string, value: string) {
    this.label = label
    this.value = value
  }
}

class DocumentChecklist {
  label: string
  status: string

  constructor(label: string, status: string) {
    this.label = label
    this.status = status
  }
}

const COLOR_PRIMARY: string = '#A07CFF'
const COLOR_PRIMARY_SOFT: string = '#D9CAFF'
const COLOR_SECONDARY: string = '#F6B4D7'
const COLOR_BACKGROUND: string = '#FDF8FF'
const COLOR_SURFACE: string = '#FFFFFF'
const COLOR_SURFACE_VARIANT: string = '#EFE7FF'
const COLOR_OUTLINE: string = '#C9B4E6'
const COLOR_ON_PRIMARY: string = '#1D0F33'
const COLOR_ON_SECONDARY: string = '#2B0E1C'
const COLOR_ON_SURFACE: string = '#24132C'
const COLOR_MUTED: string = '#685B70'

@Entry
@Component
struct LeaseWizard {
  @State currentStep: number = 1
  @State fullName: string = 'Avery Tenant'
  @State contact: string = 'avery@example.com'
  @State income: string = '$120k annual'

  private steps: WizardStep[] = [
    new WizardStep('Profile', 'Tenant basics'),
    new WizardStep('Income', 'Proof details'),
    new WizardStep('References', 'Upload letters'),
    new WizardStep('Summary', 'Confirm submission')
  ]

  private summaryItems: SummaryItem[] = [
    new SummaryItem('Lease start', 'Aug 12'),
    new SummaryItem('Monthly', '$2,450'),
    new SummaryItem('Deposit', '$2,450'),
    new SummaryItem('Pets', '2 approved')
  ]

  private checklist: DocumentChecklist[] = [
    new DocumentChecklist('ID verification', 'Uploaded'),
    new DocumentChecklist('Employment letter', 'Pending'),
    new DocumentChecklist('Credit report', 'Synced')
  ]

  @Builder
  HeaderDot(color: string) {
    Circle()
      .width(60)
      .height(60)
      .fill(color)
      .opacity(0.72)
  }

  @Builder
  StepRow(step: WizardStep, index: number) {
    Row() {
      Column() {
        Stack() {
          Circle()
            .width(56)
            .height(56)
            .fill(index <= this.currentStep ? COLOR_PRIMARY : '#F3ECFF')
          Text((index + 1).toString())
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(index <= this.currentStep ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE)
        }
        .width(56)
        .height(56)

        if (index !== this.steps.length - 1) {
          Rect()
            .width(8)
            .height(65)
            .fill(COLOR_SURFACE)
            .opacity(0.45)
        }
      }
      .width(56)
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text(step.title)
          .fontSize(29)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
          .lineHeight(34)
          .maxLines(1)
        Text(step.description)
          .fontSize(25)
          .fontColor(COLOR_MUTED)
          .lineHeight(30)
          .maxLines(1)
      }
      .layoutWeight(1)
      .padding({ left: 32 })
      .alignItems(HorizontalAlign.Start)

      Button(index <= this.currentStep ? 'Edit' : 'Go')
        .width(133)
        .height(80)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SECONDARY)
        .backgroundColor(COLOR_SECONDARY)
        .borderRadius(16)
        .onClick(() => {
          this.currentStep = index
        })
    }
    .width('100%')
    .height(index === this.steps.length - 1 ? 80 : 121)
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  LabeledInput(label: string, value: string, onChange: (value: string) => void) {
    Stack({ alignContent: Alignment.TopStart }) {
      TextInput({ text: value })
        .width('100%')
        .height(110)
        .fontSize(29)
        .fontColor(COLOR_ON_SURFACE)
        .padding({ left: 30, right: 24, top: 12 })
        .backgroundColor(COLOR_SURFACE_VARIANT)
        .border({
          width: 2,
          color: COLOR_OUTLINE,
          radius: 16
        })
        .onChange(onChange)

      Text(label)
        .fontSize(24)
        .fontColor(COLOR_MUTED)
        .backgroundColor(COLOR_SURFACE_VARIANT)
        .padding({ left: 8, right: 8 })
        .margin({ left: 24, top: -18 })
    }
    .width('100%')
    .height(116)
    .margin({ top: 12 })
  }

  @Builder
  SummaryRow(item: SummaryItem) {
    Row() {
      Text(item.label)
        .fontSize(23)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)
      Text(item.value)
        .fontSize(22)
        .fontColor(COLOR_ON_SURFACE)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 20, bottom: 20 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(18)
  }

  @Builder
  DocumentRow(doc: DocumentChecklist) {
    Row() {
      Text(doc.label)
        .fontSize(22)
        .fontColor(COLOR_ON_SURFACE)
      Text(doc.status)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_SECONDARY)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 16, bottom: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#F4EEFF')
    .borderRadius(12)
  }

  build() {
    Column() {
      Row() {
        this.HeaderDot(COLOR_SURFACE_VARIANT)
        Column() {
          Text('LeaseWizard')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_ON_SURFACE)
            .lineHeight(36)
          Text('Guided handoff')
            .fontSize(23)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_MUTED)
            .lineHeight(29)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        this.HeaderDot(COLOR_PRIMARY_SOFT)
      }
      .width('100%')
      .height(128)
      .padding({ left: 26, right: 26, top: 34 })
      .alignItems(VerticalAlign.Top)

      Scroll() {
        Column({ space: 32 }) {
          Column() {
            Column({ space: 24 }) {
              Text('Steps')
                .fontSize(40)
                .fontWeight(FontWeight.Bold)
                .fontColor(COLOR_ON_SURFACE)
                .lineHeight(48)

              ForEach(this.steps, (step: WizardStep, index: number) => {
                this.StepRow(step, index)
              }, (step: WizardStep, index: number) => `${index}-${step.title}`)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding(32)
          .borderRadius(48)
          .backgroundColor(COLOR_SURFACE_VARIANT)

          Column() {
            Column({ space: 22 }) {
              Text('Form')
                .fontSize(40)
                .fontWeight(FontWeight.Bold)
                .fontColor(COLOR_ON_SURFACE)
                .lineHeight(48)

              this.LabeledInput('Full name', this.fullName, (value: string) => {
                this.fullName = value
              })
              this.LabeledInput('Contact', this.contact, (value: string) => {
                this.contact = value
              })
              this.LabeledInput('Income', this.income, (value: string) => {
                this.income = value
              })

              Row({ space: 20 }) {
                Button('Back')
                  .layoutWeight(1)
                  .height(72)
                  .fontSize(24)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(COLOR_ON_SURFACE)
                  .backgroundColor(COLOR_SURFACE)
                  .borderRadius(24)
                  .onClick(() => {
                    if (this.currentStep > 0) {
                      this.currentStep -= 1
                    }
                  })

                Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
                  .layoutWeight(1)
                  .height(72)
                  .fontSize(24)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(COLOR_ON_PRIMARY)
                  .backgroundColor(COLOR_PRIMARY)
                  .borderRadius(24)
                  .onClick(() => {
                    if (this.currentStep < this.steps.length - 1) {
                      this.currentStep += 1
                    }
                  })
              }
              .width('100%')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding(32)
          .borderRadius(48)
          .backgroundColor(COLOR_SURFACE_VARIANT)

          Column() {
            Column({ space: 16 }) {
              Text('Summary')
                .fontSize(40)
                .fontWeight(FontWeight.Bold)
                .fontColor(COLOR_ON_SURFACE)
                .lineHeight(48)

              ForEach(this.summaryItems, (item: SummaryItem) => {
                this.SummaryRow(item)
              }, (item: SummaryItem) => item.label)

              Column({ space: 12 }) {
                Text('Documents')
                  .fontSize(24)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(COLOR_ON_SURFACE)
                  .margin({ top: 6 })

                ForEach(this.checklist, (doc: DocumentChecklist) => {
                  this.DocumentRow(doc)
                }, (doc: DocumentChecklist) => doc.label)
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding(32)
          .borderRadius(48)
          .backgroundColor(COLOR_SURFACE_VARIANT)
        }
        .width('100%')
        .padding({ left: 40, right: 40, top: 32, bottom: 36 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}
