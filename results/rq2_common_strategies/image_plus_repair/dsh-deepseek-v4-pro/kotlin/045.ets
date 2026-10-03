// 045 - After-Sale Service (Clay Morph / ECommerce)
// Translated from Kotlin Jetpack Compose to ArkTS (ArkUI)

const COLOR_PRIMARY = '#8E6BF2';
const COLOR_SECONDARY = '#D3C1FF';
const COLOR_TERTIARY = '#B39DDB';
const COLOR_BACKGROUND = '#F5F3FF';
const COLOR_SURFACE = '#FFFFFF';
const COLOR_SURFACE_VARIANT = '#ECE6F8';
const COLOR_OUTLINE = '#D1C4E9';
const COLOR_SUCCESS = '#4CAF50';
const COLOR_WARNING = '#FFB300';
const COLOR_ERROR = '#E53935';
const COLOR_ON_PRIMARY = '#FFFFFF';
const COLOR_ON_SECONDARY = '#2E1A47';
const COLOR_ON_BACKGROUND = '#2E1A47';
const COLOR_ON_SURFACE = '#2E1A47';

const SPACING_SM = 6;
const SPACING_MD = 10;
const SPACING_LG = 16;
const SPACING_XL = 24;

const SHAPE_SMALL = 8;
const SHAPE_MEDIUM = 14;
const SHAPE_LARGE = 20;

const FONT_DISPLAY = 28;
const FONT_TITLE = 18;
const FONT_BODY = 14;
const FONT_LABEL = 12;

@Entry
@Component
struct RootScreen {
  @State orderId: string = '';
  @State issue: string = '';
  @State submitted: boolean = false;

  build() {
    Column({ space: SPACING_LG }) {
      Text('After-Sale Service')
        .fontSize(FONT_DISPLAY)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_BACKGROUND)

      Column({ space: SPACING_MD }) {
        Text('Order ID')
          .fontSize(FONT_TITLE)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)

        TextInput({ placeholder: 'Enter order number', text: this.orderId })
          .width('100%')
          .backgroundColor(COLOR_SURFACE_VARIANT)
          .borderRadius(SHAPE_MEDIUM)
          .placeholderColor('#802E1A47')
          .placeholderFont({ size: FONT_BODY })
          .fontColor(COLOR_ON_SURFACE)
          .onChange((value: string) => {
            this.orderId = value;
          })

        Text('Issue Description')
          .fontSize(FONT_TITLE)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)

        TextArea({ placeholder: 'Describe your issue', text: this.issue })
          .width('100%')
          .height(120)
          .backgroundColor(COLOR_SURFACE_VARIANT)
          .borderRadius(SHAPE_MEDIUM)
          .placeholderColor('#802E1A47')
          .placeholderFont({ size: FONT_BODY })
          .fontColor(COLOR_ON_SURFACE)
          .onChange((value: string) => {
            this.issue = value;
          })
      }
      .width('100%')
      .padding(SPACING_LG)
      .backgroundColor(COLOR_SURFACE)
      .borderRadius(SHAPE_LARGE)
      .shadow({ radius: 12, color: '#38D3C1FF', offsetX: 0, offsetY: 4 })

      Button() {
        Text('Submit Request')
          .fontSize(FONT_TITLE)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_PRIMARY)
      }
      .width('100%')
      .height(56)
      .backgroundColor(COLOR_PRIMARY)
      .borderRadius(SHAPE_LARGE)
      .onClick(() => {
        this.submitted = true;
      })

      if (this.submitted) {
        Stack() {
          Text('Request submitted successfully!')
            .fontSize(FONT_BODY)
            .fontWeight(FontWeight.Normal)
            .fontColor(COLOR_SUCCESS)
        }
        .width('100%')
        .backgroundColor('#264CAF50')
        .borderRadius(SHAPE_MEDIUM)
        .padding(SPACING_LG)
        .alignContent(Alignment.Center)
      }
    }
    .width('100%')
    .height('100%')
    .padding(SPACING_LG)
    .backgroundColor(COLOR_BACKGROUND)
  }
}