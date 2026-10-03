class AppColors {
  static readonly primary: string = '#111111'
  static readonly secondary: string = '#2A2A2A'
  static readonly tertiary: string = '#474747'
  static readonly background: string = '#F6F6F6'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#EDEDED'
  static readonly outline: string = '#D1D1D1'
  static readonly success: string = '#2E7D32'
  static readonly warning: string = '#B98900'
  static readonly error: string = '#B3261E'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly onBackground: string = '#0A0A0A'
  static readonly onSurface: string = '#0A0A0A'
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
  static readonly xxxl: number = 48
}

class AppShape {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
}

class ShadowSpec {
  radius: number
  dy: number
  color: string

  constructor(radius: number, dy: number, color: string) {
    this.radius = radius
    this.dy = dy
    this.color = color
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(4, 2, '#1A000000')
  static readonly level2: ShadowSpec = new ShadowSpec(8, 4, '#24000000')
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

@Component
struct MapGridOverlay {
  mapW: number = 164
  mapH: number = 360
  gridLines: number[] = [0, 1, 2, 3, 4, 5, 6]

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      ForEach(this.gridLines, (i: number) => {
        Rect()
          .width(1)
          .height(this.mapH - 32)
          .fill(AppColors.surfaceVariant)
          .position({
            x: 16 + i * (this.mapW - 32) / 6,
            y: 16
          })
      }, (i: number) => i.toString())

      ForEach(this.gridLines, (i: number) => {
        Rect()
          .width(this.mapW - 32)
          .height(1)
          .fill(AppColors.surfaceVariant)
          .position({
            x: 16,
            y: 16 + i * (this.mapH - 32) / 6
          })
      }, (i: number) => `h-${i}`)
    }
    .width(this.mapW)
    .height(this.mapH)
  }
}

@Component
struct MapMarker {
  type: string = ''
  selected: boolean = false
  onClick: () => void = () => {
  }

  markerColor(): string {
    if (this.type === 'Warehouse') {
      return AppColors.tertiary
    }
    if (this.type === 'Device') {
      return AppColors.secondary
    }
    return AppColors.primary
  }

  markerSize(): number {
    return this.selected ? 28 : 22
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle()
        .width(this.markerSize())
        .height(this.markerSize())
        .fill(this.markerColor())
        .stroke({
          width: 2,
          color: this.selected ? AppColors.primary : AppColors.surface
        })
        .position({ x: 0, y: 4 })
        .onClick(() => {
          this.onClick()
        })

      Text(this.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .padding({
          left: AppSpacing.sm,
          right: AppSpacing.sm,
          top: AppSpacing.xs,
          bottom: AppSpacing.xs
        })
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShape.small)
        .border({
          width: 1,
          color: AppColors.outline
        })
        .shadow({
          radius: AppElevation.level1.radius,
          color: AppElevation.level1.color,
          offsetX: 0,
          offsetY: AppElevation.level1.dy
        })
        .position({ x: 18, y: 0 })
        .onClick(() => {
          this.onClick()
        })
    }
    .width(132)
    .height(44)
  }
}

@Entry
@Component
struct Index {
  @State categories: string[] = ['Warehouse', 'Device', 'Office']
  @State enabledCats: string[] = ['Warehouse', 'Device', 'Office']
  @State markers: AssetMarker[] = [
    new AssetMarker(1, 'Main Warehouse', 'Warehouse', 0.18, 0.34),
    new AssetMarker(2, 'CNC-07', 'Device', 0.52, 0.46),
    new AssetMarker(3, 'HQ Office', 'Office', 0.75, 0.62),
    new AssetMarker(4, 'Spare Parts', 'Warehouse', 0.33, 0.78)
  ]
  @State assetName: string = ''
  @State assetCode: string = ''
  @State assetType: string = 'Device'
  @State selectedId: number = -1

  mapW: number = 164
  mapH: number = 360

  isCategoryEnabled(category: string): boolean {
    return this.enabledCats.indexOf(category) >= 0
  }

  toggleCategory(category: string): void {
    if (this.isCategoryEnabled(category)) {
      this.enabledCats = this.enabledCats.filter((item: string) => item !== category)
    } else {
      this.enabledCats = [...this.enabledCats, category]
    }
  }

  selectedAssetName(): string {
    if (this.selectedId < 0) {
      return 'None'
    }
    for (let i = 0; i < this.markers.length; i++) {
      if (this.markers[i].id === this.selectedId) {
        return this.markers[i].name
      }
    }
    return 'None'
  }

  resetForm(): void {
    this.assetName = ''
    this.assetCode = ''
    this.assetType = 'Device'
    this.selectedId = -1
  }

  @Builder
  AppTextInput(placeholder: string, value: string, onValueChange: (value: string) => void) {
    TextInput({
      placeholder: placeholder,
      text: value
    })
      .height(36)
      .width('100%')
      .fontSize(14)
      .fontWeight(FontWeight.Normal)
      .fontColor(AppColors.onSurface)
      .placeholderColor('#B8B8B8')
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShape.small)
      .border({
        width: 1,
        color: AppColors.outline
      })
      .padding({
        left: AppSpacing.md,
        right: AppSpacing.md
      })
      .onChange((text: string) => {
        onValueChange(text)
      })
  }

  build() {
    Column() {
      Row() {
        Text('Asset Inventory')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
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
              ForEach(this.categories, (category: string) => {
                Button({ type: ButtonType.Normal, stateEffect: false }) {
                  Text(category)
                    .fontSize(this.isCategoryEnabled(category) ? 16 : 14)
                    .fontWeight(this.isCategoryEnabled(category) ? FontWeight.Medium : FontWeight.Normal)
                    .fontColor(this.isCategoryEnabled(category) ? AppColors.onPrimary : AppColors.onSurface)
                }
                .height(36)
                .padding({
                  left: AppSpacing.md,
                  right: AppSpacing.md
                })
                .backgroundColor(this.isCategoryEnabled(category) ? AppColors.primary : AppColors.surface)
                .borderRadius(AppShape.small)
                .border({
                  width: 1,
                  color: AppColors.outline
                })
                .onClick(() => {
                  this.toggleCategory(category)
                })
              }, (category: string) => category)
            }
            .padding({
              left: AppSpacing.lg,
              right: AppSpacing.lg
            })
          }
          .width('100%')
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .margin({
            top: AppSpacing.md
          })

          Row({ space: 15 }) {
            Column({ space: AppSpacing.md }) {
              this.AppTextInput('Asset Name', this.assetName, (value: string) => {
                this.assetName = value
              })

              this.AppTextInput('Asset Code', this.assetCode, (value: string) => {
                this.assetCode = value
              })

              this.AppTextInput('Asset Type', this.assetType, (value: string) => {
                this.assetType = value
              })

              Column({ space: AppSpacing.sm }) {
                Text('Selected')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)

                Text(this.selectedAssetName())
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)
              }
              .width('100%')
              .padding(AppSpacing.lg)
              .alignItems(HorizontalAlign.Start)
              .backgroundColor(AppColors.surface)
              .borderRadius(AppShape.large)
              .border({
                width: 1,
                color: AppColors.outline
              })
              .shadow({
                radius: AppElevation.level1.radius,
                color: AppElevation.level1.color,
                offsetX: 0,
                offsetY: AppElevation.level1.dy
              })
            }
            .width(164)
            .alignItems(HorizontalAlign.Start)

            Stack({ alignContent: Alignment.TopStart }) {
              MapGridOverlay({
                mapW: this.mapW,
                mapH: this.mapH
              })

              ForEach(this.markers.filter((marker: AssetMarker) => this.isCategoryEnabled(marker.type)), (marker: AssetMarker) => {
                MapMarker({
                  type: marker.type,
                  selected: this.selectedId === marker.id,
                  onClick: () => {
                    this.selectedId = this.selectedId === marker.id ? -1 : marker.id
                  }
                })
                  .position({
                    x: this.mapW * marker.x,
                    y: this.mapH * marker.y
                  })
              }, (marker: AssetMarker) => marker.id.toString())
            }
            .width(this.mapW)
            .height(this.mapH)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShape.large)
            .border({
              width: 1,
              color: AppColors.outline
            })
          }
          .width('100%')
          .padding({
            left: AppSpacing.lg,
            right: AppSpacing.lg
          })
          .alignItems(VerticalAlign.Top)
        }
        .width('100%')
        .padding({
          bottom: AppSpacing.md
        })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppColors.background)
      .scrollBar(BarState.Off)

      Row({ space: AppSpacing.xl }) {
        Button({ type: ButtonType.Normal, stateEffect: false }) {
          Text('Reset')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .layoutWeight(1)
        .height(48)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShape.medium)
        .onClick(() => {
          this.resetForm()
        })

        Button({ type: ButtonType.Normal, stateEffect: false }) {
          Text('Save Asset')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
        }
        .layoutWeight(1)
        .height(48)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShape.medium)
        .onClick(() => {
        })
      }
      .width('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.md
      })
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: AppElevation.level2.radius,
        color: AppElevation.level2.color,
        offsetX: 0,
        offsetY: -AppElevation.level2.dy
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}