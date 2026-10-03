// AppTokens.ts
export class AppTokens {
  static readonly Colors = {
    primary: '#1E3A8A',
    secondary: '#3B82F6',
    tertiary: '#60A5FA',
    background: '#F5F8FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E8EEFA',
    outline: '#CBD5E1',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#0B1220',
    onBackground: '#0B1220',
    onSurface: '#0B1220'
  }

  static readonly TypographyTokens = {
    display: { size: 28, weight: 700 },
    title: { size: 18, weight: 500 },
    body: { size: 14, weight: 400 },
    label: { size: 12, weight: 500 }
  }

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 16
  }

  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36
  }

  static readonly ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 }
  }

  static readonly MaterialDefaults = {
    bottomAppBarHeight: 80,
    fabSize: 56,
    buttonHorizontalPadding: 16,
    buttonVerticalPadding: 8,
    fabBottomMargin: 16,
    fabTrailingMargin: 16,
    lazyColumnContentBottomPadding: 96
  }
}

// LiveItem.ts
export interface LiveItem {
  id: number;
  title: string;
  viewers: number;
  price: string;
}

// RootScreen.ets
import { AppTokens } from './AppTokens';
import { LiveItem } from './LiveItem';

@Entry
@Component
struct RootScreen {
  private liveList: LiveItem[] = [
    { id: 1, title: 'Smartphone Flash Deal', viewers: 1234, price: '$699' },
    { id: 2, title: 'Gaming Chair Special', viewers: 880, price: '$249' },
    { id: 3, title: 'Headphones Clearance', viewers: 1640, price: '$99' },
    { id: 4, title: 'Mechanical Keyboard', viewers: 512, price: '$129' }
  ];

  build() {
    Stack() {
      // Main Content Area
      Column({ space: AppTokens.Spacing.md }) {
        Text('Live Shop Events')
          .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight as FontWeight })
          .fontColor(AppTokens.Colors.primary)

        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.liveList, (item: LiveItem) => {
              LiveItemCard(item)
            })
          }
          .padding({ bottom: AppTokens.MaterialDefaults.lazyColumnContentBottomPadding })
        }
        .layoutWeight(1)
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 90,
        colors: [
          [AppTokens.Colors.background, 0],
          [AppTokens.Colors.surfaceVariant, 0.5],
          [AppTokens.Colors.background, 1]
        ]
      })

      // Floating Action Button
      Row() {
        Blank()
        Button('+', { type: ButtonType.Circle })
          .width(AppTokens.MaterialDefaults.fabSize)
          .height(AppTokens.MaterialDefaults.fabSize)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight as FontWeight)
          .margin({ right: AppTokens.MaterialDefaults.fabTrailingMargin, bottom: AppTokens.MaterialDefaults.fabBottomMargin + AppTokens.MaterialDefaults.bottomAppBarHeight })
      }
      .width('100%')
      .alignItems(HorizontalAlign.End)
      .justifyContent(FlexAlign.End)

      // Bottom Navigation Bar
      BottomNavBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// LiveItemCard.ets
import { AppTokens } from './AppTokens';
import { LiveItem } from './LiveItem';

@Component
struct LiveItemCard {
  @Prop item: LiveItem;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Placeholder Image Area
      Rectangle()
        .fill(AppTokens.Colors.secondary)
        .width('100%')
        .height(160)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.item.title)
        .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight as FontWeight })
        .fontColor(AppTokens.Colors.onSurface)

      Text(`${this.item.viewers.toLocaleString()} viewers`)
        .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight as FontWeight })
        .fontColor(AppTokens.Colors.tertiary)

      Row() {
        Text(this.item.price)
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight as FontWeight })
          .fontColor(AppTokens.Colors.primary)

        Blank()

        Button('Join Live')
          .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight as FontWeight })
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({ left: AppTokens.MaterialDefaults.buttonHorizontalPadding, right: AppTokens.MaterialDefaults.buttonHorizontalPadding, top: AppTokens.MaterialDefaults.buttonVerticalPadding, bottom: AppTokens.MaterialDefaults.buttonVerticalPadding })
      }
    }
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

// BottomNavBar.ets
import { AppTokens } from './AppTokens';

@Component
struct BottomNavBar {
  build() {
    Row() {
      Text('Home')
        .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight as FontWeight })
        .fontColor(AppTokens.Colors.primary)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Live')
        .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight as FontWeight })
        .fontColor(AppTokens.Colors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Cart')
        .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight as FontWeight })
        .fontColor(AppTokens.Colors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Profile')
        .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight as FontWeight })
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