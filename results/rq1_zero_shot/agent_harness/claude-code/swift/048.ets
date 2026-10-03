import { AppTokens } from './AppTokens';

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
      // Main content area
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
