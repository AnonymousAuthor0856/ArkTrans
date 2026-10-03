class AppColors {
  static readonly primary: string = '#111111'
  static readonly secondary: string = '#2A2A2A'
  static readonly tertiary: string = '#474747'
  static readonly background: string = '#F6F6F6'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#EDEDED'
  static readonly outline: string = '#D1D1D1'
  static readonly onSurface: string = '#0A0A0A'
}

interface AssetMarker {
  id: number
  name: string
  type: string
  x: number
  y: number
}

@Entry
@Component
struct AssetInventoryPage {
  @State assetName: string = ''
  @State assetCode: string = ''
  @State assetType: string = 'Device'
  @State selectedId: number = -1
  @State enabledCategories: string[] = ['Warehouse', 'Device', 'Office']

  private readonly categories: string[] = ['Warehouse', 'Device', 'Office']
  private readonly gridItems: number[] = [
    0, 1, 2, 3, 4, 5,
    6, 7, 8, 9, 10, 11,
    12, 13, 14, 15, 16, 17,
    18, 19, 20, 21, 22, 23,
    24, 25, 26, 27, 28, 29,
    30, 31, 32, 33, 34, 35
  ]
  private readonly markers: AssetMarker[] = [
    { id: 1, name: 'Main Warehouse', type: 'Warehouse', x: 0.18, y: 0.34 },
    { id: 2, name: 'CNC-07', type: 'Device', x: 0.52, y: 0.46 },
    { id: 3, name: 'HQ Office', type: 'Office', x: 0.75, y: 0.62 },
    { id: 4, name: 'Spare Parts', type: 'Warehouse', x: 0.33, y: 0.78 }
  ]

  private isEnabled(category: string): boolean {
    return this.enabledCategories.indexOf(category) >= 0
  }

  private markerColor(type: string): string {
    if (type === 'Warehouse') {
      return AppColors.tertiary
    }
    if (type === 'Device') {
      return AppColors.secondary
    }
    return AppColors.primary
  }

  private toggleCategory(category: string): void {
    const index: number = this.enabledCategories.indexOf(category)
    if (index >= 0) {
      this.enabledCategories.splice(index, 1)
    } else {
      this.enabledCategories.push(category)
    }
  }

  private reset(): void {
    this.assetName = ''
    this.assetCode = ''
    this.assetType = 'Device'
    this.selectedId = -1
  }

  private selectedName(): string {
    for (let index: number = 0; index < this.markers.length; index++) {
      if (this.markers[index].id === this.selectedId) {
        return this.markers[index].name
      }
    }
    return 'None'
  }

  @Builder
  private field(value: string, placeholder: string, onChange: (value: string) => void): void {
    TextInput({ text: value, placeholder: placeholder })
      .width('100%')
      .height(70)
      .fontSize(27)
      .fontColor(AppColors.onSurface)
      .placeholderColor('#B9B9B9')
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(16)
      .border({ width: 2, color: AppColors.outline })
      .padding({ left: 24, right: 18 })
      .onChange(onChange)
  }

  @Builder
  private filterChip(category: string): void {
    Button(category)
      .height(70)
      .padding({ left: 24, right: 24 })
      .fontSize(30)
      .fontColor(this.isEnabled(category) ? AppColors.surface : AppColors.onSurface)
      .backgroundColor(this.isEnabled(category) ? AppColors.primary : AppColors.surface)
      .borderRadius(16)
      .border({ width: 2, color: AppColors.outline })
      .onClick(() => this.toggleCategory(category))
  }

  @Builder
  private mapMarker(marker: AssetMarker): void {
    if (this.isEnabled(marker.type)) {
      Stack() {
        Circle()
          .width(this.selectedId === marker.id ? 44 : 40)
          .height(this.selectedId === marker.id ? 44 : 40)
          .fill(this.markerColor(marker.type))
          .border({
            width: 2,
            color: this.selectedId === marker.id ? AppColors.primary : AppColors.surface
          })

        Button(marker.type)
          .height(46)
          .fontSize(24)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surface)
          .borderRadius(16)
          .border({ width: 2, color: AppColors.outline })
          .shadow({
            radius: 8,
            color: '#24000000',
            offsetX: 0,
            offsetY: 3
          })
          .padding({ left: 16, right: 16 })
          .position({ x: 34, y: -5 })
          .onClick(() => {
            this.selectedId = this.selectedId === marker.id ? -1 : marker.id
          })
      }
      .width(40)
      .height(44)
      .position({
        x: marker.x * 250,
        y: marker.y * 650
      })
    }
  }

  @Builder
  private mapPanel(): void {
    Stack() {
      Grid() {
        ForEach(this.gridItems, (item: number) => {
          GridItem()
            .border({ width: 1, color: '#E5E5E5' })
        }, (item: number) => item.toString())
      }
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr')
      .width('80%')
      .height('92%')
      .position({ x: '10%', y: '4%' })

      ForEach(this.markers, (marker: AssetMarker) => {
        this.mapMarker(marker)
      }, (marker: AssetMarker) => marker.id.toString())
    }
    .width('100%')
    .height(720)
    .backgroundColor(AppColors.surface)
    .borderRadius(32)
    .border({ width: 2, color: AppColors.outline })
    .clip(true)
  }

  build() {
    Column() {
      Column() {
        Text('Asset Inventory')
          .fontSize(54)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .height(172)
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.surface)

      Scroll() {
        Column({ space: 24 }) {
          Row({ space: 16 }) {
            ForEach(this.categories, (category: string) => {
              this.filterChip(category)
            }, (category: string) => category)
          }
          .width('100%')
          .padding({ left: 32, right: 32, top: 24 })

          Row({ space: 30 }) {
            Column({ space: 22 }) {
              this.field(this.assetName, 'Asset Name', (value: string) => {
                this.assetName = value
              })
              this.field(this.assetCode, 'Asset Code', (value: string) => {
                this.assetCode = value
              })
              this.field(this.assetType, 'Device', (value: string) => {
                this.assetType = value
              })

              Column({ space: 10 }) {
                Text('Selected')
                  .fontSize(25)
                  .fontColor(AppColors.onSurface)
                Text(this.selectedName())
                  .fontSize(40)
                  .fontColor(AppColors.onSurface)
              }
              .width('100%')
              .height(156)
              .alignItems(HorizontalAlign.Start)
              .justifyContent(FlexAlign.Center)
              .padding({ left: 32, right: 24 })
              .backgroundColor(AppColors.surface)
              .borderRadius(32)
              .border({ width: 2, color: AppColors.outline })
              .shadow({
                radius: 10,
                color: '#22000000',
                offsetX: 0,
                offsetY: 4
              })
            }
            .width('48%')
            .alignItems(HorizontalAlign.Start)

            Column() {
              this.mapPanel()
            }
            .width('48%')
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)
          .padding({ left: 32, right: 32 })
        }
        .width('100%')
        .padding({ bottom: 24 })
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
      .backgroundColor(AppColors.background)
      .scrollBar(BarState.Off)

      Row({ space: 24 }) {
        Button('Reset')
          .layoutWeight(1)
          .height(96)
          .fontSize(30)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(24)
          .onClick(() => this.reset())

        Button('Save Asset')
          .layoutWeight(1)
          .height(96)
          .fontSize(30)
          .fontColor(AppColors.surface)
          .backgroundColor(AppColors.primary)
          .borderRadius(24)
          .onClick(() => {
            this.selectedId = -1
          })
      }
      .width('100%')
      .padding({ left: 32, right: 32, top: 24, bottom: 24 })
      .backgroundColor(AppColors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
