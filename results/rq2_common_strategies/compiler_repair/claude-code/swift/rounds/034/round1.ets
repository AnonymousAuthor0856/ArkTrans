// Design tokens
class AppColors {
  static primary: string = '#00FF66'
  static secondary: string = '#CCCCCC'
  static tertiary: string = '#999999'
  static background: string = '#000000'
  static surface: string = '#0A0A0A'
  static surfaceVariant: string = '#111111'
  static outline: string = '#1F1F1F'
  static onPrimary: string = '#000000'
  static onSurface: string = '#E0E0E0'
}

class AppSpacing {
  static xs: number = 4
  static sm: number = 8
  static md: number = 12
  static lg: number = 16
  static xl: number = 24
}

class AppShapes {
  static small: number = 6
  static medium: number = 10
  static large: number = 14
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
  @Prop marker: MapMarker = { id: '', name: '', distance: '' }

  build() {
    Row() {
      Column() {
        Text(this.marker.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(this.marker.distance)
          .fontSize(13)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.secondary)
          .margin({ top: AppSpacing.xs })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Text('View')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .type(ButtonType.Normal)
      .backgroundColor(AppColors.primary)
      .borderRadius(AppShapes.small)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.xs, bottom: AppSpacing.xs })
      .onClick((): void => {
        console.info('View ' + this.marker.name + ' Tapped')
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .shadow({
      radius: 4,
      color: '#1E000000',
      offsetY: 2
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
        Text('Explore Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
          .backgroundColor(AppColors.background)

        Column({ space: AppSpacing.lg }) {
          TextInput({ placeholder: 'Search destination', text: this.$query })
            .fontSize(13)
            .fontColor(AppColors.onSurface)
            .placeholderColor(AppColors.tertiary)
            .caretColor(AppColors.primary)
            .padding(AppSpacing.md)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.medium)
            .border({
              width: 1,
              color: this.isSearchFocused ? AppColors.primary : AppColors.outline
            })
            .onFocus((): void => {
              this.isSearchFocused = true
            })
            .onBlur((): void => {
              this.isSearchFocused = false
            })
            .width('100%')

          Column({ space: AppSpacing.md }) {
            ForEach(this.markers, (marker: MapMarker): void => {
              CardView({ marker: marker })
            }, (marker: MapMarker): string => marker.id)
          }
          .width('100%')

          Blank()

          Button() {
            Text('Refresh Map')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
          }
          .type(ButtonType.Normal)
          .width('100%')
          .height(48)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.large)
          .onClick((): void => {
            console.info('Refresh Map Tapped')
          })
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
