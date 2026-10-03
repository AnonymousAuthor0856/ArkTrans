// AppTokens - Design tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = '#111111'
    export const secondary: ResourceColor = '#2A2A2A'
    export const tertiary: ResourceColor = '#474747'
    export const background: ResourceColor = '#F6F6F6'
    export const surface: ResourceColor = '#FFFFFF'
    export const surfaceVariant: ResourceColor = '#EDEDED'
    export const outline: ResourceColor = '#D1D1D1'
    export const success: ResourceColor = '#2E7D32'
    export const warning: ResourceColor = '#B98900'
    export const error: ResourceColor = '#B3261E'
    export const onPrimary: ResourceColor = '#FFFFFF'
    export const onSecondary: ResourceColor = '#FFFFFF'
    export const onTertiary: ResourceColor = '#FFFFFF'
    export const onBackground: ResourceColor = '#0A0A0A'
    export const onSurface: ResourceColor = '#0A0A0A'
  }

  export namespace TypographyTokens {
    export const display = { size: 28, weight: FontWeight.Medium }
    export const headline = { size: 20, weight: FontWeight.Medium }
    export const title = { size: 16, weight: FontWeight.Medium }
    export const body = { size: 14, weight: FontWeight.Regular }
    export const label = { size: 12, weight: FontWeight.Medium }
  }

  export namespace Shapes {
    export const small: number = 8
    export const medium: number = 12
    export const large: number = 16
  }

  export namespace Spacing {
    export const xs: Length = 4
    export const sm: Length = 8
    export const md: Length = 12
    export const lg: Length = 16
    export const xl: Length = 24
    export const xxl: Length = 32
    export const xxxl: Length = 48
  }

  export namespace ElevationMapping {
    export const level1 = { radius: 4, dy: 2, opacity: 0.10 }
    export const level2 = { radius: 8, dy: 4, opacity: 0.14 }
    export const level3 = { radius: 12, dy: 6, opacity: 0.16 }
    export const level4 = { radius: 16, dy: 8, opacity: 0.18 }
    export const level5 = { radius: 20, dy: 10, opacity: 0.20 }
  }
}

// AppColorScheme - Light theme colors
class AppColorScheme {
  primary: ResourceColor = AppTokens.Colors.primary
  onPrimary: ResourceColor = AppTokens.Colors.onPrimary
  secondary: ResourceColor = AppTokens.Colors.secondary
  onSecondary: ResourceColor = AppTokens.Colors.onSecondary
  tertiary: ResourceColor = AppTokens.Colors.tertiary
  onTertiary: ResourceColor = AppTokens.Colors.onTertiary
  background: ResourceColor = AppTokens.Colors.background
  onBackground: ResourceColor = AppTokens.Colors.onBackground
  surface: ResourceColor = AppTokens.Colors.surface
  onSurface: ResourceColor = AppTokens.Colors.onSurface
  surfaceVariant: ResourceColor = AppTokens.Colors.surfaceVariant
  outline: ResourceColor = AppTokens.Colors.outline
  error: ResourceColor = AppTokens.Colors.error

  static light(): AppColorScheme {
    return new AppColorScheme()
  }
}

// AssetMarker data model
interface AssetMarker {
  id: number
  name: string
  type: string
  x: number
  y: number
}

// MapGridOverlay component
@Component
struct MapGridOverlay {
  build() {
    Stack() {
      Column() {
        ForEach([0, 1, 2, 3, 4, 5, 6], (_: number, index: number) => {
          Divider()
            .strokeWidth(1)
            .color(AppTokens.Colors.surfaceVariant)
          if (index < 6) {
            Blank()
          }
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)

      Row() {
        ForEach([0, 1, 2, 3, 4, 5, 6], (_: number, index: number) => {
          Divider()
            .vertical(true)
            .strokeWidth(1)
            .color(AppTokens.Colors.surfaceVariant)
          if (index < 6) {
            Blank()
          }
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}

// MapMarker component
@Component
struct MapMarker {
  @Prop type: string = ''
  @Prop selected: boolean = false
  @Prop colorScheme: AppColorScheme = AppColorScheme.light()
  onMarkerClick: () => void = () => {}

  @Builder
  markerColor(type_: string): ResourceColor {
    if (type_ === 'Warehouse') {
      return AppTokens.Colors.tertiary
    } else if (type_ === 'Device') {
      return AppTokens.Colors.secondary
    } else {
      return AppTokens.Colors.primary
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle({ width: this.selected ? 28 : 22, height: this.selected ? 28 : 22 })
        .fill(this.type === 'Warehouse' ? AppTokens.Colors.tertiary :
              this.type === 'Device' ? AppTokens.Colors.secondary :
              AppTokens.Colors.primary)
        .stroke({
          color: this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface,
          width: 2
        })

      Column() {
        Text(this.type)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(this.colorScheme.onSurface)
          .padding({
            left: AppTokens.Spacing.sm,
            right: AppTokens.Spacing.sm,
            top: AppTokens.Spacing.xs,
            bottom: AppTokens.Spacing.xs
          })
          .backgroundColor(this.colorScheme.surface)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: this.colorScheme.outline })
      }
      .shadow({
        radius: AppTokens.ElevationMapping.level1.radius,
        color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
        offsetY: AppTokens.ElevationMapping.level1.dy
      })
      .translate({ x: 18, y: -4 })
      .onClick(() => {
        this.onMarkerClick()
      })
    }
  }
}

// Selected Asset Card component
@Component
struct SelectedAssetCard {
  @Prop colorScheme: AppColorScheme = AppColorScheme.light()
  @Prop selectedName: string = 'None'

  build() {
    Column() {
      Text('Selected')
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(this.colorScheme.onSurface)
        .margin({ bottom: AppTokens.Spacing.sm })

      Text(this.selectedName)
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(this.colorScheme.onSurface)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(this.colorScheme.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: this.colorScheme.outline })
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }
}

// Filter Chip component
@Component
struct FilterChip {
  @Prop label: string = ''
  @Prop isOn: boolean = false
  @Prop colorScheme: AppColorScheme = AppColorScheme.light()
  onToggle: () => void = () => {}

  build() {
    Text(this.label)
      .fontSize(this.isOn ? AppTokens.TypographyTokens.title.size : AppTokens.TypographyTokens.body.size)
      .fontWeight(this.isOn ? AppTokens.TypographyTokens.title.weight : AppTokens.TypographyTokens.body.weight)
      .fontColor(this.isOn ? this.colorScheme.onPrimary : this.colorScheme.onSurface)
      .padding({
        left: AppTokens.Spacing.md,
        right: AppTokens.Spacing.md,
        top: AppTokens.Spacing.sm,
        bottom: AppTokens.Spacing.sm
      })
      .backgroundColor(this.isOn ? this.colorScheme.primary : this.colorScheme.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: this.colorScheme.outline })
      .onClick(() => {
        this.onToggle()
      })
  }
}

// Custom styled TextInput
@Component
struct AppTextField {
  @Prop placeholder: string = ''
  @Prop colorScheme: AppColorScheme = AppColorScheme.light()
  @Link text: string

  build() {
    TextInput({ placeholder: this.placeholder, text: this.text })
      .fontSize(AppTokens.TypographyTokens.body.size)
      .fontColor(this.colorScheme.onSurface)
      .placeholderColor(this.colorScheme.onSurface)
      .padding({
        left: AppTokens.Spacing.md,
        right: AppTokens.Spacing.md,
        top: AppTokens.Spacing.sm,
        bottom: AppTokens.Spacing.sm
      })
      .backgroundColor(this.colorScheme.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: this.colorScheme.outline })
      .onChange((value: string) => {
        this.text = value
      })
  }
}

// RootScreen - main screen
@Entry
@Component
struct RootScreen {
  private colorScheme: AppColorScheme = AppColorScheme.light()

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
  @State mapWidth: number = 0
  @State mapHeight: number = 0

  private toggleCategory(c: string): void {
    const idx = this.enabledCats.indexOf(c)
    if (idx >= 0) {
      this.enabledCats.splice(idx, 1)
    } else {
      this.enabledCats.push(c)
    }
  }

  private getSelectedName(): string {
    if (this.selectedId === null) return 'None'
    const marker = this.markers.find(m => m.id === this.selectedId)
    return marker ? marker.name : 'None'
  }

  private toggleMarker(id: number): void {
    if (this.selectedId === id) {
      this.selectedId = null
    } else {
      this.selectedId = id
    }
  }

  private resetForm(): void {
    this.assetName = ''
    this.assetCode = ''
    this.assetType = 'Device'
    this.selectedId = null
  }

  build() {
    Column() {
      // Top bar
      Column() {
        Text('Asset Inventory')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(this.colorScheme.onSurface)
      }
      .width('100%')
      .height(86)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.colorScheme.surface)

      // Main content area
      Scroll() {
        Column() {
          // Filter chips row
          Scroll() {
            Row() {
              ForEach(this.categories, (c: string) => {
                FilterChip({
                  label: c,
                  isOn: this.enabledCats.includes(c),
                  colorScheme: this.colorScheme,
                  onToggle: () => this.toggleCategory(c)
                })
              })
            }
            .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
          .margin({ top: AppTokens.Spacing.md })

          // Asset details and map row
          Row() {
            // Left side: asset inputs and selected card
            Column() {
              AppTextField({
                placeholder: 'Asset Name',
                colorScheme: this.colorScheme,
                text: $assetName
              })

              AppTextField({
                placeholder: 'Asset Code',
                colorScheme: this.colorScheme,
                text: $assetCode
              })

              AppTextField({
                placeholder: 'Asset Type',
                colorScheme: this.colorScheme,
                text: $assetType
              })

              SelectedAssetCard({
                colorScheme: this.colorScheme,
                selectedName: this.getSelectedName()
              })
            }
            .width('50%')
            .alignItems(HorizontalAlign.Start)

            // Right side: map area
            Stack({ alignContent: Alignment.TopStart }) {
              MapGridOverlay()

              ForEach(this.markers.filter(m => this.enabledCats.includes(m.type)), (m: AssetMarker) => {
                MapMarker({
                  type: m.type,
                  selected: this.selectedId === m.id,
                  colorScheme: this.colorScheme,
                  onMarkerClick: () => this.toggleMarker(m.id)
                })
                  .position({
                    x: m.x * this.mapWidth,
                    y: m.y * this.mapHeight
                  })
              }, (m: AssetMarker) => m.id.toString())
            }
            .width('50%')
            .aspectRatio(0.9)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .onAreaChange((oldValue: Area, newValue: Area) => {
              this.mapWidth = newValue.width as number
              this.mapHeight = newValue.height as number
            })
          }
          .width('100%')
          .margin({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.lg
          })
          .alignItems(VerticalAlign.Top)
        }
        .width('100%')
        .padding({ bottom: AppTokens.Spacing.md })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(this.colorScheme.background)
      .scrollBar(BarState.Off)

      // Bottom bar
      Column() {
        Row() {
          // Reset button
          Text('Reset')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(this.colorScheme.onSurface)
            .width('100%')
            .height(48)
            .textAlign(TextAlign.Center)
            .backgroundColor(this.colorScheme.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.resetForm()
            })

          // Save Asset button
          Text('Save Asset')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(this.colorScheme.onPrimary)
            .width('100%')
            .height(48)
            .textAlign(TextAlign.Center)
            .backgroundColor(this.colorScheme.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              // Save asset logic
            })
        }
        .width('100%')
        .margin({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.md
        })
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
      .backgroundColor(this.colorScheme.surface)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
        offsetY: -AppTokens.ElevationMapping.level2.dy
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorScheme.background)
  }
}
