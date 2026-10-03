import { CanvasRenderingContext2D, RenderingContextSettings } from '@kit.ArkUI'

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF7B00'
    export const secondary: string = '#FFD166'
    export const background: string = '#FFF6E5'
    export const surface: string = '#FFFFFF'
    export const surfaceVariant: string = '#FFF0C1'
    export const outline: string = '#E0C080'
    export const onPrimary: string = '#FFFFFF'
    export const onSecondary: string = '#3E2723'
    export const onBackground: string = '#3E2723'
    export const onSurface: string = '#3E2723'
  }

  export namespace TypographyTokens {
    export const displaySize: number = 28
    export const headlineSize: number = 20
    export const titleSize: number = 16
    export const bodySize: number = 14
    export const labelSize: number = 12
    export const labelFontSize: number = 12
  }

  export namespace Shapes {
    export const small: number = 6
    export const medium: number = 10
    export const large: number = 14
  }

  export namespace Spacing {
    export const sm: number = 8
    export const md: number = 12
    export const lg: number = 16
  }

  export namespace ElevationMapping {
    export const level2Radius: number = 8
    export const level2Dy: number = 4
    export const level2Opacity: number = 0.12
  }
}

class ResultItem {
  id: number
  title: string

  constructor(id: number, title: string) {
    this.id = id
    this.title = title
  }
}

@Component
struct CardView {
  item: ResultItem = new ResultItem(0, '')

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Rect()
        .width(96)
        .height(96)
        .fill(AppTokens.Colors.surfaceVariant)
        .radius(AppTokens.Shapes.medium)

      Text(this.item.title)
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      Button('Add', { type: ButtonType.Normal, stateEffect: true })
        .width('100%')
        .height(48)
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level2Radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2Opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2Dy
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State private query: string = ''
  @State private knobOffsetX: number = 144
  @State private knobOffsetY: number = 104
  @State private isTextFieldFocused: boolean = false
  @State private canvasWidth: number = 0
  @State private canvasHeight: number = 0

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private results: ResultItem[] = [
    new ResultItem(0, 'Result 1'),
    new ResultItem(1, 'Result 2'),
    new ResultItem(2, 'Result 3'),
    new ResultItem(3, 'Result 4'),
    new ResultItem(4, 'Result 5'),
    new ResultItem(5, 'Result 6')
  ]

  private drawCanvas(): void {
    const width: number = this.canvasWidth
    const height: number = this.canvasHeight

    if (width <= 0 || height <= 0) {
      return
    }

    this.context.clearRect(0, 0, width, height)

    this.context.fillStyle = AppTokens.Colors.surfaceVariant
    this.context.fillRect(0, 0, width, height)

    const centerX: number = width / 2
    const centerY: number = height / 2
    const gradient: CanvasGradient = this.context.createRadialGradient(centerX, centerY, 0, centerX, centerY, 60)
    gradient.addColorStop(0, AppTokens.Colors.secondary)
    gradient.addColorStop(1, AppTokens.Colors.primary)

    this.context.beginPath()
    this.context.arc(centerX, centerY, 60, 0, Math.PI * 2)
    this.context.fillStyle = gradient
    this.context.fill()

    this.context.beginPath()
    this.context.arc(this.knobOffsetX, this.knobOffsetY, 16, 0, Math.PI * 2)
    this.context.fillStyle = AppTokens.Colors.primary
    this.context.fill()
  }

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.md }) {
        Text('Retro Filter Search')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        TextInput({
          placeholder: 'Search products',
          text: this.query
        })
          .height(56)
          .width('100%')
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppTokens.Colors.onSurface)
          .placeholderColor('rgba(62, 39, 35, 0.4)')
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg
          })
          .border({
            width: 1,
            color: this.isTextFieldFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline
          })
          .onChange((value: string) => {
            this.query = value
          })
          .onFocus(() => {
            this.isTextFieldFocused = true
          })
          .onBlur(() => {
            this.isTextFieldFocused = false
          })

        Row({ space: AppTokens.Spacing.sm }) {
          ForEach(['Popular', 'New', 'Discount', 'Premium'], (text: string) => {
            Button(text, { type: ButtonType.Normal, stateEffect: true })
              .height(36)
              .padding({
                left: AppTokens.Spacing.md,
                right: AppTokens.Spacing.md
              })
              .fontSize(AppTokens.TypographyTokens.labelSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSecondary)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.small)
          }, (text: string) => text)
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)

        Stack() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawCanvas()
            })
            .onAreaChange((_oldValue: Area, newValue: Area) => {
              this.canvasWidth = Number(newValue.width)
              this.canvasHeight = Number(newValue.height)
              this.drawCanvas()
            })
            .gesture(
              PanGesture()
                .onActionUpdate((event: GestureEvent) => {
                  const minX: number = 8
                  const maxX: number = 8
                  const minY: number = 8
                  const maxY: number = 8

                  const localX: number = event.fingerList && event.fingerList.length > 0 ? event.fingerList[0].localX : this.knobOffsetX
                  const localY: number = event.fingerList && event.fingerList.length > 0 ? event.fingerList[0].localY : this.knobOffsetY

                  this.knobOffsetX = Math.max(minX, Math.min(localX, maxX))
                  this.knobOffsetY = Math.max(minY, Math.min(localY, maxY))
                  this.drawCanvas()
                })
            )
        }
        .width('100%')
        .height(180)
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)

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
        .padding({ bottom: 24 })
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