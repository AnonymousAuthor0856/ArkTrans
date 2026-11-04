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

@Entry
@Component
struct Index {
  private markers: CodeMarker[] = [
    new CodeMarker(1, 'Main.kt', 'Entry point for Compose app'),
    new CodeMarker(2, 'Utils.kt', 'Helper functions'),
    new CodeMarker(3, 'Theme.kt', 'Color & Typography setup'),
    new CodeMarker(4, 'Data.kt', 'Repository and model classes')
  ]

  @Builder
  TopAppBar() {
    Row() {
      Blank()
      Text('CodeIDE Terminal')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#E2E8F0')
      Blank()
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .backgroundColor('#1E293B')
  }

  @Builder
  CodeMarkerCard(marker: CodeMarker) {
    Row() {
      Stack() {
        Rect()
          .width(32)
          .height(32)
          .radius(4)
          .fill('#0EA5E9')
        Text(marker.id.toString())
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
      }

      Column() {
        Text(marker.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0')
          .width('100%')
        Text(marker.desc)
          .fontSize(14)
          .fontColor('#E2E8F0')
          .width('100%')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 12 })
    }
    .width('100%')
    .padding(12)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#334155')
    .borderRadius(8)
    .shadow({ radius: 2, color: '#1A000000', offsetY: 1 })
  }

  @Builder
  TerminalPanel() {
    Stack({ alignContent: Alignment.TopStart }) {
      Rect()
        .width('100%')
        .height('100%')
        .radius(8)
        .fill('#334155')
      Text('> println("Hello, Kotlin!")')
        .fontSize(14)
        .fontColor('#E2E8F0')
        .padding(12)
    }
    .width('100%')
    .height(240)
    .border({ width: 1, color: '#475569', radius: 8 })
  }

  build() {
    Column() {
      this.TopAppBar()

      Scroll() {
        Column() {
          Text('Project Files')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#E2E8F0')
            .width('100%')

          Column() {
            ForEach(this.markers, (marker: CodeMarker) => {
              Column() {
                this.CodeMarkerCard(marker)
              }
              .margin({ bottom: 8 })
            }, (marker: CodeMarker) => marker.id.toString())
          }
          .width('100%')
          .margin({ top: 16, bottom: 24 })

          Text('Live Terminal')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#E2E8F0')
            .width('100%')

          Column() {
            this.TerminalPanel()
          }
          .margin({ top: 16 })

          Row() {
            Blank()
            Button('Run Code')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .width('60%')
              .height(48)
              .backgroundColor('#0EA5E9')
              .borderRadius(12)
              .shadow({ radius: 2, color: '#1A000000', offsetY: 1 })
            Blank()
          }
          .width('100%')
          .margin({ top: 16 })
        }
        .width('100%')
        .padding(16)
        .linearGradient({
          angle: 180,
          colors: [['#CC1E293B', 0.0], ['#E61E293B', 1.0]]
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#1E293B')
  }
}
