@Entry
@Component
struct AssetInventoryApp {
  @State categories: string[] = ['Warehouse', 'Device', 'Office']
  @State enabledCats: string[] = ['Warehouse', 'Device', 'Office']
  @State markers: AssetMarker[] = [
    { id: 1, name: 'Main Warehouse', type: 'Warehouse', x: 0.18, y: 0.34 },
    { id: 2, name: 'CNC-07', type: 'Device', x: 0.52, y: 0.46 },
    { id: 3, name: 'HQ Office', type: 'Office', x: 0.75, y: 0.62 },
    { id: 4, name: 'Spare Parts', type: 'Warehouse', x: 0.33, y: 0.78 }
  ]
  @State assetName: string = ''
  @State assetCode: string = ''
  @State assetType: string = 'Device'
  @State selectedId: number | null = null

  filteredMarkers(): AssetMarker[] {
    return this.markers.filter(m => this.enabledCats.includes(m.type))
  }

  getMarkerColor(type: string): string {
    switch (type) {
      case 'Warehouse': return '#474747'
      case 'Device': return '#2A2A2A'
      default: return '#111111'
    }
  }

  getSelectedName(): string {
    if (this.selectedId === null) return 'None'
    let found = this.markers.find(m => m.id === this.selectedId)
    return found ? found.name : 'None'
  }

  @Builder
  buildFilterChip(cat: string): void {
    let isOn = this.enabledCats.includes(cat)
    Button() {
      Text(cat)
        .fontSize(isOn ? 16 : 14)
        .fontWeight(FontWeight.Medium)
        .foregroundColor(isOn ? '#FFFFFF' : '#0A0A0A')
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })
        .textAlign(TextAlign.Center)
    }
    .backgroundColor(isOn ? '#111111' : '#FFFFFF')
    .borderRadius(8)
    .border({ width: 1, color: '#D1D1D1' })
    .onClick(() => {
      if (isOn) {
        this.enabledCats = this.enabledCats.filter(c => c !== cat)
      } else {
        this.enabledCats = [...this.enabledCats, cat]
      }
    })
  }

  @Builder
  buildInputField(placeholder: string, text: string, onChange: (val: string) => void): void {
    TextInput({ placeholder: placeholder, text: text })
      .fontSize(14)
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor('#EDEDED')
      .borderRadius(8)
      .border({ width: 1, color: '#D1D1D1' })
      .onChange(onChange)
  }

  @Builder
  buildMarker(m: AssetMarker): void {
    let size = this.selectedId === m.id ? 28 : 22
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width(size)
        .height(size)
        .borderRadius(size / 2)
        .backgroundColor(this.getMarkerColor(m.type))
        .border({ width: 2, color: this.selectedId === m.id ? '#111111' : '#FFFFFF' })
        .onClick(() => {
          this.selectedId = this.selectedId === m.id ? null : m.id
        })
      Button() {
        Text(m.type)
          .fontSize(12)
          .foregroundColor('#0A0A0A')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
      .backgroundColor('#FFFFFF')
      .borderRadius(8)
      .border({ width: 1, color: '#D1D1D1' })
      .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
      .position({ x: 18, y: -4 })
      .onClick(() => {
        this.selectedId = this.selectedId === m.id ? null : m.id
      })
    }
    .position({ x: 360 * m.x, y: 360 * m.y })
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F6F6F6')

      Column({ space: 0 }) {
        Row({ space: 0 }) {
          Text('Asset Inventory')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#0A0A0A')
            .padding({ top: 16, bottom: 16 })
            .width('100%')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(86)
        .backgroundColor('#FFFFFF')

        List({ space: 16 }) {
          ListItem() {
            Row({ space: 8 }) {
              ForEach(this.categories, (cat: string) => {
                buildFilterChip(cat)
              })
            }
            .width('100%')
            .padding({ left: 16, right: 16 })
          }

          ListItem() {
            Row({ space: 16 }) {
              Column({ space: 12 }) {
                buildInputField('Asset Name', this.assetName, (val: string) => { this.assetName = val })
                buildInputField('Asset Code', this.assetCode, (val: string) => { this.assetCode = val })
                buildInputField('Asset Type', this.assetType, (val: string) => { this.assetType = val })

                Column({ space: 8 }) {
                  Text('Selected')
                    .fontSize(12)
                    .foregroundColor('#0A0A0A')
                  Text(this.getSelectedName())
                    .fontSize(20)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#0A0A0A')
                }
                .padding(16)
                .width('100%')
                .alignItems(HorizontalAlign.Start)
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .border({ width: 1, color: '#D1D1D1' })
                .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
              }
              .layoutWeight(1)

              Stack({ alignContent: Alignment.TopStart }) {
                Column()
                  .width('100%')
                  .height(360)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(16)
                  .border({ width: 1, color: '#D1D1D1' })

                Divider().width('100%').height(1).color('#EDEDED').position({ x: 16, y: 64 })
                Divider().width('100%').height(1).color('#EDEDED').position({ x: 16, y: 128 })
                Divider().width('100%').height(1).color('#EDEDED').position({ x: 16, y: 192 })
                Divider().width(1).height('100%').color('#EDEDED').position({ x: 64, y: 16 })
                Divider().width(1).height('100%').color('#EDEDED').position({ x: 128, y: 16 })

                ForEach(this.filteredMarkers(), (m: AssetMarker) => {
                  buildMarker(m)
                })
              }
              .width('100%')
              .aspectRatio(0.9)
              .layoutWeight(1)
              .height(360)
            }
            .width('100%')
            .padding({ left: 16, right: 16 })
          }

          ListItem() {
            Column({ space: 0 }) {
              Row({ space: 12 }) {
                Button() {
                  Text('Reset')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#0A0A0A')
                    .width('100%')
                    .height(48)
                    .textAlign(TextAlign.Center)
                }
                .layoutWeight(1)
                .height(48)
                .backgroundColor('#EDEDED')
                .borderRadius(12)
                .onClick(() => {
                  this.assetName = ''
                  this.assetCode = ''
                  this.assetType = 'Device'
                  this.selectedId = null
                })

                Button() {
                  Text('Save Asset')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#FFFFFF')
                    .width('100%')
                    .height(48)
                    .textAlign(TextAlign.Center)
                }
                .layoutWeight(1)
                .height(48)
                .backgroundColor('#111111')
                .borderRadius(12)
                .onClick(() => {
                  // save logic
                })
              }
              .width('100%')
              .padding({ left: 16, right: 16, top: 12, bottom: 12 })
              .backgroundColor('#FFFFFF')
            }
            .width('100%')
          }
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

interface AssetMarker {
  id: number
  name: string
  type: string
  x: number
  y: number
}