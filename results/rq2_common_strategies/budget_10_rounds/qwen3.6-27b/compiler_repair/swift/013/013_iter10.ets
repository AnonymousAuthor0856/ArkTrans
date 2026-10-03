import { router } from '@kit.ArkUI';

interface Point {
  x: number;
  y: number;
}

@Entry
@Component
struct RetroMusicPlayerRoot {
  @State knobPosition: Point = { x: 140, y: 140 };
  @State isDragging: boolean = false;
  @State scale: number = 1.0;
  @State centerX: number = 140;
  @State centerY: number = 140;
  @State radius: number = 120;

  // Color Tokens
  private readonly primary: string = '#EF476F';
  private readonly secondary: string = '#FFD166';
  private readonly tertiary: string = '#06D6A0';
  private readonly background: string = '#FFFCF2';
  private readonly surface: string = '#FFF8E1';
  private readonly outline: string = '#BDBDBD';
  private readonly onSurface: string = '#1F1F1F';
  private readonly onPrimary: string = '#FFFFFF';
  private readonly onSecondary: string = '#1F1F1F';

  aboutToAppear() {
    // Initial position will be set in build based on calculated scale
  }

  build() {
    Column() {
      GridRowTemplate({ rows: 'auto, 1fr, auto' }) {
        // Top App Bar
        Stack() {
          Rectangle()
            .fill(this.background)
            .height(80 * this.scale)
          
          Text("Retro Music Player")
            .fontSize(34 * this.scale)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.onSurface)
        }
        .height(80 * this.scale)
        .width('100%')

        // Main Content
        Column() {
          // Circular Deck
          Stack() {
            // Background surface with border
            RoundedRectangle({ width: '100%', height: '100%' })
              .fill(this.surface)
              .borderWidth(3 * this.scale)
              .borderColor(this.outline)
              .borderRadius(16 * this.scale)

            // Outer circle (record) - Yellow ring
            Circle()
              .stroke(this.secondary)
              .strokeWidth(8 * this.scale)
              .padding(20 * this.scale) // This padding affects the visual size relative to container

            // Draggable knob - Red dot
            Circle()
              .fill(this.primary)
              .width(24 * this.scale)
              .height(24 * this.scale)
              .position({ x: this.knobPosition.x, y: this.knobPosition.y })
              .gesture(
                GestureGroup(GestureMode.Parallel, [
                  DragGesture()
                    .onActionStart((event?: GestureEvent) => {
                      this.isDragging = true;
                    })
                    .onActionUpdate((event?: GestureEvent) => {
                      if (event) {
                        let locationX = event.localX;
                        let locationY = event.localY;
                        
                        // Vector from center
                        let dx = locationX - this.centerX;
                        let dy = locationY - this.centerY;
                        let distance = Math.sqrt(dx * dx + dy * dy);

                        if (distance <= this.radius) {
                          this.knobPosition = { x: locationX, y: locationY };
                        } else {
                          let angle = Math.atan2(dy, dx);
                          this.knobPosition = {
                            x: this.centerX + Math.cos(angle) * this.radius,
                            y: this.centerY + Math.sin(angle) * this.radius
                          };
                        }
                      }
                    })
                    .onActionEnd(() => {
                      this.isDragging = false;
                    })
                ])
              )
              .animation({ duration: this.isDragging ? 0 : 200, curve: Curve.EaseOut }, this.knobPosition)
          }
          .width(280 * this.scale)
          .height(280 * this.scale)

          // Track Info
          Text("Track: Summer Nights")
            .fontSize(22 * this.scale)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurface)
            .margin({ top: 32 * this.scale })

          // Control Buttons
          Row() {
            Button("Play") {
              // Play action
            }
            .fontSize(22 * this.scale)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onPrimary)
            .backgroundColor(this.primary)
            .borderRadius(12 * this.scale)
            .width(140 * this.scale)
            .height(56 * this.scale)

            Button("Pause") {
              // Pause action
            }
            .fontSize(22 * this.scale)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSecondary)
            .backgroundColor(this.secondary)
            .borderRadius(12 * this.scale)
            .width(140 * this.scale)
            .height(56 * this.scale)
            .margin({ left: 32 * this.scale })
          }
          .margin({ top: 32 * this.scale })

          // Knob Coordinates
          Text(`Knob X:${Math.round(this.knobPosition.x)} Y:${Math.round(this.knobPosition.y)}`)
            .fontSize(16 * this.scale)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.tertiary)
            .margin({ top: 32 * this.scale })
        }
        .padding({ left: 32 * this.scale, right: 32 * this.scale })

        // Bottom Spacer
        Rectangle()
          .fill('#00000000')
          .height(60 * this.scale)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.background)
      .onAppear(() => {
        // Initialize knob position to center when view appears/scale changes
        this.knobPosition = { x: this.centerX, y: this.centerY };
      })
    }
    .width('100%')
    .height('100%')
    .systemBarProperties({ statusBarType: SystemBarProperties.Hide })
  }
}