import { ClickEvent } from '@kit.ArkUI'

@Entry
@Component
struct AssetInventory {
  @State categories: string[] = ['Warehouse', 'Device', 'Office']
  @State enabledCats: string[] = ['Warehouse', 'Device', 'Office']
  @State assetName: string = ''
  @State assetCode: string = ''
  @State assetType: string = 'Device'
  @State selectedId: number | null = null

  // Mock data for markers
  private markers: MarkerData[] = [
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
        .fontWeight(FontWeight.Bold)
        .fontColor('#111111')
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 20, bottom: 20 })

      // Filter Chips
      Row() {
        ForEach(this.categories, (cat: string) => {
          Button(cat)
            .backgroundColor(this.enabledCats.includes(cat) ? '#111111' : '#FFFFFF')
            .fontColor(this.enabledCats.includes(cat) ? '#FFFFFF' : '#111111')
            .borderWidth(1)
            .borderColor('#D1D1D1')
            .borderRadius(8)
            .height(40)
            .margin({ right: 12 })
            .onClick(() => {
              const index = this.enabledCats.indexOf(cat)
              if (index > -1) {
                this.enabledCats.splice(index, 1)
              } else {
                this.enabledCats.push(cat)
              }
            })
        })
      }
      .width('100%')
      .margin({ bottom: 20 })

      // Main Content Area
      Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Top }) {
        // Left Column: Inputs & Selected Info
        Column() {
          // Input Fields
          this.createInputField('Asset Name', this.assetName, (val: string) => this.assetName = val)
          this.createInputField('Asset Code', this.assetCode, (val: string) => this.assetCode = val)
          this.createInputField('Asset Type', this.assetType, (val: string) => this.assetType = val)

          // Selected Card
          Column() {
            Text('Selected')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111111')
              .margin({ bottom: 4 })
            
            Text(this.selectedId !== null 
              ? this.markers.find(m => m.id === this.selectedId)?.name || 'None' 
              : 'None')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111111')
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
          .border({ width: 1, color: '#D1D1D1' })
          .margin({ top: 16 })
        }
        .width('45%')
        .margin({ right: 16 })

        // Right Column: Map Visualization
        Stack() {
          // Grid Background
          Column() {
            CustomGridRow()
            CustomGridRow()
            CustomGridRow()
            CustomGridRow()
            CustomGridRow()
            CustomGridRow()
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .border({ width: 1, color: '#D1D1D1' })
          
          // Markers
          ForEach(this.markers.filter(m => this.enabledCats.includes(m.type)), (marker: MarkerData) => {
            MapMarkerComponent({
              type: marker.type,
              isSelected: this.selectedId === marker.id,
              onClick: () => {
                this.selectedId = this.selectedId === marker.id ? null : marker.id
              },
              xPercent: marker.x,
              yPercent: marker.y
            })
          })
        }
        .width('55%')
        .aspectRatio(0.9)
        .height(360)
      }
      .width('100%')
      .wrap(FlexWrap.NoWrap)
      .alignItems(ItemAlign.Top)
      .layoutWeight(1)

      // Bottom Actions
      Row() {
        Button('Reset')
          .backgroundColor('#EDEDED')
          .fontColor('#111111')
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
          .margin({ right: 12 })
          .onClick(() => {
            this.assetName = ''
            this.assetCode = ''
            this.assetType = 'Device'
            this.selectedId = null
          })

        Button('Save Asset')
          .backgroundColor('#111111')
          .fontColor('#FFFFFF')
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
      }
      .width('100%')
      .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F6F6')
    .padding({ left: 16, right: 16, top: 16, bottom: 16 })
  }

  @Builder
  createInputField(label: string, value: string, onChange: (val: string) => void) {
    TextInput({ placeholder: label, text: value })
      .width('100%')
      .height(60)
      .backgroundColor('#EAE5EE') // Approximating the light purple/grey from screenshot
      .borderRadius(8)
      .margin({ bottom: 12 })
      .onChange((val: string) => onChange(val))
      .type(InputType.Normal)
      .placeholderColor('#666666')
      .fontColor('#111111')
      .fontSize(16)
  }
}

interface MarkerData {
  id: number;
  name: string;
  type: string;
  x: number;
  y: number;
}

// Helper component for the map markers
@Component
struct MapMarkerComponent {
  private type: string = ''
  private isSelected: boolean = false
  private onClick: (event?: ClickEvent) => void = () => {}
  private xPercent: number = 0
  private yPercent: number = 0

  aboutToAppear(): void {
    // Initialization if needed
  }

  build() {
    Stack() {
      // The Dot
      Circle()
        .width(this.isSelected ? 28 : 22)
        .height(this.isSelected ? 28 : 22)
        .fill(this.getMarkerColor())
        .border({ width: 2, color: this.isSelected ? '#111111' : '#FFFFFF' })
      
      // The Label Bubble
      Text(this.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#111111')
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
        .border({ width: 1, color: '#D1D1D1' })
        .position({ x: 18, y: -4 })
    }
    .onClick(() => this.onClick())
    .position({
      left: `${this.xPercent * 100}%`,
      top: `${this.yPercent * 100}%`
    })
    .translate({ x: -11, y: -11 }) // Center the dot roughly
  }

  getMarkerColor(): string {
    switch (this.type) {
      case 'Warehouse': return '#474747'
      case 'Device': return '#2A2A2A'
      default: return '#111111'
    }
  }
}

// Helper for grid lines
@Component
struct CustomGridRow {
  build() {
    Row() {
      Divider().width('100%').color('#EDEDED').strokeWidth(1)
    }
    .layoutWeight(1)
  }
}