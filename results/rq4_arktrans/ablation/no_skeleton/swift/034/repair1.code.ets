@Entry
@Component
struct RootScreen {
  @State query: string = ''
  @State isSearchFieldFocused: boolean = false

  // Data Model
  private markers: MapMarker[] = [
    { name: 'Central Plaza', distance: '1.2 km' },
    { name: 'Museum District', distance: '3.4 km' },
    { name: 'Tech Park', distance: '5.6 km' },
    { name: 'Old Town Gate', distance: '7.8 km' }
  ]

  build() {
    Column() {
      // Top Bar
      Text('Explore Map')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00FF66')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })

      // Main Content Area
      Column({ space: 16 }) {
        // Search Field
        TextInput({ placeholder: 'Search destination' })
          .type(InputType.Normal)
          .text(this.query)
          .onChange((value: string) => {
            this.query = value
          })
          .onFocus(() => {
            this.isSearchFieldFocused = true
          })
          .onBlur(() => {
            this.isSearchFieldFocused = false
          })
          .backgroundColor('#111111')
          .borderRadius(10)
          .border({
            width: 1,
            color: this.isSearchFieldFocused ? '#00FF66' : '#1F1F1F',
            style: BorderStyle.Solid
          })
          .padding(12)
          .width('100%')
          .height(48)
          .fontColor('#E0E0E0')
          .placeholderColor('#999999')
          .fontSize(13)

        // Markers List
        Column({ space: 12 }) {
          ForEach(this.markers, (marker: MapMarker) => {
            CardView({ controller: marker })
          })
        }.width('100%')

        Blank()

        // Refresh Map Button
        Button('Refresh Map')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .backgroundColor('#00FF66')
          .borderRadius(14)
          .width('100%')
          .height(48)
      }
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }
}

interface MapMarker {
  name: string
  distance: string
}

@Component
struct CardView {
  controller: MapMarker

  build() {
    Row() {
      Column({ space: 0 }) {
        Text(this.controller.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E0E0E0')
        
        Text(this.controller.distance)
          .fontSize(13)
          .fontWeight(FontWeight.Regular)
          .fontColor('#CCCCCC')
      }

      Blank()

      Button('View')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .backgroundColor('#00FF66')
        .borderRadius(6)
        .padding({ left: 12, right: 12, top: 4, bottom: 4 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#0A0A0A')
    .borderRadius(10)
    .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.12)', offsetY: 2 })
  }
}