import { BusinessError } from '@kit.BasicServicesKit';

// Color Utility Helper to mimic SwiftUI hex init
function getColorFromHex(hex: number): string {
  const r = ((hex >> 16) & 0xFF);
  const g = ((hex >> 8) & 0xFF);
  const b = (hex & 0xFF);
  return `#${r.toString(16).padStart(2, '0')}${g.toString(16).padStart(2, '0')}${b.toString(16).padStart(2, '0')}`;
}

@Entry
@Component
struct VideoPlayerRoot {
  // Constants matching VP struct
  private readonly VIDEO_SURFACE_RATIO: number = 0.50;
  
  // Colors
  private readonly COLOR_PRIMARY: string = getColorFromHex(0x1E3A8A);
  private readonly COLOR_BACKGROUND: string = getColorFromHex(0x0F172A);
  private readonly COLOR_SURFACE_VARIANT: string = getColorFromHex(0x334155);
  private readonly COLOR_OUTLINE: string = getColorFromHex(0x475569);
  private readonly COLOR_ON_SURFACE: string = getColorFromHex(0xE2E8F0);
  private readonly COLOR_CHIP: string = getColorFromHex(0xE8DEF8);
  private readonly COLOR_TEXT_LIGHT: string = getColorFromHex(0xA3AAB5);
  private readonly COLOR_TEXT_DARK: string = getColorFromHex(0x1D192B);
  private readonly COLOR_WHITE: string = '#FFFFFF';

  build() {
    Column() {
      GeometryReader((constraint: ViewAttributes) => {
        let sw: number = constraint.width;
        let sh: number = constraint.height;
        
        // Base scale calculation based on 720x1280 reference
        let scale: number = Math.min(sw / 720.0, sh / 1280.0);
        let padX: number = 24.0 * scale;
        let titleH: number = 56.0 * scale;
        
        // Video container height logic
        let videoH: number = Math.max(sh * this.VIDEO_SURFACE_RATIO, 360 * scale);

        Column() {
          // Top Title
          Text("Video Player")
            .fontSize(18 * scale)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.COLOR_ON_SURFACE)
            .height(titleH)
            .padding({ top: 12 * scale, bottom: 12 * scale })
            .alignSelf(ItemAlign.Start)
            .margin({ left: padX })

          // Video Surface
          Row() {
            Text("Video Surface")
              .fontSize(16 * scale)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color(this.COLOR_ON_SURFACE).opacity(0.9))
          }
          .width('100%')
          .height(videoH)
          .backgroundColor(this.COLOR_SURFACE_VARIANT)
          .borderRadius(24 * scale)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .margin({ right: 10 }) // Matching padding(.trailing, 10)

          // Movie Title
          Text("Journey through the Skies")
            .fontSize(18 * scale)
            .fontWeight(FontWeight.Medium)
            .fontColor(getColorFromHex(0xE0E8F0))
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: 20, right: 20, top: 10, bottom: 10 })

          // Progress Area
          Column() {
            // Progress Bar Row
            Row() {
              Blank()
              
              // Left Capsule (Played)
              Rectangle()
                .fill(this.COLOR_PRIMARY)
                .width((sw - 2 * padX) * 0.40)
                .height(32 * scale)
                .borderRadius(16 * scale)

              // Vertical Indicator
              Rectangle()
                .fill(this.COLOR_PRIMARY)
                .width(6 * scale)
                .height(72 * scale)
                .borderRadius(3 * scale)
                .margin({ left: 18 * scale, right: 0 })

              // Right Track (Remaining) with Dot
              Stack({ alignContent: Alignment.End }) {
                Rectangle()
                  .fill(getColorFromHex(0x475569))
                  .width((sw - 2 * padX) * 0.47)
                  .height(32 * scale)
                  .borderRadius(16 * scale)
                
                Circle()
                  .fill(this.COLOR_PRIMARY)
                  .width(12 * scale)
                  .height(12 * scale)
                  .margin({ right: 10 * scale }) // offset(x: -10*scale) equivalent in trailing stack
              }
              .width((sw - 2 * padX) * 0.47)

              Blank()
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            // Time Labels
            Row() {
              Text("1:35")
                .fontSize(12 * scale)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.COLOR_TEXT_LIGHT)
                .margin({ left: 10 })
              
              Blank()
              
              Text("4:00")
                .fontSize(12 * scale)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.COLOR_TEXT_LIGHT)
                .margin({ right: 10 })
            }
            .width('100%')
            .margin({ top: 10 * scale })

          }
          .padding({ left: padX, right: padX, top: 8 * scale, bottom: 6 * scale })

          // Controls Area (-10s, Play, +30s)
          Row() {
            // -10s Button
            Text("-10s")
              .fontSize(18 * scale)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.COLOR_TEXT_DARK)
              .width(180 * scale)
              .height(96 * scale)
              .textAlign(TextAlign.Center)
              .verticalCenter(true)
              .backgroundColor(this.COLOR_CHIP)
              .borderRadius(18 * scale)

            // Play Button
            Stack() {
              Circle()
                .fill(this.COLOR_PRIMARY)
                .width(120 * scale)
                .height(120 * scale)
              
              Text("▶") // Using text for play icon as system images vary by platform
                .fontSize(40 * scale)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.COLOR_WHITE)
                .margin({ left: 5 * scale }) // Visual adjustment for triangle centering
            }
            .width(120 * scale)
            .height(120 * scale)
            .margin({ left: 24 * scale, right: 24 * scale })

            // +30s Button
            Text("+30s")
              .fontSize(18 * scale)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.COLOR_TEXT_DARK)
              .width(180 * scale)
              .height(96 * scale)
              .textAlign(TextAlign.Center)
              .verticalCenter(true)
              .backgroundColor(this.COLOR_CHIP)
              .borderRadius(18 * scale)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ top: 10 * scale, bottom: 10 })

          // Fullscreen Ghost Button
          Button() {
            Text("Fullscreen")
              .fontSize(18 * scale)
              .fontWeight(FontWeight.Medium)
              .fontColor(getColorFromHex(0x47434E))
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .width(220 * scale)
          .height(64 * scale)
          .borderWidth(1)
          .borderColor(this.COLOR_OUTLINE)
          .borderRadius(12 * scale)
          .margin({ top: 12 * scale })

          Blank()
        }
        .width('100%')
        .height('100%')
        .backgroundColor(this.COLOR_BACKGROUND)
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.COLOR_BACKGROUND)
  }
}