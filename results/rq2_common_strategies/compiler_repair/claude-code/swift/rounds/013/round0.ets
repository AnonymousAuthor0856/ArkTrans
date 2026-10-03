@Entry
@Component
struct RetroMusicPlayerRoot {
  private readonly C = {
    primary: '#EF476F',
    secondary: '#FFD166',
    tertiary: '#06D6A0',
    background: '#FFFCF2',
    surface: '#FFF8E1',
    surfaceVariant: '#FCE7E7',
    outline: '#BDBDBD',
    success: '#06D6A0',
    warning: '#FFA600',
    error: '#D62828',
    onPrimary: '#FFFFFF',
    onSecondary: '#1F1F1F',
    onTertiary: '#1F1F1F',
    onBackground: '#1F1F1F',
    onSurface: '#1F1F1F',
  };

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
                  let newX = this.startKnobX + event.offsetX;
                  let newY = this.startKnobY + event.offsetY;

                  let centerX = this.deckSize / 2;
                  let centerY = this.deckSize / 2;
                  let dx = newX - centerX;
                  let dy = newY - centerY;
                  let distance = Math.sqrt(dx * dx + dy * dy);

                  if (distance > this.ringRadius) {
                    let angle = Math.atan2(dy, dx);
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
