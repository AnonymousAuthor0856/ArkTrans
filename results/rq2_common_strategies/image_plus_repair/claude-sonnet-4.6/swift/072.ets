import router from '@ohos.router';

// Color constants
const rfBackground = '#FBF8F3';
const rfCardBg = '#F7F3EE';
const rfHeaderCircle = '#EBE2D6';
const rfSummaryRow = '#EBE2D6';
const rfTextDark = '#3D352E';
const rfTextGray = '#8A8A8E';
const rfBorder = '#C5B8A9';
const rfButtonBack = '#EBE2D6';
const rfButtonNext = '#B58B5A';
const rfBackground2 = '#FBF8F3';

@Entry
@Component
struct ContentView {
  @State fullName: string = '';
  @State organization: string = '';
  @State contact: string = '';
  @State narrative: string = '';

  build() {
    Stack() {
      // Global Background
      Column() {
        // Header
        Row() {
          Circle()
            .fill(rfHeaderCircle)
            .width(48)
            .height(48)

          Blank()

          Column({ space: 2 }) {
            Text('ReliefFund')
              .fontSize(19)
              .fontWeight(FontWeight.Bold)
              .fontColor(rfTextDark)

            Text('Civic support intake')
              .fontSize(13)
              .fontWeight(FontWeight.Normal)
              .fontColor(rfTextGray)
          }
          .alignItems(HorizontalAlign.Center)

          Blank()

          Circle()
            .fill(rfHeaderCircle)
            .width(48)
            .height(48)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 10, bottom: 20 })
        .justifyContent(FlexAlign.SpaceBetween)

        // Scrollable Content
        Scroll() {
          Column({ space: 24 }) {
            // Applicant Details Card
            Column({ space: 16 }) {
              Text('Applicant details')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(rfTextDark)
                .alignSelf(ItemAlign.Start)
                .margin({ bottom: 4 })

              // Full Name Field
              TextInput({ placeholder: 'Full name', text: this.fullName })
                .fontSize(16)
                .fontColor(rfTextDark)
                .placeholderColor('#6D5F58')
                .placeholderFont({ size: 16 })
                .padding({ left: 16, right: 16 })
                .height(48)
                .width('100%')
                .backgroundColor(rfBackground2)
                .borderRadius(16)
                .border({ width: 1.5, color: rfBorder, radius: 16 })
                .onChange((value: string) => {
                  this.fullName = value;
                })

              // Organization Field
              TextInput({ placeholder: 'Organization', text: this.organization })
                .fontSize(16)
                .fontColor(rfTextDark)
                .placeholderColor('#6D5F58')
                .placeholderFont({ size: 16 })
                .padding({ left: 16, right: 16 })
                .height(48)
                .width('100%')
                .backgroundColor(rfBackground2)
                .borderRadius(16)
                .border({ width: 1.5, color: rfBorder, radius: 16 })
                .onChange((value: string) => {
                  this.organization = value;
                })

              // Contact Field
              TextInput({ placeholder: 'Contact', text: this.contact })
                .fontSize(16)
                .fontColor(rfTextDark)
                .placeholderColor('#6D5F58')
                .placeholderFont({ size: 16 })
                .padding({ left: 16, right: 16 })
                .height(48)
                .width('100%')
                .backgroundColor(rfBackground2)
                .borderRadius(16)
                .border({ width: 1.5, color: rfBorder, radius: 16 })
                .onChange((value: string) => {
                  this.contact = value;
                })

              // Relief Narrative Field
              TextInput({ placeholder: 'Relief narrative', text: this.narrative })
                .fontSize(16)
                .fontColor(rfTextDark)
                .placeholderColor('#6D5F58')
                .placeholderFont({ size: 16 })
                .padding({ left: 16, right: 16 })
                .height(48)
                .width('100%')
                .backgroundColor(rfBackground2)
                .borderRadius(16)
                .border({ width: 1.5, color: rfBorder, radius: 16 })
                .onChange((value: string) => {
                  this.narrative = value;
                })

              // Spacer area
              Column()
                .height(90)

              // Navigation Buttons
              Row({ space: 2 }) {
                // Back Button
                Button('Back')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')
                  .backgroundColor(rfButtonBack)
                  .borderRadius(16)
                  .height(120)
                  .layoutWeight(1)
                  .onClick(() => {})

                // Next Button
                Button('Next')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')
                  .backgroundColor(rfButtonNext)
                  .borderRadius(16)
                  .height(120)
                  .layoutWeight(1)
                  .onClick(() => {})
              }
              .width('100%')
              .margin({ top: 80 })
              .justifyContent(FlexAlign.SpaceBetween)
            }
            .padding(24)
            .backgroundColor(rfCardBg)
            .borderRadius(32)
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            // Summary Card
            Column({ space: 16 }) {
              Text('Summary')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(rfTextDark)
                .alignSelf(ItemAlign.Start)

              // Summary Row
              Row() {
                Text('Requested')
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(rfTextDark)

                Blank()

                Text('$4,500')
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')
              }
              .width('100%')
              .padding(20)
              .backgroundColor(rfSummaryRow)
              .borderRadius(16)
              .justifyContent(FlexAlign.SpaceBetween)
            }
            .padding(24)
            .backgroundColor(rfCardBg)
            .borderRadius(32)
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .padding({ left: 16, right: 16, bottom: 40 })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(rfBackground)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(rfBackground)
  }
}