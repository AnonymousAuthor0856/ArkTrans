interface AssetMarker {
  id: number
  name: string
  type: string
  x: number
  y: number
}

class AppTokens {
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

  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
  static readonly xxxl: number = 48

  static readonly radiusSmall: number = 8
  static readonly radiusMedium: number = 12
  static readonly radiusLarge: number = 16
}

@Entry
@Component
struct Index {
  @State categories: string[] = ['Warehouse', 'Device', 'Office']
  @State enabledCats: string[] = ['Warehouse', 'Device', 'Office']
  @State assetName: string = ''
  @State assetCode: string = ''
  @State assetType: string = 'Device'
  @State selectedId: number = -1

  private markers: AssetMarker[] = [
    { id: 1, name: 'Main Warehouse', type: 'Warehouse', x: 0.18, y: 0.34 },
    { id: 2, name: 'CNC-07', type: 'Device', x: 0.52, y: 0.46 },
    { id: 3, name: 'HQ Office', type: 'Office', x: 0.75, y: 0.62 },
    { id: 4, name: 'Spare Parts', type: 'Warehouse', x: 0.33, y: 0.78 }
  ]

  private isCategoryEnabled(category: string): boolean {
    return this.enabledCats.indexOf(category) >= 0
  }

  private toggleCategory(category: string): void {
    const index = this.enabledCats.indexOf(category)
    if (index >= 0) {
      this.enabledCats.splice(index, 1)
      this.enabledCats = [...this.enabledCats]
    } else {
      this.enabledCats = [...this.enabledCats, category]
    }
  }

  private resetForm(): void {
    this.assetName = ''
    this.assetCode = ''
    this.assetType = 'Device'
    this.selectedId = -1
  }

  private getSelectedName(): string {
    if (this.selectedId < 0) {
      return 'None'
    }
    const found = this.markers.find((item: AssetMarker) => item.id === this.selectedId)
    return found ? found.name : 'None'
  }

  private markerColor(type: string): string {
    if (type === 'Warehouse') {
      return AppTokens.tertiary
    }
    if (type === 'Device') {
      return AppTokens.secondary
    }
    return AppTokens.primary
  }

  @Builder
  DisplayText(value: string) {
    Text(value)
      .fontSize(28)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppTokens.onSurface)
      .lineHeight(34)
  }

  @Builder
  HeadlineText(value: string) {
    Text(value)
      .fontSize(20)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppTokens.onSurface)
      .lineHeight(26)
  }

  @Builder
  TitleText(value: string, color: string = AppTokens.onSurface) {
    Text(value)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(color)
      .lineHeight(22)
  }

  @Builder
  BodyText(value: string, color: string = AppTokens.onSurface) {
    Text(value)
      .fontSize(14)
      .fontWeight(FontWeight.Regular)
      .fontColor(color)
      .lineHeight(20)
  }

  @Builder
  LabelText(value: string, color: string = AppTokens.onSurface) {
    Text(value)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(color)
      .lineHeight(16)
  }

  @Builder
  FilterChipItem(category: string) {
    Text(category)
      .fontSize(this.isCategoryEnabled(category) ? 16 : 14)
      .fontWeight(this.isCategoryEnabled(category) ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.isCategoryEnabled(category) ? AppTokens.onPrimary : AppTokens.onSurface)
      .lineHeight(this.isCategoryEnabled(category) ? 22 : 20)
      .padding({
        left: AppTokens.md,
        right: AppTokens.md,
        top: AppTokens.sm,
        bottom: AppTokens.sm
      })
      .backgroundColor(this.isCategoryEnabled(category) ? AppTokens.primary : AppTokens.surface)
      .borderRadius(AppTokens.radiusSmall)
      .border({
        width: 1,
        color: AppTokens.outline
      })
      .onClick(() => {
        this.toggleCategory(category)
      })
  }

  @Builder
  LabeledInput(label: string, value: string, onChange: (value: string) => void) {
    Column({ space: AppTokens.xs }) {
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onSurface)
        .lineHeight(16)

      TextInput({
        text: value,
        placeholder: label
      })
        .height(52)
        .width('100%')
        .fontSize(14)
        .fontColor(AppTokens.onSurface)
        .placeholderColor('#777777')
        .backgroundColor(AppTokens.surfaceVariant)
        .borderRadius(AppTokens.radiusSmall)
        .padding({
          left: AppTokens.md,
          right: AppTokens.md
        })
        .onChange((text: string) => {
          onChange(text)
        })
    }
    .width('100%')
  }

  @Builder
  SelectedCard() {
    Column({ space: AppTokens.sm }) {
      this.LabelText('Selected')
      this.HeadlineText(this.getSelectedName())
    }
    .width('100%')
    .padding(AppTokens.lg)
    .backgroundColor(AppTokens.surface)
    .borderRadius(AppTokens.radiusLarge)
    .border({
      width: 1,
      color: AppTokens.outline
    })
    .shadow({
      radius: 4,
      color: '#1A000000',
      offsetY: 2
    })
  }

  @Builder
  MapGridOverlay() {
    Stack() {
      Column({ space: 0 }) {
        ForEach([0, 1, 2, 3, 4, 5], (_: number) => {
          Divider()
            .strokeWidth(1)
            .color(AppTokens.surfaceVariant)
            .width('100%')
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.lg)
      .justifyContent(FlexAlign.SpaceEvenly)

      Row({ space: 0 }) {
        ForEach([0, 1, 2, 3, 4, 5], (_: number) => {
          Divider()
            .vertical(true)
            .strokeWidth(1)
            .color(AppTokens.surfaceVariant)
            .height('100%')
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.lg)
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  MapMarker(marker: AssetMarker) {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle()
        .width(this.selectedId === marker.id ? 28 : 22)
        .height(this.selectedId === marker.id ? 28 : 22)
        .fill(this.markerColor(marker.type))
        .stroke(this.selectedId === marker.id ? AppTokens.primary : AppTokens.surface)
        .strokeWidth(2)
        .onClick(() => {
          this.selectedId = this.selectedId === marker.id ? -1 : marker.id
        })

      Text(marker.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onSurface)
        .lineHeight(16)
        .padding({
          left: AppTokens.sm,
          right: AppTokens.sm,
          top: AppTokens.xs,
          bottom: AppTokens.xs
        })
        .backgroundColor(AppTokens.surface)
        .borderRadius(AppTokens.radiusSmall)
        .border({
          width: 1,
          color: AppTokens.outline
        })
        .shadow({
          radius: 4,
          color: '#1A000000',
          offsetY: 2
        })
        .position({
          x: 18,
          y: -4
        })
        .onClick(() => {
          this.selectedId = this.selectedId === marker.id ? -1 : marker.id
        })
    }
    .width(120)
    .height(40)
    .position({
      x: `${marker.x * 100}%`,
      y: `${marker.y * 100}%`
    })
  }

  @Builder
  MapPanel() {
    Stack({ alignContent: Alignment.TopStart }) {
      this.MapGridOverlay()

      ForEach(this.markers.filter((marker: AssetMarker) => this.isCategoryEnabled(marker.type)), (marker: AssetMarker) => {
        this.MapMarker(marker)
      }, (marker: AssetMarker) => marker.id.toString())
    }
    .width('100%')
    .constraintSize({
      minHeight: 360
    })
    .aspectRatio(0.9)
    .backgroundColor(AppTokens.surface)
    .borderRadius(AppTokens.radiusLarge)
    .border({
      width: 1,
      color: AppTokens.outline
    })
  }

  @Builder
  TopBar() {
    Row() {
      this.DisplayText('Asset Inventory')
    }
    .width('100%')
    .height(80)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.surface)
  }

  @Builder
  BottomBar() {
    Row({ space: AppTokens.md }) {
      Button({ type: ButtonType.Normal, stateEffect: true }) {
        this.TitleText('Reset', AppTokens.onSurface)
      }
      .height(48)
      .layoutWeight(1)
      .borderRadius(AppTokens.radiusMedium)
      .backgroundColor(AppTokens.surfaceVariant)
      .onClick(() => {
        this.resetForm()
      })

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        this.TitleText('Save Asset', AppTokens.onPrimary)
      }
      .height(48)
      .layoutWeight(1)
      .borderRadius(AppTokens.radiusMedium)
      .backgroundColor(AppTokens.primary)
      .onClick(() => {
      })
    }
    .width('100%')
    .padding({
      left: AppTokens.lg,
      right: AppTokens.lg,
      top: AppTokens.md,
      bottom: AppTokens.md
    })
    .backgroundColor(AppTokens.surface)
    .shadow({
      radius: 8,
      color: '#24000000',
      offsetY: -4
    })
  }

  build() {
    Column() {
      this.TopBar()

      Column({ space: AppTokens.lg }) {
        Scroll() {
          Row({ space: AppTokens.sm }) {
            ForEach(this.categories, (category: string) => {
              this.FilterChipItem(category)
            }, (category: string) => category)
          }
          .padding({
            left: 0,
            right: 0,
            top: 0,
            bottom: 0
          })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')

        Row({ space: AppTokens.lg }) {
          Column({ space: AppTokens.md }) {
            this.LabeledInput('Asset Name', this.assetName, (value: string) => {
              this.assetName = value
            })

            this.LabeledInput('Asset Code', this.assetCode, (value: string) => {
              this.assetCode = value
            })

            this.LabeledInput('Asset Type', this.assetType, (value: string) => {
              this.assetType = value
            })

            this.SelectedCard()
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          Column() {
            this.MapPanel()
          }
          .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppTokens.lg,
        right: AppTokens.lg,
        top: AppTokens.md,
        bottom: AppTokens.md
      })
      .backgroundColor(AppTokens.background)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }
}