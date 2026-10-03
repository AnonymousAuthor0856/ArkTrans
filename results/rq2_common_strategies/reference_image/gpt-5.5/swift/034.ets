class AppColors {
  static readonly primary: ResourceColor = '#00FF66'
  static readonly secondary: ResourceColor = '#CCCCCC'
  static readonly tertiary: ResourceColor = '#999999'
  static readonly background: ResourceColor = '#000000'
  static readonly surface: ResourceColor = '#0A0A0A'
  static readonly surfaceVariant: ResourceColor = '#111111'
  static readonly outline: ResourceColor = '#1F1F1F'
  static readonly success: ResourceColor = '#16A34A'
  static readonly warning: ResourceColor = '#F59E0B'
  static readonly error: ResourceColor = '#FF4444'
  static readonly onPrimary: ResourceColor = '#000000'
  static readonly onSecondary: ResourceColor = '#FFFFFF'
  static readonly onTertiary: ResourceColor = '#FFFFFF'
  static readonly onBackground: ResourceColor = '#E0E0E0'
  static readonly onSurface: ResourceColor = '#E0E0E0'
}

class AppTypographyTokens {
  static readonly display: number = 28
  static readonly headline: number = 20
  static readonly title: number = 16
  static readonly body: number = 13
  static readonly label: number = 11
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 14
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

class MapMarker {
  id: string
  name: string
  distance: string

  constructor(name: string, distance: string) {
    this.id = `${name}-${distance}`
    this.name = name
    this.distance = distance
  }
}

@Component
struct CardView {
  @Prop marker: MapMarker = new MapMarker('', '')

  build() {
    Row() {
      Column() {
        Text(this.marker.name)
          .fontSize(AppTypographyTokens.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .lineHeight(20)

        Text(this.marker.distance)
          .fontSize(AppTypographyTokens.body)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.secondary)
          .lineHeight(17)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('View', { type: ButtonType.Normal, stateEffect: true })
        .width(50)
        .height(22)
        .padding(0)
        .fontSize(AppTypographyTokens.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.small)
        .onClick(() => {
          console.info(`View ${this.marker.name} tapped`)
        })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .shadow({
      radius: 4,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State query: string = ''
  @State isSearchFieldFocused: boolean = true

  private markers: MapMarker[] = [
    new MapMarker('Central Plaza', '1.2 km'),
    new MapMarker('Museum District', '3.4 km'),
    new MapMarker('Tech Park', '5.6 km'),
    new MapMarker('Old Town Gate', '7.8 km')
  ]

  build() {
    Stack() {
      Column() {
        Text('Explore Map')
          .width('100%')
          .padding({
            top: AppSpacing.lg,
            bottom: AppSpacing.lg
          })
          .textAlign(TextAlign.Center)
          .fontSize(AppTypographyTokens.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .backgroundColor(AppColors.background)

        Column({ space: AppSpacing.lg }) {
          TextInput({
            placeholder: 'Search destination',
            text: this.query
          })
            .width('100%')
            .height(42)
            .padding({
              left: AppSpacing.md,
              right: AppSpacing.md
            })
            .fontSize(AppTypographyTokens.body)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onSurface)
            .placeholderColor(AppColors.outline)
            .caretColor(AppColors.primary)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.medium)
            .border({
              width: 1,
              color: this.isSearchFieldFocused ? AppColors.primary : AppColors.outline,
              radius: AppShapes.medium
            })
            .onChange((value: string) => {
              this.query = value
            })
            .onFocus(() => {
              this.isSearchFieldFocused = true
            })
            .onBlur(() => {
              this.isSearchFieldFocused = false
            })

          Column({ space: AppSpacing.md }) {
            ForEach(this.markers, (marker: MapMarker) => {
              CardView({ marker: marker })
            }, (marker: MapMarker) => marker.id)
          }
          .width('100%')

          Blank()
            .layoutWeight(1)

          Button('Refresh Map', { type: ButtonType.Normal, stateEffect: true })
            .width('100%')
            .height(48)
            .fontSize(AppTypographyTokens.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.large)
            .onClick(() => {
              console.info('Refresh Map tapped')
            })
        }
        .width('100%')
        .layoutWeight(1)
        .padding(AppSpacing.lg)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}