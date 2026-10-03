interface MapMarker {
  name: string
  distance: string
}

const PRIMARY: string = '#00FF66'
const SECONDARY: string = '#CCCCCC'
const BACKGROUND: string = '#000000'
const SURFACE: string = '#0A0A0A'
const OUTLINE: string = '#1F1F1F'
const ON_PRIMARY: string = '#000000'
const ON_SURFACE: string = '#E0E0E0'

const MARKERS: MapMarker[] = [
  { name: 'Central Plaza', distance: '1.2 km' },
  { name: 'Museum District', distance: '3.4 km' },
  { name: 'Tech Park', distance: '5.6 km' },
  { name: 'Old Town Gate', distance: '7.8 km' }
]

@Entry
@Component
struct ExploreMapPage {
  @State query: string = ''
  @State isSearchFocused: boolean = false

  build() {
    Column() {
      Text('Explore Map')
        .width('100%')
        .height(68)
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor(PRIMARY)
        .textAlign(TextAlign.Center)
        .lineHeight(68)
        .margin({ top: 35, bottom: 74 })

      TextInput({ placeholder: 'Search destination', text: this.query })
        .width('100%')
        .height(110)
        .fontSize(30)
        .fontWeight(FontWeight.Normal)
        .fontColor(ON_SURFACE)
        .placeholderColor(ON_SURFACE)
        .backgroundColor(BACKGROUND)
        .border({
          width: 1,
          color: this.isSearchFocused ? PRIMARY : OUTLINE
        })
        .borderRadius(18)
        .padding({ left: 30, right: 30 })
        .onChange((value: string) => {
          this.query = value
        })
        .onFocus(() => {
          this.isSearchFocused = true
        })
        .onBlur(() => {
          this.isSearchFocused = false
        })
        .margin({ bottom: 34 })

      Column({ space: 24 }) {
        ForEach(MARKERS, (marker: MapMarker) => {
          Row() {
            Column() {
              Text(marker.name)
                .fontSize(30)
                .fontWeight(FontWeight.Medium)
                .fontColor(ON_SURFACE)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              Text(marker.distance)
                .fontSize(26)
                .fontWeight(FontWeight.Normal)
                .fontColor(SECONDARY)
                .maxLines(1)
            }
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Center)

            Button({ type: ButtonType.Normal, stateEffect: false }) {
              Text('View')
                .fontSize(22)
                .fontWeight(FontWeight.Medium)
                .fontColor(ON_PRIMARY)
            }
            .width(144)
            .height(80)
            .backgroundColor(PRIMARY)
            .borderRadius(12)
          }
          .width('100%')
          .height(144)
          .padding({ left: 24, right: 24 })
          .backgroundColor(SURFACE)
          .borderRadius(18)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        }, (marker: MapMarker) => marker.name)
      }
      .width('100%')

      Blank()
        .height(128)

      Button({ type: ButtonType.Normal, stateEffect: false }) {
        Text('Refresh Map')
          .fontSize(30)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_PRIMARY)
      }
      .width('100%')
      .height(96)
      .backgroundColor(PRIMARY)
      .borderRadius(24)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32 })
    .backgroundColor(BACKGROUND)
    .alignItems(HorizontalAlign.Center)
  }
}