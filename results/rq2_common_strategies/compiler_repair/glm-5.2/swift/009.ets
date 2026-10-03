// VideoPlayerApp.ets

// Helper to convert hex to ResourceColor
function hexToColor(hex: number): ResourceColor {
  const r = (hex >> 16) & 0xFF;
  const g = (hex >> 8) & 0xFF;
  const b = hex & 0xFF;
  return `#${r.toString(16).padStart(2, '0')}${g.toString(16).padStart(2, '0')}${b.toString(16).padStart(2, '0')}`;
}

@Entry
@Component
struct VideoPlayerRoot {
  // Screen dimensions and scale factors
  private sw: number = 720;
  private sh: number = 1280;
  private scaleFactor: number = 1; // Renamed to avoid conflict with built-in scale property
  private padX: number = 24;
  private titleH: number = 56;
  private videoH: number = 360;

  // Colors matching VP.Colors
  private readonly COLOR_PRIMARY = hexToColor(0x1E3A8A);
  private readonly COLOR_BACKGROUND = hexToColor(0x0F172A);
  private readonly COLOR_SURFACE = hexToColor(0x1E293B);
  private readonly COLOR_SURFACE_VARIANT = hexToColor(0x334155);
  private readonly COLOR_OUTLINE = hexToColor(0x475569);
  private readonly COLOR_ON_SURFACE = hexToColor(0xE2E8F0);
  private readonly COLOR_CHIP = hexToColor(0xE8DEF8);
  private readonly COLOR_TEXT_MUTED = hexToColor(0xa3aab5);
  private readonly COLOR_TEXT_DARK = hexToColor(0x1d192b);
  private readonly COLOR_GHOST_TEXT = hexToColor(0x47434e);

  aboutToAppear() {
    // Simulating GeometryReader calculations
    // In a real app, you might use display.getDefaultDisplaySync() to get real screen size
    this.scaleFactor = Math.min(this.sw / 720.0, this.sh / 1280.0);
    this.padX = 24.0 * this.scaleFactor;
    this.titleH = 56.0 * this.scaleFactor;
    this.videoH = Math.max(this.sh * 0.50, 360 * this.scaleFactor);
  }

  build() {
    Column() {
      // 顶部标题
      Text('Video Player')
        .fontSize(18 * this.scaleFactor)
        .fontWeight(FontWeight.Medium)
        .fontColor(hexToColor(0xe2e8f0))
        .height(this.titleH)
        .padding({ top: 12 * this.scaleFactor, bottom: 12 * this.scaleFactor })

      // Video Surface
      Row() {
        Column() {
          Text('Video Surface')
            .fontSize(16 * this.scaleFactor)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.COLOR_ON_SURFACE)
            .opacity(0.9)
        }
        .width('100%')
        .height(300)
        .backgroundColor(this.COLOR_SURFACE_VARIANT)
        .borderRadius(24 * this.scaleFactor)
        .justifyContent(FlexAlign.Center)
        .padding({ right: 10 })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)

      // 片名
      Text('Journey through the Skies')
        .fontSize(18 * this.scaleFactor)
        .fontWeight(FontWeight.Medium)
        .fontColor(hexToColor(0xe0e8f0))
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })

      // ===== 进度区域 =====
      Column({ space: 10 * this.scaleFactor }) {
        // Calculate widths dynamically based on padding
        // Note: ArkTS doesn't have direct GeometryReader inside build easily for nested elements,
        // so we estimate based on parent width or use percentage/flex.
        // For exact match, we use a custom Row layout.
        
        Row({ space: 18 * this.scaleFactor }) {
          Blank() // Spacer equivalent

          // Left Capsule
          Column()
            .width('40%') // Approximate contentW * 0.40
            .height(32 * this.scaleFactor)
            .backgroundColor(this.COLOR_PRIMARY)
            .borderRadius(16 * this.scaleFactor)

          // Vertical Bar
          Column()
            .width(6 * this.scaleFactor)
            .height(72 * this.scaleFactor)
            .backgroundColor(this.COLOR_PRIMARY)
            .borderRadius(3 * this.scaleFactor)

          // Right Track with Dot
          Stack({ alignContent: Alignment.End }) {
            Column()
              .width('100%')
              .height(32 * this.scaleFactor)
              .backgroundColor(this.COLOR_OUTLINE)
              .borderRadius(16 * this.scaleFactor)
            
            // Blue Dot
            Circle({ width: 12 * this.scaleFactor, height: 12 * this.scaleFactor })
              .fill(this.COLOR_PRIMARY)
              .margin({ right: 10 * this.scaleFactor })
          }
          .width('47%') // Approximate contentW * 0.47
          .height(32 * this.scaleFactor)

          Blank() // Spacer equivalent
        }
        .width('100%')

        // Time labels
        Row() {
          Text('1:35')
            .fontSize(12 * this.scaleFactor)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.COLOR_TEXT_MUTED)
            .margin({ left: 10 })
          
          Blank() // Spacer

          Text('4:00')
            .fontSize(12 * this.scaleFactor)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.COLOR_TEXT_MUTED)
            .margin({ right: 10 })
        }
        .width('100%')
      }
      .width('100%')
      .padding({ left: this.padX, right: this.padX, top: 8 * this.scaleFactor, bottom: 6 * this.scaleFactor })

      // ===== 控制区 =====
      Row({ space: 24 * this.scaleFactor }) {
        // -10s Button
        Text('−10s')
          .fontSize(18 * this.scaleFactor)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.COLOR_TEXT_DARK)
          .width(180 * this.scaleFactor)
          .height(96 * this.scaleFactor)
          .textAlign(TextAlign.Center)
          .backgroundColor(this.COLOR_CHIP)
          .borderRadius(18 * this.scaleFactor)

        // Play Button
        Stack() {
          Circle({ width: 120 * this.scaleFactor, height: 120 * this.scaleFactor })
            .fill(this.COLOR_PRIMARY)
          
          // Play Icon (Using Text as placeholder for system image)
          Text('▶')
            .fontSize(40 * this.scaleFactor)
            .fontColor(Color.White)
        }
        .width(120 * this.scaleFactor)
        .height(120 * this.scaleFactor)

        // +30s Button
        Text('+30s')
          .fontSize(18 * this.scaleFactor)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.COLOR_TEXT_DARK)
          .width(180 * this.scaleFactor)
          .height(96 * this.scaleFactor)
          .textAlign(TextAlign.Center)
          .backgroundColor(this.COLOR_CHIP)
          .borderRadius(18 * this.scaleFactor)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 10 * this.scaleFactor, bottom: 10 })

      // Fullscreen Ghost Button
      Button() {
        Text('Fullscreen')
          .fontSize(18 * this.scaleFactor)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.COLOR_GHOST_TEXT)
      }
      .type(ButtonType.Normal)
      .width(220 * this.scaleFactor)
      .height(64 * this.scaleFactor)
      .borderRadius(12 * this.scaleFactor)
      .border({ width: 1, color: this.COLOR_OUTLINE })
      .backgroundColor(Color.Transparent)
      .margin({ top: 12 * this.scaleFactor })

      Blank() // Spacer minLength: 0
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.COLOR_BACKGROUND)
  }
}