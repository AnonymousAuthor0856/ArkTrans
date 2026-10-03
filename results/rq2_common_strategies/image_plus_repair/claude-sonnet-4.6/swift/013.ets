// Color tokens
class ColorTokens {
  primary: string = '#EF476F';
  secondary: string = '#FFD166';
  tertiary: string = '#06D6A0';
  background: string = '#FFFCF2';
  surface: string = '#FFF8E1';
  surfaceVariant: string = '#FCE7E7';
  outline: string = '#BDBDBD';
  success: string = '#06D6A0';
  warning: string = '#FFA600';
  error: string = '#D62828';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#1F1F1F';
  onTertiary: string = '#1F1F1F';
  onBackground: string = '#1F1F1F';
  onSurface: string = '#1F1F1F';
}

const C = new ColorTokens();

@Entry
@Component
struct RetroMusicPlayer {
  @State knobX: number = 140;
  @State knobY: number = 140;
  @State isDragging: boolean = false;

  private deckSize: number = 280;
  private deckRadius: number = 120;
  private deckCenterX: number = 140;
  private deckCenterY: number = 140;

  build() {
    Column({ space: 0 }) {
      // Top App Bar
      Stack() {
        Row()
          .width('100%')
          .height(80)
          .backgroundColor(C.background)

        Text('Retro Music Player')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(C.onSurface)
      }
      .width('100%')
      .height(80)
      .alignContent(Alignment.Center)

      Blank()

      // Main Content
      Column({ space: 32 }) {
        // Circular Deck
        Stack() {
          // Background surface with border
          Column()
            .width(this.deckSize)
            .height(this.deckSize)
            .backgroundColor(C.surface)
            .borderRadius(16)
            .border({ width: 3, color: C.outline, radius: 16 })

          // Outer circle (record) - yellow ring
          Circle()
            .width(this.deckSize - 40)
            .height(this.deckSize - 40)
            .fill('transparent')
            .stroke(C.secondary)
            .strokeWidth(8)

          // Draggable knob - red dot
          Circle()
            .width(24)
            .height(24)
            .fill(C.primary)
            .position({ x: this.knobX - 12, y: this.knobY - 12 })
            .gesture(
              PanGesture()
                .onActionStart(() => {
                  this.isDragging = true;
                })
                .onActionUpdate((event: GestureEvent) => {
                  this.isDragging = true;
                  const centerX: number = this.deckCenterX;
                  const centerY: number = this.deckCenterY;
                  const radius: number = this.deckRadius;

                  const newX: number = this.knobX + event.offsetX;
                  const newY: number = this.knobY + event.offsetY;

                  const dx: number = newX - centerX;
                  const dy: number = newY - centerY;
                  const distance: number = Math.sqrt(dx * dx + dy * dy);

                  if (distance <= radius) {
                    this.knobX = newX;
                    this.knobY = newY;
                  } else {
                    const angle: number = Math.atan2(dy, dx);
                    this.knobX = centerX + Math.cos(angle) * radius;
                    this.knobY = centerY + Math.sin(angle) * radius;
                  }
                })
                .onActionEnd(() => {
                  this.isDragging = false;
                })
            )
        }
        .width(this.deckSize)
        .height(this.deckSize)
        .clip(false)

        // Track Info
        Text('Track: Summer Nights')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(C.onSurface)

        // Control Buttons
        Row({ space: 32 }) {
          Button('Play')
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(C.onPrimary)
            .width(140)
            .height(56)
            .backgroundColor(C.primary)
            .borderRadius(12)
            .onClick(() => {
              // Play action
            })

          Button('Pause')
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(C.onSecondary)
            .width(140)
            .height(56)
            .backgroundColor(C.secondary)
            .borderRadius(12)
            .onClick(() => {
              // Pause action
            })
        }

        // Knob Coordinates
        Text('Knob X:268 Y:303')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(C.tertiary)
      }
      .padding({ left: 32, right: 32 })
      .alignItems(HorizontalAlign.Center)

      Blank()

      // Bottom Spacer
      Row()
        .width('100%')
        .height(60)
        .backgroundColor(C.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(C.background)
    .alignItems(HorizontalAlign.Center)
  }
}