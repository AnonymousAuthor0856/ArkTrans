@Entry
@Component
struct ExploreMapScreen {
  @State private query: string = '';
  private markers: Array<MapMarker> = [
    { name: 'Central Plaza', distance: '1.2 km' },
    { name: 'Museum District', distance: '3.4 km' },
    { name: 'Tech Park', distance: '5.6 km' },
    { name: 'Old Town Gate', distance: '7.8 km' }
  ];

  // AppTokens Colors
  private primary: string = '#00FF66';
  private secondary: string = '#CCCCCC';
  private tertiary: string = '#999999';
  private background: string = '#000000';
  private surface: string = '#0A0A0A';
  private surfaceVariant: string = '#111111';
  private outline: string = '#1F1F1F';
  private onPrimary: string = '#000000';
  private onSurface: string = '#E0E0E0';

  @Builder
  TopBar() {
    Row() {
      Text('Explore Map')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.primary)
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .width('100%')
    .height(56)
    .backgroundColor(this.background)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SearchField() {
    TextInput({ text: string = '' }) {
      this.query = text;
    }
    .placeholder('Search destination')
    .placeholderColor(this.onSurface)
    .fontColor(this.onSurface)
    .caretColor(this.primary)
    .borderRadius(10)
    .border({ color: this.outline, width: 1 })
    .backgroundColor(this.surface)
    .width('100%')
    .height(48)
    .padding({ left: 12, right: 12 })
  }

  @Builder
  MarkerCard(marker: MapMarker) {
    Row() {
      Column() {
        Text(marker.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurface)
        Text(marker.distance)
          .fontSize(13)
          .fontColor(this.secondary)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('View')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.onPrimary)
        .backgroundColor(this.primary)
        .borderRadius(6)
        .height(32)
        .padding({ left: 12, right: 12 })
    }
    .width('100%')
    .padding(12)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(this.surface)
    .borderRadius(10)
  }

  @Builder
  RefreshButton() {
    Button('Refresh Map')
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.onPrimary)
      .backgroundColor(this.primary)
      .borderRadius(14)
      .width('100%')
      .height(48)
  }

  build() {
    Column() {
      this.TopBar()

      Column() {
        this.SearchField()

        ForEach(this.markers, (marker: MapMarker) => {
          this.MarkerCard(marker)
        }, (marker: MapMarker) => marker.name)

        Blank()
          .height(32)

        this.RefreshButton()
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor(this.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
  }
}

interface MapMarker {
  name: string;
  distance: string;
}