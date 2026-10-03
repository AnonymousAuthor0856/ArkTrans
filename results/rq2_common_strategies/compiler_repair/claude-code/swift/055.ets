// MARK: - AppTokens
// Design tokens: colors, typography, shapes, spacing, and elevation.

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF2563EB';
    export const secondary: string = '#FF38BDF8';
    export const tertiary: string = '#FF3B82F6';
    export const background: string = '#FFF8FAFC';
    export const surface: string = '#FFFFFFFF';
    export const surfaceVariant: string = '#FFE2E8F0';
    export const outline: string = '#FFCBD5E1';
    export const success: string = '#FF22C55E';
    export const warning: string = '#FFF59E0B';
    export const error: string = '#FFEF4444';
    export const onPrimary: string = '#FFFFFFFF';
    export const onSecondary: string = '#FF0F172A';
    export const onTertiary: string = '#FFFFFFFF';
    export const onBackground: string = '#FF0F172A';
    export const onSurface: string = '#FF1E293B';
  }

  export namespace TypographyTokens {
    export const displaySize: number = 28;
    export const displayWeight: FontWeight = FontWeight.Bold;
    export const headlineSize: number = 20;
    export const headlineWeight: FontWeight = FontWeight.Medium;
    export const titleSize: number = 16;
    export const titleWeight: FontWeight = FontWeight.Medium;
    export const bodySize: number = 14;
    export const bodyWeight: FontWeight = FontWeight.Regular;
    export const labelSize: number = 12;
    export const labelWeight: FontWeight = FontWeight.Medium;
  }

  export namespace Shapes {
    export const small: Length = 8;
    export const medium: Length = 12;
    export const large: Length = 16;
  }

  export namespace Spacing {
    export const xs: Length = 4;
    export const sm: Length = 8;
    export const md: Length = 12;
    export const lg: Length = 16;
    export const xl: Length = 24;
    export const xxl: Length = 36;
  }

  export namespace ElevationMapping {
    export const level1Radius: number = 4;
    export const level1Y: number = 2;
    export const level2Radius: number = 8;
    export const level2Y: number = 4;
    export const level3Radius: number = 12;
    export const level3Y: number = 6;
  }
}

// MARK: - RootScreen Component

@Component
struct RootScreen {
  private readonly topBarHeight: Length = 64;
  private readonly bottomBarHeight: Length = 80;
  private readonly fabSize: Length = 56;

  build() {
    Stack() {
      // 1. Main content layer
      Column({ space: AppTokens.Spacing.lg }) {
        Blank()
          .height(this.topBarHeight)

        Text('Sign In to Continue')
          .fontSize(AppTokens.TypographyTokens.headlineSize)
          .fontWeight(AppTokens.TypographyTokens.headlineWeight)
          .fontColor(AppTokens.Colors.onSurface)

        // Workout Preview Box
        Stack() {
          Text('Workout Preview')
            .fontSize(AppTokens.TypographyTokens.bodySize)
            .fontWeight(AppTokens.TypographyTokens.bodyWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })

        // Authenticate Button
        Button('Authenticate')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('80%')
          .height(52)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .onClick(() => {})

        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#1A38BDF8', 0.0],
          ['#262563EB', 1.0]
        ]
      })
      .padding({ bottom: this.bottomBarHeight })

      // 2. Custom top bar layer
      Column() {
        Text('Workout Plan')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .height(this.topBarHeight)
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.Center)
      .align(Alignment.Top)

      // 3. Custom bottom bar layer
      Row() {
        Text('Home')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.primary)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Plan')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Profile')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(this.bottomBarHeight)
      .backgroundColor(AppTokens.Colors.surface)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .shadow({
        radius: AppTokens.ElevationMapping.level2Radius,
        color: '#240F172A',
        offsetY: AppTokens.ElevationMapping.level2Y
      })
      .align(Alignment.Bottom)

      // 4. Floating Action Button
      Button('+')
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontColor(AppTokens.Colors.onPrimary)
        .width(this.fabSize)
        .height(this.fabSize)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(28)
        .margin({
          right: AppTokens.Spacing.lg as number,
          bottom: (this.bottomBarHeight as number) + (AppTokens.Spacing.lg as number)
        })
        .onClick(() => {})
        .align(Alignment.BottomEnd)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - App Entry Point

@Entry
@Component
struct Index {
  build() {
    Stack() {
      RootScreen()
        .width('100%')
        .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
