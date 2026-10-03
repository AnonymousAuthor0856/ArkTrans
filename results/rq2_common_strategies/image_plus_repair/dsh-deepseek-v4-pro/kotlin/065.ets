class AssetMarker {
  id: number
  name: string
  type: string
  x: number
  y: number

  constructor(id: number, name: string, type: string, x: number, y: number) {
    this.id = id
    this.name = name
    this.type = type
    this.x = x
    this.y = y
  }
}

@Entry
@Component
struct AssetInventoryPage {
  @State assetName: string = ''
  @State assetCode: string = ''
  @State assetType: string = 'Device'
  @State selectedId: number = -1
  @State enabledCats: string[] = ['Warehouse', 'Device', 'Office']

  categories: string[] = ['Warehouse', 'Device', 'Office']
  markers: AssetMarker[] = [
    new AssetMarker(1, 'Main Warehouse', 'Warehouse', 0.18, 0.34),
    new AssetMarker(2, 'CNC-07', 'Device', 0.52, 0.46),
    new AssetMarker(3, 'HQ Office', 'Office', 0.75, 0.62),
    new AssetMarker(4, 'Spare Parts', 'Warehouse', 0.33, 0.78)
  ]
  lineIndex: number[] = [0, 1, 2, 3, 4, 5]

  markerColor(type: string): string {
    if (type === 'Warehouse') {
      return '#474747'
    }
    if (type === 'Device') {
      return '#2A2A2A'
    }
    return '#111111'
  }

  selectedName(): string {
    for (const m of this.markers) {
      if (m.id === this.selectedId) {
        return m.name
      }
    }
    return 'None'
  }

  visibleMarkers(): AssetMarker[] {
    const result: AssetMarker[] = []
    for (const m of this.markers) {
      if (this.enabledCats.includes(m.type)) {
        result.push(m)
      }
    }
    return result
  }

  toggleCategory(c: string): void {
    if (this.enabledCats.includes(c)) {
      this.enabledCats = this.enabledCats.filter((item: string): boolean => item !== c)
    } else {
      this.enabledCats = this.enabledCats.concat([c])
    }
  }

  resetForm(): void {
    this.assetName = ''
    this.assetCode = ''
    this.assetType = 'Device'
    this.selectedId = -1
  }

  selectMarker(id: number): void {
    this.selectedId = this.selectedId === id ? -1 : id
  }

  build() {
    Column() {
      Row() {
        Text('Asset Inventory')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0A0A0A')
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')

      Column({ space: 16 }) {
        Scroll() {
          Row({ space: 8 }) {
            ForEach(this.categories, (c: string) => {
              Text(c)
                .fontSize(this.enabledCats.includes(c) ? 16 : 14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.enabledCats.includes(c) ? '#FFFFFF' : '#0A0A0A')
                .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                .backgroundColor(this.enabledCats.includes(c) ? '#111111' : '#FFFFFF')
                .borderRadius(8)
                .border({ width: 1, color: '#D1D1D1' })
                .onClick(() => {
                  this.toggleCategory(c)
                })
            }, (c: string) => c)
          }
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')

        Row({ space: 16 }) {
          Column({ space: 12 }) {
            Column({ space: 4 }) {
              Text('Asset Name')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0A0A0A')
              TextInput({ text: this.assetName, placeholder: 'Asset Name' })
                .onChange((value: string) => {
                  this.assetName = value
                })
                .height(52)
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
                .border({ width: 1, color: '#D1D1D1' })
            }
            .alignItems(HorizontalAlign.Start)

            Column({ space: 4 }) {
              Text('Asset Code')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0A0A0A')
              TextInput({ text: this.assetCode, placeholder: 'Asset Code' })
                .onChange((value: string) => {
                  this.assetCode = value
                })
                .height(52)
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
                .border({ width: 1, color: '#D1D1D1' })
            }
            .alignItems(HorizontalAlign.Start)

            Column({ space: 4 }) {
              Text('Asset Type')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0A0A0A')
              TextInput({ text: this.assetType, placeholder: 'Asset Type' })
                .onChange((value: string) => {
                  this.assetType = value
                })
                .height(52)
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
                .border({ width: 1, color: '#D1D1D1' })
            }
            .alignItems(HorizontalAlign.Start)

            Column({ space: 8 }) {
              Text('Selected')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0A0A0A')
              Text(this.selectedName())
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0A0A0A')
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .border({ width: 1, color: '#D1D1D1' })
            .alignItems(HorizontalAlign.Start)
          }
          .layoutWeight(1)

          Stack() {
            Column() {
              ForEach(this.lineIndex, (i: number) => {
                Row()
                  .width('100%')
                  .height(1)
                  .backgroundColor('#EDEDED')
              }, (i: number) => i.toString())
            }
            .width('100%')
            .height('100%')
            .padding(16)
            .justifyContent(FlexAlign.SpaceEvenly)

            Row() {
              ForEach(this.lineIndex, (i: number) => {
                Row()
                  .width(1)
                  .height('100%')
                  .backgroundColor('#EDEDED')
              }, (i: number) => i.toString())
            }
            .width('100%')
            .height('100%')
            .padding(16)
            .justifyContent(FlexAlign.SpaceEvenly)

            ForEach(this.visibleMarkers(), (m: AssetMarker) => {
              Row() {
                Stack() {}
                  .width(this.selectedId === m.id ? 28 : 22)
                  .height(this.selectedId === m.id ? 28 : 22)
                  .backgroundColor(this.markerColor(m.type))
                  .borderRadius(this.selectedId === m.id ? 14 : 11)
                  .border({ width: 2, color: this.selectedId === m.id ? '#111111' : '#FFFFFF' })

                Text(m.type)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0A0A0A')
                  .backgroundColor('#FFFFFF')
                  .borderRadius(8)
                  .border({ width: 1, color: '#D1D1D1' })
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                  .margin({ left: 18 })
                  .translate({ y: -4 })
                  .onClick(() => {
                    this.selectMarker(m.id)
                  })
              }
              .alignItems(VerticalAlign.Top)
              .position({ x: Math.round(m.x * 100) + '%', y: Math.round(m.y * 100) + '%' })
            }, (m: AssetMarker) => m.id.toString())
          }
          .layoutWeight(1)
          .constraintSize({ minHeight: 360 })
          .aspectRatio(0.9)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .border({ width: 1, color: '#D1D1D1' })
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })

      Row({ space: 12 }) {
        Button() {
          Text('Reset')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0A0A0A')
        }
        .height(48)
        .layoutWeight(1)
        .backgroundColor('#EDEDED')
        .borderRadius(12)
        .onClick(() => {
          this.resetForm()
        })

        Button() {
          Text('Save Asset')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .height(48)
        .layoutWeight(1)
        .backgroundColor('#111111')
        .borderRadius(12)
        .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F6F6')
  }
}
