// RetroMusicPlayerApp.ets
import { display } from '@kit.ArkUI';

@Entry
@Component
struct RetroMusicPlayerApp {
  build() {
    RetroMusicPlayerRoot()
  }
}

// Color tokens
class RMColors {
  static readonly primary: string = '#EF476F';
  static readonly secondary: string = '#FFD166';
  static readonly tertiary: string = '#06D6A0';
  static readonly background: string = '#FFFCF2';
  static readonly surface: string = '#FFF8E1';
  static readonly surfaceVariant: string = '#FCE7E7';
  static readonly outline: string = '#BDBDBD';
  static readonly success: string = '#06D6A0';
  static readonly warning: string = '#FFA600';
  static readonly error: string = '#D62828';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1F1F1F';
  static readonly onTertiary: string = '#1F1F1F';
  static readonly onBackground: string = '#1F1F1F';
  static readonly onSurface: string = '#1F1F1F';
}

@Component
struct RetroMusicPlayerRoot {
  @State private knobPositionX: number = 140;
  @State private knobPositionY: number = 140;
  @State private isDragging: boolean = false;
  @State private scale: number = 1;
  @State private containerWidth: number = 360;
  @State private containerHeight: number = 640;

  private calculateScale(): number {
    return Math.max(this.containerWidth / 360.0, this.containerHeight / 640.0);
  }

  private handleKnobDrag(event: GestureEvent): void {
    this.isDragging = true;
    const centerX = 140 * this.scale;
    const centerY = 140 * this.scale;
    const radius = 120 * this.scale;

    const vectorX = event.fingerList[0].localX - centerX;
    const vectorY = event.fingerList[0].localY - centerY;
    const distance = Math.sqrt(vectorX * vectorX + vectorY * vectorY);

    if (distance <= radius) {
      this.knobPositionX = event.fingerList[0].localX;
      this.knobPositionY = event.fingerList[0].localY;
    } else {
      const angle = Math.atan2(vectorY, vectorX);
      this.knobPositionX = centerX + Math.cos(angle) * radius;
      this.knobPositionY = centerY + Math.sin(angle) * radius;
    }
  }

  private handleKnobDragEnd(): void {
    this.isDragging = false;
  }

  build() {
    Stack() {
      Column() {
        // Top App Bar
        Column() {
          Text('Retro Music Player')
            .fontSize(34 * this.scale)
            .fontWeight(FontWeight.Bold)
            .fontColor(RMColors.onSurface)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(80 * this.scale)
        .backgroundColor(RMColors.background)
        .justifyContent(FlexAlign.Center)

        Blank()

        // Main Content
        Column({ space: 32 * this.scale }) {
          // Circular Deck
          Stack() {
            // Background surface with border
            Rect()
              .fill(RMColors.surface)
              .stroke(RMColors.outline)
              .strokeWidth(3 * this.scale)
              .width(280 * this.scale)
              .height(280 * this.scale)
              .radius(16 * this.scale)

            // Outer circle (record) - yellow ring
            Circle()
              .fill(Color.Transparent)
              .stroke(RMColors.secondary)
              .strokeWidth(8 * this.scale)
              .width(240 * this.scale)
              .height(240 * this.scale)

            // Draggable knob - red dot
            Circle()
              .fill(RMColors.primary)
              .width(24 * this.scale)
              .height(24 * this.scale)
              .position({
                x: this.knobPositionX,
                y: this.knobPositionY
              })
              .gesture(
                PanGesture()
                  .onActionStart(() => {
                    this.isDragging = true;
                  })
                  .onActionUpdate((event: GestureEvent) => {
                    this.handleKnobDrag(event);
                  })
                  .onActionEnd(() => {
                    this.handleKnobDragEnd();
                  })
              )
              .animation({
                duration: this.isDragging ? 0 : 200,
                curve: Curve.EaseOut
              })
          }
          .width(280 * this.scale)
          .height(280 * this.scale)

          // Track Info
          Text('Track: Summer Nights')
            .fontSize(22 * this.scale)
            .fontWeight(FontWeight.Medium)
            .fontColor(RMColors.onSurface)

          // Control Buttons
          Row({ space: 32 * this.scale }) {
            Button('Play')
              .fontSize(22 * this.scale)
              .fontWeight(FontWeight.Medium)
              .fontColor(RMColors.onPrimary)
              .width(140 * this.scale)
              .height(56 * this.scale)
              .backgroundColor(RMColors.primary)
              .borderRadius(12 * this.scale)
              .onClick(() => {
                // Play action
              })

            Button('Pause')
              .fontSize(22 * this.scale)
              .fontWeight(FontWeight.Medium)
              .fontColor(RMColors.onSecondary)
              .width(140 * this.scale)
              .height(56 * this.scale)
              .backgroundColor(RMColors.secondary)
              .borderRadius(12 * this.scale)
              .onClick(() => {
                // Pause action
              })
          }
          .justifyContent(FlexAlign.Center)

          // Knob Coordinates
          Text('Knob X:268 Y:303')
            .fontSize(16 * this.scale)
            .fontWeight(FontWeight.Medium)
            .fontColor(RMColors.tertiary)
        }
        .padding({ left: 32 * this.scale, right: 32 * this.scale })
        .alignItems(HorizontalAlign.Center)

        Blank()

        // Bottom Spacer
        Row()
          .width('100%')
          .height(60 * this.scale)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(RMColors.background)
    }
    .width('100%')
    .height('100%')
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.containerWidth = Number(newValue.width);
      this.containerHeight = Number(newValue.height);
      this.scale = this.calculateScale();
      this.knobPositionX = 140 * this.scale;
      this.knobPositionY = 140 * this.scale;
    })
  }
}