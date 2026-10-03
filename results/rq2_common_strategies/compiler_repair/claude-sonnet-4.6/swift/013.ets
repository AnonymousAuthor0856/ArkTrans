// Color tokens
class RMColors {
  static primary: string = '#EF476F';
  static secondary: string = '#FFD166';
  static tertiary: string = '#06D6A0';
  static background: string = '#FFFCF2';
  static surface: string = '#FFF8E1';
  static surfaceVariant: string = '#FCE7E7';
  static outline: string = '#BDBDBD';
  static success: string = '#06D6A0';
  static warning: string = '#FFA600';
  static error: string = '#D62828';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#1F1F1F';
  static onTertiary: string = '#1F1F1F';
  static onBackground: string = '#1F1F1F';
  static onSurface: string = '#1F1F1F';
}

@Entry
@Component
struct RetroMusicPlayerRoot {
  @State knobX: number = 140;
  @State knobY: number = 140;
  @State isDragging: boolean = false;
  @State knobDisplayX: number = 268;
  @State knobDisplayY: number = 303;

  private deckSize: number = 280;
  private deckPadding: number = 20;
  private knobDotRadius: number = 12;

  private getCenterX(): number {
    return this.deckSize / 2;
  }

  private getCenterY(): number {
    return this.deckSize / 2;
  }

  private getRingRadius(): number {
    return (this.deckSize / 2) - this.deckPadding - 4;
  }

  private updateKnobPosition(touchX: number, touchY: number): void {
    const cx = this.getCenterX();
    const cy = this.getCenterY();
    const radius = this.getRingRadius();

    const dx = touchX - cx;
    const dy = touchY - cy;
    const distance = Math.sqrt(dx * dx + dy * dy);

    if (distance <= radius) {
      this.knobX = touchX;
      this.knobY = touchY;
    } else {
      const angle = Math.atan2(dy, dx);
      this.knobX = cx + Math.cos(angle) * radius;
      this.knobY = cy + Math.sin(angle) * radius;
    }

    this.knobDisplayX = Math.round(this.knobX);
    this.knobDisplayY = Math.round(this.knobY);
  }

  build() {
    Column() {
      // ===== Top App Bar =====
      Stack() {
        Column()
          .width('100%')
          .height(80)
          .backgroundColor(RMColors.background)

        Text('Retro Music Player')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(RMColors.onSurface)
      }
      .width('100%')
      .height(80)
      .alignContent(Alignment.Center)

      Blank()

      // ===== Main Content =====
      Column({ space: 32 }) {
        // ===== Circular Deck =====
        Stack() {
          // Background surface with border
          Column()
            .width(this.deckSize)
            .height(this.deckSize)
            .borderRadius(16)
            .backgroundColor(RMColors.surface)
            .border({ width: 3, color: RMColors.outline, radius: 16 })

          // Outer yellow ring
          Circle()
            .width(this.deckSize - this.deckPadding * 2)
            .height(this.deckSize - this.deckPadding * 2)
            .fill(Color.Transparent)
            .stroke(RMColors.secondary)
            .strokeWidth(8)
            .position({
              x: this.deckPadding,
              y: this.deckPadding
            })

          // Draggable red knob
          Circle()
            .width(24)
            .height(24)
            .fill(RMColors.primary)
            .position({
              x: this.knobX - this.knobDotRadius,
              y: this.knobY - this.knobDotRadius
            })
        }
        .width(this.deckSize)
        .height(this.deckSize)
        .clip(true)
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down || event.type === TouchType.Move) {
            this.isDragging = true;
            const touch = event.touches[0];
            this.updateKnobPosition(touch.x, touch.y);
          } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
            this.isDragging = false;
          }
        })

        // ===== Track Info =====
        Text('Track: Summer Nights')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(RMColors.onSurface)

        // ===== Control Buttons =====
        Row({ space: 32 }) {
          Button('Play')
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(RMColors.onPrimary)
            .width(140)
            .height(56)
            .backgroundColor(RMColors.primary)
            .borderRadius(12)
            .onClick(() => {
              // Play action
            })

          Button('Pause')
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(RMColors.onSecondary)
            .width(140)
            .height(56)
            .backgroundColor(RMColors.secondary)
            .borderRadius(12)
            .onClick(() => {
              // Pause action
            })
        }

        // ===== Knob Coordinates =====
        Text(`Knob X:${this.knobDisplayX} Y:${this.knobDisplayY}`)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(RMColors.tertiary)
      }
      .padding({ left: 32, right: 32 })
      .alignItems(HorizontalAlign.Center)

      Blank()

      // ===== Bottom Spacer =====
      Column()
        .width('100%')
        .height(60)
        .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(RMColors.background)
    .alignItems(HorizontalAlign.Center)
  }
}