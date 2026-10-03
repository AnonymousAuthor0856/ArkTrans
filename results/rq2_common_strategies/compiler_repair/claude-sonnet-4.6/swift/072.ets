import { router } from '@kit.ArkUI';

// Color constants
const RF_BACKGROUND = '#FBF8F3';
const RF_CARD_BG = '#F7F3EE';
const RF_HEADER_CIRCLE = '#EBE2D6';
const RF_SUMMARY_ROW = '#EBE2D6';
const RF_TEXT_DARK = '#3D352E';
const RF_TEXT_GRAY = '#8A8A8E';
const RF_BORDER = '#C5B8A9';
const RF_BUTTON_BACK = '#EBE2D6';
const RF_BUTTON_NEXT = '#B58B5A';
const RF_BACKGROUND_FIELD = '#FBF8F3';

@Entry
@Component
struct ReliefFundApp {
  @State fullName: string = '';
  @State organization: string = '';
  @State contact: string = '';
  @State narrative: string = '';

  build() {
    Column() {
      // Header
      Row() {
        Circle()
          .width(48)
          .height(48)
          .fill(RF_HEADER_CIRCLE)

        Blank()

        Column({ space: 2 }) {
          Text('ReliefFund')
            .fontSize(19)
            .fontWeight(FontWeight.Bold)
            .fontColor(RF_TEXT_DARK)

          Text('Civic support intake')
            .fontSize(13)
            .fontWeight(FontWeight.Normal)
            .fontColor(RF_TEXT_GRAY)
        }
        .alignItems(HorizontalAlign.Center)

        Blank()

        Circle()
          .width(48)
          .height(48)
          .fill(RF_HEADER_CIRCLE)
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
              .fontColor(RF_TEXT_DARK)
              .alignSelf(ItemAlign.Start)
              .margin({ bottom: 4 })

            // Full Name Field
            TextInput({ placeholder: 'Full name', text: this.fullName })
              .fontSize(16)
              .fontColor(RF_TEXT_DARK)
              .placeholderColor('#6D5F58')
              .backgroundColor(RF_BACKGROUND_FIELD)
              .borderRadius(16)
              .border({ width: 1.5, color: RF_BORDER, radius: 16 })
              .height(48)
              .width('100%')
              .onChange((value: string) => {
                this.fullName = value;
              })

            // Organization Field
            TextInput({ placeholder: 'Organization', text: this.organization })
              .fontSize(16)
              .fontColor(RF_TEXT_DARK)
              .placeholderColor('#6D5F58')
              .backgroundColor(RF_BACKGROUND_FIELD)
              .borderRadius(16)
              .border({ width: 1.5, color: RF_BORDER, radius: 16 })
              .height(48)
              .width('100%')
              .onChange((value: string) => {
                this.organization = value;
              })

            // Contact Field
            TextInput({ placeholder: 'Contact', text: this.contact })
              .fontSize(16)
              .fontColor(RF_TEXT_DARK)
              .placeholderColor('#6D5F58')
              .backgroundColor(RF_BACKGROUND_FIELD)
              .borderRadius(16)
              .border({ width: 1.5, color: RF_BORDER, radius: 16 })
              .height(48)
              .width('100%')
              .onChange((value: string) => {
                this.contact = value;
              })

            // Narrative Field (TextArea)
            TextArea({ placeholder: 'Relief narrative', text: this.narrative })
              .fontSize(16)
              .fontColor(RF_TEXT_DARK)
              .placeholderColor('#6D5F58')
              .backgroundColor(RF_BACKGROUND_FIELD)
              .borderRadius(16)
              .border({ width: 1.5, color: RF_BORDER, radius: 16 })
              .height(130)
              .width('100%')
              .onChange((value: string) => {
                this.narrative = value;
              })

            // Navigation Buttons
            Row() {
              // Back Button
              Button('Back')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
                .backgroundColor(RF_BUTTON_BACK)
                .borderRadius(16)
                .height(64)
                .layoutWeight(1)
                .margin({ right: 1 })

              // Next Button
              Button('Next')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
                .backgroundColor(RF_BUTTON_NEXT)
                .borderRadius(16)
                .height(64)
                .layoutWeight(1)
                .margin({ left: 1 })
            }
            .width('100%')
            .margin({ top: 16 })
          }
          .padding(24)
          .backgroundColor(RF_CARD_BG)
          .borderRadius(32)
          .width('100%')
          .alignItems(HorizontalAlign.Start)

          // Summary Card
          Column({ space: 16 }) {
            Text('Summary')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(RF_TEXT_DARK)
              .alignSelf(ItemAlign.Start)

            // Summary Row
            Row() {
              Text('Requested')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(RF_TEXT_DARK)

              Blank()

              Text('$4,500')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
            }
            .width('100%')
            .padding(20)
            .backgroundColor(RF_SUMMARY_ROW)
            .borderRadius(16)
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .padding(24)
          .backgroundColor(RF_CARD_BG)
          .borderRadius(32)
          .width('100%')
          .alignItems(HorizontalAlign.Start)

        }
        .padding({ left: 16, right: 16, bottom: 40 })
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(RF_BACKGROUND)
    .alignItems(HorizontalAlign.Start)
  }
}