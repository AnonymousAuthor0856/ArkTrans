class AppColors {
  static readonly primary: string = '#FF7B00'
  static readonly secondary: string = '#FFD166'
  static readonly background: string = '#FFF6E5'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#FFF0C1'
  static readonly outline: string = '#E0C080'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#3E2723'
  static readonly onBackground: string = '#3E2723'
  static readonly onSurface: string = '#3E2723'
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 14
}

class AppSpacing {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
}

interface ResultItem {
  id: number
  title: string
}

interface FilterChip {
  label: string
}

@Component
struct CardView {
  @Prop item: ResultItem = { id: 0, title: '' }

  build() {
    Column({ space: AppSpacing.sm }) {
      Row() {}
        .width(96)
        .height(96)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)

      Text(this.item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Button('Add')
        .width('100%')
        .height(48)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
    }
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 8,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: 4
    })
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

interface PanEvent extends GestureEvent {
  offsetX: number
  offsetY: number
}

@Component
struct RootScreen {
  @State query: string = ''
  @State knobX: number = 144
  @State knobY: number = 104
  @State startKnobX: number = 144
  @State startKnobY: number = 104
  @State isTextFieldFocused: boolean = false

  private results: ResultItem[] = [
    { id: 0, title: 'Result 1' },
    { id: 1, title: 'Result 2' },
    { id: 2, title: 'Result 3' },
    { id: 3, title: 'Result 4' },
    { id: 4, title: 'Result 5' },
    { id: 5, title: 'Result 6' }
  ]

  private filterLabels: FilterChip[] = [
    { label: 'Popular' },
    { label: 'New' },
    { label: 'Discount' },
    { label: 'Premium' }
  ]

  private onPanStart(): void {
    this.startKnobX = this.knobX
    this.startKnobY = this.knobY
  }

  private onPanUpdate(event: PanEvent): void {
    const knobRadius: number = 16
    const minVal: number = knobRadius
    const maxX: number = 260
    const maxY: number = 116
    const dx: number = event.offsetX
    const dy: number = event.offsetY
    this.knobX = Math.max(minVal, Math.min(this.startKnobX + dx, maxX))
    this.knobY = Math.max(minVal, Math.min(this.startKnobY + dy, maxY))
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Scroll() {
        Column({ space: AppSpacing.md }) {
          Text('Retro Filter Search')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)
            .width('100%')

          TextInput({ placeholder: 'Search products', text: this.$query })
            .fontSize(14)
            .fontColor(AppColors.onSurface)
            .placeholderColor('rgba(62, 39, 35, 0.4)')
            .placeholderFont({ size: 14 })
            .height(56)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.medium)
            .border({
              width: 1,
              color: this.isTextFieldFocused ? AppColors.primary : AppColors.outline
            })
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            .onFocus(() => { this.isTextFieldFocused = true })
            .onBlur(() => { this.isTextFieldFocused = false })

          Scroll() {
            Row({ space: AppSpacing.sm }) {
              ForEach(this.filterLabels, (chip: FilterChip) => {
                Button(chip.label)
                  .height(36)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSecondary)
                  .backgroundColor(AppColors.secondary)
                  .borderRadius(AppShapes.small)
                  .padding({ left: AppSpacing.md, right: AppSpacing.md })
              }, (chip: FilterChip) => chip.label)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Stack({ alignContent: Alignment.TopStart }) {
            Stack({ alignContent: Alignment.Center }) {
              Row() {}
                .width(120)
                .height(120)
                .borderRadius(60)
                .radialGradient({
                  center: [0.5, 0.5],
                  radius: 0.5,
                  colors: [[AppColors.secondary, 0], [AppColors.primary, 1]]
                })

              Row() {}
                .width(32)
                .height(32)
                .borderRadius(16)
                .backgroundColor(AppColors.primary)
                .position({ x: this.knobX - 16, y: this.knobY - 16 })
            }
            .width('100%')
            .height('100%')
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.medium)
            .padding(AppSpacing.lg)
            .gesture(
              PanGesture()
                .onActionStart(() => { this.onPanStart() })
                .onActionUpdate((event: GestureEvent) => { this.onPanUpdate(event as PanEvent) })
            )
          }
          .height(180)
          .width('100%')
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .shadow({
            radius: 8,
            color: 'rgba(0, 0, 0, 0.12)',
            offsetX: 0,
            offsetY: 4
          })

          Grid() {
            ForEach(this.results, (item: ResultItem) => {
              GridItem() {
                CardView({ item: item })
              }
            }, (item: ResultItem) => item.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppSpacing.lg)
          .rowsGap(AppSpacing.lg)
          .width('100%')
          .padding({ bottom: 24 })
        }
        .padding(AppSpacing.lg)
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    Stack() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}
