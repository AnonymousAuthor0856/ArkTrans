@Entry
@Component
struct AssetInventory {
  @State assetName: string = ''
  @State assetCode: string = ''
  @State assetType: string = 'Device'
  @State selectedId: number | null = null
  @State enabledCats: string[] = ['Warehouse', 'Device', 'Office']

  private markers: AssetMarker[] = [
    { id: 1, name: 'Main Warehouse', type: 'Warehouse', x: 0.18, y: 0.34 },
    { id: 2, name: 'CNC-07', type: 'Device', x: 0.52, y: 0.46 },
    { id: 3, name: 'HQ Office', type: 'Office', x: 0.75, y: 0.62 },
    { id: 4, name: 'Spare Parts', type: 'Warehouse', x: 0.33, y: 0.78 }
  ]

  build() {
    Column() {
      // Header
      Text('Asset Inventory')
        .fontSize(28)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#111111')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 20, bottom: 20 })

      // Filter Chips
      Row({ space: 8 }) {
        ForEach(['Warehouse', 'Device', 'Office'], (cat: string) => {
          Button(cat) {
            Text(cat)
              .fontSize(14)
              .fontWeight(this.enabledCats.includes(cat) ? FontWeight.Medium : FontWeight.Normal)
              .fontColor(this.enabledCats.includes(cat) ? '#FFFFFF' : '#111111')
          }
          .backgroundColor(this.enabledCats.includes(cat) ? '#111111' : '#FFFFFF')
          .borderWidth(1)
          .borderColor('#D1D1D1')
          .borderRadius(8)
          .height(36)
          .onClick(() => {
            const idx = this.enabledCats.indexOf(cat)
            if (idx > -1) {
              this.enabledCats.splice(idx, 1)
            } else {
              this.enabledCats.push(cat)
            }
          })
        })
      }.width('100%').padding({ left: 16, right: 16 })

      // Main Content Area
      Row({ space: 16 }) {
        // Left Column (Inputs & Selected Card)
        Column({ space: 12 }) {
          // Input Fields
          TextInput({ placeholder: 'Asset Name' })
            .type(InputType.Text)
            .backgroundColor('#EAE5EC')
            .borderRadius(0)
            .borderWidth(0)
            .borderBottomWidth(1)
            .borderBottomColor('#111111')
            .height(56)
            .onChange((value: string) => { this.assetName = value })

          TextInput({ placeholder: 'Asset Code' })
            .type(InputType.Text)
            .backgroundColor('#EAE5EC')
            .borderRadius(0)
            .borderWidth(0)
            .borderBottomWidth(1)
            .borderBottomColor('#111111')
            .height(56)
            .onChange((value: string) => { this.assetCode = value })

          TextInput({ placeholder: 'Asset Type', text: this.assetType })
            .type(InputType.Text)
            .backgroundColor('#EAE5EC')
            .borderRadius(0)
            .borderWidth(0)
            .borderBottomWidth(1)
            .borderBottomColor('#111111')
            .height(56)
            .onChange((value: string) => { this.assetType = value })

          // Selected Card
          Column() {
            Text('Selected')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111111')
            
            Text(this.selectedId !== null 
              ? this.markers.find(m => m.id === this.selectedId)?.name ?? 'None' 
              : 'None')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111111')
              .margin({ top: 4 })
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        // Right Column (Map)
        Stack() {
          // Grid Lines
          Column() {
            ForEach([0, 1, 2, 3, 4, 5], () => {
              Divider().color('#EDEDED').width('100%')
            })
          }.width('100%').height('100%').padding(16)

          Row() {
            ForEach([0, 1, 2, 3, 4, 5], () => {
              Divider().vertical(true).color('#EDEDED').layoutWeight(1)
            })
          }.width('100%').height('100%').padding(16)

          // Markers
          ForEach(this.markers.filter(m => this.enabledCats.includes(m.type)), (marker: AssetMarker) => {
            Stack() {
              // Dot
              Circle()
                .width(this.selectedId === marker.id ? 28 : 22)
                .height(this.selectedId === marker.id ? 28 : 22)
                .fill(marker.type === 'Warehouse' ? '#474747' : marker.type === 'Device' ? '#2A2A2A' : '#111111')
                .borderWidth(2)
                .borderColor(this.selectedId === marker.id ? '#111111' : '#FFFFFF')
              
              // Label
              Text(marker.type)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#111111')
                .backgroundColor('#FFFFFF')
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .borderRadius(8)
                .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
                .position({ x: 20, y: -10 })
            }
            .position({
              x: `${marker.x * 100}%`,
              y: `${marker.y * 100}%`
            })
            .onClick(() => {
              this.selectedId = this.selectedId === marker.id ? null : marker.id
            })
          })
        }
        .layoutWeight(1)
        .aspectRatio(0.9)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .border({ width: 1, color: '#D1D1D1' })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16 })
      .layoutWeight(1)

      // Bottom Buttons
      Row({ space: 12 }) {
        Button('Reset')
          .backgroundColor('#F2F2F2')
          .fontColor('#111111')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .height(48)
          .borderRadius(12)
          .layoutWeight(1)
          .onClick(() => {
            this.assetName = ''
            this.assetCode = ''
            this.assetType = 'Device'
            this.selectedId = null
          })

        Button('Save Asset')
          .backgroundColor('#111111')
          .fontColor('#FFFFFF')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .height(48)
          .borderRadius(12)
          .layoutWeight(1)
      }
      .width('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F6F6')
  }
}

interface AssetMarker {
  id: number
  name: string
  type: string
  x: number
  y: number
}