const Colors = {
  primary: '#111111',
  secondary: '#2A2A2A',
  tertiary: '#474747',
  background: '#F6F6F6',
  surface: '#FFFFFF',
  surfaceVariant: '#EDEDED',
  outline: '#D1D1D1',
  success: '#2E7D32',
  warning: '#B98900',
  error: '#B3261E',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#FFFFFF',
  onBackground: '#0A0A0A',
  onSurface: '#0A0A0A',
}

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
  xxxl: 48,
}

interface AssetMarker {
  id: number
  name: string
  type: string
  x: number
  y: number
}

@Component
struct MapGridOverlay {
  build() {
    Stack() {
      ForEach([1, 2, 3, 4, 5, 6], (i: number) => {
        Divider()
          .width('100%')
          .height(1)
          .backgroundColor(Colors.surfaceVariant)
          .position({ x: 0, y: ((i * 100) / 7).toString() + '%' })
      }, (i: number) => 'h' + i.toString())
      ForEach([1, 2, 3, 4, 5, 6], (i: number) => {
        Divider()
          .width(1)
          .height('100%')
          .backgroundColor(Colors.surfaceVariant)
          .position({ x: ((i * 100) / 7).toString() + '%', y: 0 })
      }, (i: number) => 'v' + i.toString())
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct MapMarker {
  @Prop type: string = ''
  @Prop selected: boolean = false
  onClick: () => void = () => {}

  private markerColor(): string {
    if (this.type === 'Warehouse') {
      return Colors.tertiary
    } else if (this.type === 'Device') {
      return Colors.secondary
    } else {
      return Colors.primary
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Blank()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .backgroundColor(this.markerColor())
        .borderRadius(this.selected ? 14 : 11)
        .border({ width: 2, color: this.selected ? Colors.primary : Colors.surface })
      Button() {
        Text(this.type)
          .fontSize(12)
          .fontColor(Colors.onSurface)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Colors.surface)
      .borderRadius(8)
      .border({ width: 1, color: Colors.outline })
      .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })
      .position({ x: 18, y: -4 })
      .onClick(() => {
        this.onClick()
      })
    }
    .width(28)
    .height(28)
    .onClick(() => {
      this.onClick()
    })
  }
}

@Entry
@Component
struct Index {
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
    { id: 4, name: 'Spare Parts', type: 'Warehouse', x: 0.33, y: 0.78 },
  ]

  private visibleMarkers(): AssetMarker[] {
    return this.markers.filter((m: AssetMarker) => this.enabledCats.indexOf(m.type) >= 0)
  }

  private selectedName(): string {
    if (this.selectedId === null) {
      return 'None'
    }
    const found = this.markers.find((m: AssetMarker) => m.id === this.selectedId)
    return found !== undefined ? found.name : 'None'
  }

  build() {
    Column() {
      Row() {
        Text('Asset Inventory')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.lg })
      .backgroundColor(Colors.surface)
      .alignItems(VerticalAlign.Center)

      Column({ space: Spacing.lg }) {
        Scroll() {
          Row({ space: Spacing.sm }) {
            ForEach(this.categories, (c: string) => {
              Button() {
                Text(c)
                  .fontSize(this.enabledCats.indexOf(c) >= 0 ? 16 : 14)
                  .fontColor(this.enabledCats.indexOf(c) >= 0 ? Colors.onPrimary : Colors.onSurface)
              }
              .type(ButtonType.Normal)
              .backgroundColor(this.enabledCats.indexOf(c) >= 0 ? Colors.primary : Colors.surface)
              .borderRadius(8)
              .border({ width: 1, color: Colors.outline })
              .onClick(() => {
                if (this.enabledCats.indexOf(c) >= 0) {
                  this.enabledCats = this.enabledCats.filter((x: string) => x !== c)
                } else {
                  this.enabledCats = this.enabledCats.concat([c])
                }
              })
            }, (c: string) => c)
          }
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')

        Row({ space: Spacing.lg }) {
          Column({ space: Spacing.md }) {
            TextInput({ text: this.assetName, placeholder: 'Asset Name' })
              .width('100%')
              .onChange((value: string) => {
                this.assetName = value
              })
            TextInput({ text: this.assetCode, placeholder: 'Asset Code' })
              .width('100%')
              .onChange((value: string) => {
                this.assetCode = value
              })
            TextInput({ text: this.assetType, placeholder: 'Asset Type' })
              .width('100%')
              .onChange((value: string) => {
                this.assetType = value
              })

            Column({ space: Spacing.sm }) {
              Text('Selected')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
              Text(this.selectedName())
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
            }
            .width('100%')
            .padding(Spacing.lg)
            .backgroundColor(Colors.surface)
            .borderRadius(16)
            .border({ width: 1, color: Colors.outline })
            .alignItems(HorizontalAlign.Start)
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          Stack({ alignContent: Alignment.TopStart }) {
            MapGridOverlay()
            ForEach(this.visibleMarkers(), (m: AssetMarker) => {
              MapMarker({
                type: m.type,
                selected: this.selectedId === m.id,
                onClick: () => {
                  this.selectedId = this.selectedId === m.id ? null : m.id
                }
              })
                .position({ x: (m.x * 100).toString() + '%', y: (m.y * 100).toString() + '%' })
            }, (m: AssetMarker) => m.id.toString())
          }
          .layoutWeight(1)
          .aspectRatio(0.9)
          .constraintSize({ minHeight: 360 })
          .backgroundColor(Colors.surface)
          .borderRadius(16)
          .border({ width: 1, color: Colors.outline })
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })

      Row({ space: Spacing.md }) {
        Button('Reset')
          .type(ButtonType.Normal)
          .fontSize(16)
          .fontColor(Colors.onSurface)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
          .onClick(() => {
            this.assetName = ''
            this.assetCode = ''
            this.assetType = 'Device'
            this.selectedId = null
          })
        Button('Save Asset')
          .type(ButtonType.Normal)
          .fontSize(16)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      .backgroundColor(Colors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
