/**
 * 031_ClipboardHistory_en.ets
 *
 * NAME            : 031_ClipboardHistory_en
 * UI_TYPE         : Productivity
 * STYLE_THEME     : Modern Blue
 * LANG            : en
 * BASELINE_SIZE   : 720x1280
 *
 * ArkTS / ArkUI port of the Kotlin Jetpack Compose source.
 */

/* ------------------------------------------------------------------ */
/* Design tokens                                                       */
/* ------------------------------------------------------------------ */

const APP_NAME: string = '031_ClipboardHistory_en';
const UI_TYPE: string = 'Productivity';
const STYLE_THEME: string = 'Modern Blue';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

/* Colors */
const COLOR_PRIMARY: string = '#007BFF';
const COLOR_SECONDARY: string = '#6C757D';
const COLOR_TERTIARY: string = '#17A2B8';
const COLOR_BACKGROUND: string = '#F8F9FA';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_SURFACE_VARIANT: string = '#E9ECEF';
const COLOR_OUTLINE: string = '#DEE2E6';
const COLOR_SUCCESS: string = '#28A745';
const COLOR_WARNING: string = '#FFC107';
const COLOR_ERROR: string = '#DC3545';
const COLOR_ON_PRIMARY: string = '#FFFFFF';
const COLOR_ON_BACKGROUND: string = '#212529';
const COLOR_ON_SURFACE: string = '#212529';
const COLOR_SHADOW_LEVEL1: string = '#1A000000';
const COLOR_SHADOW_LEVEL2: string = '#1A000000';
const COLOR_SHADOW_LEVEL3: string = '#1A000000';

/* Typography (sp) */
const FONT_DISPLAY: number = 36;
const FONT_HEADLINE: number = 28;
const FONT_TITLE: number = 22;
const FONT_BODY: number = 16;
const LINE_HEIGHT_BODY: number = 24;
const FONT_LABEL: number = 14;
const LETTER_SPACING_LABEL: number = 0.25;

/* Shape (vp) */
const RADIUS_SMALL: number = 4;
const RADIUS_MEDIUM: number = 8;
const RADIUS_LARGE: number = 12;

/* Spacing (vp) */
const SPACE_XS: number = 4;
const SPACE_SM: number = 8;
const SPACE_MD: number = 12;
const SPACE_LG: number = 16;
const SPACE_XL: number = 24;

/* Elevation mapping: radius / dy */
const ELEVATION_LEVEL1_RADIUS: number = 3;
const ELEVATION_LEVEL1_DY: number = 1;
const ELEVATION_LEVEL2_RADIUS: number = 6;
const ELEVATION_LEVEL2_DY: number = 2;
const ELEVATION_LEVEL3_RADIUS: number = 10;
const ELEVATION_LEVEL3_DY: number = 4;

/* ------------------------------------------------------------------ */
/* Model                                                               */
/* ------------------------------------------------------------------ */

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

/* ------------------------------------------------------------------ */
/* Screen                                                              */
/* ------------------------------------------------------------------ */

@Entry
@Component
struct ClipboardHistoryPage {
  @State sliderValue: number = 24;
  @State historyLimit: number = 24;

  private clipboardItems: ClipboardItem[] = [
    new ClipboardItem(1, 'https://www.example.com/modern-design', 'Link', '5 min ago', 0.2),
    new ClipboardItem(2, 'Final project review notes have been updated.', 'Text', '23 min ago', 0.5),
    new ClipboardItem(3, '#007BFF', 'Color', '1 hour ago', 0.8),
    new ClipboardItem(4, 'Meeting at 3 PM with the design team.', 'Text', '3 hours ago', 0.9),
    new ClipboardItem(5, "Shared file: 'Q3_Report.pdf'", 'File', 'Yesterday', 1.0)
  ];

  /* ---------------- Top app bar ---------------- */

  @Builder
  topBar() {
    Stack() {
      Text('Clipboard History')
        .fontSize(FONT_TITLE)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_BACKGROUND)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Row() {
        Button('Clear', { type: ButtonType.Normal, stateEffect: true })
          .fontSize(FONT_LABEL)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
          .backgroundColor(COLOR_SURFACE_VARIANT)
          .borderRadius(RADIUS_MEDIUM)
          .height(36)
          .padding({ left: SPACE_LG, right: SPACE_LG })
          .onClick(() => {
            this.clipboardItems = [];
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .padding({ right: SPACE_MD })
    }
    .width('100%')
    .height(64)
    .backgroundColor(COLOR_BACKGROUND)
  }

  /* ---------------- Clipboard card ---------------- */

  @Builder
  clipboardCard(item: ClipboardItem) {
    Column() {
      Row() {
        Row() {
          Column()
            .width(24)
            .height(24)
            .borderRadius(RADIUS_SMALL)
            .backgroundColor(COLOR_PRIMARY)
          Text(item.type)
            .fontSize(FONT_LABEL)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_PRIMARY)
            .margin({ left: SPACE_SM })
        }
        .alignItems(VerticalAlign.Center)

        Text(item.timestamp)
          .fontSize(FONT_LABEL)
          .fontColor(COLOR_SECONDARY)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)

      Text(item.content)
        .fontSize(FONT_BODY)
        .lineHeight(LINE_HEIGHT_BODY)
        .fontColor(COLOR_ON_SURFACE)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ top: SPACE_SM })

      Progress({
        value: item.progress * 100,
        total: 100,
        type: ProgressType.Linear
      })
        .color(COLOR_TERTIARY)
        .backgroundColor(COLOR_SURFACE_VARIANT)
        .style({ strokeWidth: RADIUS_SMALL })
        .width('100%')
        .margin({ top: SPACE_MD })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(SPACE_MD)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(RADIUS_LARGE)
    .border({ width: 1, color: COLOR_SURFACE_VARIANT })
    .shadow({
      radius: ELEVATION_LEVEL1_RADIUS,
      color: COLOR_SHADOW_LEVEL1,
      offsetX: 0,
      offsetY: ELEVATION_LEVEL1_DY
    })
  }

  /* ---------------- Bottom settings pane ---------------- */

  @Builder
  settingsPane() {
    Column() {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(FONT_LABEL)
          .fontColor(COLOR_ON_SURFACE)
          .layoutWeight(1)

        Text(Math.round(this.sliderValue).toString())
          .fontSize(FONT_BODY)
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
        style: SliderStyle.OutSet,
        direction: Axis.Horizontal,
        reverse: false
      })
        .width('100%')
        .blockColor(COLOR_PRIMARY)
        .selectedColor(COLOR_PRIMARY)
        .trackColor(COLOR_SURFACE_VARIANT)
        .trackThickness(8)
        .blockSize({ width: 4, height: 24 })
        .margin({ top: SPACE_MD })
        .onChange((value: number, mode: SliderChangeMode) => {
          this.sliderValue = value;
          this.historyLimit = Math.round(value);
        })
    }
    .width('100%')
    .padding(SPACE_LG)
    .backgroundColor(COLOR_SURFACE)
    .shadow({
      radius: ELEVATION_LEVEL2_RADIUS,
      color: COLOR_SHADOW_LEVEL2,
      offsetX: 0,
      offsetY: -ELEVATION_LEVEL2_DY
    })
  }

  /* ---------------- Root ---------------- */

  build() {
    Column() {
      this.topBar()

      List({ space: SPACE_MD }) {
        ForEach(this.clipboardItems, (item: ClipboardItem) => {
          ListItem() {
            this.clipboardCard(item)
          }
        }, (item: ClipboardItem) => item.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: SPACE_LG,
        right: SPACE_LG,
        top: SPACE_MD,
        bottom: SPACE_MD
      })
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      this.settingsPane()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}