class Marker {
  x: number
  y: number
  label: string

  constructor(x: number, y: number, label: string) {
    this.x = x
    this.y = y
    this.label = label
  }
}

@Entry
@Component
struct Index {
  @State markers: Marker[] = [
    new Marker(120, 200, 'A1'),
    new Marker(300, 400, 'B2'),
    new Marker(520, 600, 'C3')
  ]
  @State scanning: boolean = false

  private nextMarker(): Marker {
    const index = this.markers.length + 1
    const x = 80 + ((index * 83) % 500)
    const y = 150 + ((index * 97) % 500)
    return new Marker(x, y, `N${index}`)
  }

  @Builder
  ScannerSurface() {
    Stack() {
      Rect()
        .width('100%')
        .height('100%')
        .radius(20)
        .fill('#E6FFFFFF')

      Circle()
        .width(260)
        .height(260)
        .fill('#E0F2FE')
        .opacity(0.9)

      ForEach(this.markers, (marker: Marker) => {
        Stack() {
          Circle()
            .width(24)
            .height(24)
            .fill('#06B6D4')
          Text(marker.label)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }
        .width(42)
        .height(42)
        .translate({ x: marker.x / 2 - 180, y: marker.y / 2 - 210 })
      }, (marker: Marker) => marker.label)
    }
    .width('100%')
    .height(400)
    .padding(12)
    .backgroundColor('#E6FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })
  }

  build() {
    Column() {
      Text('Invoice Scanner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 16, bottom: 16 })
        .backgroundColor('#F0F9FF')

      Column() {
        this.ScannerSurface()

        Row() {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0F172A')
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .selectedColor('#3B82F6')
            .onChange((value: boolean) => {
              this.scanning = value
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 16 })

        Button('Add Marker')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .width('100%')
          .height(48)
          .backgroundColor('#06B6D4')
          .borderRadius(12)
          .margin({ top: 16 })
          .onClick(() => {
            if (this.scanning) {
              this.markers = [...this.markers, this.nextMarker()]
            }
          })
      }
      .layoutWeight(1)
      .width('100%')
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [['#4D3B82F6', 0.0], ['#F0F9FF', 0.5], ['#4D06B6D4', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}
