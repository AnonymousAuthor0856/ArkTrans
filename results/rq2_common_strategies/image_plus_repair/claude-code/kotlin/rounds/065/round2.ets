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
          .fontSize(48)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#0A0A0A')
          .width('100%')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding({ top: 24, bottom: 24 })
      .backgroundColor('#FFFFFF')

      // Main scrollable content
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
          .padding({ left: 24, right: 24, top: 16, bottom: 16 })

          // Main content: form column + map
          Row() {
            // Left column: form fields
            Column() {
              // Asset Name (empty - shows label as placeholder)
              FilledTextField({
                label: 'Asset Name',
                value: this.assetName,
                onChanged: (val: string) => { this.assetName = val }
              })
              .margin({ bottom: 16 })

              // Asset Code (empty - shows label as placeholder)
              FilledTextField({
                label: 'Asset Code',
                value: this.assetCode,
                onChanged: (val: string) => { this.assetCode = val }
              })
              .margin({ bottom: 16 })

              // Asset Type (has value - shows floating label)
              FilledTextField({
                label: 'Asset Type',
                value: this.assetType,
                onChanged: (val: string) => { this.assetType = val }
              })
              .margin({ bottom: 16 })

              // Selected card
              Column() {
                Text('Selected')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0A0A0A')
                Text(this.getSelectedName())
                  .fontSize(32)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0A0A0A')
                  .margin({ top: 6 })
              }
              .width('100%')
              .padding(20)
              .alignItems(HorizontalAlign.Start)
              .backgroundColor('#FFFFFF')
              .borderRadius(24)
              .border({ width: 1, color: '#D1D1D1' })
              .shadow({ radius: 4, color: 'rgba(0,0,0,0.10)', offsetY: 2 })
            }
            .width('48%')
            .alignItems(HorizontalAlign.Start)

            // Map area
            Stack() {
              MapGridOverlay()

              ForEach(this.getVisibleMarkers(),
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
            .aspectRatio(1.0)
            .backgroundColor('#FFFFFF')
            .borderRadius(32)
            .border({ width: 1, color: '#D1D1D1' })
            .alignContent(Alignment.TopStart)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Top)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .backgroundColor('#F6F6F6')

      // Bottom action bar
      Column() {
        Row() {
          Button('Reset')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0A0A0A')
            .backgroundColor('#EDEDED')
            .borderRadius(24)
            .height(56)
            .layoutWeight(1)
            .onClick(() => {
              this.assetName = ''
              this.assetCode = ''
              this.assetType = 'Device'
              this.selectedId = null
            })

          Blank().width(16)

          Button('Save Asset')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#111111')
            .borderRadius(24)
            .height(56)
            .layoutWeight(1)
            .onClick(() => {})
        }
        .width('100%')
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 16, bottom: 16 })
      .backgroundColor('#EDEDED')
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

  getVisibleMarkers(): AssetMarker[] {
    return this.markers.filter((m: AssetMarker) => this.enabledCats.includes(m.type))
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
      .fontSize(24)
      .fontWeight(this.isOn ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(this.isOn ? '#FFFFFF' : '#0A0A0A')
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .backgroundColor(this.isOn ? '#111111' : '#FFFFFF')
      .borderRadius(16)
      .border({ width: 1, color: '#D1D1D1' })
      .margin({ right: 8 })
      .onClick(() => this.onToggle())
  }
}

@Component
struct FilledTextField {
  label: string = ''
  value: string = ''
  onChanged: (val: string) => void = () => {}

  build() {
    Column() {
      if (this.value.length > 0) {
        Text(this.label)
          .fontSize(16)
          .fontColor('#474747')
          .margin({ bottom: 2 })
      }
      TextInput({
        text: this.value,
        placeholder: this.value.length === 0 ? this.label : ''
      })
        .width('100%')
        .height(this.value.length > 0 ? 36 : 64)
        .fontSize(28)
        .fontColor('#0A0A0A')
        .placeholderColor('#474747')
        .placeholderFont({ size: 28, weight: FontWeight.Normal })
        .backgroundColor(Color.Transparent)
        .padding({ left: 0, right: 0 })
        .onChange((val: string) => { this.onChanged(val) })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: this.value.length > 0 ? 12 : 0, bottom: 0 })
    .backgroundColor('#E9E4ED')
    .borderRadius({ topLeft: 20, topRight: 20, bottomLeft: 4, bottomRight: 4 })
    .border({ width: { bottom: 1 }, color: '#111111' })
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct MapGridOverlay {
  build() {
    Stack() {
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
      .padding(24)
      .justifyContent(FlexAlign.SpaceEvenly)

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
      .padding(24)
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
      Circle()
        .width(this.selected ? 36 : 28)
        .height(this.selected ? 36 : 28)
        .fill(this.getColor(this.marker.type))
        .stroke({
          color: this.selected ? '#111111' : '#FFFFFF',
          width: 2
        })

      Text(this.marker.type)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0A0A0A')
        .padding({ left: 12, right: 12, top: 6, bottom: 6 })
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .border({ width: 1, color: '#D1D1D1' })
        .shadow({ radius: 4, color: 'rgba(0,0,0,0.10)', offsetY: 2 })
        .translate({ x: 22, y: -6 })
    }
    .position({
      x: this.marker.x * '100%',
      y: this.marker.y * '100%'
    })
    .translate({ x: -(this.selected ? 18 : 14), y: -(this.selected ? 18 : 14) })
    .onClick(() => this.onClick())
  }
}
