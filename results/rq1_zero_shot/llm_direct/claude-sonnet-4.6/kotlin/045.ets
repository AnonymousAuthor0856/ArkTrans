import { router } from '@kit.ArkUI'

// Design Tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#8E6BF2'
    export const secondary: string = '#D3C1FF'
    export const tertiary: string = '#B39DDB'
    export const background: string = '#F5F3FF'
    export const surface: string = '#FFFFFF'
    export const surfaceVariant: string = '#ECE6F8'
    export const outline: string = '#D1C4E9'
    export const success: string = '#4CAF50'
    export const warning: string = '#FFB300'
    export const error: string = '#E53935'
    export const onPrimary: string = '#FFFFFF'
    export const onSecondary: string = '#2E1A47'
    export const onBackground: string = '#2E1A47'
    export const onSurface: string = '#2E1A47'
  }

  export namespace Spacing {
    export const sm: number = 6
    export const md: number = 10
    export const lg: number = 16
    export const xl: number = 24
  }

  export namespace Radius {
    export const small: number = 8
    export const medium: number = 14
    export const large: number = 20
  }
}

@Entry
@Component
struct RootScreen {
  @State orderId: string = ''
  @State issue: string = ''
  @State submitted: boolean = false

  build() {
    Scroll() {
      Column({ space: AppTokens.Spacing.lg }) {

        // Title
        Text('After-Sale Service')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')

        // Card: Order ID + Issue Description
        Column({ space: AppTokens.Spacing.md }) {

          // Order ID Label
          Text('Order ID')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')

          // Order ID TextField
          TextInput({ placeholder: 'Enter order number', text: this.orderId })
            .placeholderColor(`${AppTokens.Colors.onSurface}80`)
            .placeholderFont({ size: 14 })
            .fontSize(14)
            .fontColor(AppTokens.Colors.onSurface)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Radius.medium)
            .borderWidth(1)
            .borderColor(AppTokens.Colors.outline)
            .width('100%')
            .height(48)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
            .onChange((value: string) => {
              this.orderId = value
            })

          // Issue Description Label
          Text('Issue Description')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')

          // Issue Description TextArea
          TextArea({ placeholder: 'Describe your issue', text: this.issue })
            .placeholderColor(`${AppTokens.Colors.onSurface}80`)
            .placeholderFont({ size: 14 })
            .fontSize(14)
            .fontColor(AppTokens.Colors.onSurface)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Radius.medium)
            .borderWidth(1)
            .borderColor(AppTokens.Colors.outline)
            .width('100%')
            .height(120)
            .padding({
              left: AppTokens.Spacing.md,
              right: AppTokens.Spacing.md,
              top: AppTokens.Spacing.sm,
              bottom: AppTokens.Spacing.sm
            })
            .onChange((value: string) => {
              this.issue = value
            })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Radius.large)
        .shadow({
          radius: 12,
          color: AppTokens.Colors.secondary,
          offsetX: 0,
          offsetY: 4
        })

        // Submit Button
        Button('Submit Request')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Radius.large)
          .width('100%')
          .height(56)
          .onClick(() => {
            this.submitted = true
          })

        // Success Banner
        if (this.submitted) {
          Row() {
            Text('Request submitted successfully!')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppTokens.Colors.success)
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding(AppTokens.Spacing.lg)
          .backgroundColor('#264CAF50')
          .borderRadius(AppTokens.Radius.medium)
        }
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .scrollBar(BarState.Off)
  }
}