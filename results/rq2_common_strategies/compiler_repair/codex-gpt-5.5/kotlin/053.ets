class CodeMarker {
  id: number;
  name: string;
  desc: string;

  constructor(id: number, name: string, desc: string) {
    this.id = id;
    this.name = name;
    this.desc = desc;
  }
}

class CodeColors {
  static readonly primary: string = '#1E293B';
  static readonly secondary: string = '#0EA5E9';
  static readonly background: string = '#111827';
  static readonly surface: string = '#1E293B';
  static readonly surfaceVariant: string = '#334155';
  static readonly outline: string = '#475569';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onBackground: string = '#E2E8F0';
  static readonly onSurface: string = '#E2E8F0';
}

@Entry
@Component
struct Index {
  private markers: CodeMarker[] = [
    new CodeMarker(1, 'Main.kt', 'Entry point for Compose app'),
    new CodeMarker(2, 'Utils.kt', 'Helper functions'),
    new CodeMarker(3, 'Theme.kt', 'Color & Typography setup'),
    new CodeMarker(4, 'Data.kt', 'Repository and model classes')
  ];

  @Builder
  MarkerRow(marker: CodeMarker) {
    Row() {
      Text(marker.id.toString())
        .width(32)
        .height(32)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(CodeColors.onSecondary)
        .backgroundColor(CodeColors.secondary)
        .borderRadius(4)
        .textAlign(TextAlign.Center)

      Column() {
        Text(marker.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(CodeColors.onSurface)
          .width('100%')
        Text(marker.desc)
          .fontSize(14)
          .fontColor(CodeColors.onSurface)
          .width('100%')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .margin({ left: 12 })
    }
    .width('100%')
    .padding(12)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(CodeColors.surfaceVariant)
    .borderRadius(8)
  }

  @Builder
  TerminalPanel() {
    Column() {
      Text('> println("Hello, Kotlin!")')
        .fontSize(14)
        .fontColor(CodeColors.onSurface)
        .width('100%')
    }
    .width('100%')
    .height(240)
    .padding(12)
    .backgroundColor(CodeColors.surfaceVariant)
    .borderRadius(8)
    .border({ width: 1, color: CodeColors.outline })
  }

  build() {
    Column() {
      Text('CodeIDE Terminal')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(CodeColors.onBackground)
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)

      Scroll() {
        Column() {
          Text('Project Files')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(CodeColors.onBackground)
            .width('100%')
            .margin({ bottom: 16 })

          ForEach(this.markers, (marker: CodeMarker) => {
            Column() {
              this.MarkerRow(marker)
            }
            .margin({ bottom: 8 })
          }, (marker: CodeMarker) => marker.id.toString())

          Text('Live Terminal')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(CodeColors.onBackground)
            .width('100%')
            .margin({ top: 8, bottom: 16 })

          this.TerminalPanel()

          Button('Run Code')
            .width('60%')
            .height(48)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(CodeColors.onSecondary)
            .backgroundColor(CodeColors.secondary)
            .borderRadius(12)
            .alignSelf(ItemAlign.Center)
            .margin({ top: 16, bottom: 24 })
        }
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16 })
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#CC1E293B', 0.0], ['#E61E293B', 1.0]]
    })
    .backgroundColor(CodeColors.background)
  }
}
