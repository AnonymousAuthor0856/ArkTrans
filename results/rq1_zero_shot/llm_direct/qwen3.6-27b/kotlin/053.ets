import { window } from '@kit.ArkUI';

// --- Design Tokens & Constants ---

const AppTokens = {
  Colors: {
    primary: '#1E293B',
    secondary: '#0EA5E9',
    tertiary: '#FACC15',
    background: '#111827',
    surface: '#1E293B',
    surfaceVariant: '#334155',
    outline: '#475569',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#0B1220',
    onBackground: '#E2E8F0',
    onSurface: '#E2E8F0'
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  }
};

interface CodeMarker {
  id: number;
  name: string;
  desc: string;
}

@Entry
@Component
struct RootScreen {
  @State markers: CodeMarker[] = [
    { id: 1, name: 'Main.kt', desc: 'Entry point for Compose app' },
    { id: 2, name: 'Utils.kt', desc: 'Helper functions' },
    { id: 3, name: 'Theme.kt', desc: 'Color & Typography setup' },
    { id: 4, name: 'Data.kt', desc: 'Repository and model classes' }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('CodeIDE Terminal')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Column() {
        // Section: Project Files
        Text('Project Files')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onBackground)
          .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.sm })

        List({ space: AppTokens.Spacing.sm }) {
          ForEach(this.markers, (item: CodeMarker) => {
            ListItem() {
              Row() {
                // Icon Box
                Text(item.id.toString())
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSecondary)
                  .width(32)
                  .height(32)
                  .textAlign(TextAlign.Center)
                  .backgroundColor(AppTokens.Colors.secondary)
                  .borderRadius(4)

                Column() {
                  Text(item.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onSurface)
                  
                  Text(item.desc)
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor(AppTokens.Colors.onSurface)
                    .opacity(0.8)
                }
                .layoutWeight(1)
                .margin({ left: AppTokens.Spacing.md })
              }
              .width('100%')
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(8)
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ bottom: AppTokens.Spacing.xl })

        // Section: Live Terminal
        Text('Live Terminal')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onBackground)
          .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.sm })

        Column() {
          Text('> println("Hello, Kotlin!")')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(240)
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(8)
        .border({ width: 1, color: AppTokens.Colors.outline })

        // Action Button
        Button('Run Code')
          .width('60%')
          .height(48)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(12)
          .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [['#1E293B', 0], ['#1E293B', 1]] // Simplified gradient as ArkTS linearGradient on container is complex, using solid bg for stability or specific shape
      })
      .backgroundColor(AppTokens.Colors.primary) // Fallback/Solid base
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}