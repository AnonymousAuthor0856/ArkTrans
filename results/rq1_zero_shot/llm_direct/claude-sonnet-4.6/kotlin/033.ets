import { router } from '@kit.ArkUI'

// Design tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#06B6D4'
    export const secondary: string = '#3B82F6'
    export const tertiary: string = '#8B5CF6'
    export const background: string = '#F0F9FF'
    export const surface: string = '#FFFFFF'
    export const surfaceVariant: string = '#E0F2FE'
    export const outline: string = '#BAE6FD'
    export const success: string = '#22C55E'
    export const warning: string = '#FACC15'
    export const error: string = '#EF4444'
    export const onPrimary: string = '#FFFFFF'
    export const onSecondary: string = '#FFFFFF'
    export const onTertiary: string = '#FFFFFF'
    export const onBackground: string = '#0F172A'
    export const onSurface: string = '#0F172A'
  }

  export namespace Spacing {
    export const sm: number = 8
    export const md: number = 12
    export const lg: number = 16
    export const xl: number = 24
    export const xxl: number = 32
  }

  export namespace Shapes {
    export const small: number = 6
    export const medium: number = 12
    export const large: number = 20
  }
}

@Entry
@Component
struct RootScreen {
  @State spending: number = 500
  private goal: number = 1000

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Bill Calendar')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main Content
      Stack() {
        // Gradient background
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [
              ['#4D3B82F6', 0.0],
              [AppTokens.Colors.background, 0.5],
              ['#3306B6D4', 1.0]
            ]
          })

        // Content
        Column({ space: AppTokens.Spacing.lg }) {

          // Spending Card
          Column({ space: AppTokens.Spacing.lg }) {
            Text('Current Spending')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.primary)

            Text(`$${Math.floor(this.spending)} / $${Math.floor(this.goal)}`)
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.onSurface)

            // Progress Bar
            Stack({ alignContent: Alignment.Start }) {
              Row()
                .width('100%')
                .height(8)
                .borderRadius(4)
                .backgroundColor(AppTokens.Colors.surfaceVariant)

              Row()
                .width(`${Math.min(this.spending / this.goal, 1) * 100}%`)
                .height(8)
                .borderRadius(4)
                .backgroundColor(AppTokens.Colors.primary)
            }
            .width('100%')
            .height(8)
          }
          .width('100%')
          .height(160)
          .padding(AppTokens.Spacing.lg)
          .backgroundColor('#E6FFFFFF')
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: 8,
            color: '#2E000000',
            offsetX: 0,
            offsetY: 4
          })
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(HorizontalAlign.Start)

          // Adjust Spending Label
          Text('Adjust Spending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .alignSelf(ItemAlign.Start)

          // Slider
          Slider({
            value: this.spending,
            min: 0,
            max: 2000,
            step: 1,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .trackColor(AppTokens.Colors.surfaceVariant)
            .selectedColor(AppTokens.Colors.primary)
            .blockColor(AppTokens.Colors.secondary)
            .onChange((value: number) => {
              this.spending = value
            })

          // Reset Button
          Button('Reset')
            .width('100%')
            .height(48)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onTertiary)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.spending = 0
            })

        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}