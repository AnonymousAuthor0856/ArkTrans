@Entry
@Component
struct AssetInventoryPage {
  @State categories: string[] = ['Warehouse', 'Device', 'Office']
  @State enabledCats: string[] = ['Warehouse', 'Device', 'Office']
  @State assetName: string = ''
  @State assetCode: string = ''
  @State assetType: string = 'Device'
  @State selectedId: number | null = null

  private markers: AssetMarker[] = [
    { id: 1, name: 'Main Warehouse', type: 'Warehouse', x: 0.18, y: 0.34 },
    { id: 2, name: 'CNC-07', type: 'Device', x: 0.52, y: 0.46 },
    { id: 3, name: 'HQ Office', type: 'Office', x: 0.75, y: 0.62 },
    { id: 4, name: 'Spare Parts', type: 'Warehouse', x: 0.33, y: 0.78 }
  ]

  build() {
    Column() {
      // TopBar
      Row() {
        Text('Asset Inventory')
          .fontSize(28)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#0A0A0A')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFFFF')

      // Content
      Scroll() {
        Column() {
          // Filter chips
          Row() {
            ForEach(this.categories, (c: string) => {
              FilterChip({
                label: c,
                isOn: this.enabledCats.includes(c),
                onClick: () => {
                  const idx = this.enabledCats.indexOf(c)
                  if (idx >= 0) {
                    this.enabledCats.splice(idx, 1)
                  } else {
                    this.enabledCats.push(c)
                  }
                }
              })
            })
          }
          .width('100%')

          // Main content row
          Row() {
            // Left column - form
            Column() {
              TextInput({ placeholder: 'Asset Name', text: this.assetName })
                .width('100%')
                .height(48)
                .backgroundColor('#FFFFFF')
                .border({ width: 1, color: '#D1D1D1', radius: 8 })
                .padding({ left: 12, right: 12 })
                .onChange((val: string) => { this.assetName = val })

              TextInput({ placeholder: 'Asset Code', text: this.assetCode })
                .width('100%')
                .height(48)
                .backgroundColor('#FFFFFF')
                .border({ width: 1, color: '#D1D1D1', radius: 8 })
                .padding({ left: 12, right: 12 })
                .margin({ top: 12 })
                .onChange((val: string) => { this.assetCode = val })

              TextInput({ placeholder: 'Asset Type', text: this.assetType })
                .width('100%')
                .height(48)
                .backgroundColor('#FFFFFF')
                .border({ width: 1, color: '#D1D1D1', radius: 8 })
                .padding({ left: 12, right: 12 })
                .margin({ top: 12 })
                .onChange((val: string) => { this.assetType = val })

              // Selected card
              Column() {
                Text('Selected')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0A0A0A')

                Text(this.getSelectedName())
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0A0A0A')
                  .margin({ top: 4 })
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFF')
              .border({ width: 1, color: '#D1D1D1', radius: 16 })
              .margin({ top: 12 })
              .shadow({ radius: 4, color: 'rgba(0,0,0,0.10)', offsetY: 2 })
            }
            .width('48%')
            .alignItems(HorizontalAlign.Start)

            // Right column - map
            Stack({ alignContent: Alignment.TopStart }) {
              // Map grid overlay
              MapGridOverlay()

              // Markers
              ForEach(this.markers.filter((m: AssetMarker) => this.enabledCats.includes(m.type)),
                (m: AssetMarker) => {
                  MapMarker({
                    marker: m,
                    selected: this.selectedId === m.id,
                    onClick: () => {
                      this.selectedId = this.selectedId === m.id ? null : m.id
                    }
                  })
                },
                (m: AssetMarker) => m.id.toString()
              )
            }
            .width('48%')
            .aspectRatio(0.9)
            .backgroundColor('#FFFFFF')
            .border({ width: 1, color: '#D1D1D1', radius: 16 })
            .margin({ left: 16 })
          }
          .width('100%')
          .margin({ top: 16 })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
      .layoutWeight(1)
      .backgroundColor('#F6F6F6')
      .scrollable(ScrollDirection.Vertical)

      // BottomBar
      Row() {
        Button('Reset')
          .layoutWeight(1)
          .height(48)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#EDEDED')
          .fontColor('#0A0A0A')
          .borderRadius(12)
          .onClick(() => {
            this.assetName = ''
            this.assetCode = ''
            this.assetType = 'Device'
            this.selectedId = null
          })

        Button('Save Asset')
          .layoutWeight(1)
          .height(48)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#111111')
          .fontColor('#FFFFFF')
          .borderRadius(12)
          .margin({ left: 12 })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.14)', offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F6F6')
  }

  getSelectedName(): string {
    if (this.selectedId === null) return 'None'
    const m = this.markers.find((item: AssetMarker) => item.id === this.selectedId)
    return m ? m.name : 'None'
  }
}

@Component
struct FilterChip {
  label: string = ''
  isOn: boolean = false
  onClick: () => void = () => {}

  build() {
    Button(this.label)
      .height(32)
      .padding({ left: 16, right: 16 })
      .fontSize(this.isOn ? 16 : 14)
      .fontWeight(this.isOn ? FontWeight.Medium : FontWeight.Normal)
      .backgroundColor(this.isOn ? '#111111' : '#FFFFFF')
      .fontColor(this.isOn ? '#FFFFFF' : '#0A0A0A')
      .borderRadius(8)
      .border({ width: 1, color: '#D1D1D1' })
      .margin({ right: 8 })
      .onClick(() => this.onClick())
  }
}

@Component
struct MapGridOverlay {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Horizontal lines
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], (_: number, idx: number) => {
          Divider()
            .strokeWidth(1)
            .color('#EDEDED')
        })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .justifyContent(FlexAlign.SpaceEvenly)

      // Vertical lines
      Row() {
        ForEach([0, 1, 2, 3, 4, 5], (_: number, idx: number) => {
          Column()
            .width(1)
            .height('100%')
            .backgroundColor('#EDEDED')
        })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct MapMarker {
  marker: AssetMarker = { id: 0, name: '', type: '', x: 0, y: 0 }
  selected: boolean = false
  onClick: () => void = () => {}

  private getMarkerColor(type: string): string {
    if (type === 'Warehouse') return '#474747'
    if (type === 'Device') return '#2A2A2A'
    return '#111111'
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Marker dot
      Circle()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .fill(this.getMarkerColor(this.marker.type))
        .stroke(this.selected ? '#111111' : '#FFFFFF', 2)
        .position({ x: 0, y: 0 })

      // Type label card
      Text(this.marker.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0A0A0A')
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor('#FFFFFF')
        .border({ width: 1, color: '#D1D1D1', radius: 8 })
        .position({ x: 18, y: -4 })
        .shadow({ radius: 4, color: 'rgba(0,0,0,0.10)', offsetY: 2 })
    }
    .position({
      x: `${this.marker.x * 100}%`,
      y: `${this.marker.y * 100}%`
    })
    .translate({ x: -(this.selected ? 14 : 11), y: -(this.selected ? 14 : 11) })
    .onClick(() => this.onClick())
  }
}

interface AssetMarker {
  id: number
  name: string
  type: string
  x: number
  y: number
}
