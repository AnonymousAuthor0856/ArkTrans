// Index.ets

class FormStep {
  title: string
  description: string
  constructor(title: string, description: string) {
    this.title = title
    this.description = description
  }
}

class SupportChip {
  label: string
  constructor(label: string) {
    this.label = label
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

const primaryColor = '#FFB58B5A'
const secondaryColor = '#FFE5C48F'
const tertiaryColor = '#FF8BB39B'
const backgroundColor = '#FFF6F0E3'
const surfaceColor = '#FFFFFFFF'
const surfaceVariantColor = '#FFE7D7C2'
const outlineColor = '#FFC3B09E'
const onPrimaryColor = '#FF2D1A0D'
const onSecondaryColor = '#FF2F230C'
const onSurfaceColor = '#FF2A1C12'

@Entry
@Component
struct RootScreen {
  steps: FormStep[] = [
    new FormStep('Identity', 'Applicant basics'),
    new FormStep('Impact', 'Community reach'),
    new FormStep('Needs', 'Immediate relief'),
    new FormStep('Summary', 'Confirm details')
  ]
  chips: SupportChip[] = [
    new SupportChip('Medical'),
    new SupportChip('Shelter'),
    new SupportChip('Food'),
    new SupportChip('Utilities')
  ]
  summary: SummaryItem[] = [
    new SummaryItem('Requested', '$4,500'),
    new SummaryItem('Households', '36'),
    new SummaryItem('Region', 'North loop'),
    new SummaryItem('Urgency', '48h')
  ]
  @State currentStep: number = 1
  @State nameVal: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''
  @State selectedChip: number = 0

  build() {
    Column() {
      // Top App Bar
      Row() {
        Stack() {
          Circle({ width: 30, height: 30 })
            .fill(surfaceVariantColor)
        }
        .width(40)
        .height(40)
        .margin({ left: 8 })

        Column() {
          Text('ReliefFund')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(onSurfaceColor)
          Text('Civic support intake')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor('#AA2A1C12')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Stack() {
          Circle({ width: 30, height: 30 })
            .fill('#59B58B5A')
        }
        .width(40)
        .height(40)
        .margin({ right: 8 })
      }
      .width('100%')
      .height(56)
      .backgroundColor(surfaceColor)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column({ space: 16 }) {
          // Steps Card
          Column({ space: 12 }) {
            Text('Steps')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(onSurfaceColor)

            ForEach(this.steps, (step: FormStep, index: number) => {
              Row({ space: 12 }) {
                Column({ space: 0 }) {
                  Stack() {
                    Circle({ width: 26, height: 26 })
                      .fill(index <= this.currentStep ? primaryColor : surfaceVariantColor)
                    Text(`${index + 1}`)
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(index <= this.currentStep ? onPrimaryColor : onSurfaceColor)
                  }
                  .width(26)
                  .height(26)

                  if (index !== this.steps.length - 1) {
                    Column()
                      .width(3)
                      .height(28)
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
                    .fontColor('#AA2A1C12')
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
          .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
          .alignItems(HorizontalAlign.Start)

          // Focus / Chips Card
          Column({ space: 12 }) {
            Text('Focus')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(onSurfaceColor)

            Row({ space: 12 }) {
              ForEach(this.chips, (chip: SupportChip, index: number) => {
                Text(chip.label)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(onSurfaceColor)
                  .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                  .backgroundColor(this.selectedChip === index ? '#33B58B5A' : surfaceVariantColor)
                  .borderRadius(8)
                  .border({
                    width: 1,
                    color: this.selectedChip === index ? primaryColor : outlineColor,
                    radius: 8
                  })
                  .onClick(() => {
                    this.selectedChip = index
                  })
              })
            }
            .width('100%')
          }
          .width('100%')
          .padding(16)
          .backgroundColor(surfaceColor)
          .borderRadius(24)
          .shadow({ radius: 4, color: '#1E000000', offsetX: 0, offsetY: 2 })
          .alignItems(HorizontalAlign.Start)

          // Applicant Details Card
          Column({ space: 12 }) {
            Text('Applicant details')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(onSurfaceColor)

            Column() {
              Text('Full name')
                .fontSize(11)
                .fontColor('#AA2A1C12')
                .margin({ bottom: 4 })
              TextInput({ text: this.nameVal, placeholder: 'Full name' })
                .width('100%')
                .height(48)
                .backgroundColor(surfaceColor)
                .border({ width: 1, color: outlineColor, radius: 8 })
                .fontSize(13)
                .fontColor(onSurfaceColor)
                .onChange((val: string) => {
                  this.nameVal = val
                })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            Column() {
              Text('Organization')
                .fontSize(11)
                .fontColor('#AA2A1C12')
                .margin({ bottom: 4 })
              TextInput({ text: this.organization, placeholder: 'Organization' })
                .width('100%')
                .height(48)
                .backgroundColor(surfaceColor)
                .border({ width: 1, color: outlineColor, radius: 8 })
                .fontSize(13)
                .fontColor(onSurfaceColor)
                .onChange((val: string) => {
                  this.organization = val
                })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            Column() {
              Text('Contact')
                .fontSize(11)
                .fontColor('#AA2A1C12')
                .margin({ bottom: 4 })
              TextInput({ text: this.contact, placeholder: 'Contact' })
                .width('100%')
                .height(48)
                .backgroundColor(surfaceColor)
                .border({ width: 1, color: outlineColor, radius: 8 })
                .fontSize(13)
                .fontColor(onSurfaceColor)
                .onChange((val: string) => {
                  this.contact = val
                })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            Column() {
              Text('Relief narrative')
                .fontSize(11)
                .fontColor('#AA2A1C12')
                .margin({ bottom: 4 })
              TextArea({ text: this.narrative, placeholder: 'Relief narrative' })
                .width('100%')
                .height(80)
                .backgroundColor(surfaceColor)
                .border({ width: 1, color: outlineColor, radius: 8 })
                .fontSize(13)
                .fontColor(onSurfaceColor)
                .onChange((val: string) => {
                  this.narrative = val
                })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

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
          .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
          .alignItems(HorizontalAlign.Start)

          // Summary Card
          Column({ space: 8 }) {
            Text('Summary')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(onSurfaceColor)

            ForEach(this.summary, (item: SummaryItem) => {
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
              .alignItems(VerticalAlign.Center)
              .padding(12)
              .backgroundColor(surfaceVariantColor)
              .borderRadius(14)
            })
          }
          .width('100%')
          .padding(16)
          .backgroundColor(surfaceColor)
          .borderRadius(24)
          .shadow({ radius: 4, color: '#1E000000', offsetX: 0, offsetY: 2 })
          .alignItems(HorizontalAlign.Start)
          .margin({ bottom: 24 })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 12, bottom: 12 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(backgroundColor)
  }
}