// Translated from 030.kt (Kotlin/Jetpack Compose) to ArkTS (ArkUI/HarmonyOS).
// Source metadata: NAME="031_ClipboardHistory_en", UI_TYPE="Productivity",
// STYLE_THEME="Modern Blue", LANG="en", BASELINE_SIZE="720x1280".

const COLOR_PRIMARY = '#007BFF';
const COLOR_SECONDARY = '#6C757D';
const COLOR_TERTIARY = '#17A2B8';
const COLOR_BACKGROUND = '#F8F9FA';
const COLOR_SURFACE = '#FFFFFF';
const COLOR_SURFACE_VARIANT = '#E9ECEF';
const COLOR_OUTLINE = '#DEE2E6';
const COLOR_SUCCESS = '#28A745';
const COLOR_WARNING = '#FFC107';
const COLOR_ERROR = '#DC3545';
const COLOR_ON_PRIMARY = '#FFFFFF';
const COLOR_ON_SECONDARY = '#FFFFFF';
const COLOR_ON_TERTIARY = '#FFFFFF';
const COLOR_ON_BACKGROUND = '#212529';
const COLOR_ON_SURFACE = '#212529';

const SPACING_XS = 4;
const SPACING_SM = 8;
const SPACING_MD = 12;
const SPACING_LG = 16;
const SPACING_XL = 24;

const SHAPE_SMALL = 4;
const SHAPE_MEDIUM = 8;
const SHAPE_LARGE = 12;

class ClipboardItem {
  id: number;
  content: string;
  type: string;
  timestamp: string;
  progress: number;

  constructor(id: number, content: string, type: string, timestamp: string, progress: number) {
    this.id = id;
    this.content = content;
    this.type = type;
    this.timestamp = timestamp;
    this.progress = progress;
  }
}

@Component
struct ClipboardCard {
  item: ClipboardItem = new ClipboardItem(0, '', '', '', 0);

  build() {
    Column() {
      Row({ space: SPACING_SM }) {
        Row()
          .width(24)
          .height(24)
          .backgroundColor(COLOR_PRIMARY)
          .borderRadius(SHAPE_SMALL)
        Text(this.item.type)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_PRIMARY)
          .letterSpacing(0.25)
        Blank()
        Text(this.item.timestamp)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_SECONDARY)
          .letterSpacing(0.25)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Row().height(SPACING_SM)

      Text(this.item.content)
        .fontSize(16)
        .lineHeight(24)
        .fontColor(COLOR_ON_SURFACE)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Row().height(SPACING_MD)

      Progress({ value: this.item.progress * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(4)
        .color(COLOR_TERTIARY)
        .backgroundColor(COLOR_SURFACE_VARIANT)
        .borderRadius(SHAPE_SMALL)
    }
    .padding(SPACING_MD)
    .width('100%')
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(SHAPE_LARGE)
    .border({ width: 1, color: COLOR_SURFACE_VARIANT })
  }
}

@Entry
@Component
struct RootScreen {
  @State sliderValue: number = 24;
  private clipboardItems: ClipboardItem[] = [
    new ClipboardItem(1, 'https://www.example.com/modern-design', 'Link', '5 min ago', 0.2),
    new ClipboardItem(2, 'Final project review notes have been updated.', 'Text', '23 min ago', 0.5),
    new ClipboardItem(3, '#007BFF', 'Color', '1 hour ago', 0.8),
    new ClipboardItem(4, 'Meeting at 3 PM with the design team.', 'Text', '3 hours ago', 0.9),
    new ClipboardItem(5, "Shared file: 'Q3_Report.pdf'", 'File', 'Yesterday', 1.0)
  ];

  build() {
    Column() {
      this.TopBar()

      List({ space: SPACING_MD }) {
        ForEach(this.clipboardItems, (item: ClipboardItem) => {
          ListItem() {
            ClipboardCard({ item: item })
          }
          .width('100%')
        }, (item: ClipboardItem) => item.id.toString())
      }
      .layoutWeight(1)
      .width('100%')
      .padding({
        left: SPACING_LG,
        right: SPACING_LG,
        top: SPACING_MD,
        bottom: SPACING_MD
      })

      this.SettingsPane()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }

  @Builder
  TopBar() {
    Stack({ alignContent: Alignment.Center }) {
      Text('Clipboard History')
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)

      Row() {
        Blank()
        Button('Clear')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
          .backgroundColor(COLOR_SURFACE_VARIANT)
          .borderRadius(SHAPE_MEDIUM)
          .height(36)
          .margin({ right: SPACING_MD })
          .onClick(() => {})
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height(64)
    .backgroundColor(COLOR_SURFACE)
  }

  @Builder
  SettingsPane() {
    Column() {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
          .letterSpacing(0.25)
        Blank()
        Text(Math.round(this.sliderValue).toString())
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Slider({
        value: this.sliderValue,
        min: 1,
        max: 72,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .selectedColor(COLOR_PRIMARY)
        .blockColor(COLOR_PRIMARY)
        .trackColor(COLOR_SURFACE_VARIANT)
        .onChange((value: number, mode: SliderChangeMode) => {
          this.sliderValue = value;
        })
    }
    .padding(SPACING_LG)
    .width('100%')
    .backgroundColor(COLOR_SURFACE)
  }
}
