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
      // Top App Bar
      Column() {
        Text('Asset Inventory')
          .fontSize(28)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#0A0A0A')
          .width('100%')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding({ top: 16, bottom: 16 })
      .backgroundColor('#FFFFFF')

      Scroll() {
        Column() {
          // Filter chips row
          Row() {
            ForEach(this.categories, (c: string) => {
              FilterChip({
                label: c,
                isOn: this.enabledCats.includes(c),
                onToggle: () => {
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
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })

          // Main content row: form + map
          Row() {
            // Left column: form fields
            Column() {
              // Asset Name
              Column() {
                Text('Asset Name')
                  .fontSize(14)
                  .fontColor('#474747')
                  .margin({ bottom: 4 })
                TextInput({ text: this.assetName, placeholder: '' })
                  .width('100%')
                  .height(48)
                  .fontSize(28)
                  .fontColor('#0A0A0A')
                  .backgroundColor('#E9E4ED')
                  .borderRadius({ topLeft: 16, topRight: 16, bottomLeft: 0, bottomRight: 0 })
                  .border({ width: { bottom: 1 }, color: '#111111' })
                  .padding({ left: 16, right: 16 })
                  .onChange((val: string) => { this.assetName = val })
              }
              .width('100%')
              .margin({ bottom: 12 })

              // Asset Code
              Column() {
                Text('Asset Code')
                  .fontSize(14)
                  .fontColor('#474747')
                  .margin({ bottom: 4 })
                TextInput({ text: this.assetCode, placeholder: '' })
                  .width('100%')
                  .height(48)
                  .fontSize(28)
                  .fontColor('#0A0A0A')
                  .backgroundColor('#E9E4ED')
                  .borderRadius({ topLeft: 16, topRight: 16, bottomLeft: 0, bottomRight: 0 })
                  .border({ width: { bottom: 1 }, color: '#111111' })
                  .padding({ left: 16, right: 16 })
                  .onChange((val: string) => { this.assetCode = val })
              }
              .width('100%')
              .margin({ bottom: 12 })

              // Asset Type
              Column() {
                Text('Asset Type')
                  .fontSize(14)
                  .fontColor('#474747')
                  .margin({ bottom: 4 })
                Text(this.assetType)
                  .fontSize(28)
                  .fontColor('#0A0A0A')
                  .width('100%')
                  .height(48)
                  .textAlign(TextAlign.Start)
                  .backgroundColor('#E9E4ED')
                  .borderRadius({ topLeft: 16, topRight: 16, bottomLeft: 0, bottomRight: 0 })
                  .border({ width: { bottom: 1 }, color: '#111111' })
                  .padding({ left: 16, right: 16 })
              }
              .width('100%')
              .margin({ bottom: 12 })

              // Selected Card
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
              .borderRadius(16)
              .border({ width: 1, color: '#D1D1D1' })
              .shadow({ radius: 4, color: 'rgba(0,0,0,0.10)', offsetY: 2 })
            }
            .width('48%')
            .alignItems(HorizontalAlign.Start)

            // Map area
            Stack() {
              // Grid overlay
              MapGridOverlay()

              // Markers
              ForEach(this.markers.filter((m: AssetMarker) => this.enabledCats.includes(m.type)),
                (m: AssetMarker) => {
                  MapMarkerComponent({
                    marker: m,
                    selected: this.selectedId === m.id,
                    onClick: () => {
                      this.selectedId = (this.selectedId === m.id) ? null : m.id
                    }
                  })
                },
                (m: AssetMarker) => m.id.toString()
              )
            }
            .width('48%')
            .aspectRatio(0.9)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .border({ width: 1, color: '#D1D1D1' })
            .alignContent(Alignment.TopStart)
          }
          .width('100%')
          .padding({ left: 16, right: 16 })
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Top)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
      .backgroundColor('#F6F6F6')

      // Bottom bar
      Row() {
        Button('Reset')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0A0A0A')
          .backgroundColor('#EDEDED')
          .borderRadius(16)
          .height(48)
          .layoutWeight(1)
          .onClick(() => {
            this.assetName = ''
            this.assetCode = ''
            this.assetType = 'Device'
            this.selectedId = null
          })

        Blank().width(12)

        Button('Save Asset')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#111111')
          .borderRadius(16)
          .height(48)
          .layoutWeight(1)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#EDEDED')
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.14)', offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F6F6')
  }

  getSelectedName(): string {
    if (this.selectedId === null) return 'None'
    const found = this.markers.find((m: AssetMarker) => m.id === this.selectedId)
    return found ? found.name : 'None'
  }
}

interface AssetMarker {
  id: number
  name: string
  type: string
  x: number
  y: number
}

@Component
struct FilterChip {
  label: string = ''
  isOn: boolean = false
  onToggle: () => void = () => {}

  build() {
    Text(this.label)
      .fontSize(this.isOn ? 16 : 14)
      .fontWeight(this.isOn ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(this.isOn ? '#FFFFFF' : '#0A0A0A')
      .padding({ left: 16, right: 16, top: 10, bottom: 10 })
      .backgroundColor(this.isOn ? '#111111' : '#FFFFFF')
      .borderRadius(12)
      .border({ width: 1, color: '#D1D1D1' })
      .onClick(() => this.onToggle())
  }
}

@Component
struct MapGridOverlay {
  build() {
    Stack() {
      // Horizontal grid lines
      Column() {
        ForEach([1, 2, 3, 4, 5, 6], (_: number, idx: number) => {
          Divider()
            .vertical(false)
            .color('#EDEDED')
            .strokeWidth(1)
            .width('100%')
        })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .justifyContent(FlexAlign.SpaceEvenly)

      // Vertical grid lines
      Row() {
        ForEach([1, 2, 3, 4, 5, 6], (_: number, idx: number) => {
          Divider()
            .vertical(true)
            .color('#EDEDED')
            .strokeWidth(1)
            .height('100%')
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
struct MapMarkerComponent {
  marker: AssetMarker = { id: 0, name: '', type: '', x: 0, y: 0 }
  selected: boolean = false
  onClick: () => void = () => {}

  private getColor(type: string): string {
    if (type === 'Warehouse') return '#474747'
    if (type === 'Device') return '#2A2A2A'
    return '#111111'
  }

  build() {
    Stack() {
      // Marker dot
      Circle()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .fill(this.getColor(this.marker.type))
        .stroke({
          color: this.selected ? '#111111' : '#FFFFFF',
          width: 2
        })
        .position({ x: 0, y: 0 })

      // Label card
      Text(this.marker.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0A0A0A')
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .border({ width: 1, color: '#D1D1D1' })
        .shadow({ radius: 4, color: 'rgba(0,0,0,0.10)', offsetY: 2 })
        .position({ x: 18, y: -4 })
    }
    .position({
      x: this.marker.x * '100%',
      y: this.marker.y * '100%'
    })
    .translate({ x: -(this.selected ? 14 : 11), y: -(this.selected ? 14 : 11) })
    .onClick(() => this.onClick())
  }
}
