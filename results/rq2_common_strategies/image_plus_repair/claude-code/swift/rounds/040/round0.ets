@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}

class AppTokens {
  static readonly Colors = class {
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

  static readonly Shapes = class {
    static readonly small: number = 6
    static readonly medium: number = 10
    static readonly large: number = 14
  }

  static readonly Spacing = class {
    static readonly sm: number = 8
    static readonly md: number = 12
    static readonly lg: number = 16
  }
}

interface ResultItem {
  id: number
  title: string
}

@Component
struct CardView {
  item: ResultItem

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      RoundRect({ width: 96, height: 96, radius: AppTokens.Shapes.medium })
        .fill(AppTokens.Colors.surfaceVariant)

      Text(this.item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      Button('Add')
        .width('100%')
        .height(48)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: 8,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: 4
    })
    .width('100%')
  }
}

@Component
struct RootScreen {
  @State query: string = ''
  @State knobOffsetX: number = 144
  @State knobOffsetY: number = 104
  @State isTextFieldFocused: boolean = false

  private results: ResultItem[] = Array.from({ length: 6 }, (_, i) => ({
    id: i,
    title: `Result ${i + 1}`
  }))

  private filterLabels: string[] = ['Popular', 'New', 'Discount', 'Premium']

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.md }) {
        Text('Retro Filter Search')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')

        TextInput({ placeholder: 'Search products', text: this.$query })
          .fontSize(14)
          .fontColor(AppTokens.Colors.onSurface)
          .placeholderColor('rgba(62, 39, 35, 0.4)')
          .placeholderFont({ size: 14 })
          .height(56)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.medium)
          .border({
            width: 1,
            color: this.isTextFieldFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline
          })
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .onFocus(() => { this.isTextFieldFocused = true })
          .onBlur(() => { this.isTextFieldFocused = false })

        Row({ space: AppTokens.Spacing.sm }) {
          ForEach(this.filterLabels, (label: string) => {
            Button(label)
              .height(36)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSecondary)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.small)
              .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          }, (label: string) => label)
        }
        .width('100%')

        Stack() {
          Stack() {
            Canvas() {
              Rect('variantRect')
                .width('100%')
                .height('100%')
                .fill(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.medium)

              RadialGradient('sunGrad', [
                [AppTokens.Colors.secondary, 0.0],
                [AppTokens.Colors.primary, 1.0]
              ])

              Circle('sun')
                .width(120)
                .height(120)
                .fill('sunGrad')
                .translate(['50%', '50%'])

              Circle('knob')
                .width(32)
                .height(32)
                .fill(AppTokens.Colors.primary)
                .position([this.knobOffsetX, this.knobOffsetY])
            }
            .width('100%')
            .height('100%')
            .gesture(
              PanGesture()
                .onActionUpdate((event: GestureEvent) => {
                  const canvasWidth = 300
                  const canvasHeight = 148
                  const padding = AppTokens.Spacing.lg
                  const knobRadius = 16
                  const minX = knobRadius
                  const maxX = canvasWidth - padding * 2 - knobRadius
                  const minY = knobRadius
                  const maxY = canvasHeight - padding * 2 - knobRadius
                  this.knobOffsetX = Math.max(minX, Math.min(event.localX, maxX))
                  this.knobOffsetY = Math.max(minY, Math.min(event.localY, maxY))
                })
            )
          }
          .padding(AppTokens.Spacing.lg)
          .width('100%')
          .height('100%')
        }
        .height(180)
        .width('100%')
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
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
        .columnsGap(AppTokens.Spacing.lg)
        .rowsGap(AppTokens.Spacing.lg)
        .width('100%')
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
