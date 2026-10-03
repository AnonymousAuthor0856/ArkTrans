import { InputType } from '@kit.ArkUI';

interface StepItem {
  title: string;
  description: string;
}

interface SummaryItem {
  label: string;
  value: string;
}

@Entry
@Component
struct Index {
  @State currentStep: number = 0
  @State name: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''

  private steps: Array<StepItem> = [
    { title: 'Applicant details', description: 'Enter your personal information' },
    { title: 'Review', description: 'Confirm your details' }
  ]

  private summaryItems: Array<SummaryItem> = [
    { label: 'Requested', value: '$4,500' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        // === Header / TopAppBar ===
        Row() {
          // Left Icon Placeholder
          Button() {
            Stack() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .objectFit(ImageFit.Contain)
            }
            .width(30)
            .height(30)
            .backgroundColor('#E6D5C3')
            .borderRadius(15)
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .margin({ right: 12 })

          // Center Title
          Column() {
            Text('ReliefFund')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2A1C12')
            Text('Civic support intake')
              .fontSize(14)
              .fontColor('#2A1C12')
              .opacity(0.7)
          }
          .alignItems(HorizontalAlign.Center)
          .layoutWeight(1)

          // Right Icon Placeholder
          Button() {
            Stack() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .objectFit(ImageFit.Contain)
            }
            .width(30)
            .height(30)
            .backgroundColor('#E6D5C3')
            .borderRadius(15)
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .margin({ left: 12 })
        }
        .width('100%')
        .padding({ top: 40, bottom: 20, left: 20, right: 20 })
        .justifyContent(FlexAlign.SpaceBetween)

        // === Scrollable Content ===
        Scroll() {
          Column({ space: 16 }) {
            
            // === Applicant Details Card ===
            Column() {
              Column({ space: 16 }) {
                Text('Applicant details')
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#2A1C12')
                  .textAlign(TextAlign.Start)
                  .width('100%')

                // Full Name Input
                TextInput({ placeholder: 'Full name' })
                  .placeholderColor('#5F554B')
                  .placeholderFont({ size: 18 })
                  .backgroundColor('#FAF6F0')
                  .borderWidth(1)
                  .borderColor('#D6C4B0')
                  .borderRadius(12)
                  .height(60)
                  .padding({ left: 16 })
                  .onChange((value: string) => { this.name = value })

                // Organization Input
                TextInput({ placeholder: 'Organization' })
                  .placeholderColor('#5F554B')
                  .placeholderFont({ size: 18 })
                  .backgroundColor('#FAF6F0')
                  .borderWidth(1)
                  .borderColor('#D6C4B0')
                  .borderRadius(12)
                  .height(60)
                  .padding({ left: 16 })
                  .onChange((value: string) => { this.organization = value })

                // Contact Input
                TextInput({ placeholder: 'Contact' })
                  .placeholderColor('#5F554B')
                  .placeholderFont({ size: 18 })
                  .backgroundColor('#FAF6F0')
                  .borderWidth(1)
                  .borderColor('#D6C4B0')
                  .borderRadius(12)
                  .height(60)
                  .padding({ left: 16 })
                  .onChange((value: string) => { this.contact = value })

                // Relief Narrative Input (Multi-line)
                TextInput({ placeholder: 'Relief narrative' })
                  .placeholderColor('#5F554B')
                  .placeholderFont({ size: 18 })
                  .backgroundColor('#FAF6F0')
                  .borderWidth(1)
                  .borderColor('#D6C4B0')
                  .borderRadius(12)
                  .height(120)
                  .type(InputType.Normal)
                  .textAlign(TextAlign.Start)
                  .padding({ left: 16, top: 16 })
                  .onChange((value: string) => { this.narrative = value })

                // Action Buttons
                Row({ space: 12 }) {
                  Button('Back')
                    .layoutWeight(1)
                    .height(50)
                    .backgroundColor('#E6D5C3')
                    .fontColor('#2A1C12')
                    .borderRadius(16)
                    .onClick(() => {
                      if (this.currentStep > 0) this.currentStep--
                    })

                  Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
                    .layoutWeight(1)
                    .height(50)
                    .backgroundColor('#B08960')
                    .fontColor('#FFF')
                    .borderRadius(16)
                    .onClick(() => {
                      if (this.currentStep < this.steps.length - 1) this.currentStep++
                    })
                }
              }
              .padding(20)
            }
            .width('100%')
            .backgroundColor('#FFF')
            .borderRadius(24)
            .shadow({ radius: 10, color: '#00000010', offsetY: 4 })

            // === Summary Card ===
            Column() {
              Column({ space: 12 }) {
                Text('Summary')
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#2A1C12')
                  .textAlign(TextAlign.Start)
                  .width('100%')

                ForEach(this.summaryItems, (item: SummaryItem) => {
                  Row() {
                    Text(item.label)
                      .fontSize(16)
                      .fontColor('#2A1C12')
                      .layoutWeight(1)
                    
                    Text(item.value)
                      .fontSize(16)
                      .fontColor('#2A1C12')
                      .fontWeight(FontWeight.Medium)
                  }
                  .width('100%')
                  .padding({ left: 16, right: 16, top: 12, bottom: 12 })
                  .backgroundColor('#E6D5C3')
                  .borderRadius(16)
                  .alignItems(VerticalAlign.Center)
                })
              }
              .padding(20)
            }
            .width('100%')
            .backgroundColor('#FFF')
            .borderRadius(24)
            .shadow({ radius: 10, color: '#00000010', offsetY: 4 })
          }
          .padding({ left: 20, right: 20, bottom: 40 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F6F0E3')
    }
    .width('100%')
    .height('100%')
  }
}