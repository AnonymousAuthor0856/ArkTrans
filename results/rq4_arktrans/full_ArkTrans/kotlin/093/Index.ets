@Entry
@Component
struct Index {
  @State selectedTea: string = 'Sencha'
  private readonly teas: string[] = ['Sencha', 'Earl Grey', 'Oolong']

  build() {
    Stack() {
      Column({ space: 0 }) {
        // HeaderSection
        Row({ space: 0 }) {
          Column({ space: 4 }) {
            Text('Tea Master').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#000000')
            Text('Perfect brew, every time').fontSize(14).fontColor('#9E9E9E')
          }
          Blank()
          Button() {
            Image($r('app.media.startIcon')).width(24).height(24)
          }.backgroundColor(Color.Transparent).borderRadius(8)
        }.width('100%')

        Blank().height(32)

        // BrewingVisualizer
        Stack({ alignContent: Alignment.Center }) {
          Stack({ alignContent: Alignment.Center }) {
            Column({ space: 8 }) {
              Image($r('app.media.startIcon')).width(48).height(48).objectFit(ImageFit.Contain)
              Text(this.selectedTea).fontSize(24).fontWeight(FontWeight.Medium).fontColor('#000000')
            }
          }.width(180).height(180).clip(true).borderRadius(90).backgroundColor('#F5F5F5')
        }.width(220).height(220)

        Blank().height(40)

        // BrewStatsRow
        Row({ space: 0 }) {
          Column({ space: 4 }) {
            Text('TEMP').fontSize(12).fontWeight(FontWeight.Bold).letterSpacing(1).fontColor('#9E9E9E')
            Text('70°C').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
          }
          Divider().vertical(true).strokeWidth(1).color('#E0E0E0').height(20)
          Column({ space: 4 }) {
            Text('TIME').fontSize(12).fontWeight(FontWeight.Bold).letterSpacing(1).fontColor('#9E9E9E')
            Text('1-2 min').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
          }
          Divider().vertical(true).strokeWidth(1).color('#E0E0E0').height(20)
          Column({ space: 4 }) {
            Text('AMOUNT').fontSize(12).fontWeight(FontWeight.Bold).letterSpacing(1).fontColor('#9E9E9E')
            Text('250ml').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
          }
        }.width('100%')

        Blank().height(40)

        // TeaSelector
        Column({ space: 12 }) {
          Text('Select Variety').fontSize(16).fontColor('#000000')
          List({ space: 12 }) {
            ForEach(this.teas, (tea: string) => {
              ListItem() {
                Column() {
                  Text(tea)
                    .fontSize(16)
                    .fontWeight(this.selectedTea === tea ? FontWeight.Bold : FontWeight.Normal)
                    .fontColor(this.selectedTea === tea ? '#FFFFFF' : '#000000')
                }
                .padding({ left: 20, right: 20, top: 10, bottom: 10 })
                .backgroundColor(this.selectedTea === tea ? '#000000' : '#FFFFFF')
                .borderRadius(50)
                .border({ width: 1, color: this.selectedTea === tea ? '#000000' : '#E0E0E0' })
                .onClick(() => {
                  this.selectedTea = tea
                })
              }
            })
          }.width('100%').listDirection(Axis.Horizontal)
        }.width('100%')

        Blank().layoutWeight(1)

        // StartBrewButton
        Button() {
          Row({ space: 8 }) {
            Image($r('app.media.startIcon')).width(20).height(20)
            Text('START TIMER').fontSize(14).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
          }
        }
        .width('100%')
        .height(56)
        .backgroundColor('#000000')
        .borderRadius(16)
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
      .padding(24)
    }.width('100%').height('100%')
  }
}