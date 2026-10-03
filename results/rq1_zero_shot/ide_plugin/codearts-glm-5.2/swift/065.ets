class AppTokens {
  static readonly Colors = {
    primary: '#FF111111',
    secondary: '#FF2A2A2A',
    tertiary: '#FF474747',
    background: '#FFF6F6F6',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFEDEDED',
    outline: '#FFD1D1D1',
    success: '#FF2E7D32',
    warning: '#FFB98900',
    error: '#FFB3261E',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF0A0A0A',
    onSurface: '#FF0A0A0A',
  }
  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Medium },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }
  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16,
  }
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 48,
  }
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
struct MapMarker {
  @Prop type: string
  @Prop selected: boolean
  onSelect: () => void = () => {}

  private getMarkerColor(): string {
    if (this.type === 'Warehouse') return AppTokens.Colors.tertiary
    if (this.type === 'Device') return AppTokens.Colors.secondary
    return AppTokens.Colors.primary
  }

  build() {
    Stack() {
      Circle({ width: this.selected ? 28 : 22, height: this.selected ? 28 : 22 })
        .fill(this.getMarkerColor())
        .border({ width: 2, color: this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface })
        .onClick(() => {
          this.onSelect()
        })

      Text(this.type)
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.small)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
        .position({ x: 18, y: -4 })
    }
  }
}

@Entry
@Component
struct RootScreen {
  @State assetName: string = ''
  @State assetCode: string = ''
  @State assetType: string = 'Device'
  @State selectedId: number = -1
  @State enabledCats: string[] = ['Warehouse', 'Device', 'Office']
  private categories: string[] = ['Warehouse', 'Device', 'Office']
  private markers: AssetMarker[] = [
    new AssetMarker(1, 'Main Warehouse', 'Warehouse', 0.18, 0.34),
    new AssetMarker(2, 'CNC-07', 'Device', 0.52, 0.46),
    new AssetMarker(3, 'HQ Office', 'Office', 0.75, 0.62),
    new AssetMarker(4, 'Spare Parts', 'Warehouse', 0.33, 0.78),
  ]

  private isMarkerVisible(m: AssetMarker): boolean {
    return this.enabledCats.indexOf(m.type) >= 0
  }

  private toggleCat(c: string) {
    const idx = this.enabledCats.indexOf(c)
    if (idx >= 0) {
      this.enabledCats.splice(idx, 1)
    } else {
      this.enabledCats.push(c)
    }
  }

  private getSelectedName(): string {
    for (let i = 0; i < this.markers.length; i++) {
      if (this.markers[i].id === this.selectedId) return this.markers[i].name
    }
    return 'None'
  }

  build() {
    Column() {
      Row() {
        Text('Asset Inventory')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.Center)

      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          Scroll() {
            Row({ space: AppTokens.Spacing.sm }) {
              ForEach(this.categories, (c: string) => {
                Text(c)
                  .fontSize(this.enabledCats.indexOf(c) >= 0 ? AppTokens.Typography.title.size : AppTokens.Typography.body.size)
                  .fontWeight(this.enabledCats.indexOf(c) >= 0 ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
                  .fontColor(this.enabledCats.indexOf(c) >= 0 ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                  .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                  .backgroundColor(this.enabledCats.indexOf(c) >= 0 ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                  .borderRadius(AppTokens.Shapes.small)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .onClick(() => {
                    this.toggleCat(c)
                  })
              })
            }
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
          .margin({ top: AppTokens.Spacing.md })

          Row({ space: AppTokens.Spacing.lg }) {
            Column({ space: AppTokens.Spacing.md }) {
              TextInput({ placeholder: 'Asset Name', text: this.assetName })
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .width('100%')
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .onChange((value: string) => { this.assetName = value })

              TextInput({ placeholder: 'Asset Code', text: this.assetCode })
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .width('100%')
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .onChange((value: string) => { this.assetCode = value })

              TextInput({ placeholder: 'Asset Type', text: this.assetType })
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .width('100%')
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .onChange((value: string) => { this.assetType = value })

              Column({ space: AppTokens.Spacing.sm }) {
                Text('Selected')
                  .fontSize(AppTokens.Typography.label.size)
                  .fontWeight(AppTokens.Typography.label.weight)
                  .fontColor(AppTokens.Colors.onSurface)
                Text(this.getSelectedName())
                  .fontSize(AppTokens.Typography.headline.size)
                  .fontWeight(AppTokens.Typography.headline.weight)
                  .fontColor(AppTokens.Colors.onSurface)
              }
              .width('100%')
              .padding(AppTokens.Spacing.lg)
              .alignItems(HorizontalAlign.Start)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .border({ width: 1, color: AppTokens.Colors.outline })
              .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            Stack() {
              ForEach([0, 1, 2, 3, 4], () => {
                Column()
                  .width('100%')
                  .height(1)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)
              })

              ForEach(this.markers, (m: AssetMarker) => {
                if (this.isMarkerVisible(m)) {
                  MapMarker({
                    type: m.type,
                    selected: this.selectedId === m.id,
                    onSelect: () => {
                      this.selectedId = this.selectedId === m.id ? -1 : m.id
                    }
                  })
                    .position({ x: `${m.x * 100}%`, y: `${m.y * 100}%` })
                }
              })
            }
            .layoutWeight(1)
            .height(300)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppTokens.Colors.background)

      Row({ space: AppTokens.Spacing.md }) {
        Button('Reset')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .height(48)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
            this.assetName = ''
            this.assetCode = ''
            this.assetType = 'Device'
            this.selectedId = -1
          })

        Button('Save Asset')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .layoutWeight(1)
          .height(48)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 8, color: '#24000000', offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}