import { window } from '@kit.ArkUI'
import { common, UIAbility, Want } from '@kit.AbilityKit'

@Entry
@Component
struct RootScreen {
  @State query: string = ''
  @State knobX: number = 160
  @State knobY: number = 120
  private results: ResultItem[] = []

  aboutToAppear() {
    for (let i = 0; i < 6; i++) {
      this.results.push(new ResultItem(i, `Result ${i + 1}`))
    }
  }

  build() {
    Column() {
      Text('Retro Filter Search')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3E2723')
        .margin({ bottom: 12 })

      // Search Field
      TextInput({ placeholder: 'Search products', text: this.query })
        .type(InputType.Normal)
        .width('100%')
        .height(48)
        .backgroundColor('#FFFFFF')
        .borderRadius(10)
        .borderWidth(1)
        .borderColor(this.query.length > 0 ? '#FF7B00' : '#E0C080')
        .onChange((value: string) => {
          this.query = value
        })
        .margin({ bottom: 12 })

      // Chips Row
      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
        ForEach(['Popular', 'New', 'Discount', 'Premium'], (item: string) => {
          Button(item)
            .width('auto')
            .height(36)
            .backgroundColor('#FFD166')
            .fontColor('#3E2723')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .borderRadius(6)
            .margin({ right: 8, bottom: 8 })
        })
      }
      .margin({ bottom: 12 })

      // Canvas Box
      Stack() {
        DrawingCanvas()
          .width('100%')
          .height(180)
          .backgroundColor('#FFFFFF')
          .borderRadius(14)
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Move) {
              this.knobX = event.touches[0].x
              this.knobY = event.touches[0].y
            }
          })
      }
      .width('100%')
      .height(180)
      .margin({ bottom: 12 })

      // Grid List
      GridContainer()
        .columnsTemplate('1fr 1fr')
        .rowsTemplate('auto')
        .gap(16)
        .width('100%')
        .layoutWeight(1)
        .padding({ bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFF6E5')
  }
}

@Component
struct DrawingCanvas {
  @State knobX: number = 160
  @State knobY: number = 120

  build() {
    Canvas(this)
      .width('100%')
      .height('100%')
      .onReady((canvas: CanvasRenderingContext2D, context: CanvasRenderingContext2D) => {
        const width = canvas.width
        const height = canvas.height
        
        // Background rect
        canvas.fillStyle = '#FFF0C1'
        canvas.fillRect(0, 0, width, height)

        // Radial Gradient Circle
        const centerX = width / 2
        const centerY = height / 2
        const gradient = canvas.createRadialGradient(centerX, centerY, 0, centerX, centerY, 80)
        gradient.addColorStop(0, '#FFD166')
        gradient.addColorStop(1, '#FF7B00')
        
        canvas.beginPath()
        canvas.arc(centerX, centerY, 80, 0, 2 * Math.PI)
        canvas.fillStyle = gradient
        canvas.fill()

        // Knob
        canvas.beginPath()
        canvas.arc(this.knobX, this.knobY, 16, 0, 2 * Math.PI)
        canvas.fillStyle = '#FF7B00'
        canvas.fill()
      })
  }
}

class ResultItem {
  id: number
  title: string

  constructor(id: number, title: string) {
    this.id = id
    this.title = title
  }
}

@Component
struct GridContainer {
  @BuilderParam itemContent: () => void

  build() {
    Grid() {
      ForEach([0, 1, 2, 3, 4, 5], (index: number) => {
        GridItem() {
          ResultCard(index)
        }
      })
    }
    .gridColumnsTemplate('1fr 1fr')
    .gridRowsTemplate('auto')
    .columnsGap(16)
    .rowsGap(16)
  }
}

@Component
struct ResultCard {
  index: number

  build() {
    Column() {
      // Placeholder Image Box
      Row()
        .width(96)
        .height(96)
        .backgroundColor('#FFF0C1')
        .borderRadius(10)
        .margin({ bottom: 8 })

      Text(`Result ${this.index + 1}`)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#3E2723')
        .margin({ bottom: 8 })

      Button('Add')
        .width('100%')
        .height(36)
        .backgroundColor('#FF7B00')
        .fontColor('#FFFFFF')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .borderRadius(10)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(14)
    .shadow({ radius: 8, color: 'rgba(0,0,0,0.12)', offsetY: 4 })
  }
}

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: common.LaunchParam): void {
    // Initialize ability
  }

  onDestroy(): void {
    // Clean up resources
  }
}