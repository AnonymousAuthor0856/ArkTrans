interface AppColors {
  primary: string
  secondary: string
  tertiary: string
  background: string
  surface: string
  surfaceVariant: string
  outline: string
  success: string
  warning: string
  error: string
  onPrimary: string
  onSecondary: string
  onTertiary: string
  onBackground: string
  onSurface: string
}

interface TypographyToken {
  size: number
  weight: number
}

interface TypographyTokens {
  display: TypographyToken
  headline: TypographyToken
  title: TypographyToken
  body: TypographyToken
  label: TypographyToken
}

interface ShapeTokens {
  small: number
  medium: number
  large: number
}

interface SpacingTokens {
  xs: number
  sm: number
  md: number
  lg: number
  xl: number
  xxl: number
  xxxl: number
}

interface ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number
}

interface ElevationTokens {
  level1: ShadowSpec
  level2: ShadowSpec
  level3: ShadowSpec
  level4: ShadowSpec
  level5: ShadowSpec
}

class AppTokens {
  static readonly Colors: AppColors = {
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
    onSurface: '#0A0A0A'
  }

  static readonly TypographyTokens: TypographyTokens = {
    display: { size: 28, weight: 600 },
    headline: { size: 20, weight: 500 },
    title: { size: 16, weight: 500 },
    body: { size: 14, weight: 400 },
    label: { size: 12, weight: 500 }
  }

  static readonly Shapes: ShapeTokens = {
    small: 8,
    medium: 12,
    large: 16
  }

  static readonly Spacing: SpacingTokens = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 48
  }

  static readonly ElevationMapping: ElevationTokens = {
    level1: { elevation: 1, radius: 4, dy: 2, opacity: 0.10 },
    level2: { elevation: 3, radius: 8, dy: 4, opacity: 0.14 },
    level3: { elevation: 6, radius: 12, dy: 6, opacity: 0.16 },
    level4: { elevation: 10, radius: 16, dy: 8, opacity: 0.18 },
    level5: { elevation: 14, radius: 20, dy: 10, opacity: 0.20 }
  }

  static readonly GridLines: number[] = [0, 1, 2, 3, 4, 5]
}

interface AppColorScheme {
  primary: string
  onPrimary: string
  secondary: string
  onSecondary: string
  tertiary: string
  onTertiary: string
  background: string
  onBackground: string
  surface: string
  onSurface: string
  surfaceVariant: string
  outline: string
  error: string
}

const LightColorScheme: AppColorScheme = {
  primary: AppTokens.Colors.primary,
  onPrimary: AppTokens.Colors.onPrimary,
  secondary: AppTokens.Colors.secondary,
  onSecondary: AppTokens.Colors.onSecondary,
  tertiary: AppTokens.Colors.tertiary,
  onTertiary: AppTokens.Colors.onTertiary,
  background: AppTokens.Colors.background,
  onBackground: AppTokens.Colors.onBackground,
  surface: AppTokens.Colors.surface,
  onSurface: AppTokens.Colors.onSurface,
  surfaceVariant: AppTokens.Colors.surfaceVariant,
  outline: AppTokens.Colors.outline,
  error: AppTokens.Colors.error
}

interface AssetMarker {
  id: number
  name: string
  type: string
  x: number
  y: number
}

function shadowColor(opacity: number): string {
  return `rgba(0, 0, 0, ${opacity})`
}

@Component
struct AppTextField {
  placeholder: string = ''
  @Link value: string
  colorScheme: AppColorScheme = LightColorScheme

  build() {
    TextInput({
      placeholder: this.placeholder,
      text: this.value
    })
      .width('100%')
      .height(44)
      .padding({
        left: AppTokens.Spacing.md,
        right: AppTokens.Spacing.md
      })
      .fontSize(AppTokens.TypographyTokens.body.size)
      .fontWeight(AppTokens.TypographyTokens.body.weight)
      .fontColor(this.colorScheme.onSurface)
      .placeholderColor('#8A8A8A')
      .caretColor(this.colorScheme.primary)
      .backgroundColor(this.colorScheme.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)
      .border({
        width: 1,
        color: this.colorScheme.outline
      })
      .onChange((value: string) => {
        this.value = value
      })
  }
}

@Component
struct MapGridOverlay {
  colorScheme: AppColorScheme = LightColorScheme

  build() {
    Stack() {
      Column() {
        ForEach(AppTokens.GridLines, (_: number) => {
          Rect()
            .width('100%')
            .height(1)
            .fill(AppTokens.Colors.surfaceVariant)

          Blank()
            .layoutWeight(1)
        }, (item: number) => item.toString())

        Rect()
          .width('100%')
          .height(1)
          .fill(AppTokens.Colors.surfaceVariant)
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)

      Row() {
        ForEach(AppTokens.GridLines, (_: number) => {
          Rect()
            .width(1)
            .height('100%')
            .fill(AppTokens.Colors.surfaceVariant)

          Blank()
            .layoutWeight(1)
        }, (item: number) => item.toString())

        Rect()
          .width(1)
          .height('100%')
          .fill(AppTokens.Colors.surfaceVariant)
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct MapMarker {
  type: string = ''
  selected: boolean = false
  colorScheme: AppColorScheme = LightColorScheme
  onMarkerClick: () => void = () => {
  }

  markerColor(): string {
    if (this.type === 'Warehouse') {
      return AppTokens.Colors.tertiary
    }

    if (this.type === 'Device') {
      return AppTokens.Colors.secondary
    }

    return AppTokens.Colors.primary
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Blank()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .backgroundColor(this.markerColor())
        .borderRadius(this.selected ? 14 : 11)
        .border({
          width: 2,
          color: this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface
        })

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
        .border({
          width: 1,
          color: this.colorScheme.outline
        })
        .shadow({
          radius: AppTokens.ElevationMapping.level1.radius,
          color: shadowColor(AppTokens.ElevationMapping.level1.opacity),
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level1.dy
        })
        .position({
          x: 18,
          y: -4
        })
        .onClick(() => {
          this.onMarkerClick()
        })
    }
    .width(120)
    .height(42)
    .onClick(() => {
      this.onMarkerClick()
    })
  }
}

@Entry
@Component
struct RootScreen {
  private colorScheme: AppColorScheme = LightColorScheme

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
  @State selectedId: number = -1

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

  selectedName(): string {
    const selected: AssetMarker | undefined = this.markers.find((item: AssetMarker) => item.id === this.selectedId)
    return selected ? selected.name : 'None'
  }

  resetForm(): void {
    this.assetName = ''
    this.assetCode = ''
    this.assetType = 'Device'
    this.selectedId = -1
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text('Asset Inventory')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(this.colorScheme.onSurface)
      }
      .width('100%')
      .height(86)
      .backgroundColor(this.colorScheme.surface)

      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          Scroll() {
            Row({ space: AppTokens.Spacing.sm }) {
              ForEach(this.categories, (category: string) => {
                Text(category)
                  .fontSize(this.isCategoryEnabled(category)
                    ? AppTokens.TypographyTokens.title.size
                    : AppTokens.TypographyTokens.body.size)
                  .fontWeight(this.isCategoryEnabled(category)
                    ? AppTokens.TypographyTokens.title.weight
                    : AppTokens.TypographyTokens.body.weight)
                  .fontColor(this.isCategoryEnabled(category)
                    ? this.colorScheme.onPrimary
                    : this.colorScheme.onSurface)
                  .padding({
                    left: AppTokens.Spacing.md,
                    right: AppTokens.Spacing.md,
                    top: AppTokens.Spacing.sm,
                    bottom: AppTokens.Spacing.sm
                  })
                  .backgroundColor(this.isCategoryEnabled(category)
                    ? this.colorScheme.primary
                    : this.colorScheme.surface)
                  .borderRadius(AppTokens.Shapes.small)
                  .border({
                    width: 1,
                    color: this.colorScheme.outline
                  })
                  .onClick(() => {
                    this.toggleCategory(category)
                  })
              }, (category: string) => category)
            }
          }
          .width('100%')
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.md
          })

          Row({ space: AppTokens.Spacing.lg }) {
            Column({ space: AppTokens.Spacing.md }) {
              AppTextField({
                placeholder: 'Asset Name',
                value: $assetName,
                colorScheme: this.colorScheme
              })

              AppTextField({
                placeholder: 'Asset Code',
                value: $assetCode,
                colorScheme: this.colorScheme
              })

              AppTextField({
                placeholder: 'Asset Type',
                value: $assetType,
                colorScheme: this.colorScheme
              })

              Column({ space: AppTokens.Spacing.sm }) {
                Text('Selected')
                  .fontSize(AppTokens.TypographyTokens.label.size)
                  .fontWeight(AppTokens.TypographyTokens.label.weight)
                  .fontColor(this.colorScheme.onSurface)

                Text(this.selectedName())
                  .fontSize(AppTokens.TypographyTokens.headline.size)
                  .fontWeight(AppTokens.TypographyTokens.headline.weight)
                  .fontColor(this.colorScheme.onSurface)
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')
              .padding(AppTokens.Spacing.lg)
              .backgroundColor(this.colorScheme.surface)
              .borderRadius(AppTokens.Shapes.large)
              .border({
                width: 1,
                color: this.colorScheme.outline
              })
              .shadow({
                radius: AppTokens.ElevationMapping.level1.radius,
                color: shadowColor(AppTokens.ElevationMapping.level1.opacity),
                offsetX: 0,
                offsetY: AppTokens.ElevationMapping.level1.dy
              })
            }
            .layoutWeight(1)

            Stack({ alignContent: Alignment.TopStart }) {
              MapGridOverlay({
                colorScheme: this.colorScheme
              })

              ForEach(this.markers.filter((marker: AssetMarker) => this.enabledCats.indexOf(marker.type) >= 0),
                (marker: AssetMarker) => {
                  MapMarker({
                    type: marker.type,
                    selected: this.selectedId === marker.id,
                    colorScheme: this.colorScheme,
                    onMarkerClick: () => {
                      this.selectedId = this.selectedId === marker.id ? -1 : marker.id
                    }
                  })
                    .position({
                      x: `${marker.x * 100}%`,
                      y: `${marker.y * 100}%`
                    })
                },
                (marker: AssetMarker) => marker.id.toString())
            }
            .layoutWeight(1)
            .height(360)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({
              width: 1,
              color: AppTokens.Colors.outline
            })
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg
          })
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding({
          bottom: AppTokens.Spacing.md
        })
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(this.colorScheme.background)
      .scrollBar(BarState.Off)

      Column() {
        Row({ space: AppTokens.Spacing.md }) {
          Text('Reset')
            .layoutWeight(1)
            .height(48)
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(this.colorScheme.onSurface)
            .textAlign(TextAlign.Center)
            .backgroundColor(this.colorScheme.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.resetForm()
            })

          Text('Save Asset')
            .layoutWeight(1)
            .height(48)
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(this.colorScheme.onPrimary)
            .textAlign(TextAlign.Center)
            .backgroundColor(this.colorScheme.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
            })
        }
        .width('100%')
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.md
        })
      }
      .width('100%')
      .backgroundColor(this.colorScheme.surface)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: shadowColor(AppTokens.ElevationMapping.level2.opacity),
        offsetX: 0,
        offsetY: -AppTokens.ElevationMapping.level2.dy
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorScheme.background)
  }
}