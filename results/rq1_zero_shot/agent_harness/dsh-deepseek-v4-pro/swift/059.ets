// MARK: - AppTokens

interface FontStyle {
  size: number;
  weight: FontWeight;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokens {
  static readonly Colors: Record<string, string> = {
    primary: '#111827',
    secondary: '#374151',
    tertiary: '#6B7280',
    background: '#F9FAFB',
    surface: '#FFFFFF',
    surfaceVariant: '#E5E7EB',
    outline: '#D1D5DB',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#111827',
    onBackground: '#111827',
    onSurface: '#1F2937',
  };

  static readonly Typography: Record<string, FontStyle> = {
    displayLarge: { size: 28, weight: FontWeight.Bold },
    headlineMedium: { size: 20, weight: FontWeight.Semibold },
    titleMedium: { size: 16, weight: FontWeight.Medium },
    bodyMedium: { size: 14, weight: FontWeight.Regular },
    labelMedium: { size: 12, weight: FontWeight.Medium },
  };

  static readonly Shapes: Record<string, number> = {
    small: 8,
    medium: 12,
    large: 16,
  };

  static readonly Spacing: Record<string, number> = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  };

  static readonly ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.14 },
    level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.16 },
  };
}

interface Medicine {
  id: number;
  name: string;
  time: string;
}

@Component
struct MedicineItem {
  medicine: Medicine = { id: 0, name: '', time: '' };

  build() {
    Row() {
      Column({ space: AppTokens.Spacing.xs }) {
        Text(this.medicine.name)
          .fontSize(AppTokens.Typography.titleMedium.size)
          .fontWeight(AppTokens.Typography.titleMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.medicine.time)
          .fontSize(AppTokens.Typography.bodyMedium.size)
          .fontWeight(AppTokens.Typography.bodyMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row()
        .width(16)
        .height(16)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(8)
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .width('100%')
  }
}

@Component
struct MedicineList {
  private items: Medicine[] = [
    { id: 1, name: 'Vitamin C', time: '08:00 AM' },
    { id: 2, name: 'Aspirin', time: '12:30 PM' },
    { id: 3, name: 'Insulin', time: '06:00 PM' },
    { id: 4, name: 'Melatonin', time: '10:00 PM' }
  ];

  build() {
    Scroll() {
      Column({ space: AppTokens.Spacing.md }) {
        ForEach(this.items, (m: Medicine) => {
          MedicineItem({ medicine: m })
        }, (m: Medicine) => m.id.toString())
      }
      .padding({ bottom: AppTokens.Spacing.xxl })
      .width('100%')
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
  }
}

@Component
struct RootScreen {
  build() {
    Stack() {
      Column() {
        Column({ space: AppTokens.Spacing.md }) {
          Text('Medicine Reminder')
            .fontSize(AppTokens.Typography.displayLarge.size)
            .fontWeight(AppTokens.Typography.displayLarge.weight)
            .fontColor(AppTokens.Colors.onBackground)

          MedicineList()
            .layoutWeight(1)

          Button() {
            Text('Mark All Taken')
              .fontSize(AppTokens.Typography.titleMedium.size)
              .fontWeight(AppTokens.Typography.titleMedium.weight)
              .fontColor(AppTokens.Colors.onSecondary)
              .width('100%')
              .height(48)
          }
          .width('80%')
          .height(48)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.large)
          .alignSelf(ItemAlign.Center)
          .onClick(() => {})
          .margin({ bottom: AppTokens.Spacing.md })
        }
        .padding({ top: AppTokens.Spacing.lg, left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .width('100%')
        .height('100%')
        .padding({ bottom: 56 })
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            [AppTokens.Colors.surfaceVariant, 0.0],
            [AppTokens.Colors.surface, 1.0]
          ]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      // Bottom app bar
      Column() {
        Blank()
        Row() {
          Text('Today')
            .fontSize(AppTokens.Typography.titleMedium.size)
            .fontWeight(AppTokens.Typography.titleMedium.weight)
            .fontColor(AppTokens.Colors.primary)
          Blank()
          Text('History')
            .fontSize(AppTokens.Typography.titleMedium.size)
            .fontWeight(AppTokens.Typography.titleMedium.weight)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Text('Profile')
            .fontSize(AppTokens.Typography.titleMedium.size)
            .fontWeight(AppTokens.Typography.titleMedium.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .width('100%')
        .height(56)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: '#24000000',
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
      }
      .width('100%')
      .height('100%')

      // Floating action button
      Column() {
        Blank()
        Row() {
          Blank()
          Button() {
            Text('+')
              .fontSize(AppTokens.Typography.displayLarge.size)
              .fontWeight(AppTokens.Typography.displayLarge.weight)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .width(56)
          .height(56)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(28)
          .margin({ right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .onClick(() => {})
        }
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    // statusBarHidden(true) has no direct ArkUI declarative equivalent.
    RootScreen()
  }
}
