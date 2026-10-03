@Entry
@Component
struct RetroRemoteControlApp {
  @State private var knobPositionX: number = 90;
  @State private var knobPositionY: number = 140;
  @State private var powerOn: boolean = false;

  // AppTokens - Colors
  private readonly primary: string = '#FF7A00';
  private readonly secondary: string = '#FFC300';
  private readonly tertiary: string = '#FFF3C0';
  private readonly background: string = '#FFF8E7';
  private readonly surface: string = '#FFFFFF';
  private readonly surfaceVariant: string = '#FFEBC8';
  private readonly outline: string = '#BCA789';
  private readonly success: string = '#28A745';
  private readonly warning: string = '#FFC107';
  private readonly error: string = '#DC3545';
  private readonly onPrimary: string = '#FFFFFF';
  private readonly onSecondary: string = '#1E1E1E';
  private readonly onTertiary: string = '#1E1E1E';
  private readonly onBackground: string = '#1E1E1E';
  private readonly onSurface: string = '#1E1E1E';

  // Spacing tokens
  private readonly spacingXs: number = 4;
  private readonly spacingSm: number = 8;
  private readonly spacingMd: number = 12;
  private readonly spacingLg: number = 16;
  private readonly spacingXl: number = 24;
  private readonly spacingXxl: number = 32;

  // Knob bounds
  private readonly knobRadius: number = 16;
  private readonly knobMinBound: number = 16;
  private readonly knobMaxBound: number = 264;

  @Builder
  KnobCanvas() {
    Stack() {
      // Background circle
      Circle()
        .width(200)
        .height(200)
        .fill(this.secondary)
        .opacity(0.2)

      // Knob circle
      Circle()
        .width(32)
        .height(32)
        .fill(this.primary)
        .position({ x: this.knobPositionX, y: this.knobPositionY })
    }
    .width(280)
    .height(280)
    .backgroundColor(this.surfaceVariant)
    .borderRadius(24)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetY: 2
    })
    .gesture(
      PanGesture({ fingers: 1, direction: PanDirection.All, distance: 0 })
        .onActionStart((event: GestureEvent) => {
          this.updateKnobPosition(event.fingerList[0].localX, event.fingerList[0].localY);
        })
        .onActionUpdate((event: GestureEvent) => {
          this.updateKnobPosition(event.fingerList[0].localX, event.fingerList[0].localY);
        })
    )
  }

  updateKnobPosition(x: number, y: number) {
    this.knobPositionX = Math.max(this.knobMinBound, Math.min(this.knobMaxBound, x));
    this.knobPositionY = Math.max(this.knobMinBound, Math.min(this.knobMaxBound, y));
  }

  @Builder
  PowerButton() {
    Button() {
      this.powerOn = !this.powerOn;
    }
    .width(80)
    .height(80)
    .borderRadius(40)
    .backgroundColor(this.primary)
    .type(ButtonType.Normal)
    .borderRadius(40)

    Text('On')
      .fontSize(18)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.onPrimary)
      .position({ x: 40, y: 40 })
  }

  @Builder
  ResetButton() {
    Button() {
      this.knobPositionX = 90;
      this.knobPositionY = 140;
    }
    .width(80)
    .height(80)
    .borderRadius(40)
    .backgroundColor(this.secondary)
    .type(ButtonType.Normal)
    .borderRadius(40)

    Column() {
      Text('Res')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.onSecondary)
      Text('et')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.onSecondary)
    }
    .position({ x: 40, y: 40 })
  }

  build() {
    Column() {
      // Top spacing
      Blank()
        .height(40)

      // Top Bar
      Stack() {
        Text('Retro Remote Control')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onSurface)
      }
      .width('100%')
      .height(64)
      .backgroundColor(this.background)

      // Scrollable content
      Scroll() {
        Column({ space: this.spacingXl }) {
          // Knob Surface
          this.KnobCanvas()
            .padding(this.spacingLg)

          // Power Status
          Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.powerOn ? this.success : this.error)

          // Buttons Row
          Row({ space: 60 }) {
            Stack() {
              this.PowerButton()
            }
            .width(80)
            .height(80)

            Stack() {
              this.ResetButton()
            }
            .width(80)
            .height(80)
          }
          .justifyContent(FlexAlign.Center)

          // Progress Bar
          Row()
            .width('100%')
            .height(6)
            .backgroundColor(this.primary)
            .borderRadius(3)
            .padding({ left: this.spacingLg, right: this.spacingLg })
        }
        .padding(this.spacingLg)
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(this.background)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
  }
}