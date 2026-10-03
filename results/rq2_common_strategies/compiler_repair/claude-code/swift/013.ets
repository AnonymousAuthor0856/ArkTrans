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

@Entry
@Component
struct RetroMusicPlayerRoot {
  private C: ColorTokens = new ColorTokens();
  private readonly deckSize: number = 280;
  private readonly knobSize: number = 24;
  private readonly ringRadius: number = 120;

  @State knobCenterX: number = 140;
  @State knobCenterY: number = 140;
  @State startKnobX: number = 0;
  @State startKnobY: number = 0;
  @State isDragging: boolean = false;

  build() {
    Column() {
      Stack() {
        Text('Retro Music Player')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.C.onSurface)
      }
      .width('100%')
      .height(80)
      .backgroundColor(this.C.background)

      Blank()

      Column({ space: 32 }) {
        Stack() {
          Circle({ width: this.deckSize - 40, height: this.deckSize - 40 })
            .stroke(this.C.secondary)
            .strokeWidth(8)
            .fill(Color.Transparent)

          Circle({ width: this.knobSize, height: this.knobSize })
            .fill(this.C.primary)
            .position({
              x: this.knobCenterX - this.knobSize / 2,
              y: this.knobCenterY - this.knobSize / 2
            })
            .gesture(
              PanGesture()
                .onActionStart(() => {
                  this.isDragging = true;
                  this.startKnobX = this.knobCenterX;
                  this.startKnobY = this.knobCenterY;
                })
                .onActionUpdate((event: GestureEvent) => {
                  let newX: number = this.startKnobX + event.offsetX;
                  let newY: number = this.startKnobY + event.offsetY;

                  let centerX: number = this.deckSize / 2;
                  let centerY: number = this.deckSize / 2;
                  let dx: number = newX - centerX;
                  let dy: number = newY - centerY;
                  let distance: number = Math.sqrt(dx * dx + dy * dy);

                  if (distance > this.ringRadius) {
                    let angle: number = Math.atan2(dy, dx);
                    newX = centerX + Math.cos(angle) * this.ringRadius;
                    newY = centerY + Math.sin(angle) * this.ringRadius;
                  }

                  this.knobCenterX = newX;
                  this.knobCenterY = newY;
                })
                .onActionEnd(() => {
                  this.isDragging = false;
                })
            )
        }
        .width(this.deckSize)
        .height(this.deckSize)
        .backgroundColor(this.C.surface)
        .borderRadius(16)
        .border({ width: 3, color: this.C.outline })

        Text('Track: Summer Nights')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.C.onSurface)

        Row({ space: 32 }) {
          Button('Play')
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.C.onPrimary)
            .width(140)
            .height(56)
            .backgroundColor(this.C.primary)
            .borderRadius(12)
            .onClick(() => {})

          Button('Pause')
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.C.onSecondary)
            .width(140)
            .height(56)
            .backgroundColor(this.C.secondary)
            .borderRadius(12)
            .onClick(() => {})
        }

        Text('Knob X:268 Y:303')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.C.tertiary)
      }
      .padding({ left: 32, right: 32 })

      Blank()

      Row()
        .width('100%')
        .height(60)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.C.background)
  }
}
