import { Point } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  @State nodes: Array<Point> = [new Point(200, 400), new Point(500, 700), new Point(350, 250)]
  @State currentColor: string = '#00FFFF'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Canvas Layer ===
      Stack({ alignContent: Alignment.Center }) {
        Canvas().width('100%').height('100%')
      }.width('100%').height('100%').padding(0).backgroundColor('#0D0D0D')

      // === Top App Bar ===
      Column() {
        Text('Neon Mind Map')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FFFF')
          .textAlign(TextAlign.Center)
          .margin({ bottom: 16 })
      }.width('100%').backgroundColor('#0D0D0D').zIndex(10)

      // === Color Selection Row ===
      Column() {
        Row({ space: 12 }) {
          Button() {
            Text('Cyan')
              .fontColor('#000000')
          }
          .backgroundColor('#00FFFF')
          .onClick(() => {
            this.currentColor = '#00FFFF'
          })

          Button() {
            Text('Green')
              .fontColor('#000000')
          }
          .backgroundColor('#00FF88')
          .onClick(() => {
            this.currentColor = '#00FF88'
          })

          Button() {
            Text('Purple')
              .fontColor('#FFFFFF')
          }
          .backgroundColor('#9C27B0')
          .onClick(() => {
            this.currentColor = '#9C27B0'
          })
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')
        .padding(12)
      }
      .backgroundColor('#2E2E2E')
      .shadow({ radius: 4, color: '#1A000000' })
      .position({ x: 0, y: 'auto' }) // Positioned relative to stack if needed, but here it's just a child

      // === Floating Action Button ===
      Button() {
        Text('+')
          .fontSize(24)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor('#00FF88')
      .shadow({ radius: 6, color: '#3F000000' })
      .position({ x: 'auto', y: 'auto' })
      .margin({ right: 24, bottom: 24 })
      .onClick(() => {
        const newX = Math.random() * (600 - 100) + 100
        const newY = Math.random() * (800 - 200) + 200
        this.nodes.push(new Point(newX, newY))
      })
    }
    .width('100%')
    .height('100%')
  }
}