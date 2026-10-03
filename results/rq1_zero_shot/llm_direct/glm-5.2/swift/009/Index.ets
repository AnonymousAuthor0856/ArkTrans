import { Length, Resource, RRect, RoundRect } from '@ohos.arkui.arkui';

const VIDEO_SURFACE_RATIO: number = 0.50;

class VP {
  static Colors = {
    primary: Color.fromHex(0x1E3A8A),
    background: Color.fromHex(0x0F172A),
    surface: Color.fromHex(0x1E293B),
    surfaceVariant: Color.fromHex(0x334155),
    outline: Color.fromHex(0x475569),
    onSurface: Color.fromHex(0xE2E8F0),
    chip: Color.fromHex(0xE8DEF8)
  };
}

class Color {
  r: number;
  g: number;
  b: number;
  a: number;

  constructor(r: number, g: number, b: number, a: number = 1.0) {
    this.r = r;
    this.g = g;
    this.b = b;
    this.a = a;
  }

  static fromHex(hex: number): Color {
    const r = (hex >> 16) & 0xFF;
    const g = (hex >> 8) & 0xFF;
    const b = hex & 0xFF;
    return new Color(r / 255.0, g / 255.0, b / 255.0, 1.0);
  }

  toResource(): Resource {
    return { id: 0, type: 40001, params: [`rgba(${this.r * 255}, ${this.g * 255}, ${this.b * 255}, ${this.a})`] };
  }
}

@Entry
@Component
struct VideoPlayerRoot {
  build() {
    Column() {
      // 顶部标题
      Text('Video Player')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.fromHex(0xe2e8f0).toResource())
        .height(56)
        .padding({ top: 12, bottom: 12 })

      // Video Surface
      Text('Video Surface')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.fromHex(0xE2E8F0).toResource())
        .backgroundColor(VP.Colors.surfaceVariant.toResource())
        .borderRadius(24)
        .height(300)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ right: 10 })

      // 片名
      Text('Journey through the Skies')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.fromHex(0xe0e8f0).toResource())
        .width('100%')
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        .textAlign(TextAlign.Start)

      // ===== 进度区域 =====
      Column() {
        Row() {
          Blank()
          Row()
            .backgroundColor(VP.Colors.primary.toResource())
            .borderRadius(16)
            .width('40%')
            .height(32)

          Row()
            .backgroundColor(VP.Colors.primary.toResource())
            .borderRadius(3)
            .width(6)
            .height(72)

          Stack({ alignContent: Alignment.End }) {
            Row()
              .backgroundColor(Color.fromHex(0x475569).toResource())
              .borderRadius(16)
              .width('100%')
              .height(32)
            Circle()
              .fill(VP.Colors.primary.toResource())
              .width(12)
              .height(12)
              .margin({ right: 10 })
          }
          .width('47%')
          .height(32)

          Blank()
        }
        .width('100%')
        .height(72)
        .justifyContent(FlexAlign.Center)

        Row() {
          Text('1:35')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.fromHex(0xa3aab5).toResource())
            .margin({ left: 10 })
          Blank()
          Text('4:00')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.fromHex(0xa3aab5).toResource())
            .margin({ right: 10 })
        }
        .width('100%')
      }
      .padding({ left: 24, right: 24, top: 8, bottom: 6 })

      // ===== 控制区 =====
      Row() {
        this.tonalButton('−10s')

        Stack() {
          Circle().fill(VP.Colors.primary.toResource())
          Text('▶')
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.fromHex(0xffffff).toResource())
        }
        .width(120)
        .height(120)

        this.tonalButton('+30s')
      }
      .padding({ top: 10, bottom: 10 })
      .justifyContent(FlexAlign.Center)

      // Fullscreen Ghost
      Button('Fullscreen')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.fromHex(0x47434e).toResource())
        .width(220)
        .height(64)
        .backgroundColor(Color.Transparent.toResource())
        .border({ width: 1, color: VP.Colors.outline.toResource(), radius: 12 })
        .margin({ top: 12 })

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(VP.Colors.background.toResource())
  }

  @Builder
  tonalButton(title: string) {
    Text(title)
      .fontSize(18)
      .fontWeight(FontWeight.Medium)
      .fontColor(Color.fromHex(0x1d192b).toResource())
      .width(180)
      .height(96)
      .backgroundColor(VP.Colors.chip.toResource())
      .borderRadius(18)
      .textAlign(TextAlign.Center)
  }
}