import { router } from '@kit.ArkUI'

class WizardStep {
  title: string = ''
  description: string = ''
}

class SummaryItem {
  label: string = ''
  value: string = ''
}

class DocumentChecklist {
  label: string = ''
  status: string = ''
}

const primaryColor: string = '#A07CFF'
const secondaryColor: string = '#F6B4D7'
const tertiaryColor: string = '#8DD3C7'
const backgroundColor: string = '#FDF8FF'
const surfaceColor: string = '#FFFFFF'
const surfaceVariantColor: string = '#EFE7FF'
const outlineColor: string = '#C9B4E6'
const successColor: string = '#6ED8A0'
const warningColor: string = '#FCD277'
const errorColor: string = '#FF8899'
const onPrimaryColor: string = '#1D0F33'
const onSecondaryColor: string = '#2B0E1C'
const onTertiaryColor: string = '#06231C'
const onBackgroundColor: string = '#1C1126'
const onSurfaceColor: string = '#24132C'

function makeSteps(): WizardStep[] {
  let s1 = new WizardStep()
  s1.title = 'Profile'
  s1.description = 'Tenant basics'
  let s2 = new WizardStep()
  s2.title = 'Income'
  s2.description = 'Proof details'
  let s3 = new WizardStep()
  s3.title = 'References'
  s3.description = 'Upload letters'
  let s4 = new WizardStep()
  s4.title = 'Summary'
  s4.description = 'Confirm submission'
  return [s1, s2, s3, s4]
}

function makeSummaryItems(): SummaryItem[] {
  let i1 = new SummaryItem()
  i1.label = 'Lease start'
  i1.value = 'Aug 12'
  let i2 = new SummaryItem()
  i2.label = 'Monthly'
  i2.value = '$2,450'
  let i3 = new SummaryItem()
  i3.label = 'Deposit'
  i3.value = '$2,450'
  let i4 = new SummaryItem()
  i4.label = 'Pets'
  i4.value = '2 approved'
  return [i1, i2, i3, i4]
}

function makeChecklist(): DocumentChecklist[] {
  let d1 = new DocumentChecklist()
  d1.label = 'ID verification'
  d1.status = 'Uploaded'
  let d2 = new DocumentChecklist()
  d2.label = 'Employment letter'
  d2.status = 'Pending'
  let d3 = new DocumentChecklist()
  d3.label = 'Credit report'
  d3.status = 'Synced'
  return [d1, d2, d3]
}

@Entry
@Component
struct Index {
  @State currentStep: number = 1
  @State nameVal: string = 'Avery Tenant'
  @State contactVal: string = 'avery@example.com'
  @State incomeVal: string = '$120k annual'
  private steps: WizardStep[] = makeSteps()
  private summaryItems: SummaryItem[] = makeSummaryItems()
  private checklist: DocumentChecklist[] = makeChecklist()

  build() {
    Column() {
      // Top App Bar
      Row() {
        Stack() {
          Circle()
            .width(30)
            .height(30)
            .fill(surfaceVariantColor)
        }
        .width(40)
        .height(40)

        Column() {
          Text('LeaseWizard')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(onSurfaceColor)
          Text('Guided handoff')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor('#99' + onSurfaceColor.substring(1))
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Stack() {
          Circle()
            .width(30)
            .height(30)
            .fill('#4DA07CFF')
        }
        .width(40)
        .height(40)
      }
      .width('100%')
      .height(56)
      .padding({ left: 8, right: 8 })
      .backgroundColor(surfaceColor)
      .alignItems(VerticalAlign.Center)

      // Scrollable content
      Scroll() {
        Column({ space: 16 }) {
          // Steps Card
          Column({ space: 12 }) {
            Text('Steps')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(onSurfaceColor)

            ForEach(this.steps, (step: WizardStep, index: number) => {
              Row({ space: 16 }) {
                Column({ space: 0 }) {
                  Stack() {
                    Circle()
                      .width(28)
                      .height(28)
                      .fill(index <= this.currentStep ? primaryColor : surfaceVariantColor)
                    Text(`${index + 1}`)
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(index <= this.currentStep ? onPrimaryColor : onSurfaceColor)
                  }
                  .width(28)
                  .height(28)

                  if (index !== this.steps.length - 1) {
                    Column()
                      .width(4)
                      .height(32)
                      .backgroundColor(surfaceVariantColor)
                  }
                }
                .alignItems(HorizontalAlign.Center)

                Column({ space: 2 }) {
                  Text(step.title)
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(onSurfaceColor)
                  Text(step.description)
                    .fontSize(13)
                    .fontColor('#B3' + onSurfaceColor.substring(1))
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

                Button(index <= this.currentStep ? 'Edit' : 'Go')
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(onSecondaryColor)
                  .backgroundColor(secondaryColor)
                  .borderRadius(8)
                  .height(32)
                  .padding({ left: 12, right: 12 })
                  .onClick(() => {
                    this.currentStep = index
                  })
              }
              .width('100%')
              .alignItems(VerticalAlign.Top)
            })
          }
          .width('100%')
          .padding(16)
          .backgroundColor(surfaceColor)
          .borderRadius(24)
          .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 4 })
          .alignItems(HorizontalAlign.Start)

          // Form Card
          Column({ space: 12 }) {
            Text('Form')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(onSurfaceColor)

            Column() {
              Text('Full name')
                .fontSize(11)
                .fontColor('#99' + onSurfaceColor.substring(1))
                .margin({ bottom: 4 })
              TextInput({ text: this.nameVal })
                .width('100%')
                .height(48)
                .fontSize(13)
                .fontColor(onSurfaceColor)
                .backgroundColor(surfaceColor)
                .border({ width: 1, color: outlineColor, radius: 8 })
                .padding({ left: 12, right: 12 })
                .onChange((val: string) => {
                  this.nameVal = val
                })
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')

            Column() {
              Text('Contact')
                .fontSize(11)
                .fontColor('#99' + onSurfaceColor.substring(1))
                .margin({ bottom: 4 })
              TextInput({ text: this.contactVal })
                .width('100%')
                .height(48)
                .fontSize(13)
                .fontColor(onSurfaceColor)
                .backgroundColor(surfaceColor)
                .border({ width: 1, color: outlineColor, radius: 8 })
                .padding({ left: 12, right: 12 })
                .onChange((val: string) => {
                  this.contactVal = val
                })
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')

            Column() {
              Text('Income')
                .fontSize(11)
                .fontColor('#99' + onSurfaceColor.substring(1))
                .margin({ bottom: 4 })
              TextInput({ text: this.incomeVal })
                .width('100%')
                .height(48)
                .fontSize(13)
                .fontColor(onSurfaceColor)
                .backgroundColor(surfaceColor)
                .border({ width: 1, color: outlineColor, radius: 8 })
                .padding({ left: 12, right: 12 })
                .onChange((val: string) => {
                  this.incomeVal = val
                })
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')

            Row({ space: 12 }) {
              Button('Back')
                .layoutWeight(1)
                .height(44)
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(onSurfaceColor)
                .backgroundColor(surfaceVariantColor)
                .borderRadius(14)
                .onClick(() => {
                  if (this.currentStep > 0) {
                    this.currentStep -= 1
                  }
                })

              Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
                .layoutWeight(1)
                .height(44)
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(onPrimaryColor)
                .backgroundColor(primaryColor)
                .borderRadius(14)
                .onClick(() => {
                  if (this.currentStep < this.steps.length - 1) {
                    this.currentStep += 1
                  }
                })
            }
            .width('100%')
          }
          .width('100%')
          .padding(16)
          .backgroundColor(surfaceColor)
          .borderRadius(24)
          .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 4 })
          .alignItems(HorizontalAlign.Start)

          // Summary Card
          Column({ space: 12 }) {
            Text('Summary')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(onSurfaceColor)

            ForEach(this.summaryItems, (item: SummaryItem) => {
              Row() {
                Text(item.label)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(onSurfaceColor)
                Text(item.value)
                  .fontSize(13)
                  .fontColor(onSurfaceColor)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .padding(12)
              .backgroundColor(surfaceVariantColor)
              .borderRadius(14)
            })

            Column({ space: 8 }) {
              Text('Documents')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(onSurfaceColor)

              ForEach(this.checklist, (doc: DocumentChecklist) => {
                Row() {
                  Text(doc.label)
                    .fontSize(13)
                    .fontColor(onSurfaceColor)
                  Text(doc.status)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(secondaryColor)
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)
                .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                .backgroundColor('#CCF6B4D7')
                .borderRadius(8)
              })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(surfaceColor)
          .borderRadius(24)
          .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
          .alignItems(HorizontalAlign.Start)
        }
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(backgroundColor)
  }
}