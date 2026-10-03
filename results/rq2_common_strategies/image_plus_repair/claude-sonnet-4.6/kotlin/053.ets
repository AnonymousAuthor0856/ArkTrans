import { LengthMetrics } from '@kit.ArkUI'

interface CodeMarker {
  id: number
  name: string
  desc: string
}

const markers: CodeMarker[] = [
  { id: 1, name: 'Main.kt', desc: 'Entry point for Compose app' },
  { id: 2, name: 'Utils.kt', desc: 'Helper functions' },
  { id: 3, name: 'Theme.kt', desc: 'Color & Typography setup' },
  { id: 4, name: 'Data.kt', desc: 'Repository and model classes' },
]

@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('CodeIDE Terminal')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#E2E8F0')
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(64)
      .backgroundColor('#1E293B')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Body
      Scroll() {
        Column({ space: 16 }) {
          // Project Files heading
          Text('Project Files')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
            .width('100%')

          // File cards
          ForEach(markers, (m: CodeMarker) => {
            Row({ space: 12 }) {
              // ID badge
              Stack() {
                Text(m.id.toString())
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFFFF')
              }
              .width(32)
              .height(32)
              .backgroundColor('#0EA5E9')
              .borderRadius(4)
              .alignContent(Alignment.Center)

              // Name + desc
              Column({ space: 2 }) {
                Text(m.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#E2E8F0')
                Text(m.desc)
                  .fontSize(14)
                  .fontWeight(FontWeight.Normal)
                  .fontColor('#E2E8F0')
              }
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#334155')
            .borderRadius(8)
            .alignItems(VerticalAlign.Center)
          })

          // Live Terminal heading
          Text('Live Terminal')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
            .width('100%')
            .margin({ top: 8 })

          // Terminal box
          Column() {
            Text('> println("Hello, Kotlin!")')
              .fontSize(14)
              .fontColor('#E2E8F0')
              .fontWeight(FontWeight.Normal)
          }
          .width('100%')
          .height(240)
          .backgroundColor('#334155')
          .borderRadius(8)
          .border({ width: 1, color: '#475569' })
          .padding(12)
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Start)

          // Run Code button
          Button('Run Code')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#0EA5E9')
            .borderRadius(12)
            .width('60%')
            .height(48)
            .alignSelf(ItemAlign.Center)
            .margin({ bottom: 36 })
        }
        .padding(16)
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [0xCC1E293B, 0.0],
        [0xE61E293B, 1.0]
      ]
    })
    .backgroundColor('#111827')
  }
}