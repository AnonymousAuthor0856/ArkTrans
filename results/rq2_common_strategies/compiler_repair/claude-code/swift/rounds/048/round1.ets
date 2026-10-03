namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#1E3A8A';
    export const secondary: string = '#3B82F6';
    export const tertiary: string = '#60A5FA';
    export const background: string = '#F5F8FF';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#E8EEFA';
    export const outline: string = '#CBD5E1';
    export const success: string = '#22C55E';
    export const warning: string = '#F59E0B';
    export const error: string = '#EF4444';
    export const onPrimary: string = '#FFFFFF';
    export const onSecondary: string = '#FFFFFF';
    export const onTertiary: string = '#0B1220';
    export const onBackground: string = '#0B1220';
    export const onSurface: string = '#0B1220';
  }

  export namespace TypographyTokens {
    export const displaySize: number = 28;
    export const displayWeight: number = FontWeight.Bold;
    export const titleSize: number = 18;
    export const titleWeight: number = FontWeight.Medium;
    export const bodySize: number = 14;
    export const bodyWeight: number = FontWeight.Regular;
    export const labelSize: number = 12;
    export const labelWeight: number = FontWeight.Medium;
  }

  export namespace Shapes {
    export const small: number = 6;
    export const medium: number = 10;
    export const large: number = 16;
  }

  export namespace Spacing {
    export const sm: number = 6;
    export const md: number = 10;
    export const lg: number = 16;
    export const xl: number = 24;
    export const xxl: number = 36;
  }

  export class ShadowSpec {
    elevation: number;
    radius: number;
    dy: number;
    opacity: number;

    constructor(elevation: number, radius: number, dy: number, opacity: number) {
      this.elevation = elevation;
      this.radius = radius;
      this.dy = dy;
      this.opacity = opacity;
    }
  }

  export namespace ElevationMapping {
    export const level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
    export const level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.15);
    export const level3: ShadowSpec = new ShadowSpec(10, 12, 6, 0.18);
  }

  export namespace MaterialDefaults {
    export const bottomAppBarHeight: number = 80;
    export const fabSize: number = 56;
    export const buttonHorizontalPadding: number = 16;
    export const buttonVerticalPadding: number = 8;
    export const fabBottomMargin: number = 16;
    export const fabTrailingMargin: number = 16;
    export const lazyColumnContentBottomPadding: number = 96;
  }
}

interface LiveItem {
  id: number;
  title: string;
  viewers: number;
  price: string;
}

@Component
struct LiveItemCard {
  @State item: LiveItem;

  build() {
    Column() {
      // Placeholder image area
      Rectangle()
        .fill(AppTokens.Colors.secondary)
        .width('100%')
        .height(160)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.item.title)
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(AppTokens.TypographyTokens.titleWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })

      Text(`${this.item.viewers} viewers`)
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(AppTokens.Colors.tertiary)
        .margin({ top: AppTokens.Spacing.sm })

      Row() {
        Text(this.item.price)
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.primary)

        Blank()

        Button('Join Live')
          .fontSize(AppTokens.TypographyTokens.labelSize)
          .fontWeight(AppTokens.TypographyTokens.labelWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({
            left: AppTokens.MaterialDefaults.buttonHorizontalPadding,
            right: AppTokens.MaterialDefaults.buttonHorizontalPadding,
            top: AppTokens.MaterialDefaults.buttonVerticalPadding,
            bottom: AppTokens.MaterialDefaults.buttonVerticalPadding
          })
          .onClick(() => {})
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.sm })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }
}

@Component
struct BottomNavBar {
  build() {
    Row() {
      Text('Home')
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(AppTokens.Colors.primary)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Live')
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Cart')
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Profile')
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(AppTokens.MaterialDefaults.bottomAppBarHeight)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: 0.5,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: -1
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State liveList: LiveItem[] = [
    { id: 1, title: 'Smartphone Flash Deal', viewers: 1234, price: '$699' },
    { id: 2, title: 'Gaming Chair Special', viewers: 880, price: '$249' },
    { id: 3, title: 'Headphones Clearance', viewers: 1640, price: '$99' },
    { id: 4, title: 'Mechanical Keyboard', viewers: 512, price: '$129' }
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Main content area with gradient background
      Column() {
        Text('Live Shop Events')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')

        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.liveList, (item: LiveItem) => {
              LiveItemCard({ item: item })
            }, (item: LiveItem) => item.id.toString())
          }
          .width('100%')
          .padding({ bottom: AppTokens.MaterialDefaults.lazyColumnContentBottomPadding })
        }
        .width('100%')
        .layoutWeight(1)
        .margin({ top: AppTokens.Spacing.md })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.background, 0.0],
          [AppTokens.Colors.surfaceVariant, 0.5],
          [AppTokens.Colors.background, 1.0]
        ]
      })

      // Floating Action Button
      Column() {
        Blank()

        Row() {
          Blank()

          Button('+')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.MaterialDefaults.fabSize / 2)
            .width(AppTokens.MaterialDefaults.fabSize)
            .height(AppTokens.MaterialDefaults.fabSize)
            .margin({
              right: AppTokens.MaterialDefaults.fabTrailingMargin,
              bottom: AppTokens.MaterialDefaults.fabBottomMargin + AppTokens.MaterialDefaults.bottomAppBarHeight
            })
            .onClick(() => {})
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')

      // Bottom navigation bar
      Column() {
        Blank()
        BottomNavBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
