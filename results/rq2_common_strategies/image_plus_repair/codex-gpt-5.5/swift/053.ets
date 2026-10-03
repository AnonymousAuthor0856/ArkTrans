interface ColorPalette {
  background: string
  surfaceVariant: string
  secondary: string
  outline: string
  text: string
  white: string
}

interface CodeMarker {
  id: number
  name: string
  description: string
}

const Colors: ColorPalette = {
  background: '#1E293B',
  surfaceVariant: '#334155',
  secondary: '#0EA5E9',
  outline: '#475569',
  text: '#E2E8F0',
  white: '#FFFFFF'
}

const markers: CodeMarker[] = [
  { id: 1, name: 'Main.kt', description: 'Entry point for Compose app' },
  { id: 2, name: 'Utils.kt', description: 'Helper functions' },
  { id: 3, name: 'Theme.kt', description: 'Color & Typography setup' },
  { id: 4, name: 'Data.kt', description: 'Repository and model classes' }
]

@Entry
@Component
struct Index {
  @State private terminalText: string = '> println("Hello, Kotlin!")'

  @Builder
  private topBar() {
    Row() {
      Text('CodeIDE Terminal')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.text)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: 12, bottom: 12 })
  }

  @Builder
  private markerCard(marker: CodeMarker) {
    Row({ space: 12 }) {
      Stack() {
        Text(marker.id.toString())
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.white)
      }
      .width(32)
      .height(32)
      .borderRadius(4)
      .backgroundColor(Colors.secondary)
      .alignContent(Alignment.Center)

      Column() {
        Text(marker.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.text)
          .maxLines(1)
        Text(marker.description)
          .fontSize(14)
          .fontColor(Colors.text)
          .maxLines(1)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Colors.surfaceVariant)
    .borderRadius(8)
  }

  @Builder
  private terminalPanel() {
    Stack({ alignContent: Alignment.TopStart }) {
      Text(this.terminalText)
        .fontSize(14)
        .fontColor(Colors.text)
        .padding(12)
    }
    .width('100%')
    .height(240)
    .backgroundColor(Colors.surfaceVariant)
    .borderRadius(8)
    .border({ width: 1, color: Colors.outline, radius: 8 })
  }

  build() {
    Column() {
      this.topBar()

      Scroll() {
        Column({ space: 16 }) {
          Text('Project Files')
            .width('100%')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.text)

          Column({ space: 8 }) {
            ForEach(markers, (marker: CodeMarker) => {
              this.markerCard(marker)
            }, (marker: CodeMarker) => marker.id.toString())
          }
          .width('100%')
          .padding({ bottom: 24 })

          Text('Live Terminal')
            .width('100%')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.text)

          this.terminalPanel()

          Button('Run Code')
            .width('60%')
            .height(48)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.white)
            .backgroundColor(Colors.secondary)
            .borderRadius(12)
            .onClick(() => {
              this.terminalText = '> println("Hello, Kotlin!")\nHello, Kotlin!'
            })
        }
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
