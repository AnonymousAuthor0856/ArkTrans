const SCREEN_PADDING: number = 24;
const HEADER_TOP_PADDING: number = 16;
const HEADER_SPACER_HEIGHT: number = 40;
const DIAL_SECTION_SPACER_HEIGHT: number = 40;
const DIAL_OUTER_BOX_SIZE: number = 280;
const DIAL_CANVAS_SIZE: number = 240;
const DIAL_STROKE_WIDTH: number = 40;
const TEMP_CONTROLS_SPACER_HEIGHT: number = 32;
const TEMP_CONTROLS_HORIZONTAL_SPACING: number = 32;
const ROUND_CONTROL_BUTTON_SIZE: number = 56;
const ROUND_CONTROL_BUTTON_ICON_SIZE: number = 28;
const QUICK_ACTIONS_TITLE_BOTTOM_PADDING: number = 16;
const QUICK_ACTIONS_ROW_SPACING: number = 16;
const QUICK_ACTION_CARD_HEIGHT: number = 100;
const QUICK_ACTION_CARD_CORNER_RADIUS: number = 20;
const QUICK_ACTION_CARD_PADDING: number = 16;
const QUICK_ACTION_CARD_ICON_SIZE: number = 24;
const LETTER_SPACING_SMALL: number = 2;
const FONT_SIZE_LABEL_MEDIUM: number = 13;
const FONT_SIZE_BODY_SMALL: number = 11;
const FONT_SIZE_DISPLAY_MEDIUM: number = 45;
const FONT_SIZE_LABEL_LARGE: number = 15;
const FONT_SIZE_LABEL_SMALL: number = 11;

const CLIMATE_WHITE: string = '#FFFFFF';
const CLIMATE_TEXT_BLACK: string = '#1C1C1E';
const CLIMATE_TEXT_GRAY: string = '#8E8E93';
const CLIMATE_BLUE: string = '#007AFF';
const CLIMATE_SOFT_GRAY: string = '#F2F2F7';
const CLIMATE_LIGHT_GRAY: string = '#F9F9F9';
const CLIMATE_BORDER_GRAY: string = '#EEEEEE';
const CLIMATE_DISABLED: string = '#D1D1D6';

@Entry
@Component
struct ClimateControllerView {
  build() {
    Stack() {
      Column() {
        HeaderSection()
          .margin({ top: HEADER_TOP_PADDING })

        Blank()
          .height(HEADER_SPACER_HEIGHT)

        TemperatureDialSection()

        Blank()
          .height(DIAL_SECTION_SPACER_HEIGHT)

        ControlGridSection()

        Blank()
      }
      .padding({ left: SCREEN_PADDING, right: SCREEN_PADDING })
      .width('100%')
      .height('100%')
    }
    .backgroundColor(CLIMATE_WHITE)
    .width('100%')
    .height('100%')
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Button() {
        Text('☰')
          .fontSize(ROUND_CONTROL_BUTTON_ICON_SIZE)
          .fontColor(CLIMATE_TEXT_BLACK)
      }
      .backgroundColor(Color.Transparent)

      Blank()

      Column() {
        Text('LIVING ROOM')
          .fontSize(FONT_SIZE_LABEL_MEDIUM)
          .fontWeight(FontWeight.Bold)
          .fontColor(CLIMATE_TEXT_GRAY)
          .letterSpacing(LETTER_SPACING_SMALL)

        Text('Connected')
          .fontSize(FONT_SIZE_BODY_SMALL)
          .fontColor(CLIMATE_BLUE)
      }
      .alignItems(HorizontalAlign.Center)

      Blank()

      Button() {
        Text('⚙')
          .fontSize(ROUND_CONTROL_BUTTON_ICON_SIZE)
          .fontColor(CLIMATE_TEXT_BLACK)
      }
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TemperatureDialSection {
  @State targetTemp: number = 21.5;
  @State isActive: boolean = true;

  private adjustTemp(delta: number) {
    let next: number = this.targetTemp + delta;
    if (next < 16.0) {
      next = 16.0;
    }
    if (next > 30.0) {
      next = 30.0;
    }
    this.targetTemp = Math.round(next * 10) / 10;
  }

  build() {
    Column() {
      Stack() {
        Progress({ value: 100, total: 100, type: ProgressType.Ring })
          .color(CLIMATE_SOFT_GRAY)
          .style({ strokeWidth: DIAL_STROKE_WIDTH })
          .width(DIAL_CANVAS_SIZE)
          .height(DIAL_CANVAS_SIZE)

        Progress({ value: this.isActive ? (this.targetTemp - 16.0) : 0, total: 14, type: ProgressType.Ring })
          .color(this.isActive ? CLIMATE_BLUE : CLIMATE_TEXT_GRAY)
          .style({ strokeWidth: DIAL_STROKE_WIDTH })
          .width(DIAL_CANVAS_SIZE)
          .height(DIAL_CANVAS_SIZE)

        Circle()
          .fill(CLIMATE_WHITE)
          .width(32)
          .height(32)
          .translate({ x: 54, y: -84 })

        Circle()
          .fill(this.isActive ? CLIMATE_BLUE : CLIMATE_TEXT_GRAY)
          .width(20)
          .height(20)
          .translate({ x: 54, y: -84 })

        Column() {
          Text(`${this.targetTemp.toFixed(1)}°`)
            .fontSize(FONT_SIZE_DISPLAY_MEDIUM)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? CLIMATE_TEXT_BLACK : CLIMATE_TEXT_GRAY)

          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(FONT_SIZE_LABEL_LARGE)
            .fontWeight(FontWeight.Medium)
            .fontColor(CLIMATE_TEXT_GRAY)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(DIAL_OUTER_BOX_SIZE)
      .height(DIAL_OUTER_BOX_SIZE)

      Blank()
        .height(TEMP_CONTROLS_SPACER_HEIGHT)

      Row({ space: TEMP_CONTROLS_HORIZONTAL_SPACING }) {
        RoundControlButton({ iconName: '⌄', enabled: this.isActive, action: () => this.adjustTemp(-0.5) })

        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .selectedColor(CLIMATE_TEXT_BLACK)
          .onChange((value: boolean) => {
            this.isActive = value;
          })

        RoundControlButton({ iconName: '⌃', enabled: this.isActive, action: () => this.adjustTemp(0.5) })
      }
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
    .width('100%')
  }
}

@Component
struct RoundControlButton {
  @Prop iconName: string;
  @Prop enabled: boolean;
  action: () => void = () => {};

  build() {
    Button() {
      Text(this.iconName)
        .fontSize(ROUND_CONTROL_BUTTON_ICON_SIZE)
        .fontColor(this.enabled ? CLIMATE_TEXT_BLACK : CLIMATE_DISABLED)
    }
    .width(ROUND_CONTROL_BUTTON_SIZE)
    .height(ROUND_CONTROL_BUTTON_SIZE)
    .type(ButtonType.Circle)
    .backgroundColor(this.enabled ? CLIMATE_SOFT_GRAY : CLIMATE_LIGHT_GRAY)
    .border({ width: this.enabled ? 0 : 1, color: CLIMATE_BORDER_GRAY })
    .enabled(this.enabled)
    .onClick(() => this.action())
  }
}

@Component
struct ControlGridSection {
  build() {
    Column() {
      Text('QUICK ACTIONS')
        .fontSize(FONT_SIZE_LABEL_SMALL)
        .fontWeight(FontWeight.Bold)
        .fontColor(CLIMATE_TEXT_GRAY)
        .margin({ bottom: QUICK_ACTIONS_TITLE_BOTTOM_PADDING })

      Row({ space: QUICK_ACTIONS_ROW_SPACING }) {
        QuickActionCard({ iconName: '↻', label: 'Fan Speed', status: 'Auto' })
        QuickActionCard({ iconName: '♥', label: 'Eco Mode', status: 'On', isActive: true })
      }
      .width('100%')

      Blank()
        .height(QUICK_ACTIONS_ROW_SPACING)

      Row({ space: QUICK_ACTIONS_ROW_SPACING }) {
        QuickActionCard({ iconName: 'i', label: 'Timer', status: 'Set 2h' })
        QuickActionCard({ iconName: 'home', label: 'Away', status: 'Off' })
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct QuickActionCard {
  @Prop iconName: string;
  @Prop label: string;
  @Prop status: string;
  @Prop isActive: boolean = false;

  build() {
    Column() {
      Text(this.iconName)
        .fontSize(QUICK_ACTION_CARD_ICON_SIZE)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isActive ? CLIMATE_WHITE : CLIMATE_TEXT_BLACK)
        .margin({ bottom: 8 })

      Blank()

      Column() {
        Text(this.label)
          .fontSize(FONT_SIZE_LABEL_MEDIUM)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.isActive ? CLIMATE_WHITE : CLIMATE_TEXT_BLACK)

        Text(this.status)
          .fontSize(FONT_SIZE_BODY_SMALL)
          .fontColor(CLIMATE_TEXT_GRAY)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(QUICK_ACTION_CARD_PADDING)
    .height(QUICK_ACTION_CARD_HEIGHT)
    .layoutWeight(1)
    .backgroundColor(this.isActive ? CLIMATE_TEXT_BLACK : CLIMATE_SOFT_GRAY)
    .borderRadius(QUICK_ACTION_CARD_CORNER_RADIUS)
  }
}
