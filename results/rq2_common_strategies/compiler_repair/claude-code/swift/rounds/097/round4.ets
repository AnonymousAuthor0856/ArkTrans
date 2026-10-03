// MARK: - Constants and Colors

const SCREEN_PADDING: number = 24;
const HEADER_TOP_PADDING: number = 16;
const HEADER_SPACER_HEIGHT: number = 40;
const DIAL_SECTION_SPACER_HEIGHT: number = 40;

const DIAL_OUTER_BOX_SIZE: number = 280;
const DIAL_CANVAS_SIZE: number = 240;
const DIAL_STROKE_WIDTH: number = 40;
const KNOB_RADIUS_OUTER: number = 16;
const KNOB_RADIUS_INNER: number = 10;
const TEMP_CONTROLS_SPACER_HEIGHT: number = 32;
const TEMP_CONTROLS_HORIZONTAL_SPACING: number = 32;

const ROUND_CONTROL_BUTTON_SIZE: number = 56;
const ROUND_CONTROL_BUTTON_BORDER_WIDTH: number = 1;
const ROUND_CONTROL_BUTTON_ICON_SIZE: number = 28;

const QUICK_ACTIONS_TITLE_BOTTOM_PADDING: number = 16;
const QUICK_ACTIONS_ROW_SPACING: number = 16;
const QUICK_ACTION_CARD_HEIGHT: number = 100;
const QUICK_ACTION_CARD_CORNER_RADIUS: number = 20;
const QUICK_ACTION_CARD_PADDING: number = 16;
const QUICK_ACTION_CARD_ICON_SIZE: number = 24;

const FONT_SIZE_LABEL_MEDIUM: number = 13;
const FONT_SIZE_BODY_SMALL: number = 11;
const FONT_SIZE_DISPLAY_MEDIUM: number = 45;
const FONT_SIZE_LABEL_LARGE: number = 15;
const FONT_SIZE_LABEL_SMALL: number = 11;

const COLOR_PURE_WHITE: string = '#FFFFFFFF';
const COLOR_TEXT_BLACK: string = '#FF1C1C1E';
const COLOR_TEXT_GRAY: string = '#FF8E8E93';
const COLOR_ACCENT_BLUE: string = '#FF007AFF';
const COLOR_SOFT_GRAY_BG: string = '#FFF2F2F7';
const COLOR_LIGHT_GRAY_BG: string = '#FFF9F9F9';
const COLOR_LIGHT_BORDER_GRAY: string = '#FFEEEEEE';
const COLOR_DISABLED_ICON_GRAY: string = '#FFD1D1D6';

// MARK: - Round Control Button Component

@Component
struct RoundControlButton {
  iconName: ResourceStr = '';
  action: () => void = () => {};
  isEnabled: boolean = true;

  build() {
    Button() {
      Text(this.iconName)
        .fontSize(ROUND_CONTROL_BUTTON_ICON_SIZE)
        .fontColor(this.isEnabled ? COLOR_TEXT_BLACK : COLOR_DISABLED_ICON_GRAY)
    }
    .type(ButtonType.Circle)
    .width(ROUND_CONTROL_BUTTON_SIZE)
    .height(ROUND_CONTROL_BUTTON_SIZE)
    .backgroundColor(this.isEnabled ? COLOR_SOFT_GRAY_BG : COLOR_LIGHT_GRAY_BG)
    .border({
      width: ROUND_CONTROL_BUTTON_BORDER_WIDTH,
      color: this.isEnabled ? 'transparent' : COLOR_LIGHT_BORDER_GRAY,
      radius: ROUND_CONTROL_BUTTON_SIZE / 2
    })
    .enabled(this.isEnabled)
    .onClick(() => {
      this.action();
    })
  }
}

// MARK: - Temperature Dial Canvas Component

@Component
struct TemperatureDial {
  @Link progress: number;
  @Link isActive: boolean;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear() {
    this.drawDial();
  }

  aboutToUpdate() {
    this.drawDial();
  }

  private drawDial() {
    const size = DIAL_CANVAS_SIZE;
    const strokeWidth = DIAL_STROKE_WIDTH;
    const startAngleDegrees = 135;
    const sweepAngleDegrees = 270 * this.progress;
    const endAngleDegrees = startAngleDegrees + sweepAngleDegrees;

    const radius = (Math.min(size, size) - strokeWidth) / 2;
    const centerX = size / 2;
    const centerY = size / 2;

    this.ctx.clearRect(0, 0, size, size);

    // Draw background circle arc
    this.ctx.beginPath();
    this.ctx.lineWidth = strokeWidth;
    this.ctx.strokeStyle = COLOR_SOFT_GRAY_BG;
    this.ctx.lineCap = 'round';
    this.ctx.arc(centerX, centerY, radius,
      (startAngleDegrees * Math.PI) / 180,
      ((startAngleDegrees + 270) * Math.PI) / 180,
      false);
    this.ctx.stroke();

    // Draw progress arc
    this.ctx.beginPath();
    this.ctx.lineWidth = strokeWidth;
    this.ctx.strokeStyle = this.isActive ? COLOR_ACCENT_BLUE : COLOR_TEXT_GRAY;
    this.ctx.lineCap = 'round';
    this.ctx.arc(centerX, centerY, radius,
      (startAngleDegrees * Math.PI) / 180,
      (endAngleDegrees * Math.PI) / 180,
      false);
    this.ctx.stroke();

    // Draw knob
    const knobAngleRad = (endAngleDegrees * Math.PI) / 180;
    const knobX = centerX + radius * Math.cos(knobAngleRad);
    const knobY = centerY + radius * Math.sin(knobAngleRad);

    // Outer knob (white)
    this.ctx.beginPath();
    this.ctx.fillStyle = COLOR_PURE_WHITE;
    this.ctx.arc(knobX, knobY, KNOB_RADIUS_OUTER, 0, 2 * Math.PI);
    this.ctx.fill();

    // Inner knob (colored)
    this.ctx.beginPath();
    this.ctx.fillStyle = this.isActive ? COLOR_ACCENT_BLUE : COLOR_TEXT_GRAY;
    this.ctx.arc(knobX, knobY, KNOB_RADIUS_INNER, 0, 2 * Math.PI);
    this.ctx.fill();
  }

  build() {
    Canvas(this.ctx)
      .width(DIAL_CANVAS_SIZE)
      .height(DIAL_CANVAS_SIZE)
      .onReady(() => {
        this.drawDial();
      })
  }
}

// MARK: - Temperature Dial Section

@Component
struct TemperatureDialSection {
  @State targetTemp: number = 21.5;
  @State isActive: boolean = true;

  private adjustTemp(delta: number): void {
    let newTemp = this.targetTemp + delta;
    if (newTemp < 16.0) newTemp = 16.0;
    if (newTemp > 30.0) newTemp = 30.0;
    this.targetTemp = Math.round(newTemp * 10) / 10.0;
  }

  build() {
    Column() {
      Stack() {
        TemperatureDial({
          progress: $targetTemp,
          isActive: $isActive
        })

        Column() {
          Text(this.targetTemp.toFixed(1) + '°')
            .fontSize(FONT_SIZE_DISPLAY_MEDIUM)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? COLOR_TEXT_BLACK : COLOR_TEXT_GRAY)

          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(FONT_SIZE_LABEL_LARGE)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_TEXT_GRAY)
        }
      }
      .width(DIAL_OUTER_BOX_SIZE)
      .height(DIAL_OUTER_BOX_SIZE)

      Blank()
        .height(TEMP_CONTROLS_SPACER_HEIGHT)

      Row({ space: TEMP_CONTROLS_HORIZONTAL_SPACING }) {
        RoundControlButton({
          iconName: '−',
          action: () => this.adjustTemp(-0.5),
          isEnabled: this.isActive
        })

        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .onChange((value: boolean) => {
            this.isActive = value;
          })
          .selectedColor(COLOR_TEXT_BLACK)

        RoundControlButton({
          iconName: '+',
          action: () => this.adjustTemp(0.5),
          isEnabled: this.isActive
        })
      }
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - Quick Action Card Component

@Component
struct QuickActionCard {
  iconName: ResourceStr = '';
  label: string = '';
  status: string = '';
  isActive: boolean = false;

  build() {
    Column() {
      Text(this.iconName)
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
          .fontWeight(FontWeight.Regular)
          .fontColor(COLOR_TEXT_GRAY)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(QUICK_ACTION_CARD_PADDING)
    .height(QUICK_ACTION_CARD_HEIGHT)
    .width('100%')
    .layoutWeight(1)
    .backgroundColor(this.isActive ? COLOR_TEXT_BLACK : COLOR_SOFT_GRAY_BG)
    .borderRadius(QUICK_ACTION_CARD_CORNER_RADIUS)
  }
}

// MARK: - Control Grid Section

@Component
struct ControlGridSection {
  build() {
    Column() {
      Text('QUICK ACTIONS')
        .fontSize(FONT_SIZE_LABEL_SMALL)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_TEXT_GRAY)
        .margin({ bottom: QUICK_ACTIONS_TITLE_BOTTOM_PADDING })

      Row({ space: QUICK_ACTIONS_ROW_SPACING }) {
        QuickActionCard({
          iconName: '↻',
          label: 'Fan Speed',
          status: 'Auto'
        })
        QuickActionCard({
          iconName: '♥',
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
          iconName: 'ⓘ',
          label: 'Timer',
          status: 'Set 2h'
        })
        QuickActionCard({
          iconName: '⌂',
          label: 'Away',
          status: 'Off'
        })
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// MARK: - Header Section

@Component
struct HeaderSection {
  build() {
    Row() {
      Button() {
        Text('☰')
          .fontSize(ROUND_CONTROL_BUTTON_ICON_SIZE)
          .fontColor(COLOR_TEXT_BLACK)
      }
      .type(ButtonType.Circle)
      .width(ROUND_CONTROL_BUTTON_SIZE)
      .height(ROUND_CONTROL_BUTTON_SIZE)
      .backgroundColor(Color.Transparent)
      .onClick(() => {})

      Blank()

      Column() {
        Text('LIVING ROOM')
          .fontSize(FONT_SIZE_LABEL_MEDIUM)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_TEXT_GRAY)
          .letterSpacing(2)

        Text('Connected')
          .fontSize(FONT_SIZE_BODY_SMALL)
          .fontWeight(FontWeight.Regular)
          .fontColor(COLOR_ACCENT_BLUE)
      }
      .alignItems(HorizontalAlign.Center)

      Blank()

      Button() {
        Text('⚙')
          .fontSize(ROUND_CONTROL_BUTTON_ICON_SIZE)
          .fontColor(COLOR_TEXT_BLACK)
      }
      .type(ButtonType.Circle)
      .width(ROUND_CONTROL_BUTTON_SIZE)
      .height(ROUND_CONTROL_BUTTON_SIZE)
      .backgroundColor(Color.Transparent)
      .onClick(() => {})
    }
    .width('100%')
  }
}

// MARK: - Main View

@Entry
@Component
struct ClimateControllerView {
  build() {
    Stack() {
      // Global pure white background
      Column() {}
        .width('100%')
        .height('100%')
        .backgroundColor(COLOR_PURE_WHITE)

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
      .padding({ left: SCREEN_PADDING, right: SCREEN_PADDING })
    }
    .width('100%')
    .height('100%')
  }
}
