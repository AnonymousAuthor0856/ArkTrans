import { curves } from '@kit.ArkUI';

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
      .alignItems(HorizontalAlign.Center)

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
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true));

  aboutToAppear() {
    animateTo({ curve: curves.cubicBezier(0, 0, 0.2, 1), duration: 500 }, () => {
      this.animatedProgress = this.progress;
    });
  }

  drawDial() {
    const context = this.context;
    const size = DIAL_CANVAS_SIZE;
    const strokeWidth = DIAL_STROKE_WIDTH;
    const startAngleDeg = 135;
    const sweepAngleDeg = 270 * this.animatedProgress;
    const endAngleDeg = startAngleDeg + sweepAngleDeg;
    const radius = (size - strokeWidth) / 2;
    const cx = size / 2;
    const cy = size / 2;

    context.clearRect(0, 0, size, size);

    // Background arc
    context.beginPath();
    context.arc(cx, cy, radius,
      (startAngleDeg * Math.PI) / 180,
      ((startAngleDeg + 270) * Math.PI) / 180,
      false);
    context.strokeStyle = COLOR_SOFT_GRAY_BG;
    context.lineWidth = strokeWidth;
    context.lineCap = 'round';
    context.stroke();

    // Progress arc
    if (this.animatedProgress > 0) {
      context.beginPath();
      context.arc(cx, cy, radius,
        (startAngleDeg * Math.PI) / 180,
        (endAngleDeg * Math.PI) / 180,
        false);
      context.strokeStyle = this.isActive ? COLOR_ACCENT_BLUE : COLOR_TEXT_GRAY;
      context.lineWidth = strokeWidth;
      context.lineCap = 'round';
      context.stroke();
    }

    // Knob
    const endAngleRad = (endAngleDeg * Math.PI) / 180;
    const knobX = cx + radius * Math.cos(endAngleRad);
    const knobY = cy + radius * Math.sin(endAngleRad);

    // Outer knob circle (white)
    context.beginPath();
    context.arc(knobX, knobY, KNOB_RADIUS_OUTER, 0, 2 * Math.PI);
    context.fillStyle = COLOR_PURE_WHITE;
    context.fill();

    // Inner knob circle (colored)
    context.beginPath();
    context.arc(knobX, knobY, KNOB_RADIUS_INNER, 0, 2 * Math.PI);
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
  @Prop iconLabel: string = '';
  @Prop isEnabled: boolean = true;
  action: () => void = () => {};

  build() {
    Button() {
      Text(this.iconLabel)
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
    .onClick(() => {
      this.action();
    })
  }
}

@Component
struct TemperatureDialSection {
  @State targetTemp: number = 21.5;
  @State isActive: boolean = true;

  get progress(): number {
    return (this.targetTemp - 16.0) / (30.0 - 16.0);
  }

  adjustTemp(delta: number) {
    let newTemp = this.targetTemp + delta;
    newTemp = Math.min(Math.max(newTemp, 16.0), 30.0);
    this.targetTemp = Math.round(newTemp * 10) / 10;
  }

  build() {
    Column() {
      Stack() {
        TemperatureDial({
          progress: this.progress,
          isActive: this.isActive
        })
          .width(DIAL_CANVAS_SIZE)
          .height(DIAL_CANVAS_SIZE)

        Column() {
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

      Blank()
        .height(TEMP_CONTROLS_SPACER_HEIGHT)

      Row({ space: TEMP_CONTROLS_HORIZONTAL_SPACING }) {
        RoundControlButton({
          iconLabel: '∨',
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
          iconLabel: '∧',
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
  @Prop iconLabel: string = '';
  @Prop label: string = '';
  @Prop status: string = '';
  @Prop isActive: boolean = false;

  build() {
    Column() {
      Text(this.iconLabel)
        .fontSize(QUICK_ACTION_CARD_ICON_SIZE)
        .fontColor(this.isActive ? COLOR_PURE_WHITE : COLOR_TEXT_BLACK)
        .margin({ bottom: 8 })

      Blank()

      Column() {
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
    Column() {
      Text('QUICK ACTIONS')
        .fontSize(FONT_SIZE_LABEL_SMALL)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_TEXT_GRAY)
        .letterSpacing(2)
        .margin({ bottom: QUICK_ACTIONS_TITLE_BOTTOM_PADDING })
        .alignSelf(ItemAlign.Start)

      Row({ space: QUICK_ACTIONS_ROW_SPACING }) {
        QuickActionCard({
          iconLabel: '↻',
          label: 'Fan Speed',
          status: 'Auto',
          isActive: false
        })

        QuickActionCard({
          iconLabel: '♥',
          label: 'Eco Mode',
          status: 'On',
          isActive: true
        })
      }
      .width('100%')

      Blank()
        .height(QUICK_ACTIONS_ROW_SPACING)

      Row({ space: QUICK_ACTIONS_ROW_SPACING }) {
        QuickActionCard({
          iconLabel: 'ⓘ',
          label: 'Timer',
          status: 'Set 2h',
          isActive: false
        })

        QuickActionCard({
          iconLabel: '⌂',
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
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_PURE_WHITE)
    .padding({ left: SCREEN_PADDING, right: SCREEN_PADDING })
  }
}