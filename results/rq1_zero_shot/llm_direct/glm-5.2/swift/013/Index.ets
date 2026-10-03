// RetroMusicPlayer.ets
import curves from '@ohos.curves';

// MARK: - Color Helper
function hexToColor(hex: number): ResourceColor {
  const r = (hex >> 16) & 0xFF;
  const g = (hex >> 8) & 0xFF;
  const b = hex & 0xFF;
  return `rgb(${r}, ${g}, ${b})`;
}

// MARK: - Tokens
class RM_C {
  static primary: ResourceColor = hexToColor(0xEF476F);
  static secondary: ResourceColor = hexToColor(0xFFD166);
  static tertiary: ResourceColor = hexToColor(0x06D6A0);
  static background: ResourceColor = hexToColor(0xFFFCF2);
  static surface: ResourceColor = hexToColor(0xFFF8E1);
  static surfaceVariant: ResourceColor = hexToColor(0xFCE7E7);
  static outline: ResourceColor = hexToColor(0xBDBDBD);
  static success: ResourceColor = hexToColor(0x06D6A0);
  static warning: ResourceColor = hexToColor(0xFFA600);
  static error: ResourceColor = hexToColor(0xD62828);
  static onPrimary: ResourceColor = hexToColor(0xFFFFFF);
  static onSecondary: ResourceColor = hexToColor(0x1F1F1F);
  static onTertiary: ResourceColor = hexToColor(0x1F1F1F);
  static onBackground: ResourceColor = hexToColor(0x1F1F1F);
  static onSurface: ResourceColor = hexToColor(0x1F1F1F);
}

// MARK: - Main Entry
@Entry
@Component
struct RetroMusicPlayerRoot {
  @State knobPositionX: number = 140;
  @State knobPositionY: number = 140;
  @State isDragging: boolean = false;
  
  private scale: number = 1.0; // Default scale, adapts to screen in build
  private circleRadius: number = 120; // Base radius

  aboutToAppear() {
    // Update initial state based on scale
    this.knobPositionX = 140 * this.scale;
    this.knobPositionY = 140 * this.scale;
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // GeometryReader equivalent to calculate scale dynamically
      // In ArkUI, we can use the onAreaChange or assume full screen and calculate via display metrics
      // For simplicity, we use a fixed scale based on standard 360vp width, or adapt using the container size
      this.MainContent()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(RM_C.background)
    .padding({ top: 0 }) // ignoresSafeArea equivalent
  }

  @Builder
  MainContent() {
    Column() {
      // ===== Top App Bar =====
      Stack({ alignContent: Alignment.Center }) {
        Text("Retro Music Player")
          .fontSize(34 * this.scale)
          .fontWeight(FontWeight.Bold)
          .fontColor(RM_C.onSurface)
      }
      .width('100%')
      .height(80 * this.scale)
      .backgroundColor(RM_C.background)
      .padding({ top: 20 * this.scale }) // Status bar space approximation

      // ===== Main Content =====
      Column({ space: 32 * this.scale }) {
        // ===== Circular Deck =====
        Stack({ alignContent: Alignment.Center }) {
          // Background surface with border
          Column()
            .width(280 * this.scale)
            .height(280 * this.scale)
            .borderRadius(16 * this.scale)
            .backgroundColor(RM_C.surface)
            .border({ width: 3 * this.scale, color: RM_C.outline, radius: 16 * this.scale })

          // Outer circle (record) - Yellow ring
          // Using a transparent circle with a thick border
          Column()
            .width((120 * 2 + 8) * this.scale) // diameter + border width
            .height((120 * 2 + 8) * this.scale)
            .borderRadius('50%')
            .border({ width: 8 * this.scale, color: RM_C.secondary })

          // Draggable knob - Pink dot
          Column()
            .width(24 * this.scale)
            .height(24 * this.scale)
            .borderRadius('50%')
            .backgroundColor(RM_C.primary)
            .position({ x: this.knobPositionX, y: this.knobPositionY })
            .gesture(
              PanGesture({ fingers: 1, distance: 0 }) // minimumDistance: 0 equivalent
                .onActionStart(() => {
                  this.isDragging = true;
                })
                .onActionUpdate((event: GestureEvent) => {
                  this.isDragging = true;
                  
                  // The event offsets are relative to the touch start point.
                  // We need absolute position within the 280x280 container.
                  // The container is centered, so its origin is at (0,0) of this Stack.
                  // The center of the circle is at (140 * scale, 140 * scale).
                  
                  // Calculate new absolute position
                  // Note: ArkUI PanGesture gives offsets, not absolute coordinates.
                  // We need to track the base position and add offsets.
                  // A simpler approach for absolute dragging in a bounded area:
                  // We use the local offset relative to the center.
                  
                  // Since we can't get absolute touch location easily in PanGesture,
                  // we calculate based on the last position + offset.
                  // However, to strictly constrain to the circle, we do the math:
                  
                  let centerX = 140 * this.scale;
                  let centerY = 140 * this.scale;
                  let radius = this.circleRadius * this.scale;
                  
                  // Calculate new position based on previous + delta
                  let newX = this.knobPositionX + event.offsetX;
                  let newY = this.knobPositionY + event.offsetY;
                  
                  let dx = newX - centerX;
                  let dy = newY - centerY;
                  let distance = Math.sqrt(dx * dx + dy * dy);
                  
                  if (distance <= radius) {
                    this.knobPositionX = newX;
                    this.knobPositionY = newY;
                  } else {
                    let angle = Math.atan2(dy, dx);
                    this.knobPositionX = centerX + Math.cos(angle) * radius;
                    this.knobPositionY = centerY + Math.sin(angle) * radius;
                  }
                })
                .onActionEnd(() => {
                  this.isDragging = false;
                })
            )
            // Animation when not dragging
            .animation(!this.isDragging ? { duration: 200, curve: Curve.EaseOut } : { duration: 0 }, {
              onFinish: () => {}
            })
        }
        .width(280 * this.scale)
        .height(280 * this.scale)

        // ===== Track Info =====
        Text("Track: Summer Nights")
          .fontSize(22 * this.scale)
          .fontWeight(FontWeight.Medium)
          .fontColor(RM_C.onSurface)

        // ===== Control Buttons =====
        Row({ space: 32 * this.scale }) {
          Button("Play", { type: ButtonType.Normal })
            .fontSize(22 * this.scale)
            .fontWeight(FontWeight.Medium)
            .fontColor(RM_C.onPrimary)
            .width(140 * this.scale)
            .height(56 * this.scale)
            .borderRadius(12 * this.scale)
            .backgroundColor(RM_C.primary)

          Button("Pause", { type: ButtonType.Normal })
            .fontSize(22 * this.scale)
            .fontWeight(FontWeight.Medium)
            .fontColor(RM_C.onSecondary)
            .width(140 * this.scale)
            .height(56 * this.scale)
            .borderRadius(12 * this.scale)
            .backgroundColor(RM_C.secondary)
        }

        // ===== Knob Coordinates =====
        Text(`Knob X:${Math.round(this.knobPositionX)} Y:${Math.round(this.knobPositionY)}`)
          .fontSize(16 * this.scale)
          .fontWeight(FontWeight.Medium)
          .fontColor(RM_C.tertiary)
      }
      .width('100%')
      .padding({ left: 32 * this.scale, right: 32 * this.scale })
      .layoutWeight(1) // Spacer equivalent
      .justifyContent(FlexAlign.Center)

      // ===== Bottom Spacer =====
      Column()
        .width('100%')
        .height(60 * this.scale)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(RM_C.background)
  }
}