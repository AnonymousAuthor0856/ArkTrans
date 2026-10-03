const NAME = '109AssetInventoryen'
const UI_TYPE = 'Form'
const STYLE_THEME = 'Monochrome'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
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

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Medium },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 8,
    medium: 12,
    large: 16,
  }

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 48,
  }

  static ElevationMapping = {
    level1: { elevation: 1, radius: 4, dy: 2, opacity: 0.10 },
    level2: { elevation: 3, radius: 8, dy: 4, opacity: 0.14 },
    level3: { elevation: 6, radius: 12, dy: 6, opacity: 0.16 },
    level4: { elevation: 10, radius: 16, dy: 8, opacity: 0.18 },
    level5: { elevation: 14, radius: 20, dy: 10, opacity: 0.20 },
  }
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
struct RootScreen {
  @State enabledCats: string[] = ['Warehouse', 'Device', 'Office']
  @State assetName: string = ''
  @State assetCode: string = ''
  @State assetType: string = 'Device'
  @State selectedId: number | null = null
  private categories: string[] = ['Warehouse', 'Device', 'Office']
  private markers: AssetMarker[] = [
    { id: 1, name: 'Main Warehouse', type: 'Warehouse', x: 0.18, y: 0.34 },
    { id: 2, name: 'CNC-07', type: 'Device', x: 0.52, y: 0.46 },
    { id: 3, name: 'HQ Office', type: 'Office', x: 0.75, y: 0.62 },
    { id: 4, name: 'Spare Parts', type: 'Warehouse', x: 0.33, y: 0.78 },
  ]

  private getMarkerColor(type: string): string {
    if (type === 'Warehouse') return AppTokens.Colors.tertiary
    if (type === 'Device') return AppTokens.Colors.secondary
    return AppTokens.Colors.primary
  }

  private toggleCat(c: string) {
    if (this.enabledCats.includes(c)) {
      this.enabledCats = this.enabledCats.filter(item => item !== c)
    } else {
      this.enabledCats.push(c)
    }
  }

  private getSelectedName(): string {
    if (this.selectedId === null) return 'None'
    const marker = this.markers.find(m => m.id === this.selectedId)
    return marker ? marker.name : 'None'
  }

  build() {
    Column() {
      Row() {
        Text('Asset Inventory')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Column() {
        Scroll() {
          Row() {
            ForEach(this.categories, (c: string) => {
              Text(c)
                .fontSize(this.enabledCats.includes(c) ? AppTokens.TypographyTokens.title.fontSize : AppTokens.TypographyTokens.body.fontSize)
                .fontWeight(this.enabledCats.includes(c) ? AppTokens.TypographyTokens.title.fontWeight : AppTokens.TypographyTokens.body.fontWeight)
                .fontColor(this.enabledCats.includes(c) ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .backgroundColor(this.enabledCats.includes(c) ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .borderRadius(AppTokens.Shapes.small)
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .margin({ right: AppTokens.Spacing.sm })
                .onClick(() => {
                  this.toggleCat(c)
                })
            }, (c: string) => c)
          }
        }
        .scrollDirection(ScrollDirection.Horizontal)
        .width('100%')

        Row() {
          Column() {
            TextInput({ text: this.assetName, placeholder: 'Asset Name' })
              .width('100%')
              .height(48)
              .borderRadius(AppTokens.Shapes.medium)
              .border({ width: 1, color: AppTokens.Colors.outline })
              .backgroundColor(AppTokens.Colors.surface)
              .fontColor(AppTokens.Colors.onSurface)
              .fontSize(AppTokens.TypographyTokens.body.fontSize)
              .onChange((value: string) => {
                this.assetName = value
              })

            TextInput({ text: this.assetCode, placeholder: 'Asset Code' })
              .width('100%')
              .height(48)
              .borderRadius(AppTokens.Shapes.medium)
              .border({ width: 1, color: AppTokens.Colors.outline })
              .backgroundColor(AppTokens.Colors.surface)
              .fontColor(AppTokens.Colors.onSurface)
              .fontSize(AppTokens.TypographyTokens.body.fontSize)
              .margin({ top: AppTokens.Spacing.md })
              .onChange((value: string) => {
                this.assetCode = value
              })

            TextInput({ text: this.assetType, placeholder: 'Asset Type' })
              .width('100%')
              .height(48)
              .borderRadius(AppTokens.Shapes.medium)
              .border({ width: 1, color: AppTokens.Colors.outline })
              .backgroundColor(AppTokens.Colors.surface)
              .fontColor(AppTokens.Colors.onSurface)
              .fontSize(AppTokens.TypographyTokens.body.fontSize)
              .margin({ top: AppTokens.Spacing.md })
              .onChange((value: string) => {
                this.assetType = value
              })

            Column() {
              Text('Selected')
                .fontSize(AppTokens.TypographyTokens.label.fontSize)
                .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)

              Text(this.getSelectedName())
                .fontSize(AppTokens.TypographyTokens.headline.fontSize)
                .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ top: AppTokens.Spacing.sm })
            }
            .width('100%')
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`, offsetY: AppTokens.ElevationMapping.level1.dy })
            .margin({ top: AppTokens.Spacing.md })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          Stack() {
            ForEach([0, 1, 2, 3, 4, 5], (i: number) => {
              Column()
                .width('100%')
                .height(1)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .position({ x: 0, y: 30 + i * 45 })
            }, (i: number) => `h${i}`)

            ForEach([0, 1, 2, 3, 4, 5], (i: number) => {
              Column()
                .width(1)
                .height('100%')
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .position({ x: 20 + i * 45, y: 0 })
            }, (i: number) => `v${i}`)

            ForEach(this.markers, (m: AssetMarker) => {
              if (this.enabledCats.includes(m.type)) {
                Column()
                  .width(this.selectedId === m.id ? 28 : 22)
                  .height(this.selectedId === m.id ? 28 : 22)
                  .backgroundColor(this.getMarkerColor(m.type))
                  .borderRadius(this.selectedId === m.id ? 14 : 11)
                  .border({ width: 2, color: this.selectedId === m.id ? AppTokens.Colors.primary : AppTokens.Colors.surface })
                  .position({ x: `${m.x * 100}%`, y: `${m.y * 100}%` })
                  .markAnchor({ x: '50%', y: '50%' })
                  .onClick(() => {
                    this.selectedId = this.selectedId === m.id ? null : m.id
                  })
              }
            }, (m: AssetMarker) => m.id.toString())
          }
          .layoutWeight(1)
          .height(360)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .margin({ left: AppTokens.Spacing.lg })
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)
        .margin({ top: AppTokens.Spacing.lg })
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })

      Row() {
        Button('Reset')
          .type(ButtonType.Normal)
          .layoutWeight(1)
          .height(48)
          .borderRadius(AppTokens.Shapes.medium)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .onClick(() => {
            this.assetName = ''
            this.assetCode = ''
            this.assetType = 'Device'
            this.selectedId = null
          })

        Button('Save Asset')
          .type(ButtonType.Normal)
          .layoutWeight(1)
          .height(48)
          .borderRadius(AppTokens.Shapes.medium)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .margin({ left: AppTokens.Spacing.md })
      }
      .width('100%')
      .height(64)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
      .alignItems(VerticalAlign.Center)
      .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: -AppTokens.ElevationMapping.level2.dy })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}