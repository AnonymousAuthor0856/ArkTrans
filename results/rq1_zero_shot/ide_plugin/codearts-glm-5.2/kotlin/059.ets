const NAME = '088_MedicineReminder_en'
const UI_TYPE = 'Health ListDetail'
const STYLE_THEME = 'Monochrome'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
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
  }

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 8,
    medium: 12,
    large: 16,
  }

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  }

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.14 },
    level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.16 },
  }
}

interface Medicine {
  id: number
  name: string
  time: string
}

@Entry
@Component
struct RootScreen {
  private items: Medicine[] = [
    { id: 1, name: 'Vitamin C', time: '08:00 AM' },
    { id: 2, name: 'Aspirin', time: '12:30 PM' },
    { id: 3, name: 'Insulin', time: '06:00 PM' },
    { id: 4, name: 'Melatonin', time: '10:00 PM' },
  ]

  build() {
    Column() {
      Column() {
        Text('Medicine Reminder')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onBackground)

        List() {
          ForEach(this.items, (m: Medicine) => {
            ListItem() {
              MedicineItem({ medicine: m })
            }
          }, (m: Medicine) => m.id.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .margin({ top: AppTokens.Spacing.md })

        Button('Mark All Taken')
          .type(ButtonType.Normal)
          .width('80%')
          .height(48)
          .borderRadius(AppTokens.Shapes.large)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .margin({ top: AppTokens.Spacing.md })
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.surface, 1.0]]
      })

      Stack() {
        Row() {
          Text('Today')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.primary)
          Blank()
          Text('History')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Text('Profile')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(56)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: -AppTokens.ElevationMapping.level2.dy })

        Button('+')
          .type(ButtonType.Normal)
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .position({ x: '50%', y: -28 })
          .markAnchor({ x: '50%', y: 0 })
      }
      .width('100%')
      .height(56)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct MedicineItem {
  private medicine: Medicine = { id: 0, name: '', time: '' }

  build() {
    Row() {
      Column() {
        Text(this.medicine.name)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.medicine.time)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xs })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Column()
        .width(16)
        .height(16)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(8)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: AppTokens.Spacing.md })
  }
}