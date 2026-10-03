// AppTokens - design system tokens
class AppTokens {
  static class Colors {
    static primary: string = '#00FF66'
    static secondary: string = '#CCCCCC'
    static tertiary: string = '#999999'
    static background: string = '#000000'
    static surface: string = '#0A0A0A'
    static surfaceVariant: string = '#111111'
    static outline: string = '#1F1F1F'
    static success: string = '#16A34A'
    static warning: string = '#F59E0B'
    static error: string = '#FF4444'
    static onPrimary: string = '#000000'
    static onSecondary: string = '#FFFFFFFF'
    static onTertiary: string = '#FFFFFFFF'
    static onBackground: string = '#E0E0E0'
    static onSurface: string = '#E0E0E0'
  }

  static class Typography {
    static displaySize: number = 28
    static displayWeight: FontWeight = FontWeight.Bold
    static headlineSize: number = 20
    static headlineWeight: FontWeight = FontWeight.Medium
    static titleSize: number = 16
    static titleWeight: FontWeight = FontWeight.Medium
    static bodySize: number = 13
    static bodyWeight: FontWeight = FontWeight.Normal
    static labelSize: number = 11
    static labelWeight: FontWeight = FontWeight.Medium
  }

  static class Shapes {
    static small: number = 6
    static medium: number = 10
    static large: number = 14
  }

  static class Spacing {
    static xs: number = 4
    static sm: number = 8
    static md: number = 12
    static lg: number = 16
    static xl: number = 24
    static xxl: number = 32
  }

  static class Elevation {
    static level2Radius: number = 4
    static level2Y: number = 2
    static level2Opacity: number = 0.12
  }
}

// Data model
interface MapMarker {
  id: string
  name: string
  distance: string
}

// CardView component
@Component
struct CardView {
  marker: MapMarker

  build() {
    Row() {
      Column() {
        Text(this.marker.name)
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(AppTokens.Typography.titleWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.marker.distance)
          .fontSize(AppTokens.Typography.bodySize)
          .fontWeight(AppTokens.Typography.bodyWeight)
          .fontColor(AppTokens.Colors.secondary)
          .margin({ top: AppTokens.Spacing.xs })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('View') {
        Text('View')
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(AppTokens.Typography.labelWeight)
          .fontColor(AppTokens.Colors.onPrimary)
      }
      .type(ButtonType.Normal)
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.small)
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
      .onClick(() => {
        console.log(`View ${this.marker.name} Tapped`)
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.Elevation.level2Radius,
      color: `rgba(0, 0, 0, ${AppTokens.Elevation.level2Opacity})`,
      offsetY: AppTokens.Elevation.level2Y
    })
  }
}

// RootScreen - entry component
@Entry
@Component
struct RootScreen {
  @State query: string = ''
  @State isSearchFocused: boolean = false

  private markers: MapMarker[] = [
    { id: '1', name: 'Central Plaza', distance: '1.2 km' },
    { id: '2', name: 'Museum District', distance: '3.4 km' },
    { id: '3', name: 'Tech Park', distance: '5.6 km' },
    { id: '4', name: 'Old Town Gate', distance: '7.8 km' }
  ]

  build() {
    Stack() {
      Column() {
        // Top Bar
        Text('Explore Map')
          .fontSize(AppTokens.Typography.displaySize)
          .fontWeight(AppTokens.Typography.displayWeight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .backgroundColor(AppTokens.Colors.background)

        // Main content
        Column({ space: AppTokens.Spacing.lg }) {
          // Search Field
          TextInput({ placeholder: 'Search destination', text: this.$query })
            .fontSize(AppTokens.Typography.bodySize)
            .fontColor(AppTokens.Colors.onSurface)
            .placeholderColor(AppTokens.Colors.tertiary)
            .caretColor(AppTokens.Colors.primary)
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .border({
              width: 1,
              color: this.isSearchFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline
            })
            .onFocus(() => {
              this.isSearchFocused = true
            })
            .onBlur(() => {
              this.isSearchFocused = false
            })
            .width('100%')

          // Markers List
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.markers, (marker: MapMarker) => {
              CardView({ marker: marker })
            }, (marker: MapMarker) => marker.id)
          }
          .width('100%')

          Blank()

          // Refresh Map Button
          Button('Refresh Map') {
            Text('Refresh Map')
              .fontSize(AppTokens.Typography.titleSize)
              .fontWeight(AppTokens.Typography.titleWeight)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .type(ButtonType.Normal)
          .width('100%')
          .height(48)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .onClick(() => {
            console.log('Refresh Map Tapped')
          })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
