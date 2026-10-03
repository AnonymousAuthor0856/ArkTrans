@Entry
@Component
struct Index {
  // Mock data for ForEach to ensure compilation
  private sampleTeas: TeaItem[] = [
    { name: 'Earl Grey', origin: 'England', temp: '95°C', time: '3 min', colorCode: '#8B4513' },
    { name: 'Green Tea', origin: 'China', temp: '80°C', time: '2 min', colorCode: '#228B22' }
  ]

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Scroll() {
        Column({ space: 16 }) {
          Row() {
            Column() {
              Text('ZenBrew')
                .letterSpacing(-0.5)
                .fontColor('#000000')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
              
              Text('Mindful Steeping Guide')
                .fontColor('#808080')
                .fontSize(14)
                .fontWeight(FontWeight.Regular)
            }
            
            Blank()
            
            Button() {
              Image($r('app.media.startIcon'))
            }
            .width(44)
            .height(44)
          }
          .padding({ top: 10, left: 20, right: 20 })
          .alignItems(VerticalAlign.Top)

          Row() {
            Column() {
              Text('Tip of the day')
                .padding({ bottom: 4 })
                .fontColor('#808080')
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
              
              Text('Use filtered water for a purer taste profile.')
                .fontColor('#000000')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            Blank().width(16)

            Stack() {
              Circle()
                .fill(Color.White)
                .width(48)
                .height(48)
              
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .objectFit(ImageFit.Contain)
            }
          }
          .padding(24)
          .backgroundColor('#F5F5F5')
          .borderRadius(20)

          Text('Collections')
            .padding({ left: 20, right: 20, top: 8, bottom: 8 })
            .width('100%')
            .textAlign(TextAlign.Start)
            .fontColor('#000000')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)

          ForEach(this.sampleTeas, (tea: TeaItem) => {
            Row() {
              Stack() {
                Circle()
                  .fill(Color.White)
                  .width(50)
                  .height(50)
                  .overlay(
                    Circle()
                      .stroke(tea.colorCode)
                      .strokeWidth(2)
                      .opacity(0.3)
                  )
                
                Text(tea.name.substring(0, 1))
                  .fontColor(tea.colorCode)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
              }
              .clipShape(Circle())

              Blank().width(16)

              Column() {
                Text(tea.name)
                  .fontColor('#000000')
                  .fontSize(17)
                  .fontWeight(FontWeight.Bold)
                
                Text(tea.origin)
                  .fontColor('#808080')
                  .fontSize(12)
                
                Blank().height(6)
                
                Row() {
                  InfoBadge({ label: tea.temp })
                  Blank().width(8)
                  InfoBadge({ label: tea.time })
                }
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Button() {
                Image($r('app.media.startIcon'))
                  .width(20)
                  .height(20)
              }
              .width(40)
              .height(40)
              .backgroundColor(Color.White)
              .clipShape(Circle())
              .border({ width: 1, color: '#E0E0E0', radius: 20 })
            }
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .border({ width: 1, color: '#E0E0E0', radius: 16 })
          })

          Blank().height(80)
        }
        .padding({ top: 10, bottom: 10 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      Button() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
      }
      .padding({ bottom: 20, right: 20 })
      .backgroundColor('#6750A4')
      .borderRadius(20)
      .width(48)
      .height(48)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

interface TeaItem {
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: string;
}

@Component
struct InfoBadge {
  @Prop label: string = ''

  build() {
    Text(this.label)
      .fontSize(12)
      .fontColor('#6750A4')
      .backgroundColor('#EADDFF')
      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      .borderRadius(12)
  }
}