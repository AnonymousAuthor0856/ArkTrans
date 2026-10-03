import { LengthMetrics } from '@kit.ArkUI'

// Token definitions
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF111827'
    export const secondary: string = '#FF374151'
    export const tertiary: string = '#FF6B7280'
    export const background: string = '#FFF9FAFB'
    export const surface: string = '#FFFFFFFF'
    export const surfaceVariant: string = '#FFE5E7EB'
    export const outline: string = '#FFD1D5DB'
    export const success: string = '#FF16A34A'
    export const warning: string = '#FFF59E0B'
    export const error: string = '#FFEF4444'
    export const onPrimary: string = '#FFFFFFFF'
    export const onSecondary: string = '#FFFFFFFF'
    export const onTertiary: string = '#FF111827'
    export const onBackground: string = '#FF111827'
    export const onSurface: string = '#FF1F2937'
  }

  export namespace TypographyTokens {
    export const displaySize: number = 28
    export const headlineSize: number = 20
    export const titleSize: number = 16
    export const bodySize: number = 14
    export const labelSize: number = 12
  }

  export namespace Spacing {
    export const xs: number = 4
    export const sm: number = 8
    export const md: number = 12
    export const lg: number = 16
    export const xl: number = 24
    export const xxl: number = 36
  }

  export namespace ShapeRadius {
    export const small: number = 8
    export const medium: number = 12
    export const large: number = 16
  }
}

interface Medicine {
  id: number
  name: string
  time: string
}

@Component
struct MedicineItem {
  medicine: Medicine = { id: 0, name: '', time: '' }

  build() {
    Row() {
      Column() {
        Text(this.medicine.name)
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.medicine.time)
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xs })
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)

      Circle()
        .width(16)
        .height(16)
        .fill(AppTokens.Colors.primary)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.ShapeRadius.medium)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.ShapeRadius.medium })
    .padding(AppTokens.Spacing.md)
  }
}

@Component
struct MedicineList {
  private medicines: Medicine[] = [
    { id: 1, name: 'Vitamin C', time: '08:00 AM' },
    { id: 2, name: 'Aspirin', time: '12:30 PM' },
    { id: 3, name: 'Insulin', time: '06:00 PM' },
    { id: 4, name: 'Melatonin', time: '10:00 PM' }
  ]

  build() {
    List({ space: AppTokens.Spacing.md }) {
      ForEach(this.medicines, (medicine: Medicine) => {
        ListItem() {
          MedicineItem({ medicine: medicine })
        }
      }, (medicine: Medicine) => medicine.id.toString())
    }
    .width('100%')
    .layoutWeight(1)
    .scrollBar(BarState.Off)
    .contentEndOffset(AppTokens.Spacing.xxl)
  }
}

@Component
struct BottomBar {
  build() {
    Row() {
      Text('Today')
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.primary)

      Text('History')
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      Text('Profile')
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
    .height(56)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 8, color: '#22000000', offsetY: -2 })
  }
}

@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // Main content area
        Column() {
          Text('Medicine Reminder')
            .fontSize(AppTokens.TypographyTokens.displaySize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onBackground)
            .margin({ bottom: AppTokens.Spacing.md })

          MedicineList()

          Blank().height(AppTokens.Spacing.md)

          Button('Mark All Taken')
            .width('80%')
            .height(48)
            .borderRadius(AppTokens.ShapeRadius.large)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: AppTokens.Spacing.md })
        }
        .width('100%')
        .layoutWeight(1)
        .padding(AppTokens.Spacing.lg)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Start)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [[0xFFE5E7EB, 0.0], [0xFFFFFFFF, 1.0]]
        })

        // Bottom bar
        BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      // Floating Action Button
      Button('+')
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontWeight(FontWeight.Bold)
        .margin({ right: AppTokens.Spacing.lg, bottom: 72 })
        .shadow({ radius: 8, color: '#33000000', offsetY: 4 })
    }
    .width('100%')
    .height('100%')
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}