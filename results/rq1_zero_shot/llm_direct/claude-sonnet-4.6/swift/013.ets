import { display } from '@kit.ArkUI';

// Color tokens
const RM_C = {
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

@Entry
@Component
struct RetroMusicPlayerRoot {
  @State knobX: number = 140;
  @State knobY: number = 140;
  @State isDragging: boolean = false;
  @State scale: number = 1.0;

  private deckSize: number = 280;
  private centerOffset: number = 140;
  private knobRadius: number = 120;

  aboutToAppear() {
    const screenWidth = display.getDefaultDisplaySync().width / display.getDefaultDisplaySync().densityPixels;
    const screenHeight = display.getDefaultDisplaySync().height / display.getDefaultDisplaySync().densityPixels;
    this.scale = Math.max(screenWidth / 360.0, screenHeight / 640.0);
    this.knobX = this.centerOffset * this.scale;
    this.knobY = this.centerOffset * this.scale;
  }

  build() {
    Column() {
      // Top App Bar
      Stack() {
        Rectangle()
          .fill(RM_C.background)
          .width('100%')
          .height(80 * this.scale)

        Text('Retro Music Player')
          .fontSize(34 * this.scale)
          .fontWeight(FontWeight.Bold)
          .fontColor(RM_C.onSurface)
      }
      .width('100%')
      .height(80 * this.scale)

      Blank()

      // Main Content
      Column({ space: 32 * this.scale }) {
        // Circular Deck
        Stack() {
          // Background surface with border
          RoundedRect()

          // Outer circle (record) - yellow ring
          Circle()
            .width((this.deckSize - 40) * this.scale)
            .height((this.deckSize - 40) * this.scale)
            .fillColor(Color.Transparent)
            .strokeWidth(8 * this.scale)
            .stroke(RM_C.secondary)

          // Draggable knob - red dot
          Circle()
            .width(24 * this.scale)
            .height(24 * this.scale)
            .fillColor(RM_C.primary)
            .position({
              x: this.knobX - 12 * this.scale,
              y: this.knobY - 12 * this.scale
            })
            .animation(this.isDragging ? { duration: 0 } : { duration: 200, curve: Curve.EaseOut })
        }
        .width(this.deckSize * this.scale)
        .height(this.deckSize * this.scale)
        .gesture(
          PanGesture({ fingers: 1, distance: 0 })
            .onActionStart(() => {
              this.isDragging = true;
            })
            .onActionUpdate((event: GestureEvent) => {
              this.isDragging = true;
              const center = this.centerOffset * this.scale;
              const radius = this.knobRadius * this.scale;
              const touchX = event.offsetX + center;
              const touchY = event.offsetY + center;
              const dx = touchX - center;
              const dy = touchY - center;
              const distance = Math.sqrt(dx * dx + dy * dy);

              if (distance <= radius) {
                this.knobX = touchX;
                this.knobY = touchY;
              } else {
                const angle = Math.atan2(dy, dx);
                this.knobX = center + Math.cos(angle) * radius;
                this.knobY = center + Math.sin(angle) * radius;
              }
            })
            .onActionEnd(() => {
              this.isDragging = false;
            })
        )

        // Track Info
        Text('Track: Summer Nights')
          .fontSize(22 * this.scale)
          .fontWeight(FontWeight.Medium)
          .fontColor(RM_C.onSurface)

        // Control Buttons
        Row({ space: 32 * this.scale }) {
          Button('Play')
            .fontSize(22 * this.scale)
            .fontWeight(FontWeight.Medium)
            .fontColor(RM_C.onPrimary)
            .width(140 * this.scale)
            .height(56 * this.scale)
            .backgroundColor(RM_C.primary)
            .borderRadius(12 * this.scale)
            .onClick(() => {
              // Play action
            })

          Button('Pause')
            .fontSize(22 * this.scale)
            .fontWeight(FontWeight.Medium)
            .fontColor(RM_C.onSecondary)
            .width(140 * this.scale)
            .height(56 * this.scale)
            .backgroundColor(RM_C.secondary)
            .borderRadius(12 * this.scale)
            .onClick(() => {
              // Pause action
            })
        }

        // Knob Coordinates
        Text('Knob X:268 Y:303')
          .fontSize(16 * this.scale)
          .fontWeight(FontWeight.Medium)
          .fontColor(RM_C.tertiary)
      }
      .padding({ left: 32 * this.scale, right: 32 * this.scale })

      Blank()

      // Bottom Spacer
      Row()
        .width('100%')
        .height(60 * this.scale)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(RM_C.background)
  }
}

@Component
struct RoundedRect {
  build() {
    Stack() {
      RoundedRectangle({ cornerRadiusX: 16, cornerRadiusY: 16 })
        .fill('#FFF8E1')
        .width('100%')
        .height('100%')

      RoundedRectangle({ cornerRadiusX: 16, cornerRadiusY: 16 })
        .fill(Color.Transparent)
        .strokeWidth(3)
        .stroke('#BDBDBD')
        .width('100%')
        .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}