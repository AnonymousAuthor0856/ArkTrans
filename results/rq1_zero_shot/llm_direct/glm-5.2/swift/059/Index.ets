// index.ets
import { Length } from '@ohos.arkui.UIContext';

// MARK: - AppTokens
// 翻译自 Kotlin 的 AppTokens 对象，用于定义颜色、字体、形状、间距和阴影。
class AppTokens {
  static readonly Colors = {
    primary: '#FF111827',
    secondary: '#FF374151',
    tertiary: '#FF6B7280',
    background: '#FFF9FAFB',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE5E7EB',
    outline: '#FFD1D5DB',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF111827',
    onBackground: '#FF111827',
    onSurface: '#FF1F2937',
  };

  static readonly TypographyTokens = {
    displayLarge: { size: 28, weight: FontWeight.Bold },
    headlineMedium: { size: 20, weight: FontWeight.Medium },
    titleMedium: { size: 16, weight: FontWeight.Medium },
    bodyMedium: { size: 14, weight: FontWeight.Normal },
    labelMedium: { size: 12, weight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16,
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  };

  static readonly ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.14 },
    level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.16 },
  };
}

// MARK: - Data Model
// 翻译自 Kotlin 的 data class Medicine
class Medicine {
  id: number;
  name: string;
  time: string;

  constructor(id: number, name: string, time: string) {
    this.id = id;
    this.name = name;
    this.time = time;
  }
}

// MARK: - MedicineItem View
// 翻译自 Kotlin 的 @Composable fun MedicineItem
@Component
struct MedicineItem {
  private medicine: Medicine = new Medicine(0, '', '');

  build() {
    Row() {
      Column() {
        Text(this.medicine.name)
          .fontSize(AppTokens.TypographyTokens.titleMedium.size)
          .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.medicine.time)
          .fontSize(AppTokens.TypographyTokens.bodyMedium.size)
          .fontWeight(AppTokens.TypographyTokens.bodyMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xs })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Circle({ width: 16, height: 16 })
        .fill(AppTokens.Colors.primary)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })
  }
}

// MARK: - MedicineList View
// 翻译自 Kotlin 的 @Composable fun MedicineList
@Component
struct MedicineList {
  private items: Medicine[] = [
    new Medicine(1, 'Vitamin C', '08:00 AM'),
    new Medicine(2, 'Aspirin', '12:30 PM'),
    new Medicine(3, 'Insulin', '06:00 PM'),
    new Medicine(4, 'Melatonin', '10:00 PM'),
  ];

  build() {
    Scroll() {
      Column() {
        ForEach(this.items, (item: Medicine) => {
          MedicineItem({ medicine: item })
            .margin({ bottom: AppTokens.Spacing.md })
        })
      }
      .padding({ bottom: AppTokens.Spacing.xxl })
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .layoutWeight(1)
  }
}

// MARK: - RootScreen View
// 翻译自 Kotlin 的 @Composable fun RootScreen
@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Column() {
          Text('Medicine Reminder')
            .fontSize(AppTokens.TypographyTokens.displayLarge.size)
            .fontWeight(AppTokens.TypographyTokens.displayLarge.weight)
            .fontColor(AppTokens.Colors.onBackground)
            .margin({ bottom: AppTokens.Spacing.md })

          MedicineList()

          Blank()

          Button('Mark All Taken') {
            Text('Mark All Taken')
              .fontSize(AppTokens.TypographyTokens.titleMedium.size)
              .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
              .fontColor(AppTokens.Colors.onSecondary)
          }
          .height(48)
          .width('80%')
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.large)
          .margin({ bottom: AppTokens.Spacing.md })
        }
        .width('100%')
        .height('100%')
        .padding({ top: AppTokens.Spacing.lg, left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: 56 })
        .linearGradient({
          angle: 180,
          colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.surface, 1.0]]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      // BottomAppBar
      Row() {
        Text('Today')
          .fontSize(AppTokens.TypographyTokens.titleMedium.size)
          .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
          .fontColor(AppTokens.Colors.primary)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('History')
          .fontSize(AppTokens.TypographyTokens.titleMedium.size)
          .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Profile')
          .fontSize(AppTokens.TypographyTokens.titleMedium.size)
          .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
        offsetY: AppTokens.ElevationMapping.level2.dy
      })

      // FloatingActionButton
      Button('+') {
        Text('+')
          .fontSize(AppTokens.TypographyTokens.displayLarge.size)
          .fontWeight(AppTokens.TypographyTokens.displayLarge.weight)
          .fontColor(AppTokens.Colors.onPrimary)
      }
      .width(56)
      .height(56)
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(28)
      .margin(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}