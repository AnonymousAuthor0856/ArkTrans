// Constants
const SCREEN_PADDING = 24;
const HEADER_TOP_PADDING = 16;
const HEADER_SPACER_HEIGHT = 40;
const DIAL_SECTION_SPACER_HEIGHT = 40;
const DIAL_OUTER_BOX_SIZE = 280;
const DIAL_CANVAS_SIZE = 240;
const DIAL_STROKE_WIDTH = 40;
const KNOB_RADIUS_OUTER = 16;
const KNOB_RADIUS_INNER = 10;
const TEMP_CONTROLS_SPACER_HEIGHT = 32;
const TEMP_CONTROLS_HORIZONTAL_SPACING = 32;
const ROUND_CONTROL_BUTTON_SIZE = 56;
const ROUND_CONTROL_BUTTON_BORDER_WIDTH = 1;
const ROUND_CONTROL_BUTTON_ICON_SIZE = 28;
const QUICK_ACTIONS_TITLE_BOTTOM_PADDING = 16;
const QUICK_ACTIONS_ROW_SPACING = 16;
const QUICK_ACTION_CARD_HEIGHT = 100;
const QUICK_ACTION_CARD_CORNER_RADIUS = 20;
const QUICK_ACTION_CARD_PADDING = 16;
const QUICK_ACTION_CARD_ICON_SIZE = 24;
const FONT_SIZE_LABEL_MEDIUM = 13;
const FONT_SIZE_BODY_SMALL = 11;
const FONT_SIZE_DISPLAY_MEDIUM = 45;
const FONT_SIZE_LABEL_LARGE = 15;
const FONT_SIZE_LABEL_SMALL = 11;

// Colors
const COLOR_PURE_WHITE = '#FFFFFFFF';
const COLOR_TEXT_BLACK = '#FF1C1C1E';
const COLOR_TEXT_GRAY = '#FF8E8E93';
const COLOR_ACCENT_BLUE = '#FF007AFF';
const COLOR_SOFT_GRAY_BG = '#FFF2F2F7';
const COLOR_LIGHT_GRAY_BG = '#FFF9F9F9';
const COLOR_LIGHT_BORDER_GRAY = '#FFEEEEEE';
const COLOR_DISABLED_ICON_GRAY = '#FFD1D1D6';

@Component
struct HeaderSection {
  build() {
    Row() {
      Button() {
        Text('☰')
          .fontSize(ROUND_CONTROL_BUTTON_ICON_SIZE)
          .fontColor(COLOR_TEXT_BLACK)
      }
      .backgroundColor(Color.Transparent)
      .borderWidth(0)

      Blank()

      Column() {
        Text('LIVING ROOM')
          .fontSize(FONT_SIZE_LABEL_MEDIUM)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_TEXT_GRAY)
          .letterSpacing(2)
        Text('Connected')
          .fontSize(FONT_SIZE_BODY_SMALL)
          .fontColor(COLOR_ACCENT_BLUE)
      }

      Blank()

      Button() {
        Text('⚙')
          .fontSize(ROUND_CONTROL_BUTTON_ICON_SIZE)
          .fontColor(COLOR_TEXT_BLACK)
      }
      .backgroundColor(Color.Transparent)
      .borderWidth(0)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TemperatureDial {
  @Prop progress: number = 0;
  @Prop isActive: boolean = true;
  @State animatedProgress: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear() {
    animateTo({ curve: Curve.EaseOut, duration: 500 }, () => {
      this.animatedProgress = this.progress;
    });
  }

  drawDial() {
    const context = this.context;
    context.clearRect(0, 0, DIAL_CANVAS_SIZE, DIAL_CANVAS_SIZE);
    const size = DIAL_CANVAS_SIZE;
    const strokeWidth = DIAL_STROKE_WIDTH;
    const radius = (size - strokeWidth) / 2;
    const centerX = size / 2;
    const centerY = size / 2;
    const startAngle = 135 * Math.PI / 180;
    const sweepAngle = 270 * this.animatedProgress * Math.PI / 180;
    const endAngle = startAngle + sweepAngle;

    // Background arc
    context.beginPath();
    context.arc(centerX, centerY, radius, startAngle, startAngle + 270 * Math.PI / 180, false);
    context.strokeStyle = COLOR_SOFT_GRAY_BG;
    context.lineWidth = strokeWidth;
    context.lineCap = 'round';
    context.stroke();

    // Progress arc
    if (this.animatedProgress > 0) {
      context.beginPath();
      context.arc(centerX, centerY, radius, startAngle, endAngle, false);
      context.strokeStyle = this.isActive ? COLOR_ACCENT_BLUE : COLOR_TEXT_GRAY;
      context.lineWidth = strokeWidth;
      context.lineCap = 'round';
      context.stroke();
    }

    // Knob
    const knobX = centerX + radius * Math.cos(endAngle);
    const knobY = centerY + radius * Math.sin(endAngle);

    // Outer white circle
    context.beginPath();
    context.arc(knobX, knobY, KNOB_RADIUS_OUTER, 0, 2 * Math.PI, false);
    context.fillStyle = COLOR_PURE_WHITE;
    context.fill();

    // Inner colored circle
    context.beginPath();
    context.arc(knobX, knobY, KNOB_RADIUS_INNER, 0, 2 * Math.PI, false);
    context.fillStyle = this.isActive ? COLOR_ACCENT_BLUE : COLOR_TEXT_GRAY;
    context.fill();
  }

  build() {
    Canvas(this.context)
      .width(DIAL_CANVAS_SIZE)
      .height(DIAL_CANVAS_SIZE)
      .onReady(() => {
        this.drawDial();
      })
  }
}

@Component
struct RoundControlButton {
  @Prop iconName: string = '';
  @Prop isEnabled: boolean = true;
  action: () => void = () => {};

  build() {
    Button() {
      Text(this.iconName)
        .fontSize(ROUND_CONTROL_BUTTON_ICON_SIZE)
        .fontColor(this.isEnabled ? COLOR_TEXT_BLACK : COLOR_DISABLED_ICON_GRAY)
    }
    .width(ROUND_CONTROL_BUTTON_SIZE)
    .height(ROUND_CONTROL_BUTTON_SIZE)
    .borderRadius(ROUND_CONTROL_BUTTON_SIZE / 2)
    .backgroundColor(this.isEnabled ? COLOR_SOFT_GRAY_BG : COLOR_LIGHT_GRAY_BG)
    .border({
      width: this.isEnabled ? 0 : ROUND_CONTROL_BUTTON_BORDER_WIDTH,
      color: this.isEnabled ? Color.Transparent : COLOR_LIGHT_BORDER_GRAY,
      radius: ROUND_CONTROL_BUTTON_SIZE / 2
    })
    .enabled(this.isEnabled)
    .onClick(this.action)
  }
}

@Component
struct TemperatureDialSection {
  @State targetTemp: number = 21.5;
  @State isActive: boolean = true;

  adjustTemp(delta: number) {
    let newTemp = this.targetTemp + delta;
    newTemp = Math.min(Math.max(newTemp, 16.0), 30.0);
    this.targetTemp = Math.round(newTemp * 10) / 10;
  }

  getProgress(): number {
    return (this.targetTemp - 16.0) / (30.0 - 16.0);
  }

  build() {
    Column({ space: 0 }) {
      Stack() {
        Circle()
          .width(DIAL_CANVAS_SIZE)
          .height(DIAL_CANVAS_SIZE)
          .fill(COLOR_SOFT_GRAY_BG)
          .strokeWidth(0)

        Circle()
          .width(DIAL_CANVAS_SIZE - DIAL_STROKE_WIDTH)
          .height(DIAL_CANVAS_SIZE - DIAL_STROKE_WIDTH)
          .fill(COLOR_PURE_WHITE)

        TemperatureDial({
          progress: this.getProgress(),
          isActive: this.isActive
        })
          .width(DIAL_CANVAS_SIZE)
          .height(DIAL_CANVAS_SIZE)

        Column({ space: 4 }) {
          Text(`${this.targetTemp.toFixed(1)}°`)
            .fontSize(FONT_SIZE_DISPLAY_MEDIUM)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? COLOR_TEXT_BLACK : COLOR_TEXT_GRAY)
          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(FONT_SIZE_LABEL_LARGE)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_TEXT_GRAY)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(DIAL_OUTER_BOX_SIZE)
      .height(DIAL_OUTER_BOX_SIZE)
      .alignContent(Alignment.Center)

      Blank().height(TEMP_CONTROLS_SPACER_HEIGHT)

      Row({ space: TEMP_CONTROLS_HORIZONTAL_SPACING }) {
        RoundControlButton({
          iconName: '∨',
          isEnabled: this.isActive,
          action: () => {
            this.adjustTemp(-0.5);
          }
        })

        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .selectedColor(COLOR_TEXT_BLACK)
          .switchPointColor(COLOR_PURE_WHITE)
          .onChange((isOn: boolean) => {
            this.isActive = isOn;
          })

        RoundControlButton({
          iconName: '∧',
          isEnabled: this.isActive,
          action: () => {
            this.adjustTemp(0.5);
          }
        })
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct QuickActionCard {
  @Prop iconName: string = '';
  @Prop label: string = '';
  @Prop status: string = '';
  @Prop isActive: boolean = false;

  build() {
    Column({ space: 0 }) {
      Text(this.iconName)
        .fontSize(QUICK_ACTION_CARD_ICON_SIZE)
        .fontColor(this.isActive ? COLOR_PURE_WHITE : COLOR_TEXT_BLACK)
        .margin({ bottom: 8 })

      Blank()

      Column({ space: 2 }) {
        Text(this.label)
          .fontSize(FONT_SIZE_LABEL_MEDIUM)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isActive ? COLOR_PURE_WHITE : COLOR_TEXT_BLACK)
        Text(this.status)
          .fontSize(FONT_SIZE_BODY_SMALL)
          .fontColor(COLOR_TEXT_GRAY)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(QUICK_ACTION_CARD_PADDING)
    .height(QUICK_ACTION_CARD_HEIGHT)
    .layoutWeight(1)
    .backgroundColor(this.isActive ? COLOR_TEXT_BLACK : COLOR_SOFT_GRAY_BG)
    .borderRadius(QUICK_ACTION_CARD_CORNER_RADIUS)
  }
}

@Component
struct ControlGridSection {
  build() {
    Column({ space: 0 }) {
      Text('QUICK ACTIONS')
        .fontSize(FONT_SIZE_LABEL_SMALL)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_TEXT_GRAY)
        .letterSpacing(2)
        .margin({ bottom: QUICK_ACTIONS_TITLE_BOTTOM_PADDING })
        .alignSelf(ItemAlign.Start)

      Row({ space: QUICK_ACTIONS_ROW_SPACING }) {
        QuickActionCard({
          iconName: '↻',
          label: 'Fan Speed',
          status: 'Auto',
          isActive: false
        })
        QuickActionCard({
          iconName: '♥',
          label: 'Eco Mode',
          status: 'On',
          isActive: true
        })
      }
      .width('100%')

      Blank().height(QUICK_ACTIONS_ROW_SPACING)

      Row({ space: QUICK_ACTIONS_ROW_SPACING }) {
        QuickActionCard({
          iconName: 'ℹ',
          label: 'Timer',
          status: 'Set 2h',
          isActive: false
        })
        QuickActionCard({
          iconName: '⌂',
          label: 'Away',
          status: 'Off',
          isActive: false
        })
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct ClimateControllerView {
  build() {
    Column({ space: 0 }) {
      HeaderSection()
        .margin({ top: HEADER_TOP_PADDING })

      Blank().height(HEADER_SPACER_HEIGHT)

      TemperatureDialSection()

      Blank().height(DIAL_SECTION_SPACER_HEIGHT)

      ControlGridSection()

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_PURE_WHITE)
    .padding({ left: SCREEN_PADDING, right: SCREEN_PADDING })
  }
}