import { router } from '@kit.ArkUI'

// Design tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#00FFFF'
    export const secondary: string = '#9D00FF'
    export const tertiary: string = '#00FFA3'
    export const background: string = '#0B0B0D'
    export const surface: string = '#1A1A1D'
    export const surfaceVariant: string = '#2E2E33'
    export const outline: string = '#3F3F46'
    export const success: string = '#22C55E'
    export const warning: string = '#F59E0B'
    export const error: string = '#EF4444'
    export const onPrimary: string = '#000000'
    export const onSecondary: string = '#FFFFFF'
    export const onTertiary: string = '#000000'
    export const onBackground: string = '#E5E7EB'
    export const onSurface: string = '#E5E7EB'
  }

  export namespace Typography {
    export const displaySize: number = 28
    export const titleSize: number = 18
    export const bodySize: number = 14
    export const labelSize: number = 12
  }

  export namespace Spacing {
    export const xs: number = 4
    export const sm: number = 8
    export const md: number = 12
    export const lg: number = 16
    export const xl: number = 24
    export const xxl: number = 32
  }

  export namespace Radius {
    export const small: number = 6
    export const medium: number = 10
    export const large: number = 14
  }
}

@Entry
@Component
struct RootScreen {
  @State title: string = ''
  @State recording: boolean = false
  @State seconds: number = 0
  private timer: number = -1

  startTimer() {
    this.timer = setInterval(() => {
      this.seconds += 1
    }, 1000)
  }

  stopTimer() {
    if (this.timer !== -1) {
      clearInterval(this.timer)
      this.timer = -1
    }
  }

  toggleRecording() {
    this.recording = !this.recording
    if (this.recording) {
      this.seconds = 0
      this.startTimer()
    } else {
      this.stopTimer()
    }
  }

  resetRecording() {
    this.seconds = 0
    if (this.recording) {
      this.stopTimer()
      this.recording = false
    }
  }

  aboutToDisappear() {
    this.stopTimer()
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Neon Recorder')
          .fontSize(AppTokens.Typography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Scrollable content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {

          // Recording Name Input
          Column({ space: 4 }) {
            Text('Recording name')
              .fontSize(AppTokens.Typography.labelSize)
              .fontColor(AppTokens.Colors.onSurface)
              .alignSelf(ItemAlign.Start)

            TextInput({ text: this.title, placeholder: 'Enter recording name...' })
              .width('100%')
              .height(52)
              .fontSize(AppTokens.Typography.bodySize)
              .fontColor(AppTokens.Colors.onSurface)
              .placeholderColor(AppTokens.Colors.outline)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Radius.medium)
              .borderWidth(1)
              .borderColor(AppTokens.Colors.outline)
              .caretColor(AppTokens.Colors.primary)
              .onChange((value: string) => {
                this.title = value
              })
          }
          .width('100%')

          // Recording Status Card
          Column() {
            Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
              .fontSize(AppTokens.Typography.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.recording ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
          }
          .width('100%')
          .height(200)
          .borderRadius(AppTokens.Radius.large)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)

          // Buttons Row
          Row() {
            // Record / Stop Button
            Button(this.recording ? 'Stop' : 'Record')
              .height(52)
              .width(160)
              .fontSize(AppTokens.Typography.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onPrimary)
              .backgroundColor(this.recording ? AppTokens.Colors.error : AppTokens.Colors.primary)
              .borderRadius(AppTokens.Radius.large)
              .onClick(() => {
                this.toggleRecording()
              })

            // Reset Button
            Button('Reset')
              .height(52)
              .width(120)
              .fontSize(AppTokens.Typography.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSecondary)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Radius.large)
              .onClick(() => {
                this.resetRecording()
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)

          // Spacer
          Blank()
            .height(AppTokens.Spacing.xxl)

          // Output Path Text
          Text(`Output Path: /storage/recordings/${this.title.trim() === '' ? 'untitled' : this.title}.mp3`)
            .fontSize(AppTokens.Typography.bodySize)
            .fontColor('#B3E5E7EB')
            .textAlign(TextAlign.Center)
            .width('100%')

        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [0xFF0B0B0D, 0.0],
          [0xFF2E2E33, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}