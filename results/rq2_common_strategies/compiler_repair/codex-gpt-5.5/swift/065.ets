class AppColors {
  static primary: string = '#111111'
  static secondary: string = '#2A2A2A'
  static tertiary: string = '#474747'
  static background: string = '#F6F6F6'
  static surface: string = '#FFFFFF'
  static surfaceVariant: string = '#EDEDED'
  static outline: string = '#D1D1D1'
  static success: string = '#2E7D32'
  static warning: string = '#B98900'
  static error: string = '#B3261E'
  static onPrimary: string = '#FFFFFF'
  static onSecondary: string = '#FFFFFF'
  static onTertiary: string = '#FFFFFF'
  static onBackground: string = '#0A0A0A'
  static onSurface: string = '#0A0A0A'
}

class AppSpacing {
  static xs: number = 4
  static sm: number = 8
  static md: number = 12
  static lg: number = 16
  static xl: number = 24
  static xxl: number = 32
  static xxxl: number = 48
}

class AppShape {
  static small: number = 8
  static medium: number = 12
  static large: number = 16
}

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
struct Index {
  @State warehouseOn: boolean = true
  @State deviceOn: boolean = true
  @State officeOn: boolean = true
  @State assetName: string = ''
  @State assetCode: string = ''
  @State assetType: string = 'Device'
  @State selectedId: number = 0

  private categories: string[] = ['Warehouse', 'Device', 'Office']
  private markers: AssetMarker[] = [
    new AssetMarker(1, 'Main Warehouse', 'Warehouse', 18, 34),
    new AssetMarker(2, 'CNC-07', 'Device', 52, 46),
    new AssetMarker(3, 'HQ Office', 'Office', 75, 62),
    new AssetMarker(4, 'Spare Parts', 'Warehouse', 33, 78)
  ]

  private isCategoryOn(name: string): boolean {
    if (name === 'Warehouse') {
      return this.warehouseOn
    }
    if (name === 'Device') {
      return this.deviceOn
    }
    return this.officeOn
  }

  private shouldShowMarker(marker: AssetMarker): boolean {
    return this.isCategoryOn(marker.type)
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

  private selectedName(): string {
    for (let i = 0; i < this.markers.length; i++) {
      if (this.markers[i].id === this.selectedId) {
        return this.markers[i].name
      }
    }
    return 'None'
  }

  @Builder
  FilterChip(name: string) {
    Text(name)
      .fontSize(this.isCategoryOn(name) ? 16 : 14)
      .fontWeight(this.isCategoryOn(name) ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.isCategoryOn(name) ? AppColors.onPrimary : AppColors.onSurface)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(this.isCategoryOn(name) ? AppColors.primary : AppColors.surface)
      .border({ width: 1, color: AppColors.outline, radius: AppShape.small })
      .onClick(() => {
        if (name === 'Warehouse') {
          this.warehouseOn = !this.warehouseOn
        } else if (name === 'Device') {
          this.deviceOn = !this.deviceOn
        } else {
          this.officeOn = !this.officeOn
        }
      })
  }

  @Builder
  InputField(placeholder: string, value: string, kind: number) {
    TextInput({ placeholder: placeholder, text: value })
      .fontSize(14)
      .fontColor(AppColors.onSurface)
      .placeholderColor('#880A0A0A')
      .height(42)
      .padding({ left: AppSpacing.md, right: AppSpacing.md })
      .backgroundColor(AppColors.surfaceVariant)
      .border({ width: 1, color: AppColors.outline, radius: AppShape.small })
      .onChange((text: string) => {
        if (kind === 0) {
          this.assetName = text
        } else if (kind === 1) {
          this.assetCode = text
        } else {
          this.assetType = text
        }
      })
  }

  @Builder
  SelectedCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Selected')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
      Text(this.selectedName())
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: AppShape.large })
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
  }

  @Builder
  MapGridOverlay() {
    Stack() {
      ForEach([16, 32, 48, 64, 80], (pos: number) => {
        Rect()
          .width('90%')
          .height(1)
          .fill(AppColors.surfaceVariant)
          .position({ x: '50%', y: pos.toString() + '%' })
      })
      ForEach([16, 32, 48, 64, 80], (pos: number) => {
        Rect()
          .width(1)
          .height('90%')
          .fill(AppColors.surfaceVariant)
          .position({ x: pos.toString() + '%', y: '50%' })
      })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  MapMarkerView(marker: AssetMarker) {
    Stack() {
      Circle()
        .width(this.selectedId === marker.id ? 28 : 22)
        .height(this.selectedId === marker.id ? 28 : 22)
        .fill(this.markerColor(marker.type))
        .stroke(this.selectedId === marker.id ? AppColors.primary : AppColors.surface)
        .strokeWidth(2)
        .position({ x: '0%', y: '20%' })

      Text(marker.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
        .backgroundColor(AppColors.surface)
        .border({ width: 1, color: AppColors.outline, radius: AppShape.small })
        .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
        .position({ x: '55%', y: '10%' })
    }
    .width(120)
    .height(48)
    .position({ x: marker.x.toString() + '%', y: marker.y.toString() + '%' })
    .onClick(() => {
      this.selectedId = this.selectedId === marker.id ? 0 : marker.id
    })
  }

  @Builder
  MapArea() {
    Stack() {
      this.MapGridOverlay()
      ForEach(this.markers, (marker: AssetMarker) => {
        if (this.shouldShowMarker(marker)) {
          this.MapMarkerView(marker)
        }
      })
    }
    .width('100%')
    .height(360)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: AppShape.large })
  }

  @Builder
  BottomBar() {
    Row({ space: AppSpacing.md }) {
      Button('Reset')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .height(48)
        .layoutWeight(1)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShape.medium)
        .onClick(() => {
          this.assetName = ''
          this.assetCode = ''
          this.assetType = 'Device'
          this.selectedId = 0
        })

      Button('Save Asset')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .height(48)
        .layoutWeight(1)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShape.medium)
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 8, color: '#24000000', offsetY: -4 })
  }

  build() {
    Column() {
      Row() {
        Text('Asset Inventory')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(86)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surface)

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Scroll() {
            Row({ space: AppSpacing.sm }) {
              ForEach(this.categories, (item: string) => {
                this.FilterChip(item)
              })
            }
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md })
          }
          .width('100%')
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)

          Column({ space: AppSpacing.lg }) {
            Column({ space: AppSpacing.md }) {
              this.InputField('Asset Name', this.assetName, 0)
              this.InputField('Asset Code', this.assetCode, 1)
              this.InputField('Asset Type', this.assetType, 2)
              this.SelectedCard()
            }
            .width('100%')

            this.MapArea()
          }
          .width('100%')
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        }
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
      .scrollBar(BarState.Off)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
