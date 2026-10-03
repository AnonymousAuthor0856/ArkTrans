class AppColors {
  static primary: string = '#1E293B';
  static secondary: string = '#0EA5E9';
  static tertiary: string = '#FACC15';
  static background: string = '#1E293B';
  static surface: string = '#1E293B';
  static surfaceVariant: string = '#334155';
  static outline: string = '#475569';
  static success: string = '#22C55E';
  static warning: string = '#F59E0B';
  static error: string = '#EF4444';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#FFFFFF';
  static onTertiary: string = '#0B1220';
  static onBackground: string = '#E2E8F0';
  static onSurface: string = '#E2E8F0';
}

class Spacing {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 36;
}

class Shapes {
  static small: number = 4;
  static medium: number = 8;
  static large: number = 12;
}

class CodeMarker {
  id: number = 0;
  name: string = '';
  desc: string = '';

  constructor(id: number, name: string, desc: string) {
    this.id = id;
    this.name = name;
    this.desc = desc;
  }
}

const markers: CodeMarker[] = [
  new CodeMarker(1, 'Main.kt', 'Entry point for Compose app'),
  new CodeMarker(2, 'Utils.kt', 'Helper functions'),
  new CodeMarker(3, 'Theme.kt', 'Color & Typography setup'),
  new CodeMarker(4, 'Data.kt', 'Repository and model classes'),
]

@Component
struct CodeMarkerCard {
  marker: CodeMarker = new CodeMarker(0, '', '');

  build() {
    Row({ space: Spacing.md }) {
      Stack() {
        Text(this.marker.id.toString())
          .fontColor(AppColors.onSecondary)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
      }
      .width(32)
      .height(32)
      .backgroundColor(AppColors.secondary)
      .borderRadius(Shapes.small)

      Column() {
        Text(this.marker.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .margin({ bottom: 2 })
        Text(this.marker.desc)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(Spacing.md)
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(Shapes.medium)
    .shadow({
      radius: 2,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 1,
    })
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('CodeIDE Terminal')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: Spacing.md, bottom: Spacing.md })
      .backgroundColor(AppColors.background)

      // Scrollable Content
      Scroll() {
        Column({ space: Spacing.lg }) {
          // Project Files Section
          Text('Project Files')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)
            .width('100%')

          // Markers List
          Column({ space: Spacing.sm }) {
            ForEach(markers, (marker: CodeMarker) => {
              CodeMarkerCard({ marker: marker })
            })
          }
          .width('100%')
          .margin({ bottom: Spacing.xl })

          // Live Terminal Section
          Text('Live Terminal')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)
            .width('100%')

          // Terminal Box
          Stack({ alignContent: Alignment.TopStart }) {
            Column()
              .width('100%')
              .height(240)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(Shapes.medium)
              .border({
                width: 1,
                color: AppColors.outline,
                radius: Shapes.medium,
              })

            Text('> println("Hello, Kotlin!")')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onSurface)
              .padding(Spacing.md)
          }
          .width('100%')
          .height(240)

          // Run Code Button
          Row() {
            Button('Run Code')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSecondary)
              .width('60%')
              .height(48)
              .backgroundColor(AppColors.secondary)
              .borderRadius(Shapes.large)
              .shadow({
                radius: 2,
                color: '#1A000000',
                offsetX: 0,
                offsetY: 1,
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }
        .padding(Spacing.lg)
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#CC1E293B', 0.0],
          ['#E61E293B', 1.0],
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}