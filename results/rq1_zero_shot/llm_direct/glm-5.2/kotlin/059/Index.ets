// File: pages/RootScreen.ets

interface Medicine {
  id: number;
  name: string;
  time: string;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

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
    onSurface: '#FF1F2937'
  };

  static readonly TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  };

  static readonly ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 } as ShadowSpec,
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.14 } as ShadowSpec,
    level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.16 } as ShadowSpec
  };
}

@Component
struct MedicineItem {
  private m: Medicine = { id: 0, name: '', time: '' };

  build() {
    Row() {
      Column() {
        Text(this.m.name)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontSize)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.m.time)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)

      Blank()

      Row() {
        Circle({ width: 16, height: 16 })
          .fillColor(AppTokens.Colors.primary)
      }
      .width(16)
      .height(16)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
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
    Column() {
      ForEach(this.items, (item: Medicine) => {
        MedicineItem({ m: item })
      })
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Start)
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Text('Medicine Reminder')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onBackground)
          .margin({ bottom: AppTokens.Spacing.md })

        MedicineList()

        Blank().height(AppTokens.Spacing.md)

        Button('Mark All Taken') {
          Text('Mark All Taken')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSecondary)
        }
        .width('80%')
        .height(48)
        .borderRadius(AppTokens.Shapes.large)
        .backgroundColor(AppTokens.Colors.secondary)
        .margin({ bottom: AppTokens.Spacing.xxl })
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.lg })
      .linearGradient({
        angle: 180,
        colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.surface, 1.0]]
      })
      .alignItems(HorizontalAlign.Center)

      Stack() {
        Text('+')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onPrimary)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor(AppTokens.Colors.primary)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
        offsetX: 0,
        offsetY: AppTokens.ElevationMapping.level2.dy
      })
      .margin(16)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}