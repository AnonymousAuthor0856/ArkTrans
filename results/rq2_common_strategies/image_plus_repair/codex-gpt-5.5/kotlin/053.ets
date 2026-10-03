class CodeMarker {
  id: number
  name: string
  desc: string

  constructor(id: number, name: string, desc: string) {
    this.id = id
    this.name = name
    this.desc = desc
  }
}

const MARKERS: CodeMarker[] = [
  new CodeMarker(1, 'Main.kt', 'Entry point for Compose app'),
  new CodeMarker(2, 'Utils.kt', 'Helper functions'),
  new CodeMarker(3, 'Theme.kt', 'Color & Typography setup'),
  new CodeMarker(4, 'Data.kt', 'Repository and model classes')
]

@Entry
@Component
struct CodeIDETerminalPage {
  private markers: CodeMarker[] = MARKERS

  @Builder
  FileItem(marker: CodeMarker) {
    Row() {
      Text(marker.id.toString())
        .fontSize(25)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .textAlign(TextAlign.Center)
        .width(64)
        .height(64)
        .backgroundColor('#0EA5E9')
        .borderRadius(7)

      Column() {
        Text(marker.name)
          .fontSize(31)
          .fontWeight(FontWeight.Bold)
          .fontColor('#E2E8F0')
          .lineHeight(37)
          .maxLines(1)

        Text(marker.desc)
          .fontSize(28)
          .fontWeight(FontWeight.Regular)
          .fontColor('#E2E8F0')
          .lineHeight(34)
          .maxLines(1)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
      .layoutWeight(1)
      .height('100%')
      .margin({ left: 24 })
    }
    .width('100%')
    .height(119)
    .padding({ left: 24, right: 24, top: 20, bottom: 20 })
    .backgroundColor('#334155')
    .borderRadius(14)
  }

  build() {
    Column() {
      Text('CodeIDE Terminal')
        .fontSize(49)
        .fontWeight(FontWeight.Bold)
        .fontColor('#E2E8F0')
        .textAlign(TextAlign.Center)
        .width('100%')
        .lineHeight(60)
        .margin({ top: 34, bottom: 72 })

      Text('Project Files')
        .fontSize(39)
        .fontWeight(FontWeight.Bold)
        .fontColor('#E2E8F0')
        .width('100%')
        .lineHeight(48)
        .margin({ bottom: 32 })

      Column({ space: 16 }) {
        ForEach(this.markers, (marker: CodeMarker) => {
          this.FileItem(marker)
        }, (marker: CodeMarker) => marker.id.toString())
      }
      .width('100%')
      .margin({ bottom: 79 })

      Text('Live Terminal')
        .fontSize(39)
        .fontWeight(FontWeight.Bold)
        .fontColor('#E2E8F0')
        .width('100%')
        .lineHeight(48)
        .margin({ bottom: 32 })

      Stack({ alignContent: Alignment.TopStart }) {
        Text('> println("Hello, Kotlin!")')
          .fontSize(28)
          .fontWeight(FontWeight.Regular)
          .fontColor('#E2E8F0')
          .lineHeight(34)
          .margin({ left: 23, top: 23 })
      }
      .width('100%')
      .height(325)
      .backgroundColor('#334155')
      .border({
        width: 2,
        color: '#475569',
        radius: 14
      })
      .margin({ bottom: 28 })

      Button('Run Code')
        .fontSize(27)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .width(394)
        .height(48)
        .backgroundColor('#0EA5E9')
        .borderRadius(12)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32 })
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('#1C283A')
  }
}
