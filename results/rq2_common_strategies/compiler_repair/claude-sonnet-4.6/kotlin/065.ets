import { router } from '@kit.ArkUI'

class AssetMarkerData {
  id: number = 0
  name: string = ''
  type: string = ''
  x: number = 0
  y: number = 0
}

class Colors {
  static primary: string = '#FF111111'
  static secondary: string = '#FF2A2A2A'
  static tertiary: string = '#FF474747'
  static background: string = '#FFF6F6F6'
  static surface: string = '#FFFFFFFF'
  static surfaceVariant: string = '#FFEDEDED'
  static outline: string = '#FFD1D1D1'
  static success: string = '#FF2E7D32'
  static warning: string = '#FFB98900'
  static error: string = '#FFB3261E'
  static onPrimary: string = '#FFFFFFFF'
  static onSecondary: string = '#FFFFFFFF'
  static onTertiary: string = '#FFFFFFFF'
  static onBackground: string = '#FF0A0A0A'
  static onSurface: string = '#FF0A0A0A'
}

@Component
struct MapGridOverlay {
  build() {
    Stack() {
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Divider()
            .color(Colors.surfaceVariant)
            .strokeWidth(1)
        })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .justifyContent(FlexAlign.SpaceAround)

      Row() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Divider()
            .vertical(true)
            .color(Colors.surfaceVariant)
            .strokeWidth(1)
            .height('100%')
        })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct MapMarker {
  markerType: string = ''
  selected: boolean = false
  onMarkerClick: () => void = () => {}
  xOffset: number = 0
  yOffset: number = 0

  getColor(): string {
    if (this.markerType === 'Warehouse') return Colors.tertiary
    if (this.markerType === 'Device') return Colors.secondary
    return Colors.primary
  }

  build() {
    Stack() {
      Circle()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .fill(this.getColor())
        .stroke(this.selected ? Colors.primary : Colors.surface)
        .strokeWidth(2)

      Text(this.markerType)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor(Colors.surface)
        .borderRadius(8)
        .border({ width: 1, color: Colors.outline })
        .offset({ x: 18, y: -4 })
        .onClick(() => {
          this.onMarkerClick()
        })
    }
    .alignContent(Alignment.TopStart)
    .position({ x: this.xOffset, y: this.yOffset })
  }
}

@Entry
@Component
struct RootScreen {
  @State categories: string[] = ['Warehouse', 'Device', 'Office']
  @State enabledCats: string[] = ['Warehouse', 'Device', 'Office']
  @State markers: AssetMarkerData[] = [
    { id: 1, name: 'Main Warehouse', type: 'Warehouse', x: 0.18, y: 0.34 },
    { id: 2, name: 'CNC-07', type: 'Device', x: 0.52, y: 0.46 },
    { id: 3, name: 'HQ Office', type: 'Office', x: 0.75, y: 0.62 },
    { id: 4, name: 'Spare Parts', type: 'Warehouse', x: 0.33, y: 0.78 }
  ]
  @State assetName: string = ''
  @State assetCode: string = ''
  @State assetType: string = 'Device'
  @State selectedId: number = -1

  getSelectedName(): string {
    if (this.selectedId === -1) return 'None'
    const found = this.markers.find(m => m.id === this.selectedId)
    return found ? found.name : 'None'
  }

  isCatEnabled(cat: string): boolean {
    return this.enabledCats.indexOf(cat) >= 0
  }

  toggleCat(cat: string): void {
    const idx = this.enabledCats.indexOf(cat)
    if (idx >= 0) {
      this.enabledCats.splice(idx, 1)
    } else {
      this.enabledCats.push(cat)
    }
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Asset Inventory')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Colors.surface)

      // Content
      Scroll() {
        Column({ space: 16 }) {
          // Filter chips
          Scroll() {
            Row({ space: 8 }) {
              ForEach(this.categories, (cat: string) => {
                Text(cat)
                  .fontSize(this.isCatEnabled(cat) ? 16 : 14)
                  .fontWeight(this.isCatEnabled(cat) ? FontWeight.Medium : FontWeight.Normal)
                  .fontColor(this.isCatEnabled(cat) ? Colors.onPrimary : Colors.onSurface)
                  .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                  .backgroundColor(this.isCatEnabled(cat) ? Colors.primary : Colors.surface)
                  .borderRadius(8)
                  .border({ width: 1, color: Colors.outline })
                  .onClick(() => {
                    this.toggleCat(cat)
                  })
              })
            }
            .padding({ left: 0, right: 0 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          // Main content row
          Row({ space: 16 }) {
            // Left column - form
            Column({ space: 12 }) {
              TextInput({ placeholder: 'Asset Name', text: this.assetName })
                .onChange((val: string) => { this.assetName = val })
                .width('100%')
                .backgroundColor(Colors.surface)
                .borderRadius(8)

              TextInput({ placeholder: 'Asset Code', text: this.assetCode })
                .onChange((val: string) => { this.assetCode = val })
                .width('100%')
                .backgroundColor(Colors.surface)
                .borderRadius(8)

              TextInput({ placeholder: 'Asset Type', text: this.assetType })
                .onChange((val: string) => { this.assetType = val })
                .width('100%')
                .backgroundColor(Colors.surface)
                .borderRadius(8)

              // Selected card
              Column({ space: 8 }) {
                Text('Selected')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)

                Text(this.getSelectedName())
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Colors.surface)
              .borderRadius(16)
              .border({ width: 1, color: Colors.outline })
              .alignItems(HorizontalAlign.Start)
            }
            .layoutWeight(1)

            // Right column - map
            Stack() {
              MapGridOverlay()

              ForEach(this.markers.filter(m => this.enabledCats.indexOf(m.type) >= 0), (m: AssetMarkerData) => {
                MapMarker({
                  markerType: m.type,
                  selected: this.selectedId === m.id,
                  onMarkerClick: () => {
                    this.selectedId = (this.selectedId === m.id) ? -1 : m.id
                  },
                  xOffset: 300 * m.x,
                  yOffset: 360 * m.y
                })
              })
            }
            .layoutWeight(1)
            .height(360)
            .backgroundColor(Colors.surface)
            .borderRadius(16)
            .border({ width: 1, color: Colors.outline })
            .clip(true)
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)
        }
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor(Colors.background)

      // Bottom bar
      Row({ space: 12 }) {
        Button('Reset')
          .layoutWeight(1)
          .height(48)
          .backgroundColor(Colors.surfaceVariant)
          .fontColor(Colors.onSurface)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(12)
          .onClick(() => {
            this.assetName = ''
            this.assetCode = ''
            this.assetType = 'Device'
            this.selectedId = -1
          })

        Button('Save Asset')
          .layoutWeight(1)
          .height(48)
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(12)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(Colors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}